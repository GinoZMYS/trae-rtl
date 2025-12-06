#!/usr/bin/env python3

import pandas as pd
import re

def check_excel_data():
    # 加载Excel数据
    data = pd.read_excel('Protocol_Arbiter (19).xlsx', sheet_name='Protocol_Arbiter')
    print(f'总行数: {len(data)}')
    
    valid_rows = 0
    parsed_ports = []
    
    for idx, row in data.iterrows():
        # 获取方向
        direction_raw = str(row.iloc[1]).strip() if pd.notna(row.iloc[1]) else ''
        direction = re.sub(r'\s+', ' ', direction_raw).strip().lower()
        
        if 'input' in direction:
            direction = 'input'
        elif 'output' in direction:
            direction = 'output'
        else:
            continue
            
        # 获取名称
        name_raw = str(row.iloc[2]).strip() if pd.notna(row.iloc[2]) else ''
        if not name_raw or name_raw == 'nan':
            continue
            
        # 清理名称
        name = re.sub(r'\s+', '', name_raw)
        name = re.sub(r'[^a-zA-Z0-9_]', '', name)
        if not name:
            continue
            
        valid_rows += 1
        parsed_ports.append({
            'index': idx,
            'direction': direction,
            'name': name,
            'original_name': name_raw
        })
        
    print(f'有效端口行数: {valid_rows}')
    print(f'解析的端口数: {len(parsed_ports)}')
    
    # 显示前10个端口
    print('\n前10个解析的端口:')
    for i, port in enumerate(parsed_ports[:10]):
        print(f'{i+1}: {port["direction"]} {port["name"]} (原始: "{port["original_name"]}")')
    
    # 显示最后10个端口
    print('\n最后10个解析的端口:')
    for i, port in enumerate(parsed_ports[-10:]):
        print(f'{len(parsed_ports)-9+i}: {port["direction"]} {port["name"]} (原始: "{port["original_name"]}")')
    
    return parsed_ports

if __name__ == '__main__':
    check_excel_data()