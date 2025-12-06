#!/usr/bin/env python3

import pandas as pd
import re

def clean_width_expression(width_str):
    """清理位宽表达式中的参数名称"""
    # 替换常见的参数名称
    width_str = width_str.replace('DDRC_PA_SCRKBGBK_WIDTH', 'DDRC_PA_SCRKBGBK_WIDTH')
    width_str = width_str.replace('RK_NUM*SC_NUM', 'RK_NUM*SC_NUM')
    width_str = width_str.replace('DDRC_Phase width', 'DDRC_Phasewidth')
    width_str = width_str.replace('DDRC_Cmd width', 'DDRC_Cmd_width')
    # 处理数字位宽
    if width_str == '2':
        return '1:0'
    return width_str

def extract_ports_from_excel(excel_file, sheet_name):
    """从Excel文件中提取端口信息"""
    try:
        data = pd.read_excel(excel_file, sheet_name=sheet_name)
        ports = []
        
        for index, row in data.iterrows():
            # 跳过空行
            if pd.isna(row.iloc[1]) or pd.isna(row.iloc[2]):
                continue
                
            # 获取端口信息
            direction = str(row.iloc[1]).strip().lower()
            port_name = str(row.iloc[2]).strip()
            width = str(row.iloc[3]).strip() if pd.notna(row.iloc[3]) else '1'
            
            # 过滤无效端口
            if not port_name or port_name == 'nan' or direction not in ['input', 'output']:
                continue
                
            # 清理端口名称
            port_name = re.sub(r'[^a-zA-Z0-9_]', '_', port_name)
            port_name = re.sub(r'_+', '_', port_name).strip('_')
            
            # 处理位宽
            if width == '1' or width == 'nan':
                width_str = ''
            else:
                # 清理位宽表达式中的参数名称
                width_cleaned = clean_width_expression(width)
                # 移除可能存在的方括号
                width_cleaned = width_cleaned.strip('[]')
                # 确保位宽表达式格式正确，避免重复添加-1:0
                if ':' in width_cleaned:
                    # 已经是完整的位宽表达式
                    width_str = f'[{width_cleaned}]'
                else:
                    # 需要添加-1:0
                    width_str = f'[{width_cleaned}-1:0]'
            
            ports.append({
                'name': port_name,
                'direction': direction,
                'width': width_str,
                'original_width': width
            })
            
        return ports
        
    except Exception as e:
        print(f"Error reading Excel file: {e}")
        return []

def extract_ports_from_rtl(rtl_file):
    """从RTL文件中提取端口信息"""
    ports = []
    
    try:
        with open(rtl_file, 'r') as f:
            content = f.read()
            
        # 提取模块定义部分
        module_match = re.search(r'module\s+\w+.*?\)(.*?)\);', content, re.DOTALL)
        if not module_match:
            return ports
            
        port_section = module_match.group(1)
        
        # 匹配端口定义
        port_pattern = r'(input|output)\s*(?:\[([^\]]+)\])?\s*(\w+)'
        matches = re.findall(port_pattern, port_section)
        
        for direction, width, name in matches:
            width_str = f'[{width}]' if width else ''
            ports.append({
                'name': name,
                'direction': direction,
                'width': width_str,
                'original_width': width if width else '1'
            })
            
    except Exception as e:
        print(f"Error reading RTL file: {e}")
        
    return ports

def compare_ports(excel_ports, rtl_ports):
    """比较Excel和RTL中的端口"""
    excel_dict = {p['name']: p for p in excel_ports}
    rtl_dict = {p['name']: p for p in rtl_ports}
    
    print("=" * 80)
    print("端口对比结果")
    print("=" * 80)
    
    # 检查Excel中有但RTL中没有的端口
    missing_in_rtl = set(excel_dict.keys()) - set(rtl_dict.keys())
    if missing_in_rtl:
        print("\n❌ Excel中有但RTL中缺失的端口:")
        for port in sorted(missing_in_rtl):
            p = excel_dict[port]
            print(f"  - {p['direction']} {p['width']} {p['name']}")
    
    # 检查RTL中有但Excel中没有的端口
    extra_in_rtl = set(rtl_dict.keys()) - set(excel_dict.keys())
    if extra_in_rtl:
        print("\n⚠️  RTL中有但Excel中没有的端口:")
        for port in sorted(extra_in_rtl):
            p = rtl_dict[port]
            print(f"  - {p['direction']} {p['width']} {p['name']}")
    
    # 检查共同端口的差异
    common_ports = set(excel_dict.keys()) & set(rtl_dict.keys())
    mismatched = []
    
    for port in sorted(common_ports):
        excel_port = excel_dict[port]
        rtl_port = rtl_dict[port]
        
        if (excel_port['direction'] != rtl_port['direction'] or 
            excel_port['width'] != rtl_port['width']):
            mismatched.append(port)
            
    if mismatched:
        print("\n❌ 端口定义不匹配:")
        for port in mismatched:
            excel_port = excel_dict[port]
            rtl_port = rtl_dict[port]
            print(f"  - {port}:")
            print(f"    Excel: {excel_port['direction']} {excel_port['width']} {port}")
            print(f"    RTL:   {rtl_port['direction']} {rtl_port['width']} {port}")
    
    # 统计信息
    print("\n" + "=" * 80)
    print("统计信息:")
    print(f"Excel端口总数: {len(excel_ports)}")
    print(f"RTL端口总数: {len(rtl_ports)}")
    print(f"共同端口数: {len(common_ports)}")
    print(f"缺失端口数: {len(missing_in_rtl)}")
    print(f"额外端口数: {len(extra_in_rtl)}")
    print(f"不匹配端口数: {len(mismatched)}")
    
    if not missing_in_rtl and not extra_in_rtl and not mismatched:
        print("\n✅ 所有端口定义完全匹配!")
    else:
        print("\n❌ 发现端口定义差异，需要检查修正。")

if __name__ == "__main__":
    excel_file = "Protocol_Arbiter (21).xlsx"
    rtl_file = "rtl/protocol_arbiter.v"
    
    print("正在提取Excel端口信息...")
    excel_ports = extract_ports_from_excel(excel_file, "Protocol_Arbiter")
    
    print("正在提取RTL端口信息...")
    rtl_ports = extract_ports_from_rtl(rtl_file)
    
    print("正在进行端口对比...")
    compare_ports(excel_ports, rtl_ports)