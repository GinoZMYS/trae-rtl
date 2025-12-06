#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
端口对应关系可视化脚本
生成各模块端口映射的可视化图表
"""

import pandas as pd
import matplotlib.pyplot as plt
import matplotlib.patches as patches
from matplotlib.patches import FancyBboxPatch
import numpy as np
from typing import Dict, List, Tuple

# 设置中文字体
plt.rcParams['font.sans-serif'] = ['SimHei', 'Arial Unicode MS', 'DejaVu Sans']
plt.rcParams['axes.unicode_minus'] = False

def create_module_port_mapping_chart():
    """创建模块端口映射图表"""
    
    # 模块数据
    modules_data = {
        'Protocol_Arbiter': {
            'excel_ports': 80,
            'rtl_ports': 80,
            'matched': 80,
            'status': 'perfect',
            'color': '#2E8B57'  # 深绿色
        },
        'Function_Arbiter': {
            'excel_ports': 50,
            'rtl_ports': 50,
            'matched': 50,
            'status': 'perfect',
            'color': '#2E8B57'  # 深绿色
        },
        'Command_Arbiter': {
            'excel_ports': 43,
            'rtl_ports': 43,
            'matched': 43,
            'status': 'perfect',
            'color': '#2E8B57'  # 深绿色
        },
        'Pre_All': {
            'excel_ports': 44,
            'rtl_ports': 27,
            'matched': 27,
            'status': 'partial',
            'color': '#FF6B6B'  # 红色
        },
        'BP_If': {
            'excel_ports': 15,
            'rtl_ports': 9,
            'matched': 9,
            'status': 'partial',
            'color': '#FF6B6B'  # 红色
        }
    }
    
    # 创建图表
    fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(16, 8))
    fig.suptitle('子模块端口与Excel表格对应关系可视化', fontsize=16, fontweight='bold')
    
    # 图表1: 端口数量对比
    modules = list(modules_data.keys())
    excel_counts = [modules_data[m]['excel_ports'] for m in modules]
    rtl_counts = [modules_data[m]['rtl_ports'] for m in modules]
    matched_counts = [modules_data[m]['matched'] for m in modules]
    
    x = np.arange(len(modules))
    width = 0.25
    
    bars1 = ax1.bar(x - width, excel_counts, width, label='Excel端口数', color='#4A90E2', alpha=0.8)
    bars2 = ax1.bar(x, rtl_counts, width, label='RTL端口数', color='#F5A623', alpha=0.8)
    bars3 = ax1.bar(x + width, matched_counts, width, label='匹配端口数', color='#7ED321', alpha=0.8)
    
    ax1.set_xlabel('模块名称')
    ax1.set_ylabel('端口数量')
    ax1.set_title('各模块端口数量对比')
    ax1.set_xticks(x)
    ax1.set_xticklabels(modules, rotation=45, ha='right')
    ax1.legend()
    ax1.grid(True, alpha=0.3)
    
    # 添加数值标签
    for bars in [bars1, bars2, bars3]:
        for bar in bars:
            height = bar.get_height()
            ax1.annotate(f'{int(height)}',
                        xy=(bar.get_x() + bar.get_width() / 2, height),
                        xytext=(0, 3),
                        textcoords="offset points",
                        ha='center', va='bottom', fontsize=9)
    
    # 图表2: 匹配状态饼图
    perfect_count = sum(1 for m in modules_data.values() if m['status'] == 'perfect')
    partial_count = sum(1 for m in modules_data.values() if m['status'] == 'partial')
    
    labels = [f'完全匹配\n({perfect_count}个模块)', f'部分匹配\n({partial_count}个模块)']
    sizes = [perfect_count, partial_count]
    colors = ['#2E8B57', '#FF6B6B']
    explode = (0.05, 0.05)
    
    wedges, texts, autotexts = ax2.pie(sizes, explode=explode, labels=labels, colors=colors,
                                       autopct='%1.1f%%', shadow=True, startangle=90)
    ax2.set_title('模块匹配状态分布')
    
    # 美化饼图文字
    for autotext in autotexts:
        autotext.set_color('white')
        autotext.set_fontweight('bold')
    
    plt.tight_layout()
    plt.savefig('port_mapping_overview.png', dpi=300, bbox_inches='tight')
    plt.show()
    
    return fig

def create_detailed_port_mapping_diagram():
    """创建详细的端口映射示意图"""
    
    fig, ax = plt.subplots(figsize=(14, 10))
    fig.suptitle('Protocol_Arbiter 模块端口映射示意图', fontsize=16, fontweight='bold')
    
    # 关键端口组
    port_groups = {
        '时钟复位': {
            'ports': ['ddrc_clk', 'ddrc_rst_n'],
            'excel_rows': [2, 3],
            'rtl_rows': [32, 33],
            'color': '#E3F2FD'
        },
        'ACT/PRE命令': {
            'ports': ['actpre_pa_cmd_vld', 'actpre_pa_cmd_rdy', 'actpre_pa_cmd_type', 'actpre_pa_cmd_hqos'],
            'excel_rows': [4, 5, 6, 7],
            'rtl_rows': [34, 35, 36, 37],
            'color': '#F3E5F5'
        },
        'RD/WR命令': {
            'ports': ['rdwr_pa_cmd_vld', 'rdwr_pa_cmd_rdy', 'rdwr_pa_cmd_type', 'rdwr_pa_cmd_hqos'],
            'excel_rows': [8, 9, 10, 11],
            'rtl_rows': [38, 39, 40, 41],
            'color': '#E8F5E8'
        },
        'DFI输出': {
            'ports': ['pa_cmd_vld', 'pa_dfi_cmd_type', 'pa_dfi_cmd_rank', 'pa_dfi_cmd_phase', 'pa_dfi_cmd_sc'],
            'excel_rows': [70, 71, 72, 73, 74],
            'rtl_rows': [100, 101, 102, 103, 104],
            'color': '#FFF3E0'
        }
    }
    
    y_start = 0.9
    group_height = 0.15
    
    for i, (group_name, group_data) in enumerate(port_groups.items()):
        y_pos = y_start - i * (group_height + 0.05)
        
        # 绘制组标题
        ax.text(0.5, y_pos + group_height/2, group_name, 
               ha='center', va='center', fontsize=12, fontweight='bold',
               bbox=dict(boxstyle="round,pad=0.3", facecolor=group_data['color'], alpha=0.8))
        
        # Excel端口列
        excel_box = FancyBboxPatch((0.05, y_pos - group_height/2), 0.35, group_height,
                                  boxstyle="round,pad=0.02", 
                                  facecolor='#E3F2FD', edgecolor='#1976D2', linewidth=2)
        ax.add_patch(excel_box)
        
        ax.text(0.225, y_pos + group_height/4, 'Excel定义', 
               ha='center', va='center', fontsize=10, fontweight='bold')
        
        # RTL端口列
        rtl_box = FancyBboxPatch((0.6, y_pos - group_height/2), 0.35, group_height,
                                boxstyle="round,pad=0.02", 
                                facecolor='#E8F5E8', edgecolor='#388E3C', linewidth=2)
        ax.add_patch(rtl_box)
        
        ax.text(0.775, y_pos + group_height/4, 'RTL实现', 
               ha='center', va='center', fontsize=10, fontweight='bold')
        
        # 端口详情
        port_y_step = group_height / (len(group_data['ports']) + 1)
        for j, (port, excel_row, rtl_row) in enumerate(zip(group_data['ports'], 
                                                          group_data['excel_rows'], 
                                                          group_data['rtl_rows'])):
            port_y = y_pos + group_height/2 - (j + 1) * port_y_step
            
            # Excel端口信息
            ax.text(0.225, port_y, f'{port}\n(行{excel_row})', 
                   ha='center', va='center', fontsize=8)
            
            # RTL端口信息
            ax.text(0.775, port_y, f'{port}\n(行{rtl_row})', 
                   ha='center', va='center', fontsize=8)
            
            # 连接线
            ax.annotate('', xy=(0.6, port_y), xytext=(0.4, port_y),
                       arrowprops=dict(arrowstyle='<->', color='#666666', lw=1.5))
    
    # 设置图表属性
    ax.set_xlim(0, 1)
    ax.set_ylim(0, 1)
    ax.axis('off')
    
    # 添加图例
    legend_elements = [
        patches.Patch(color='#E3F2FD', label='Excel定义'),
        patches.Patch(color='#E8F5E8', label='RTL实现'),
        patches.Patch(color='#666666', label='端口映射')
    ]
    ax.legend(handles=legend_elements, loc='lower center', ncol=3, 
             bbox_to_anchor=(0.5, -0.05))
    
    plt.tight_layout()
    plt.savefig('protocol_arbiter_port_mapping.png', dpi=300, bbox_inches='tight')
    plt.show()
    
    return fig

def create_port_status_matrix():
    """创建端口状态矩阵图"""
    
    modules = ['Protocol_Arbiter', 'Function_Arbiter', 'Command_Arbiter', 'Pre_All', 'BP_If']
    categories = ['端口名匹配', '方向匹配', '位宽匹配', '数量匹配', '完整性']
    
    # 状态矩阵 (1=完全匹配, 0.5=部分匹配, 0=不匹配)
    status_matrix = np.array([
        [1.0, 1.0, 0.5, 1.0, 1.0],  # Protocol_Arbiter
        [1.0, 1.0, 0.5, 1.0, 1.0],  # Function_Arbiter
        [1.0, 1.0, 0.5, 1.0, 1.0],  # Command_Arbiter
        [1.0, 1.0, 0.5, 0.0, 0.0],  # Pre_All
        [1.0, 1.0, 0.5, 0.0, 0.0],  # BP_If
    ])
    
    fig, ax = plt.subplots(figsize=(10, 6))
    
    # 创建热力图
    im = ax.imshow(status_matrix, cmap='RdYlGn', aspect='auto', vmin=0, vmax=1)
    
    # 设置标签
    ax.set_xticks(np.arange(len(categories)))
    ax.set_yticks(np.arange(len(modules)))
    ax.set_xticklabels(categories)
    ax.set_yticklabels(modules)
    
    # 旋转x轴标签
    plt.setp(ax.get_xticklabels(), rotation=45, ha="right", rotation_mode="anchor")
    
    # 添加数值标签
    for i in range(len(modules)):
        for j in range(len(categories)):
            value = status_matrix[i, j]
            if value == 1.0:
                text = '✓'
                color = 'white'
            elif value == 0.5:
                text = '△'
                color = 'black'
            else:
                text = '✗'
                color = 'white'
            
            ax.text(j, i, text, ha="center", va="center", 
                   color=color, fontsize=16, fontweight='bold')
    
    # 添加颜色条
    cbar = ax.figure.colorbar(im, ax=ax)
    cbar.ax.set_ylabel('匹配程度', rotation=-90, va="bottom")
    
    # 设置标题
    ax.set_title('各模块端口匹配状态矩阵', fontsize=14, fontweight='bold', pad=20)
    
    # 添加图例
    legend_text = '✓ 完全匹配    △ 部分匹配    ✗ 不匹配'
    ax.text(0.5, -0.15, legend_text, transform=ax.transAxes, 
           ha='center', va='top', fontsize=10,
           bbox=dict(boxstyle="round,pad=0.3", facecolor='lightgray', alpha=0.8))
    
    plt.tight_layout()
    plt.savefig('port_status_matrix.png', dpi=300, bbox_inches='tight')
    plt.show()
    
    return fig

def main():
    """主函数"""
    print("🎨 正在生成端口映射可视化图表...")
    
    try:
        # 生成概览图表
        print("📊 生成端口数量对比和匹配状态图...")
        fig1 = create_module_port_mapping_chart()
        
        # 生成详细映射图
        print("🔍 生成Protocol_Arbiter详细端口映射图...")
        fig2 = create_detailed_port_mapping_diagram()
        
        # 生成状态矩阵图
        print("📋 生成端口匹配状态矩阵图...")
        fig3 = create_port_status_matrix()
        
        print("\n✅ 可视化图表生成完成！")
        print("📁 生成的文件:")
        print("   - port_mapping_overview.png: 端口数量对比和匹配状态")
        print("   - protocol_arbiter_port_mapping.png: Protocol_Arbiter详细映射")
        print("   - port_status_matrix.png: 端口匹配状态矩阵")
        
    except Exception as e:
        print(f"❌ 生成图表时出错: {e}")
        import traceback
        traceback.print_exc()

if __name__ == "__main__":
    main()