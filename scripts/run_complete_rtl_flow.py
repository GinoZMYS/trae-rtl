#!/usr/bin/env python3
"""
Complete RTL Generation Flow Script
完整的RTL生成流程脚本

这个脚本演示了完整的RTL生成流程：
1. 从Excel生成RTL代码
2. 应用Coding Style检查与修正
3. 运行iverilog语法检查

Usage: python3 run_complete_rtl_flow.py
"""

import sys
import os
from generate_rtl_from_excel import RTLGenerator

def main():
    """主函数 - 运行完整的RTL生成流程"""
    print("\n" + "="*80)
    print("🚀 完整RTL生成流程启动")
    print("="*80)
    print("流程包括:")
    print("  1️⃣  从Excel生成RTL代码")
    print("  2️⃣  应用Coding Style检查与修正")
    print("  3️⃣  运行iverilog语法检查")
    print("="*80)
    
    try:
        # 创建RTL生成器实例
        generator = RTLGenerator()
        
        # 运行完整流程
        generator.run()
        
        print("\n" + "="*80)
        print("🎉 完整RTL生成流程成功完成!")
        print("="*80)
        print("📁 生成的文件位于: ./rtl/ 目录")
        print("📋 可以查看生成的RTL文件:")
        
        # 列出生成的文件
        rtl_dir = "./rtl"
        if os.path.exists(rtl_dir):
            rtl_files = [f for f in os.listdir(rtl_dir) if f.endswith('.v')]
            for i, file in enumerate(rtl_files, 1):
                print(f"   {i}. {file}")
        
        return 0
        
    except Exception as e:
        print(f"\n❌ RTL生成流程失败: {e}")
        print("请检查错误信息并重试")
        return 1

if __name__ == "__main__":
    exit_code = main()
    sys.exit(exit_code)