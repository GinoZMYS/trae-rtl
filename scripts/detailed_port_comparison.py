#!/usr/bin/env python3

import pandas as pd
import re

def extract_excel_ports(excel_file, sheet_name):
    """从Excel文件中提取端口信息"""
    df = pd.read_excel(excel_file, sheet_name=sheet_name)
    ports = []
    
    for index, row in df.iterrows():
        if pd.isna(row['I/O']) or pd.isna(row['Port Name']):
            continue
            
        direction = str(row['I/O']).strip().lower().replace('\n', '')
        port_name = str(row['Port Name']).strip()
        width = str(row['Width']).strip() if pd.notna(row['Width']) else '1'
        
        if direction not in ['input', 'output'] or not port_name or port_name == 'nan':
            continue
            
        # 清理端口名称
        port_name = re.sub(r'[^a-zA-Z0-9_]', '_', port_name)
        port_name = re.sub(r'_+', '_', port_name).strip('_')
        
        ports.append({
            'name': port_name,
            'direction': direction,
            'width': width,
            'excel_raw': f"{direction} [{width}] {port_name}" if width != '1' else f"{direction} {port_name}"
        })
    
    return ports

def extract_rtl_ports(rtl_file):
    """从RTL文件中提取端口信息"""
    ports = []
    
    with open(rtl_file, 'r') as f:
        content = f.read()
    
    # 提取模块定义部分
    module_match = re.search(r'module\s+\w+\s*#?\s*\([^)]*\)\s*\((.*?)\);', content, re.DOTALL)
    if not module_match:
        return ports
    
    port_section = module_match.group(1)
    
    # 匹配端口定义
    port_pattern = r'(input|output)\s*(?:\[([^\]]+)\])?\s*([a-zA-Z_][a-zA-Z0-9_]*)'
    matches = re.findall(port_pattern, port_section)
    
    for direction, width, name in matches:
        width_str = width.strip() if width else ''
        ports.append({
            'name': name,
            'direction': direction,
            'width': width_str,
            'rtl_raw': f"{direction} [{width_str}] {name}" if width_str else f"{direction} {name}"
        })
    
    return ports

def compare_and_report(excel_ports, rtl_ports):
    """对比端口并生成详细报告"""
    excel_dict = {p['name']: p for p in excel_ports}
    rtl_dict = {p['name']: p for p in rtl_ports}
    
    print("="*80)
    print("详细端口对比报告")
    print("="*80)
    
    # 检查不匹配的端口
    mismatched = []
    for name in excel_dict:
        if name in rtl_dict:
            excel_port = excel_dict[name]
            rtl_port = rtl_dict[name]
            
            # 比较方向
            if excel_port['direction'] != rtl_port['direction']:
                mismatched.append((name, 'direction', excel_port, rtl_port))
                continue
            
            # 比较位宽
            excel_width = excel_port['width']
            rtl_width = rtl_port['width']
            
            # 标准化位宽表示
            if excel_width == '1' and rtl_width == '':
                continue  # 这是匹配的
            if excel_width == '2' and rtl_width == '2-1:0':
                continue  # 这是匹配的
            if excel_width != rtl_width:
                mismatched.append((name, 'width', excel_port, rtl_port))
    
    if mismatched:
        print("\n❌ 发现以下端口不匹配:")
        print("-" * 80)
        for name, issue, excel_port, rtl_port in mismatched:
            print(f"\n端口: {name} ({issue}不匹配)")
            print(f"  Excel: {excel_port['excel_raw']}")
            print(f"  RTL:   {rtl_port['rtl_raw']}")
            if issue == 'width':
                print(f"  分析: Excel位宽='{excel_port['width']}', RTL位宽='{rtl_port['width']}'")
    
    # 统计信息
    print("\n" + "="*80)
    print("统计信息:")
    print(f"Excel端口总数: {len(excel_ports)}")
    print(f"RTL端口总数: {len(rtl_ports)}")
    print(f"不匹配端口数: {len(mismatched)}")
    
    # 缺失端口
    missing_in_rtl = set(excel_dict.keys()) - set(rtl_dict.keys())
    extra_in_rtl = set(rtl_dict.keys()) - set(excel_dict.keys())
    
    if missing_in_rtl:
        print(f"\n❌ RTL中缺失的端口: {list(missing_in_rtl)}")
    
    if extra_in_rtl:
        print(f"\n❌ RTL中额外的端口: {list(extra_in_rtl)}")
    
    if not mismatched and not missing_in_rtl and not extra_in_rtl:
        print("\n✅ 所有端口定义完全匹配!")
    
    return len(mismatched) == 0 and len(missing_in_rtl) == 0 and len(extra_in_rtl) == 0

if __name__ == "__main__":
    excel_file = "Protocol_Arbiter (21).xlsx"
    rtl_file = "rtl/protocol_arbiter.v"
    
    print("正在提取Excel端口信息...")
    excel_ports = extract_excel_ports(excel_file, "Protocol_Arbiter")
    
    print("正在提取RTL端口信息...")
    rtl_ports = extract_rtl_ports(rtl_file)
    
    print("正在进行详细对比...")
    is_match = compare_and_report(excel_ports, rtl_ports)