import pandas as pd
import re

# 读取Parameter_Info工作表
df = pd.read_excel('Protocol_Arbiter (3).xlsx', sheet_name='Parameter_Info', header=None)

print("从Parameter_Info工作表中提取参数定义:")
parameters = {}
formula_parameters = set()

# 遍历所有行和列，查找参数定义
for i, row in df.iterrows():
    for j, cell in enumerate(row):
        if pd.notna(cell):
            cell_str = str(cell).strip()
            # 查找DDRC_PA开头的参数
            if cell_str.startswith('DDRC_PA_') and '_WIDTH' in cell_str:
                # 查看下一个单元格是否是配置值
                if j + 1 < len(row) and pd.notna(row.iloc[j + 1]):
                    config_value = str(row.iloc[j + 1]).strip()
                    print(f"找到参数: {cell_str} = {config_value}")
                    
                    # 判断是否是公式
                    if any(op in config_value for op in ['+', '-', '*', '/', 'DDRC_PA']):
                        formula_parameters.add(cell_str)
                        print(f"  -> 公式参数 (localparam): {cell_str}")
                    else:
                        try:
                            # 尝试转换为数字
                            param_value = int(config_value)
                            parameters[cell_str] = param_value
                            print(f"  -> 数值参数 (parameter): {cell_str} = {param_value}")
                        except ValueError:
                            print(f"  -> 跳过无法解析的参数: {cell_str} = {config_value}")

print(f"\n总结:")
print(f"数值参数 (parameter): {list(parameters.keys())}")
print(f"公式参数 (localparam): {list(formula_parameters)}")

# 检查当前生成的RTL中使用了哪些参数
print("\n检查当前RTL中使用的参数:")
with open('rtl/protocol_arbiter.v', 'r') as f:
    rtl_content = f.read()
    
# 提取RTL中使用的参数
used_params = set()
param_pattern = r'\b(DDRC_PA_[A-Z_]+)\b'
used_params.update(re.findall(param_pattern, rtl_content))

print(f"RTL中使用的参数: {sorted(used_params)}")

# 找出未使用的参数
unused_params = set(parameters.keys()) - used_params
print(f"未使用的参数: {sorted(unused_params)}")