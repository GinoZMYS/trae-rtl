#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
全模块RTL与Excel端口对比工具
比较所有模块与最新Excel表格的端口定义
"""

import pandas as pd
import re
import sys
from pathlib import Path

def extract_excel_ports(excel_file, sheet_name):
    """从Excel文件提取端口信息"""
    try:
        df = pd.read_excel(excel_file, sheet_name=sheet_name)
        ports = []
        
        for _, row in df.iterrows():
            if pd.notna(row.get('Port Name')):
                port_info = {
                    'name': str(row['Port Name']).strip(),
                    'direction': str(row.get('I/O', '')).strip().lower(),
                    'width': str(row.get('Width', '')).strip(),
                    'category': str(row.get('Category', '')).strip()
                }
                if port_info['name'] and port_info['name'] != 'nan':
                    ports.append(port_info)
        
        return ports
    except Exception as e:
        print(f"读取Excel文件错误 ({sheet_name}): {e}")
        return []

def extract_rtl_ports(rtl_file):
    """从RTL文件提取端口信息"""
    try:
        with open(rtl_file, 'r', encoding='utf-8') as f:
            lines = f.readlines()
        
        ports = []
        port_pattern = r'(input|output)\s*(?:\[([^\]]+)\])?\s*([a-zA-Z_][a-zA-Z0-9_]*),?'
        
        for line in lines:
            stripped_line = line.strip()
            if stripped_line.startswith('//') or stripped_line.startswith('/*') or not stripped_line:
                continue
                
            matches = re.findall(port_pattern, line)
            for match in matches:
                direction, width, name = match
                if width:
                    width = width.strip()
                else:
                    width = '1'
                
                ports.append({
                    'name': name.strip(),
                    'direction': direction.strip().lower(),
                    'width': width
                })
        
        return ports
    except Exception as e:
        print(f"读取RTL文件错误 ({rtl_file}): {e}")
        return []

def normalize_width(width_str):
    """标准化位宽表达式"""
    if not width_str or width_str == 'nan':
        return '1'
    
    width_str = str(width_str).strip()
    
    # 移除外层方括号
    if width_str.startswith('[') and width_str.endswith(']'):
        width_str = width_str[1:-1]
    
    # 处理 "n-1:0" 格式
    if ':0' in width_str:
        width_str = width_str.replace(':0', '').strip()
        if width_str.endswith('-1'):
            width_str = width_str[:-2].strip()
    
    # 处理单独的数字
    if width_str.isdigit():
        return width_str
    
    return width_str

def are_widths_equivalent(excel_width, rtl_width):
    """检查两个位宽表达式是否等价"""
    excel_norm = normalize_width(excel_width)
    rtl_norm = normalize_width(rtl_width)
    
    return excel_norm == rtl_norm

def compare_ports(excel_ports, rtl_ports, module_name):
    """比较端口并生成报告"""
    print(f"\n=== {module_name} 模块端口对比报告 ===")
    print(f"Excel端口总数: {len(excel_ports)}")
    print(f"RTL端口总数: {len(rtl_ports)}")
    
    # 创建端口字典
    excel_dict = {port['name']: port for port in excel_ports}
    rtl_dict = {port['name']: port for port in rtl_ports}
    
    matched = 0
    mismatched = 0
    excel_only = 0
    rtl_only = 0
    
    mismatched_details = []
    
    # 检查匹配情况
    all_ports = set(excel_dict.keys()) | set(rtl_dict.keys())
    
    for port_name in sorted(all_ports):
        if port_name in excel_dict and port_name in rtl_dict:
            excel_port = excel_dict[port_name]
            rtl_port = rtl_dict[port_name]
            
            direction_match = excel_port['direction'] == rtl_port['direction']
            width_match = are_widths_equivalent(excel_port['width'], rtl_port['width'])
            
            if direction_match and width_match:
                matched += 1
            else:
                mismatched += 1
                mismatched_details.append({
                    'name': port_name,
                    'excel': f"{excel_port['direction']} [{excel_port['width']}]",
                    'rtl': f"{rtl_port['direction']} [{rtl_port['width']}]",
                    'direction_match': direction_match,
                    'width_match': width_match
                })
        elif port_name in excel_dict:
            excel_only += 1
            print(f"  仅在Excel中: {port_name} ({excel_dict[port_name]['direction']} [{excel_dict[port_name]['width']}])")
        else:
            rtl_only += 1
            print(f"  仅在RTL中: {port_name} ({rtl_dict[port_name]['direction']} [{rtl_dict[port_name]['width']}])")
    
    print(f"\n完全匹配的端口: {matched}")
    print(f"不匹配的端口: {mismatched}")
    print(f"仅在Excel中的端口: {excel_only}")
    print(f"仅在RTL中的端口: {rtl_only}")
    
    # 显示不匹配的详细信息
    if mismatched_details:
        print(f"\n=== 不匹配端口详情 ===")
        for detail in mismatched_details[:10]:  # 只显示前10个
            print(f"  {detail['name']}:")
            print(f"    Excel: {detail['excel']}")
            print(f"    RTL:   {detail['rtl']}")
            if not detail['direction_match']:
                print(f"    ❌ 方向不匹配")
            if not detail['width_match']:
                print(f"    ❌ 位宽不匹配")
    
    return {
        'matched': matched,
        'mismatched': mismatched,
        'excel_only': excel_only,
        'rtl_only': rtl_only,
        'total_issues': mismatched + excel_only + rtl_only
    }

def main():
    # 模块配置
    modules = [
        {'name': 'Protocol_Arbiter', 'excel_sheet': 'Protocol_Arbiter', 'rtl_file': 'rtl/protocol_arbiter.sv'},
        {'name': 'Function_Arbiter', 'excel_sheet': 'Function_Arbiter', 'rtl_file': 'rtl/function_arbiter.v'},
        {'name': 'Command_Arbiter', 'excel_sheet': 'Command_Arbiter', 'rtl_file': 'rtl/command_arbiter.v'},
        {'name': 'Pre_All', 'excel_sheet': 'Pre_All', 'rtl_file': 'rtl/pre_all.v'},
        {'name': 'BP_If', 'excel_sheet': 'BP_If', 'rtl_file': 'rtl/bp_if.v'}
    ]
    
    excel_file = 'Protocol_Arbiter (22).xlsx'
    
    print("开始比较所有模块的RTL与Excel端口定义...")
    print(f"Excel文件: {excel_file}")
    
    total_issues = 0
    results_summary = []
    
    for module in modules:
        print(f"\n{'='*60}")
        print(f"正在处理模块: {module['name']}")
        
        # 提取端口信息
        excel_ports = extract_excel_ports(excel_file, module['excel_sheet'])
        rtl_ports = extract_rtl_ports(module['rtl_file'])
        
        if not excel_ports:
            print(f"❌ 无法从Excel提取 {module['name']} 端口信息")
            continue
        
        if not rtl_ports:
            print(f"❌ 无法从RTL提取 {module['name']} 端口信息")
            continue
        
        # 比较端口
        result = compare_ports(excel_ports, rtl_ports, module['name'])
        total_issues += result['total_issues']
        results_summary.append({
            'module': module['name'],
            'status': '✅ 完全匹配' if result['total_issues'] == 0 else f"❌ {result['total_issues']} 个问题",
            'matched': result['matched'],
            'issues': result['total_issues']
        })
    
    # 总结报告
    print(f"\n{'='*60}")
    print("=== 全模块对比总结 ===")
    for summary in results_summary:
        print(f"  {summary['module']}: {summary['status']} (匹配: {summary['matched']})")
    
    if total_issues == 0:
        print("\n🎉 所有模块的端口都完全匹配!")
    else:
        print(f"\n⚠️  总共发现 {total_issues} 个端口问题需要解决")
        print("\n建议:")
        print("   - 检查位宽表达式格式是否一致")
        print("   - 确认端口方向定义正确")
        print("   - 同步Excel表格和RTL文件的端口定义")

if __name__ == '__main__':
    main()