#!/usr/bin/env python3

import pandas as pd
import re

def extract_rtl_ports():
    """Extract port information from RTL file"""
    rtl_ports = []
    
    with open('rtl/protocol_arbiter.v', 'r') as f:
        content = f.read()
    
    # Extract module definition
    module_match = re.search(r'module\s+protocol_arbiter\s*#?\s*\([^)]*\)\s*\((.*?)\);', content, re.DOTALL)
    if not module_match:
        return []
    
    port_section = module_match.group(1)
    
    # Parse each port line
    lines = port_section.split('\n')
    for line in lines:
        line = line.strip()
        if not line or line.startswith('//'):
            continue
            
        # Match port patterns
        port_match = re.match(r'(input|output)\s*(?:\[([^\]]+)\])?\s*(\w+)', line)
        if port_match:
            direction = port_match.group(1)
            width = port_match.group(2) if port_match.group(2) else '1'
            name = port_match.group(3)
            
            rtl_ports.append({
                'name': name,
                'direction': direction,
                'width': width
            })
    
    return rtl_ports

def extract_excel_ports():
    """Extract port information from Excel file"""
    try:
        df = pd.read_excel('Protocol_Arbiter (20).xlsx', sheet_name='Protocol_Arbiter')
        
        excel_ports = []
        
        # Based on the structure: Col 1=I/O, Col 2=Port Name, Col 3=Width
        for idx, row in df.iterrows():
            # Skip empty rows
            if pd.isna(row.iloc[1]) or pd.isna(row.iloc[2]):
                continue
                
            direction = str(row.iloc[1]).strip().lower()
            if direction not in ['input', 'output']:
                continue
                
            port_name = str(row.iloc[2]).strip()
            width = str(row.iloc[3]).strip() if not pd.isna(row.iloc[3]) else '1'
            
            if port_name and re.match(r'^[a-zA-Z_][a-zA-Z0-9_]*$', port_name):
                excel_ports.append({
                    'name': port_name,
                    'direction': direction,
                    'width': width
                })
        
        return excel_ports
        
    except Exception as e:
        print(f"Error reading Excel: {e}")
        return []

def normalize_width(width_str):
    """Normalize width string for comparison"""
    if not width_str or width_str == '1':
        return '1'
    
    # Remove extra brackets and spaces
    width_str = width_str.strip('[]() \t\n')
    
    # Handle common patterns
    if '-1:0' in width_str:
        return width_str
    elif width_str.isdigit():
        if width_str == '1':
            return '1'
        else:
            return f'{width_str}-1:0'
    else:
        return width_str

def detailed_comparison():
    """Perform detailed port comparison"""
    print("=== Detailed RTL vs Excel Port Analysis ===")
    
    rtl_ports = extract_rtl_ports()
    excel_ports = extract_excel_ports()
    
    # Create dictionaries for easy lookup
    rtl_dict = {port['name']: port for port in rtl_ports}
    excel_dict = {port['name']: port for port in excel_ports}
    
    print(f"\nTotal RTL ports: {len(rtl_ports)}")
    print(f"Total Excel ports: {len(excel_ports)}")
    
    # Find all unique port names
    all_ports = set(rtl_dict.keys()) | set(excel_dict.keys())
    
    # Categorize ports
    matching_ports = []
    width_mismatches = []
    direction_mismatches = []
    rtl_only = []
    excel_only = []
    
    for port_name in sorted(all_ports):
        rtl_port = rtl_dict.get(port_name)
        excel_port = excel_dict.get(port_name)
        
        if rtl_port and excel_port:
            # Both exist, check for differences
            if rtl_port['direction'] != excel_port['direction']:
                direction_mismatches.append({
                    'name': port_name,
                    'rtl_dir': rtl_port['direction'],
                    'excel_dir': excel_port['direction']
                })
            
            rtl_width_norm = normalize_width(rtl_port['width'])
            excel_width_norm = normalize_width(excel_port['width'])
            
            if rtl_width_norm != excel_width_norm:
                width_mismatches.append({
                    'name': port_name,
                    'rtl_width': rtl_port['width'],
                    'excel_width': excel_port['width'],
                    'rtl_norm': rtl_width_norm,
                    'excel_norm': excel_width_norm
                })
            else:
                matching_ports.append(port_name)
                
        elif rtl_port:
            rtl_only.append(port_name)
        else:
            excel_only.append(port_name)
    
    # Print results
    print(f"\n=== Summary ===")
    print(f"Perfectly matching ports: {len(matching_ports)}")
    print(f"Width mismatches: {len(width_mismatches)}")
    print(f"Direction mismatches: {len(direction_mismatches)}")
    print(f"RTL only: {len(rtl_only)}")
    print(f"Excel only: {len(excel_only)}")
    
    if direction_mismatches:
        print(f"\n=== Direction Mismatches ===")
        for mismatch in direction_mismatches:
            print(f"{mismatch['name']:30} RTL: {mismatch['rtl_dir']:6} Excel: {mismatch['excel_dir']:6}")
    
    if width_mismatches:
        print(f"\n=== Width Mismatches ===")
        for mismatch in width_mismatches:
            print(f"{mismatch['name']:30} RTL: {mismatch['rtl_width']:25} Excel: {mismatch['excel_width']:25}")
    
    if rtl_only:
        print(f"\n=== Ports in RTL only ===")
        for port in rtl_only:
            rtl_port = rtl_dict[port]
            print(f"{port:30} {rtl_port['direction']:6} [{rtl_port['width']:20}]")
    
    if excel_only:
        print(f"\n=== Ports in Excel only ===")
        for port in excel_only:
            excel_port = excel_dict[port]
            print(f"{port:30} {excel_port['direction']:6} [{excel_port['width']:20}]")
    
    # Generate final assessment
    print(f"\n=== Final Assessment ===")
    total_issues = len(width_mismatches) + len(direction_mismatches) + len(rtl_only) + len(excel_only)
    
    if total_issues == 0:
        print("✅ Perfect match! All ports are consistent between RTL and Excel.")
    elif total_issues <= 5:
        print(f"⚠️  Minor issues found ({total_issues} total). Mostly consistent.")
    else:
        print(f"❌ Significant differences found ({total_issues} total). Review needed.")
    
    return {
        'matching': len(matching_ports),
        'width_mismatches': len(width_mismatches),
        'direction_mismatches': len(direction_mismatches),
        'rtl_only': len(rtl_only),
        'excel_only': len(excel_only),
        'total_issues': total_issues
    }

if __name__ == "__main__":
    detailed_comparison()