#!/usr/bin/env python3
"""
改进的RTL生成器，确保与Excel端口定义完全一致
"""

import pandas as pd
import re
import os
from datetime import datetime

class FixedRTLGenerator:
    def __init__(self, excel_file, sheet_name):
        self.excel_file = excel_file
        self.sheet_name = sheet_name
        self.data = None
        self.ports = []
        
    def load_excel_data(self):
        """加载Excel数据"""
        try:
            self.data = pd.read_excel(self.excel_file, sheet_name=self.sheet_name)
            print(f"成功加载Excel文件: {self.excel_file}, 工作表: {self.sheet_name}")
            print(f"数据行数: {len(self.data)}")
            return True
        except Exception as e:
            print(f"加载Excel文件失败: {e}")
            return False
    
    def parse_ports(self):
        """解析端口定义"""
        if self.data is None:
            return False
            
        # 查找关键列
        direction_col = None
        name_col = None
        width_col = None
        
        for i, col in enumerate(self.data.columns):
            col_str = str(col).lower().strip()
            if 'i/o' in col_str:
                direction_col = i
            elif 'port name' in col_str or 'name' in col_str:
                name_col = i
            elif 'width' in col_str:
                width_col = i
        
        print(f"找到列索引 - 方向: {direction_col}, 名称: {name_col}, 位宽: {width_col}")
        
        if direction_col is None or name_col is None:
            print("未找到必要的列")
            return False
        
        # 解析每一行
        for idx, row in self.data.iterrows():
            # 获取方向
            direction_raw = str(row.iloc[direction_col]).strip() if pd.notna(row.iloc[direction_col]) else ''
            # 清理方向字符串，移除换行符等
            direction = re.sub(r'\s+', ' ', direction_raw).strip().lower()
            if 'input' in direction:
                direction = 'input'
            elif 'output' in direction:
                direction = 'output'
            else:
                continue
                
            # 获取名称
            name_raw = str(row.iloc[name_col]).strip() if pd.notna(row.iloc[name_col]) else ''
            if not name_raw or name_raw == 'nan':
                continue
                
            # 清理名称，移除换行符和特殊字符
            name = re.sub(r'\s+', '', name_raw)  # 移除所有空白字符
            name = re.sub(r'[^a-zA-Z0-9_]', '', name)  # 只保留字母数字下划线
            if not name:
                continue
                
            # 获取位宽
            width = ''
            if width_col is not None and pd.notna(row.iloc[width_col]):
                width_value = str(row.iloc[width_col]).strip()
                if width_value and width_value != 'nan' and width_value != '1':
                    # 清理位宽表达式
                    width = self.clean_width_expression(width_value)
            
            port_info = {
                'direction': direction,
                'name': name,
                'width': width,
                'original_width': str(row.iloc[width_col]) if width_col is not None else ''
            }
            
            self.ports.append(port_info)
            
        print(f"解析到 {len(self.ports)} 个端口")
        return True
    
    def clean_width_expression(self, width_expr):
        """清理位宽表达式"""
        # 移除多余的空格和特殊字符
        width_expr = re.sub(r'\s+', '', width_expr)
        
        # 移除可能存在的方括号
        width_expr = width_expr.strip('[]')
        
        # 处理常见的位宽表达式格式
        if re.match(r'^\d+$', width_expr):
            # 纯数字，转换为位宽表达式
            num = int(width_expr)
            if num > 1:
                return f'{num-1}:0'
            else:
                return ''
        
        # 处理包含参数的表达式
        if any(param in width_expr for param in ['RK_NUM', 'SC_NUM', 'DDRC']):
            # 确保格式正确
            if ':0' not in width_expr and '-1:0' not in width_expr:
                return f'{width_expr}-1:0'
            return width_expr
        
        # 处理其他格式
        if ':' in width_expr:
            return width_expr
        
        return width_expr
    
    def generate_module_parameters(self):
        """生成模块参数"""
        params = [
            'parameter RK_NUM = 2',
            'parameter SC_NUM = 4', 
            'parameter DDRC_SCRK_WIDTH = 7',
            'parameter DDRC_RK_WIDTH = 4',
            'parameter DDRC_SCRKBK_WIDTH = 7',
            'parameter DDRC_PA_CMD_WIDTH = 4',
            'parameter DDRC_PA_PHASE_WIDTH = 5',
            'parameter DDRC_PA_QOS_WIDTH = 4'
        ]
        return params
    
    def generate_rtl_module(self, module_name='protocol_arbiter'):
        """生成RTL模块"""
        if not self.ports:
            print("没有端口定义，无法生成RTL")
            return None
        
        lines = []
        
        # 文件头注释
        lines.extend([
            '//==============================================================================',
            f'// Module: {module_name}',
            f'// Generated: {datetime.now().strftime("%Y-%m-%d %H:%M:%S")}',
            '// Description: Protocol Arbiter Module',
            '//==============================================================================',
            ''
        ])
        
        # 模块声明开始
        lines.append(f'module {module_name} #(')
        
        # 参数声明
        params = self.generate_module_parameters()
        for i, param in enumerate(params):
            if i < len(params) - 1:
                lines.append(f'    {param},')
            else:
                lines.append(f'    {param}')
        
        lines.append(') (')
        
        # 端口声明
        for i, port in enumerate(self.ports):
            direction = port['direction']
            name = port['name']
            width = port['width']
            
            # 格式化端口声明
            if width:
                # 确保位宽格式正确
                if not width.startswith('['):
                    width_formatted = f'[{width}]'
                else:
                    width_formatted = width
                port_line = f'    {direction:<8} {width_formatted:<25} {name}'
            else:
                port_line = f'    {direction:<35} {name}'
            
            # 添加逗号（除了最后一个）
            if i < len(self.ports) - 1:
                port_line += ','
            
            lines.append(port_line)
        
        lines.extend([
            ');',
            '',
            '//==============================================================================',
            '// Local Parameters',
            '//=============================================================================='
        ])
        
        # 本地参数
        local_params = [
            'localparam RK_NUM = RK_NUM;',
            'localparam SC_NUM = SC_NUM;',
            'localparam DDRC_SCRKBK_WIDTH = DDRC_SCRKBK_WIDTH;'
        ]
        
        for param in local_params:
            lines.append(f'    {param}')
        
        lines.extend([
            '',
            '//==============================================================================',
            '// Signal Declarations',
            '//==============================================================================',
            '',
            '// TODO: Add internal signal declarations here',
            '',
            '//==============================================================================',
            '// Module Implementation',
            '//==============================================================================',
            '',
            '// TODO: Add module implementation here',
            '',
            'endmodule'
        ])
        
        return '\n'.join(lines)
    
    def save_rtl_file(self, content, filename='protocol_arbiter_fixed.v'):
        """保存RTL文件"""
        try:
            with open(filename, 'w', encoding='utf-8') as f:
                f.write(content)
            print(f"RTL文件已保存: {filename}")
            return True
        except Exception as e:
            print(f"保存RTL文件失败: {e}")
            return False
    
    def generate_port_summary(self):
        """生成端口摘要"""
        if not self.ports:
            return "没有端口定义"
        
        summary = []
        summary.append(f"端口总数: {len(self.ports)}")
        
        input_ports = [p for p in self.ports if p['direction'] == 'input']
        output_ports = [p for p in self.ports if p['direction'] == 'output']
        
        summary.append(f"输入端口: {len(input_ports)}")
        summary.append(f"输出端口: {len(output_ports)}")
        summary.append("")
        summary.append("端口列表:")
        
        for port in self.ports:
            width_str = f"[{port['width']}]" if port['width'] else "[0:0]"
            summary.append(f"  {port['direction']:<8} {width_str:<20} {port['name']}")
        
        return '\n'.join(summary)

def main():
    # 配置
    excel_file = 'Protocol_Arbiter (19).xlsx'
    sheet_name = 'Protocol_Arbiter'
    
    # 创建生成器
    generator = FixedRTLGenerator(excel_file, sheet_name)
    
    # 加载数据
    if not generator.load_excel_data():
        return
    
    # 解析端口
    if not generator.parse_ports():
        return
    
    # 生成端口摘要
    print("\n端口摘要:")
    print(generator.generate_port_summary())
    
    # 生成RTL
    rtl_content = generator.generate_rtl_module()
    if rtl_content:
        # 保存文件
        generator.save_rtl_file(rtl_content, 'rtl/protocol_arbiter.v')
        print("\nRTL生成完成!")
    else:
        print("RTL生成失败!")

if __name__ == '__main__':
    main()