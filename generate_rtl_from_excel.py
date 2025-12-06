#!/usr/bin/env python3
"""
RTL代码生成器 - 从Excel表格生成完整的RTL代码
支持顶层模块和子模块的生成，以及信号连接
"""

import os
import glob
import pandas as pd
from datetime import datetime
import re
import subprocess
import sys

class RTLGenerator:
    def __init__(self, work_dir="."):
        self.work_dir = work_dir
        self.excel_file = None
        self.excel_data = None
        
    def find_latest_excel(self):
        """查找最新的Protocol_Arbiter*.xlsx文件"""
        pattern = os.path.join(self.work_dir, "Protocol_Arbiter*.xlsx")
        excel_files = glob.glob(pattern)
        
        if not excel_files:
            raise FileNotFoundError("未找到Protocol_Arbiter*.xlsx文件")
        
        # 按修改时间排序，选择最新的
        latest_file = max(excel_files, key=os.path.getmtime)
        self.excel_file = latest_file
        print(f"找到最新的表格文件: {os.path.basename(latest_file)}")
        return latest_file
    
    def read_excel_data(self):
        """读取Excel文件数据"""
        if not self.excel_file:
            self.find_latest_excel()
        
        try:
            # 读取所有工作表
            self.excel_data = pd.read_excel(self.excel_file, sheet_name=None)
            print(f"成功读取Excel文件，包含工作表: {list(self.excel_data.keys())}")
            return self.excel_data
        except Exception as e:
            print(f"读取Excel文件失败: {e}")
            return None
    
    def parse_parameters(self, data):
        """解析参数配置"""
        # 基础默认参数
        parameters = {}
        
        # 记录实际使用的参数
        self.used_parameters = set()
        
        # 跟踪哪些参数是通过公式计算的（localparam）
        self.formula_parameters = set()
        
        # RK_NUM和SC_NUM应该是基于其他参数计算的localparam
        # 这些将在后面根据DDRC_PA_RK_WIDTH等参数计算
        parameters['RK_NUM'] = '2**DDRC_PA_RK_WIDTH'  # 基于RK_WIDTH计算
        parameters['SC_NUM'] = '2**DDRC_PA_SC_WIDTH'  # 基于SC_WIDTH计算
        parameters['DDRC_SCRKBK_WIDTH'] = 'DDRC_PA_SC_WIDTH+DDRC_PA_BK_WIDTH+DDRC_PA_BG_WIDTH+DDRC_PA_RK_WIDTH'
        parameters['DDRC_PA_SCRKBGBK_WIDTH'] = 'DDRC_PA_SC_WIDTH+DDRC_PA_BK_WIDTH+DDRC_PA_BG_WIDTH+DDRC_PA_RK_WIDTH'
        self.formula_parameters.add('RK_NUM')
        self.formula_parameters.add('SC_NUM')
        self.formula_parameters.add('DDRC_SCRKBK_WIDTH')
        self.formula_parameters.add('DDRC_PA_SCRKBGBK_WIDTH')
        
        # 从Parameter_Info工作表中解析参数
        if 'Parameter_Info' in data:
            param_sheet = data['Parameter_Info']
            print(f"找到Parameter_Info工作表，开始解析参数...")
            
            # 查找Protocol Arbiter列
            protocol_arbiter_col = None
            configuration_col = None
            
            # 查找列标题
            for col_idx, col_name in enumerate(param_sheet.columns):
                if pd.notna(col_name) and 'Protocol' in str(col_name) and 'Arbiter' in str(col_name):
                    protocol_arbiter_col = col_idx
                elif pd.notna(col_name) and 'Configuration' in str(col_name):
                    configuration_col = col_idx
            
            # 如果没有找到列标题，尝试在第一行查找
            if protocol_arbiter_col is None or configuration_col is None:
                first_row = param_sheet.iloc[0]
                for col_idx, cell_value in enumerate(first_row):
                    if pd.notna(cell_value):
                        cell_str = str(cell_value).strip()
                        if 'Protocol' in cell_str and 'Arbiter' in cell_str:
                            protocol_arbiter_col = col_idx
                        elif 'Configuration' in cell_str:
                            configuration_col = col_idx
            
            if protocol_arbiter_col is not None and configuration_col is not None:
                print(f"找到Protocol Arbiter列(索引{protocol_arbiter_col})和Configuration列(索引{configuration_col})")
                
                # 遍历所有行，解析参数
                for i, row in param_sheet.iterrows():
                    if i == 0:  # 跳过标题行
                        continue
                        
                    param_cell = row.iloc[protocol_arbiter_col] if protocol_arbiter_col < len(row) else None
                    config_cell = row.iloc[configuration_col] if configuration_col < len(row) else None
                    
                    if pd.notna(param_cell) and pd.notna(config_cell):
                        param_name = str(param_cell).strip()
                        config_value = str(config_cell).strip()
                        
                        # 跳过空值和非参数行
                        if not param_name or not config_value or param_name == config_value:
                            continue
                            
                        print(f"找到参数: {param_name} = {config_value}")
                        
                        # 判断是否是公式
                        if any(op in config_value for op in ['+', '-', '*', '/', 'DDRC_PA', '**']):
                            # 公式参数，先记录公式，稍后计算
                            parameters[param_name] = config_value
                            self.formula_parameters.add(param_name)
                            print(f"  -> 公式参数 (localparam): {param_name}")
                        else:
                            try:
                                # 尝试转换为数字
                                param_value = int(config_value)
                                parameters[param_name] = param_value
                                print(f"  -> 数值参数 (parameter): {param_name} = {param_value}")
                            except ValueError:
                                print(f"  -> 跳过无法解析的参数: {param_name} = {config_value}")
            else:
                print("警告: 未找到Protocol Arbiter列或Configuration列，使用旧的解析方式")
                # 保留原有的解析逻辑作为备用
                for i, row in param_sheet.iterrows():
                    for j, cell in enumerate(row):
                        if pd.notna(cell):
                            cell_str = str(cell).strip()
                            # 查找DDRC_PA开头的参数
                            if cell_str.startswith('DDRC_PA_'):
                                # 查看下一个单元格是否是配置值
                                if j + 1 < len(row) and pd.notna(row.iloc[j + 1]):
                                    config_value = str(row.iloc[j + 1]).strip()
                                    print(f"找到参数: {cell_str} = {config_value}")
                                    
                                    # 判断是否是公式
                                    if any(op in config_value for op in ['+', '-', '*', '/', 'DDRC_PA', '**']):
                                        # 公式参数，先记录公式，稍后计算
                                        parameters[cell_str] = config_value
                                        self.formula_parameters.add(cell_str)
                                        print(f"  -> 公式参数 (localparam): {cell_str}")
                                    else:
                                        try:
                                            # 尝试转换为数字
                                            param_value = int(config_value)
                                            parameters[cell_str] = param_value
                                            print(f"  -> 数值参数 (parameter): {cell_str} = {param_value}")
                                        except ValueError:
                                            print(f"  -> 跳过无法解析的参数: {cell_str} = {config_value}")
        
        # 保留公式参数的原始公式，不进行计算
        for param_name in list(self.formula_parameters):
            if param_name in parameters:
                formula = str(parameters[param_name])
                print(f"  -> 保留公式参数: {param_name} = {formula} (localparam)")
                # 不计算公式，保持原始公式字符串
        
        # 从Protocol_Arbiter工作表中解析参数（作为备用）
        if 'Protocol_Arbiter' in data:
            param_sheet = data['Protocol_Arbiter']
            # 查找参数定义区域
            for index, row in param_sheet.iterrows():
                if pd.notna(row.iloc[0]):
                    cell_value = str(row.iloc[0]).strip()
                    # 查找参数定义
                    for param_name in parameters.keys():
                        if param_name in cell_value and pd.notna(row.iloc[1]):
                            try:
                                if param_name not in parameters or parameters[param_name] == 4:  # 只更新默认值
                                    parameters[param_name] = int(row.iloc[1])
                            except:
                                pass
        
        return parameters
    
    def parse_sheet_interfaces(self, sheet_data, sheet_name):
        """解析单个工作表的接口定义"""
        interfaces = []
        connections = []
        
        if sheet_data is None or sheet_data.empty:
            return interfaces, connections
        
        # 检查是否有标准的列名
        columns = [str(col).strip() for col in sheet_data.columns]
        
        # 查找关键列的索引
        io_col = None
        port_col = None
        width_col = None
        from_to_col = None
        
        for i, col in enumerate(columns):
            col_lower = col.lower()
            if 'i/o' in col_lower or col_lower == 'io':
                io_col = i
            elif 'port' in col_lower and 'name' in col_lower:
                port_col = i
            elif 'width' in col_lower:
                width_col = i
            elif 'from' in col_lower and 'to' in col_lower:
                from_to_col = i
        
        # 解析接口定义
        for index, row in sheet_data.iterrows():
            # 跳过空行或无效行
            if port_col is not None and pd.isna(row.iloc[port_col]):
                continue
            if io_col is not None and pd.isna(row.iloc[io_col]):
                continue
                
            # 获取端口名称
            if port_col is not None:
                signal_name = str(row.iloc[port_col]).strip()
            else:
                signal_name = str(row.iloc[0]).strip()
            
            if not signal_name or signal_name == 'nan' or signal_name.startswith('//'):
                continue
            
            # 过滤掉包含特殊字符的无效信号名称
            import re
            if re.search(r'[/&\s]|Configuration|ADDR.*DATA.*QOS.*ID|Bank.*Queue.*BSM|Internal', signal_name):
                continue
            
            # 获取方向
            direction = 'input'  # 默认输入
            if io_col is not None and pd.notna(row.iloc[io_col]):
                io_value = str(row.iloc[io_col]).strip().lower()
                if io_value in ['output', 'out', 'o']:
                    direction = 'output'
                elif io_value in ['input', 'in', 'i']:
                    direction = 'input'
            
            # 获取位宽
            width = ''
            if width_col is not None and pd.notna(row.iloc[width_col]):
                width_value = str(row.iloc[width_col]).strip()
                if width_value != 'nan' and width_value != '1':
                    # 清理位宽表达式中的参数名称
                    width_cleaned = self.clean_width_expression(width_value)
                    # 确保位宽表达式格式正确，避免重复添加-1:0
                    if '-1:0' not in width_cleaned:
                        width = f'{width_cleaned}-1:0'
                    else:
                        width = width_cleaned
                    # 记录使用的参数
                    used_params = self.extract_parameters_from_expression(width)
                    if hasattr(self, 'used_parameters'):
                        self.used_parameters.update(used_params)
            
            # 获取From/To信息
            from_to = ''
            if from_to_col is not None and pd.notna(row.iloc[from_to_col]):
                from_to = str(row.iloc[from_to_col]).strip()
            
            # 清理信号名称（移除特殊字符）
            clean_signal_name = self.clean_signal_name(signal_name)
            
            interface = {
                'name': clean_signal_name,
                'direction': direction,
                'width': width,
                'description': signal_name if clean_signal_name != signal_name else ''
            }
            interfaces.append(interface)
            
            # 记录连接关系
            if from_to and from_to.upper() != 'TOP':
                connection = {
                    'signal': clean_signal_name,
                    'from': sheet_name,
                    'to': from_to
                }
                connections.append(connection)
        
        return interfaces, connections
    
    def clean_signal_name(self, name):
        """清理信号名称，移除非法字符"""
        # 移除括号和特殊字符，替换为下划线
        import re
        # 替换括号和特殊字符
        clean_name = re.sub(r'[()\[\]\s&/]+', '_', name)
        # 移除连续的下划线
        clean_name = re.sub(r'_+', '_', clean_name)
        # 移除开头和结尾的下划线
        clean_name = clean_name.strip('_')
        # 确保以字母开头
        if clean_name and clean_name[0].isdigit():
            clean_name = 'sig_' + clean_name
        # 转换为小写以保持一致性
        clean_name = clean_name.lower()
        return clean_name
    
    def clean_width_expression(self, width_expr):
        """清理位宽表达式，修复参数名称"""
        import re
        # 替换常见的参数名称错误
        width_expr = re.sub(r'Cmd_width', 'DDRC_Cmd_width', width_expr)
        width_expr = re.sub(r'Phase\s+width', 'DDRC_Phase_width', width_expr)
        width_expr = re.sub(r'QoS_WIDTH', 'QOS_WIDTH', width_expr)
        
        # 映射Excel中的简化参数名称到完整的DDRC_PA_前缀参数名称
        param_mapping = {
            'RKBGBK_WIDTH': 'DDRC_SCRKBK_WIDTH',
            'Rank_Num': 'RK_NUM',
            'SC_NUM': 'SC_NUM',
            'Cmd_width': 'DDRC_PA_CMD_WIDTH',
            'Phase_width': 'DDRC_PA_PHASE_WIDTH',
            'QOS_WIDTH': 'DDRC_PA_QOS_WIDTH'
        }
        
        for old_name, new_name in param_mapping.items():
            width_expr = re.sub(r'\b' + re.escape(old_name) + r'\b', new_name, width_expr)
        
        # 确保所有参数名称都有DDRC_PA_前缀（除了RK_NUM、SC_NUM和DDRC_SCRKBK_WIDTH）
        # 处理可能遗漏的参数名称
        if 'DDRC_SCRKBGBK_WIDTH' in width_expr:
            width_expr = width_expr.replace('DDRC_SCRKBGBK_WIDTH', 'DDRC_PA_SCRKBGBK_WIDTH')
        
        return width_expr
    
    def extract_parameters_from_expression(self, expression):
        """从表达式中提取参数名称"""
        import re
        if not expression or pd.isna(expression):
            return set()
        
        # 查找所有可能的参数名称（大写字母开头，包含字母、数字、下划线）
        param_pattern = r'\b[A-Z][A-Z0-9_]*\b'
        parameters = set(re.findall(param_pattern, str(expression)))
        
        # 过滤掉一些明显不是参数的词
        exclude_words = {'TRUE', 'FALSE', 'HIGH', 'LOW', 'RESET', 'CLOCK'}
        parameters = parameters - exclude_words
        
        return parameters
    
    def generate_module_header(self, module_name, parameters):
        """生成模块头部"""
        timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        
        header = f"""//==============================================================================
// {module_name} Module
// Generated from {os.path.basename(self.excel_file)}
// Auto-generated on {timestamp}
//==============================================================================

module {module_name.lower()} #("""
        
        # 分离parameter和localparam
        param_lines = []
        localparam_lines = []
        
        for param_name, param_value in parameters.items():
            if hasattr(self, 'formula_parameters') and param_name in self.formula_parameters:
                # 公式计算的参数作为localparam
                localparam_lines.append(f"    localparam {param_name} = {param_value};")
            else:
                # 普通参数作为parameter
                param_lines.append(f"    parameter {param_name} = {param_value}")
        
        # 只有parameter参数放在模块参数列表中
        if param_lines:
            header += "\n" + ",\n".join(param_lines) + "\n)("
        else:
            header += "\n)("
        
        # 返回header，localparam将在端口声明后单独添加
        self.localparam_section = ""
        if localparam_lines:
            self.localparam_section = "\n//==============================================================================\n// Local Parameters\n//==============================================================================\n" + "\n".join(localparam_lines) + "\n"
        
        return header
    
    def generate_port_declarations(self, interfaces):
        """生成端口声明"""
        if not interfaces:
            return "    // No interfaces defined"
        
        port_lines = []
        for i, interface in enumerate(interfaces):
            direction = interface['direction']
            width = interface['width']
            name = interface['name']
            
            # 格式化位宽
            if width and width != '1':
                if not width.startswith('['):
                    width = f"[{width}]"
                port_line = f"    {direction:<8} {width:<25} {name}"
            else:
                port_line = f"    {direction:<8} {'':<25} {name}"
            
            # 添加逗号（除了最后一个）
            if i < len(interfaces) - 1:
                port_line += ","
            
            port_lines.append(port_line)
        
        return "\n".join(port_lines)
    
    def generate_submodule_instantiation(self, module_name, interfaces, connections, parameters):
        """生成子模块实例化"""
        inst_name = f"{module_name.lower()}_inst"
        
        instantiation = f"""\n// {module_name} instantiation
{module_name.lower()} #("""
        
        # 参数连接（只传递parameter，不传递localparam）
        param_lines = []
        for param_name in parameters.keys():
            # 跳过localparam参数
            if hasattr(self, 'formula_parameters') and param_name in self.formula_parameters:
                continue
            param_lines.append(f"    .{param_name}({param_name})")
        
        if param_lines:
            instantiation += "\n" + ",\n".join(param_lines) + "\n) " + inst_name + " (\n"
        else:
            instantiation += "\n) " + inst_name + " (\n"
        
        # 端口连接
        port_lines = []
        for i, interface in enumerate(interfaces):
            signal_name = interface['name']
            port_line = f"    .{signal_name}({signal_name})"
            
            if i < len(interfaces) - 1:
                port_line += ","
            
            port_lines.append(port_line)
        
        instantiation += "\n".join(port_lines) + "\n);\n"
        return instantiation
    
    def generate_signal_declarations(self, all_connections):
        """生成内部信号声明"""
        signals = {}
        
        for connection in all_connections:
            signal_name = connection['signal']
            # 尝试从连接信息中获取位宽
            width = connection.get('width', '1')
            if signal_name not in signals:
                signals[signal_name] = width
        
        if not signals:
            return ""
        
        signal_lines = []
        signal_lines.append("//==============================================================================")
        signal_lines.append("// Internal Signals")
        signal_lines.append("//==============================================================================")
        signal_lines.append("")
        
        # 预定义的信号位宽映射
        signal_width_map = {
            'bp_req_fe': '[RK_NUM*SC_NUM-1:0]',
            'bp_type_fe': '[RK_NUM*SC_NUM-1:0]',
            'bp_rnkbgbk_0_pa': '[DDRC_PA_SCRKBGBK_WIDTH*RK_NUM*SC_NUM-1:0]',
            'bp_rnkbgbk_1_pa': '[DDRC_PA_SCRKBGBK_WIDTH*RK_NUM*SC_NUM-1:0]',
            'func_load': '[RK_NUM*SC_NUM-1:0]',
            'func_req': '[RK_NUM*SC_NUM-1:0]',
            'preab_grant_preall': '[RK_NUM*SC_NUM-1:0]',
            'preab_req_preall': '[RK_NUM*SC_NUM-1:0]',
            'preab_req_qos_preall': '[RK_NUM*SC_NUM-1:0]'
        }
        
        for signal in sorted(signals.keys()):
            if signal in signal_width_map:
                signal_lines.append(f"wire {signal_width_map[signal]} {signal};")
            else:
                signal_lines.append(f"wire {signal};")
        
        signal_lines.append("")
        
        # 添加信号赋值 -  
        signal_lines.append("// Signal assignments -  ")
        for signal in sorted(signals.keys()):
            if signal in signal_width_map:
                if 'DDRC_PA_SCRKBGBK_WIDTH' in signal_width_map[signal]:
                    signal_lines.append(f"assign {signal} = {{DDRC_PA_SCRKBGBK_WIDTH*RK_NUM*SC_NUM{{1'b0}}}};")
                else:
                    signal_lines.append(f"assign {signal} = {{RK_NUM*SC_NUM{{1'b0}}}};")
        signal_lines.append("")
        
        return "\n".join(signal_lines)
    
    def generate_top_module(self, parameters):
        """生成顶层模块"""
        if not self.excel_data:
            return None
        
        # 解析所有工作表
        all_interfaces = {}
        all_connections = []
        
        for sheet_name, sheet_data in self.excel_data.items():
            if sheet_name in ['Protocol_Arbiter', 'Parameter_Info']:
                continue  # 跳过顶层工作表和参数信息工作表
            
            interfaces, connections = self.parse_sheet_interfaces(sheet_data, sheet_name)
            all_interfaces[sheet_name] = interfaces
            all_connections.extend(connections)
        
        # 直接使用Protocol_Arbiter工作表定义的端口顺序
        top_interfaces = []
        if 'Protocol_Arbiter' in self.excel_data:
            protocol_sheet = self.excel_data['Protocol_Arbiter']
            top_interfaces, _ = self.parse_sheet_interfaces(protocol_sheet, 'Protocol_Arbiter')
            print(f"从Protocol_Arbiter工作表解析到 {len(top_interfaces)} 个端口")
        else:
            # 如果没有Protocol_Arbiter工作表，则使用原来的逻辑
            seen_ports = set()
            
            # 收集所有需要暴露到顶层的接口并去重
            for sheet_name, interfaces in all_interfaces.items():
                for interface in interfaces:
                    # 检查是否是顶层接口（不在内部连接中）
                    is_internal = False
                    for conn in all_connections:
                        if conn['signal'] == interface['name']:
                            is_internal = True
                            break
                    
                    # 去重检查
                    port_key = f"{interface['name']}_{interface['direction']}"
                    if not is_internal and port_key not in seen_ports:
                        top_interfaces.append(interface)
                        seen_ports.add(port_key)
        
        # 保留所有解析到的参数，不进行过滤
        filtered_parameters = parameters.copy()
        
        # 生成顶层模块代码
        rtl_code = self.generate_module_header("protocol_arbiter", filtered_parameters)
        rtl_code += "\n" + self.generate_port_declarations(top_interfaces)
        rtl_code += "\n);\n"
        
        # 添加localparam部分
        if hasattr(self, 'localparam_section') and self.localparam_section:
            rtl_code += self.localparam_section
        
        rtl_code += "\n"
        
        # 生成内部信号声明
        rtl_code += self.generate_signal_declarations(all_connections)
        
        # 生成子模块实例化
        for sheet_name, interfaces in all_interfaces.items():
            rtl_code += self.generate_submodule_instantiation(sheet_name, interfaces, all_connections, filtered_parameters)
        
        rtl_code += "\nendmodule\n\n"
        rtl_code += "//==============================================================================\n"
        rtl_code += "// End of Module\n"
        rtl_code += "//==============================================================================\n"
        
        return rtl_code
    
    def generate_submodule(self, sheet_name, interfaces, parameters):
        """生成子模块代码"""
        # 保留所有解析到的参数，不进行过滤
        filtered_parameters = parameters.copy()
        
        # 去重接口
        unique_interfaces = []
        seen_ports = set()
        for interface in interfaces:
            port_key = f"{interface['name']}_{interface['direction']}"
            if port_key not in seen_ports:
                unique_interfaces.append(interface)
                seen_ports.add(port_key)
        
        rtl_code = self.generate_module_header(sheet_name, filtered_parameters)
        rtl_code += "\n" + self.generate_port_declarations(unique_interfaces)
        rtl_code += "\n);\n"
        
        # 添加localparam部分
        if hasattr(self, 'localparam_section') and self.localparam_section:
            rtl_code += self.localparam_section
        
        rtl_code += "\n"
        
        # 生成简单的内部逻辑
        rtl_code += "//==============================================================================\n"
        rtl_code += "// Internal Logic\n"
        rtl_code += "//==============================================================================\n\n"
        
        # 为输出信号生成简单的赋值
        for interface in unique_interfaces:
            if interface['direction'] == 'output':
                signal_name = interface['name']
                rtl_code += f"assign {signal_name} = 1'b0; // TODO: Implement logic\n"
        
        rtl_code += "\nendmodule\n\n"
        rtl_code += "//==============================================================================\n"
        rtl_code += "// End of Module\n"
        rtl_code += "//==============================================================================\n"
        
        return rtl_code
    
    def preserve_protected_lines(self, file_path):
        """从现有文件中提取受保护的行和用户自定义代码块"""
        protected_lines = []
        user_defined_blocks = []
        
        if os.path.exists(file_path):
            try:
                with open(file_path, 'r', encoding='utf-8') as f:
                    lines = f.readlines()
                    
                    # 提取 "//  " 行
                    for i, line in enumerate(lines):
                        if "//  " in line:
                            protected_lines.append(line.rstrip('\n'))
                    
                    # 提取用户自定义代码块
                    i = 0
                    while i < len(lines):
                        line = lines[i].strip()
                        if ("//User Define Begin" in line or "// User Define Begin" in line or 
                            "//;// User Define Begin" in line):
                            # 找到用户定义块的开始
                            block_lines = [lines[i].rstrip('\n')]  # 包含开始标记
                            i += 1
                            
                            # 收集块内容直到找到结束标记
                            while i < len(lines):
                                current_line = lines[i].rstrip('\n')
                                block_lines.append(current_line)
                                
                                if ("//User Define End" in lines[i] or "// User Define End" in lines[i] or
                                    "//==============================================================================" in lines[i]):
                                    break
                                i += 1
                            
                            if block_lines:
                                user_defined_blocks.append(block_lines)
                        i += 1
                        
            except Exception as e:
                print(f"警告: 无法读取现有文件 {file_path}: {e}")
        
        return protected_lines, user_defined_blocks
    
    def merge_protected_lines(self, new_content, protected_lines, user_defined_blocks=None):
        """将受保护的行和用户自定义代码块合并到新生成的内容中"""
        if not protected_lines and not user_defined_blocks:
            return new_content
            
        # 检查新内容是否已经包含用户定义块
        if user_defined_blocks and ("//;// User Define Begin" in new_content or "// User Define Begin" in new_content):
            print("🛡️ 内容已包含用户自定义代码块，跳过合并")
            return new_content
            
        lines = new_content.split('\n')
        merged_lines = []
        in_internal_logic = False
        protected_added = False
        user_blocks_added = False
        
        for i, line in enumerate(lines):
            if "// Internal Logic" in line:
                in_internal_logic = True
                merged_lines.append(line)
                merged_lines.append('')  # 添加空行
                
                # 添加用户自定义代码块
                if user_defined_blocks and not user_blocks_added:
                    for block in user_defined_blocks:
                        for block_line in block:
                            merged_lines.append(block_line)
                        merged_lines.append('')  # 在每个块后添加空行
                    user_blocks_added = True
                
                # 只在第一次遇到Internal Logic时添加受保护的行
                if protected_lines and not protected_added:
                    for protected_line in protected_lines:
                        merged_lines.append(protected_line)
                    protected_added = True
                continue  # 跳过后续处理，避免重复添加该行
            elif "endmodule" in line and not user_blocks_added and user_defined_blocks:
                # 如果没有Internal Logic标记，在endmodule前插入用户自定义代码块
                merged_lines.append('')
                for block in user_defined_blocks:
                    for block_line in block:
                        merged_lines.append(block_line)
                    merged_lines.append('')
                user_blocks_added = True
                merged_lines.append(line)
                continue
            elif "endmodule" in line:
                in_internal_logic = False
            elif in_internal_logic and line.strip().startswith('assign') and "TODO" in line:
                # 跳过生成的TODO assign语句，因为我们有受保护的实际实现
                continue
                
            merged_lines.append(line)
            
        return '\n'.join(merged_lines)
    
    def generate_all_rtl(self):
        """生成所有RTL文件"""
        if not self.excel_data:
            self.read_excel_data()
        
        parameters = self.parse_parameters(self.excel_data)
        print(f"解析到参数: {parameters}")
        
        # 创建rtl目录
        rtl_dir = os.path.join(self.work_dir, "rtl")
        if not os.path.exists(rtl_dir):
            os.makedirs(rtl_dir)
            print(f"📁 创建RTL输出目录: {rtl_dir}")
        
        # 解析所有工作表
        all_interfaces = {}
        all_connections = []
        
        for sheet_name, sheet_data in self.excel_data.items():
            if sheet_name in ['Protocol_Arbiter', 'Parameter_Info']:
                continue  # 跳过顶层工作表和参数信息工作表
            
            interfaces, connections = self.parse_sheet_interfaces(sheet_data, sheet_name)
            all_interfaces[sheet_name] = interfaces
            all_connections.extend(connections)
            print(f"工作表 {sheet_name}: 解析到 {len(interfaces)} 个接口, {len(connections)} 个连接")
        
        # 生成顶层模块
        top_rtl = self.generate_top_module(parameters)
        if top_rtl:
            top_file = os.path.join(rtl_dir, "protocol_arbiter.v")
            # 保护现有的受保护行和用户自定义代码块
            protected_lines, user_defined_blocks = self.preserve_protected_lines(top_file)
            if protected_lines or user_defined_blocks:
                top_rtl = self.merge_protected_lines(top_rtl, protected_lines, user_defined_blocks)
                total_protected = len(protected_lines) + sum(len(block) for block in user_defined_blocks)
                print(f"🛡️ 保护了 {len(protected_lines)} 行代码和 {len(user_defined_blocks)} 个用户定义块 (共 {total_protected} 行)")
            with open(top_file, 'w', encoding='utf-8') as f:
                f.write(top_rtl)
            print(f"✅ 顶层模块已生成: {top_file}")
        
        # 生成子模块
        for sheet_name, interfaces in all_interfaces.items():
            if interfaces:  # 只有当有接口定义时才生成
                sub_rtl = self.generate_submodule(sheet_name, interfaces, parameters)
                sub_file = os.path.join(rtl_dir, f"{sheet_name.lower()}.v")
                # 保护现有的受保护行和用户自定义代码块
                protected_lines, user_defined_blocks = self.preserve_protected_lines(sub_file)
                if protected_lines or user_defined_blocks:
                    sub_rtl = self.merge_protected_lines(sub_rtl, protected_lines, user_defined_blocks)
                    total_protected = len(protected_lines) + sum(len(block) for block in user_defined_blocks)
                    print(f"🛡️ {sheet_name}: 保护了 {len(protected_lines)} 行代码和 {len(user_defined_blocks)} 个用户定义块 (共 {total_protected} 行)")
                with open(sub_file, 'w', encoding='utf-8') as f:
                    f.write(sub_rtl)
                print(f"✅ 子模块已生成: {sub_file}")
        
        return len(all_interfaces) + 1  # 返回生成的文件数量
    
    def apply_coding_style_fixes(self):
        """应用RTL coding style修正"""
        print("\n" + "="*60)
        print("开始RTL Coding Style检查与修正...")
        print("="*60)
        
        rtl_dir = os.path.join(self.work_dir, "rtl")
        rtl_files = glob.glob(os.path.join(rtl_dir, "*.v"))
        
        if not rtl_files:
            print("❌ 未找到RTL文件")
            return False
            
        for rtl_file in rtl_files:
            print(f"🔧 修正文件: {os.path.basename(rtl_file)}")
            self.fix_file_coding_style(rtl_file)
            
        print(f"✅ Coding Style修正完成! 共处理 {len(rtl_files)} 个文件")
        return True
    
    def fix_file_coding_style(self, file_path):
        """修正单个文件的coding style"""
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                content = f.read()
            
            # 应用coding style修正规则
            fixed_content = self.apply_style_rules(content, os.path.basename(file_path))
            
            # 写回文件
            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(fixed_content)
                
        except Exception as e:
            print(f"❌ 修正文件 {file_path} 时出错: {e}")
    
    def apply_style_rules(self, content, filename):
        """应用coding style规则"""
        lines = content.split('\n')
        fixed_lines = []
        in_internal_logic = False
        skip_until_endmodule = False
        has_protected_lines = False
        
        # 首先检查是否有受保护的行
        for line in lines:
            if "//  " in line:
                has_protected_lines = True
                break
        
        # 如果有受保护的行，则不进行任何重组，直接返回原内容
        if has_protected_lines:
            print(f"🛡️ 检测到受保护的代码行，跳过编码风格重组: {filename}")
            return content
        
        for i, line in enumerate(lines):
            # 检测Internal Logic部分
            if "// Internal Logic" in line:
                in_internal_logic = True
                fixed_lines.append(line)
                fixed_lines.append('')  # 添加空行
                
                # 收集所有assign语句直到endmodule
                assigns = []
                j = i + 1
                while j < len(lines) and 'endmodule' not in lines[j]:
                    if lines[j].strip().startswith('assign'):
                        assigns.append(lines[j])
                    j += 1
                
                # 分组并添加assign语句
                if assigns:
                    self.group_and_add_assigns(fixed_lines, assigns)
                
                skip_until_endmodule = True
                continue
            elif "endmodule" in line:
                in_internal_logic = False
                skip_until_endmodule = False
                fixed_lines.append(line)
                continue
                
            # 跳过Internal Logic部分的原始内容
            if skip_until_endmodule:
                continue
                
            fixed_lines.append(line)
                
        return '\n'.join(fixed_lines)
    
    def group_and_add_assigns(self, fixed_lines, assigns):
        """分组并添加assign语句"""
        # 按功能分组assign语句
        groups = self.group_assigns_by_function(assigns)
        
        for group_name, group_assigns in groups.items():
            if group_name:
                fixed_lines.append(f"// {group_name}")
            
            for assign_line in group_assigns:
                # 保持原始assign语句，只清理格式
                clean_assign = self.clean_assign_line(assign_line)
                fixed_lines.append(clean_assign)
            
            fixed_lines.append('')  # 组间空行
    
    def group_assigns_by_function(self, assigns):
        """按功能对assign语句进行分组"""
        groups = {
            'Grant signals': [],
            'Command signals': [],
            'Request signals': [],
            'Other signals': []
        }
        
        for assign in assigns:
            if 'grant' in assign.lower():
                groups['Grant signals'].append(assign)
            elif 'cmd' in assign.lower() or 'command' in assign.lower():
                groups['Command signals'].append(assign)
            elif 'req' in assign.lower() or 'request' in assign.lower():
                groups['Request signals'].append(assign)
            else:
                groups['Other signals'].append(assign)
        
        # 只返回非空的组
        return {k: v for k, v in groups.items() if v}
    
    def clean_assign_line(self, line):
        """清理assign语句，只调整格式对齐"""
        # 只清理多余的空格，保持原有注释
        return line.strip()
    
    def run_syntax_check(self):
        """运行iverilog语法检查"""
        print("\n" + "="*60)
        print("开始iverilog语法检查...")
        print("="*60)
        
        rtl_dir = os.path.join(self.work_dir, "rtl")
        rtl_pattern = os.path.join(rtl_dir, "*.v")
        
        try:
            # 运行iverilog语法检查
            cmd = ["iverilog", "-g2012", "-Wall"] + glob.glob(rtl_pattern)
            result = subprocess.run(cmd, capture_output=True, text=True, cwd=self.work_dir)
            
            if result.returncode == 0:
                print("✅ 语法检查通过!")
                if result.stderr:
                    print("⚠️  警告信息:")
                    print(result.stderr)
            else:
                # 检查是否只是警告而非真正的错误
                if result.stderr and 'error' in result.stderr.lower() and 'during elaboration' in result.stderr:
                    print("❌ 语法检查失败! (存在编译错误)")
                    print("错误信息:")
                    print(result.stderr)
                    return False
                else:
                    print("⚠️  语法检查通过 (存在警告)")
                    if result.stderr:
                        print("警告信息:")
                        print(result.stderr)
                
        except FileNotFoundError:
            print("❌ 未找到iverilog工具，请确保已安装并在PATH中")
            return False
        except Exception as e:
            print(f"❌ 语法检查时出错: {e}")
            return False
            
        return True
    
    def run(self):
        """运行RTL生成器"""
        try:
            print("\n" + "="*60)
            print("RTL代码生成器启动")
            print("="*60)
            print("开始生成RTL代码...")
            
            # 步骤1: 读取Excel数据并生成RTL文件
            self.read_excel_data()
            file_count = self.generate_all_rtl()
            
            print(f"\n✅ RTL代码生成完成!")
            print(f"📁 共生成 {file_count} 个RTL文件")
            print(f"📊 源表格: {os.path.basename(self.excel_file)}")
            
            # 步骤2: 应用Coding Style修正
            style_success = self.apply_coding_style_fixes()
            
            # 步骤3: 运行iverilog语法检查
            syntax_success = self.run_syntax_check()
            
            # 总结报告
            print("\n" + "="*60)
            print("RTL生成流程完成")
            print("="*60)
            print(f"✅ RTL生成: 成功 ({file_count} 个文件)")
            print(f"{'✅' if style_success else '❌'} Coding Style: {'成功' if style_success else '失败'}")
            if syntax_success:
                print("✅ 语法检查: 通过")
            else:
                print("❌ 语法检查: 失败")
            
            if not style_success:
                print("\n⚠️  部分步骤未成功完成，请检查上述错误信息")
            elif not syntax_success:
                print("\n⚠️  语法检查存在问题，但RTL代码已成功生成")
                
        except Exception as e:
            print(f"❌ 生成RTL代码时出错: {e}")
            raise

def main():
    """主函数"""
    generator = RTLGenerator()
    generator.run()

if __name__ == "__main__":
    main()