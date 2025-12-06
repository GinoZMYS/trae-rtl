#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
子模块端口与Excel表格对应关系标注脚本
将RTL代码中的端口与Excel表格中的定义一一对应标注
"""

import pandas as pd
import re
import os
from typing import Dict, List, Tuple, Any

def extract_excel_ports(excel_file: str, sheet_name: str) -> Dict[str, Dict[str, Any]]:
    """从Excel文件中提取端口信息"""
    try:
        df = pd.read_excel(excel_file, sheet_name=sheet_name)
        ports = {}
        
        for _, row in df.iterrows():
            if pd.isna(row.get('Port Name')) or pd.isna(row.get('I/O')):
                continue
                
            port_name = str(row['Port Name']).strip()
            direction = str(row['I/O']).strip().lower().replace('\n', '')
            width = str(row.get('Width', '1')).strip() if not pd.isna(row.get('Width')) else '1'
            description = str(row.get('Description', '')).strip() if not pd.isna(row.get('Description')) else ''
            
            ports[port_name] = {
                'direction': direction,
                'width': width,
                'description': description,
                'excel_row': _ + 2  # Excel行号（从1开始，加上表头）
            }
            
        return ports
    except Exception as e:
        print(f"读取Excel文件 {excel_file} 的工作表 {sheet_name} 时出错: {e}")
        return {}

def extract_rtl_ports(rtl_file: str) -> Dict[str, Dict[str, Any]]:
    """从RTL文件中提取端口信息"""
    try:
        with open(rtl_file, 'r', encoding='utf-8') as f:
            content = f.read()
        
        ports = {}
        
        # 匹配端口定义模式
        port_patterns = [
            r'(input|output|inout)\s+(?:wire\s+|reg\s+)?(?:\[([^\]]+)\]\s+)?(\w+)',
            r'(input|output|inout)\s+(?:\[([^\]]+)\]\s+)?(\w+)',
        ]
        
        lines = content.split('\n')
        for line_num, line in enumerate(lines, 1):
            line = line.strip()
            if not line or line.startswith('//'):
                continue
                
            for pattern in port_patterns:
                matches = re.finditer(pattern, line)
                for match in matches:
                    direction = match.group(1).lower()
                    width = match.group(2) if match.group(2) else '0'
                    port_name = match.group(3)
                    
                    if port_name and not port_name.startswith('_'):
                        ports[port_name] = {
                            'direction': direction,
                            'width': width,
                            'line_number': line_num,
                            'line_content': line.strip()
                        }
        
        return ports
    except Exception as e:
        print(f"读取RTL文件 {rtl_file} 时出错: {e}")
        return {}

def create_port_annotation(module_name: str, excel_file: str, sheet_name: str, rtl_file: str) -> str:
    """创建端口标注报告"""
    print(f"\n正在处理模块: {module_name}")
    print(f"Excel工作表: {sheet_name}")
    print(f"RTL文件: {rtl_file}")
    
    excel_ports = extract_excel_ports(excel_file, sheet_name)
    rtl_ports = extract_rtl_ports(rtl_file)
    
    report = f"# {module_name} 模块端口标注报告\n\n"
    report += f"**Excel文件**: {excel_file}\n"
    report += f"**工作表**: {sheet_name}\n"
    report += f"**RTL文件**: {rtl_file}\n\n"
    
    # 统计信息
    excel_count = len(excel_ports)
    rtl_count = len(rtl_ports)
    common_ports = set(excel_ports.keys()) & set(rtl_ports.keys())
    excel_only = set(excel_ports.keys()) - set(rtl_ports.keys())
    rtl_only = set(rtl_ports.keys()) - set(excel_ports.keys())
    
    report += f"## 统计信息\n\n"
    report += f"- Excel中定义的端口数: {excel_count}\n"
    report += f"- RTL中定义的端口数: {rtl_count}\n"
    report += f"- 匹配的端口数: {len(common_ports)}\n"
    report += f"- 仅在Excel中的端口数: {len(excel_only)}\n"
    report += f"- 仅在RTL中的端口数: {len(rtl_only)}\n\n"
    
    # 匹配的端口详细标注
    if common_ports:
        report += f"## 匹配的端口 ({len(common_ports)}个)\n\n"
        report += "| 端口名 | Excel行号 | RTL行号 | 方向匹配 | 位宽匹配 | Excel位宽 | RTL位宽 | 描述 |\n"
        report += "|--------|----------|---------|----------|----------|-----------|---------|------|\n"
        
        for port in sorted(common_ports):
            excel_info = excel_ports[port]
            rtl_info = rtl_ports[port]
            
            direction_match = "✅" if excel_info['direction'] == rtl_info['direction'] else "❌"
            width_match = "✅" if excel_info['width'] == rtl_info['width'] else "❌"
            
            report += f"| {port} | {excel_info['excel_row']} | {rtl_info['line_number']} | {direction_match} | {width_match} | {excel_info['width']} | {rtl_info['width']} | {excel_info['description'][:50]}... |\n"
    
    # 仅在Excel中的端口
    if excel_only:
        report += f"\n## 仅在Excel中定义的端口 ({len(excel_only)}个)\n\n"
        report += "| 端口名 | Excel行号 | 方向 | 位宽 | 描述 |\n"
        report += "|--------|----------|------|------|------|\n"
        
        for port in sorted(excel_only):
            excel_info = excel_ports[port]
            report += f"| {port} | {excel_info['excel_row']} | {excel_info['direction']} | {excel_info['width']} | {excel_info['description'][:50]}... |\n"
    
    # 仅在RTL中的端口
    if rtl_only:
        report += f"\n## 仅在RTL中定义的端口 ({len(rtl_only)}个)\n\n"
        report += "| 端口名 | RTL行号 | 方向 | 位宽 | RTL代码行 |\n"
        report += "|--------|---------|------|------|-----------|\n"
        
        for port in sorted(rtl_only):
            rtl_info = rtl_ports[port]
            report += f"| {port} | {rtl_info['line_number']} | {rtl_info['direction']} | {rtl_info['width']} | `{rtl_info['line_content'][:60]}...` |\n"
    
    # 不匹配的详细信息
    mismatches = []
    for port in common_ports:
        excel_info = excel_ports[port]
        rtl_info = rtl_ports[port]
        
        if excel_info['direction'] != rtl_info['direction'] or excel_info['width'] != rtl_info['width']:
            mismatches.append({
                'port': port,
                'excel_info': excel_info,
                'rtl_info': rtl_info
            })
    
    if mismatches:
        report += f"\n## 不匹配的端口详情 ({len(mismatches)}个)\n\n"
        for mismatch in mismatches:
            port = mismatch['port']
            excel_info = mismatch['excel_info']
            rtl_info = mismatch['rtl_info']
            
            report += f"### {port}\n"
            report += f"- **Excel定义** (行{excel_info['excel_row']}): {excel_info['direction']} [{excel_info['width']}] - {excel_info['description']}\n"
            report += f"- **RTL定义** (行{rtl_info['line_number']}): {rtl_info['direction']} [{rtl_info['width']}] - `{rtl_info['line_content']}`\n\n"
    
    return report

def main():
    """主函数"""
    excel_file = "Protocol_Arbiter (23).xlsx"
    
    # 定义需要比较的模块
    modules = [
        {
            'name': 'Protocol_Arbiter',
            'excel_sheet': 'Protocol_Arbiter',
            'rtl_file': 'rtl/protocol_arbiter.sv'
        },
        {
            'name': 'Function_Arbiter',
            'excel_sheet': 'Function_Arbiter',
            'rtl_file': 'rtl/function_arbiter.v'
        },
        {
            'name': 'Command_Arbiter',
            'excel_sheet': 'Command_Arbiter',
            'rtl_file': 'rtl/command_arbiter.v'
        },
        {
            'name': 'Pre_All',
            'excel_sheet': 'Pre_All',
            'rtl_file': 'rtl/pre_all.v'
        },
        {
            'name': 'BP_If',
            'excel_sheet': 'BP_If',
            'rtl_file': 'rtl/bp_if.v'
        }
    ]
    
    # 检查文件是否存在
    if not os.path.exists(excel_file):
        print(f"错误: Excel文件 {excel_file} 不存在")
        return
    
    # 生成每个模块的标注报告
    all_reports = []
    
    for module in modules:
        if not os.path.exists(module['rtl_file']):
            print(f"警告: RTL文件 {module['rtl_file']} 不存在，跳过模块 {module['name']}")
            continue
            
        report = create_port_annotation(
            module['name'],
            excel_file,
            module['excel_sheet'],
            module['rtl_file']
        )
        all_reports.append(report)
    
    # 保存完整报告
    output_file = "port_annotation_detailed_report.md"
    with open(output_file, 'w', encoding='utf-8') as f:
        f.write("# 子模块端口与Excel表格对应关系详细标注\n\n")
        f.write("本报告详细标注了每个子模块的RTL端口与Excel表格中定义的对应关系。\n\n")
        f.write("---\n\n")
        
        for report in all_reports:
            f.write(report)
            f.write("\n---\n\n")
    
    print(f"\n✅ 详细标注报告已生成: {output_file}")
    print(f"📊 共处理了 {len(all_reports)} 个模块")

if __name__ == "__main__":
    main()