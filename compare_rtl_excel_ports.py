#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
RTL与Excel端口对比工具
比较protocol_arbiter.v与最新Excel表格的端口定义
"""

import pandas as pd
import re
import sys
from pathlib import Path

def extract_excel_ports(excel_file):
    """从Excel文件提取端口信息"""
    try:
        df = pd.read_excel(excel_file, sheet_name='Protocol_Arbiter')
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
        print(f"读取Excel文件错误: {e}")
        return []

def extract_rtl_ports(rtl_file):
    """从RTL文件提取端口信息"""
    try:
        with open(rtl_file, 'r', encoding='utf-8') as f:
            lines = f.readlines()
        
        ports = []
        
        # 匹配端口定义的正则表达式，更精确地处理位宽
        port_pattern = r'(input|output)\s*(?:\[([^\]]+)\])?\s*([a-zA-Z_][a-zA-Z0-9_]*),?'
        
        for line in lines:
            # 跳过注释行和空行
            stripped_line = line.strip()
            if stripped_line.startswith('//') or stripped_line.startswith('/*') or not stripped_line:
                continue
            
            # 移除行内注释
            if '//' in line:
                line = line[:line.index('//')]
            
            matches = re.findall(port_pattern, line)
            
            for match in matches:
                direction, width, name = match
                # 如果没有位宽定义，默认为1位
                if not width:
                    width_expr = '1'
                else:
                    width_expr = width.strip()
                
                port_info = {
                    'name': name.strip(),
                    'direction': direction.strip().lower(),
                    'width': width_expr,
                    'category': 'RTL'
                }
                ports.append(port_info)
        
        return ports
    except Exception as e:
        print(f"读取RTL文件错误: {e}")
        return []

def normalize_width(width_str):
    """标准化位宽表达式"""
    if not width_str or width_str == '1' or width_str == 'nan':
        return '1'
    
    # 移除空格和方括号
    width_str = re.sub(r'\s+', '', width_str)
    width_str = width_str.strip('[]')
    
    # 如果是单独的数字，转换为标准格式
    if width_str.isdigit():
        return width_str
    
    # 处理 [n-1:0] 格式
    if ':0' in width_str:
        width_str = width_str.replace(':0', '')
        if width_str.endswith('-1'):
            width_str = width_str[:-2]
    
    # 处理常见的位宽表达式格式
    width_str = width_str.replace('2**', '2^')
    
    return width_str

def are_widths_equivalent(excel_width, rtl_width):
    """判断两个位宽表达式是否等价"""
    excel_norm = normalize_width(excel_width)
    rtl_norm = normalize_width(rtl_width)
    
    # 直接比较
    if excel_norm == rtl_norm:
        return True
    
    # 特殊情况：1位信号
    if (excel_norm == '1' and rtl_norm == '1') or \
       (excel_norm == '1-1' and rtl_norm == '1') or \
       (excel_norm == '1' and rtl_norm == '1-1'):
        return True
    
    return False

def compare_ports(excel_ports, rtl_ports):
    """比较Excel和RTL端口"""
    print("\n=== RTL与Excel端口对比报告 ===")
    print(f"Excel端口总数: {len(excel_ports)}")
    print(f"RTL端口总数: {len(rtl_ports)}")
    
    # 创建端口字典便于查找
    excel_dict = {port['name']: port for port in excel_ports}
    rtl_dict = {port['name']: port for port in rtl_ports}
    
    # 找出所有端口名
    all_ports = set(excel_dict.keys()) | set(rtl_dict.keys())
    
    matches = []
    mismatches = []
    excel_only = []
    rtl_only = []
    
    for port_name in sorted(all_ports):
        excel_port = excel_dict.get(port_name)
        rtl_port = rtl_dict.get(port_name)
        
        if excel_port and rtl_port:
            # 比较方向和位宽
            direction_match = excel_port['direction'] == rtl_port['direction']
            width_match = are_widths_equivalent(excel_port['width'], rtl_port['width'])
            
            if direction_match and width_match:
                matches.append(port_name)
            else:
                mismatches.append({
                    'name': port_name,
                    'excel_direction': excel_port['direction'],
                    'rtl_direction': rtl_port['direction'],
                    'excel_width': excel_port['width'],
                    'rtl_width': rtl_port['width'],
                    'direction_match': direction_match,
                    'width_match': width_match
                })
        elif excel_port:
            excel_only.append(port_name)
        else:
            rtl_only.append(port_name)
    
    # 输出结果
    print(f"\n完全匹配的端口: {len(matches)}")
    print(f"不匹配的端口: {len(mismatches)}")
    print(f"仅在Excel中的端口: {len(excel_only)}")
    print(f"仅在RTL中的端口: {len(rtl_only)}")
    
    if mismatches:
        print("\n=== 不匹配的端口详情 ===")
        for mismatch in mismatches:
            print(f"\n端口: {mismatch['name']}")
            if not mismatch['direction_match']:
                print(f"  方向不匹配: Excel={mismatch['excel_direction']}, RTL={mismatch['rtl_direction']}")
            if not mismatch['width_match']:
                print(f"  位宽不匹配: Excel='{mismatch['excel_width']}', RTL='{mismatch['rtl_width']}'")
                print(f"    标准化后: Excel='{normalize_width(mismatch['excel_width'])}', RTL='{normalize_width(mismatch['rtl_width'])}'")
    
    if excel_only:
        print(f"\n=== 仅在Excel中的端口 ({len(excel_only)}) ===")
        for port in excel_only:
            excel_port = excel_dict[port]
            print(f"  {port} ({excel_port['direction']}, {excel_port['width']})")
    
    if rtl_only:
        print(f"\n=== 仅在RTL中的端口 ({len(rtl_only)}) ===")
        for port in rtl_only:
            rtl_port = rtl_dict[port]
            print(f"  {port} ({rtl_port['direction']}, {rtl_port['width']})")
    
    # 显示一些匹配的端口作为参考
    if matches:
        print(f"\n=== 匹配端口示例 (前10个) ===")
        for port_name in sorted(matches)[:10]:
            excel_port = excel_dict[port_name]
            rtl_port = rtl_dict[port_name]
            print(f"  {port_name}: {excel_port['direction']}, Excel='{excel_port['width']}', RTL='{rtl_port['width']}'")
    
    return {
        'total_excel': len(excel_ports),
        'total_rtl': len(rtl_ports),
        'matches': len(matches),
        'mismatches': len(mismatches),
        'excel_only': len(excel_only),
        'rtl_only': len(rtl_only)
    }

def main():
    # 文件路径
    excel_file = 'Protocol_Arbiter (22).xlsx'
    rtl_file = 'rtl/protocol_arbiter.sv'
    
    print("开始比较RTL与Excel端口定义...")
    print(f"Excel文件: {excel_file}")
    print(f"RTL文件: {rtl_file}")
    
    # 提取端口信息
    excel_ports = extract_excel_ports(excel_file)
    rtl_ports = extract_rtl_ports(rtl_file)
    
    if not excel_ports:
        print("错误: 无法从Excel文件提取端口信息")
        return
    
    if not rtl_ports:
        print("错误: 无法从RTL文件提取端口信息")
        return
    
    # 比较端口
    results = compare_ports(excel_ports, rtl_ports)
    
    # 总结
    print("\n=== 对比总结 ===")
    if results['mismatches'] == 0 and results['excel_only'] == 0 and results['rtl_only'] == 0:
        print("✅ 所有端口完全匹配!")
    else:
        print("❌ 发现端口不匹配")
        if results['mismatches'] > 0:
            print(f"   - {results['mismatches']} 个端口定义不匹配")
        if results['excel_only'] > 0:
            print(f"   - {results['excel_only']} 个端口仅在Excel中存在")
        if results['rtl_only'] > 0:
            print(f"   - {results['rtl_only']} 个端口仅在RTL中存在")
        
        print("\n建议:")
        if results['mismatches'] > 0:
            print("   - 检查位宽表达式格式是否一致")
            print("   - 确认端口方向定义正确")
        if results['excel_only'] > 0 or results['rtl_only'] > 0:
            print("   - 同步Excel表格和RTL文件的端口定义")

if __name__ == '__main__':
    main()