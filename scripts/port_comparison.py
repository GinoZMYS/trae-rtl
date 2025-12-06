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
        # input/output [width] port_name
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

def compare_ports():
    """Compare RTL and Excel ports"""
    print("=== RTL vs Excel Port Comparison ===")
    
    rtl_ports = extract_rtl_ports()
    excel_ports = extract_excel_ports()
    
    print(f"\nRTL ports found: {len(rtl_ports)}")
    print(f"Excel ports found: {len(excel_ports)}")
    
    print("\n=== RTL Ports ===")
    for port in rtl_ports[:20]:  # Show first 20
        print(f"{port['direction']:6} [{port['width']:20}] {port['name']}")
    
    print("\n=== Excel Ports ===")
    for port in excel_ports[:20]:  # Show first 20
        print(f"{port['direction']:6} [{port['width']:20}] {port['name']}")
    
    # Create sets for comparison
    rtl_names = {port['name'] for port in rtl_ports}
    excel_names = {port['name'] for port in excel_ports}
    
    print("\n=== Comparison Results ===")
    print(f"Ports in RTL only: {rtl_names - excel_names}")
    print(f"Ports in Excel only: {excel_names - rtl_names}")
    print(f"Common ports: {len(rtl_names & excel_names)}")
    
    return rtl_ports, excel_ports

if __name__ == "__main__":
    compare_ports()