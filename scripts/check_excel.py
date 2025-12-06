#!/usr/bin/env python3
import pandas as pd

# 读取Excel文件
data = pd.read_excel('Protocol_Arbiter.xlsx', sheet_name='Pre_All')

print('Pre_All工作表的列名:')
print(list(data.columns))
print('\n前20行详细信息:')
print('序号 | I/O      | Port Name                    | Width     | From/To')
print('-' * 80)

for i in range(min(20, len(data))):
    io = str(data.iloc[i]['I/O']) if pd.notna(data.iloc[i]['I/O']) else 'NaN'
    port = str(data.iloc[i]['Port Name']) if pd.notna(data.iloc[i]['Port Name']) else 'NaN'
    width = str(data.iloc[i]['Width']) if pd.notna(data.iloc[i]['Width']) else 'NaN'
    from_to = str(data.iloc[i]['From/To']) if pd.notna(data.iloc[i]['From/To']) else 'NaN'
    
    print(f'{i:3d}  | {io:8s} | {port:28s} | {width:9s} | {from_to}')

print('\n\n查看其他工作表的结构:')
excel_data = pd.read_excel('Protocol_Arbiter.xlsx', sheet_name=None)
for sheet_name in excel_data.keys():
    if sheet_name != 'Pre_All':
        sheet_data = excel_data[sheet_name]
        print(f'\n{sheet_name} 工作表:')
        print(f'  行数: {len(sheet_data)}')
        print(f'  列名: {list(sheet_data.columns)}')
        if len(sheet_data) > 0:
            print('  前5行:')
            for i in range(min(5, len(sheet_data))):
                if pd.notna(sheet_data.iloc[i, 0]):
                    print(f'    {i}: {sheet_data.iloc[i, 0]}')