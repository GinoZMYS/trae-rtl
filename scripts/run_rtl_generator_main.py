#!/usr/bin/env python3
"""
主RTL生成器脚本
基于最新的Excel表格生成RTL代码，并保护用户自定义代码

使用方法:
    python3 run_rtl_generator_main.py
"""

import os
import sys
from generate_rtl_from_excel import RTLGenerator

def main():
    """
    主函数 - 运行RTL生成器
    """
    print("\n" + "="*60)
    print("🚀 RTL代码生成器 - 主脚本")
    print("="*60)
    print("📋 功能: 基于最新Excel表格生成RTL代码")
    print("🛡️  特性: 自动保护用户自定义代码块")
    print("✅ 检查: 自动进行语法检查和代码风格修正")
    print("="*60)
    
    try:
        # 创建RTL生成器实例
        generator = RTLGenerator()
        
        # 运行生成器
        generator.run()
        
        print("\n🎉 RTL代码生成完成!")
        print("📁 生成的文件位于: ./rtl/ 目录")
        print("\n💡 提示: 您可以随时运行此脚本来基于最新表格重新生成代码")
        print("🛡️  用户自定义代码块会被自动保护")
        
    except FileNotFoundError as e:
        print(f"❌ 错误: {e}")
        print("💡 请确保当前目录包含 Protocol_Arbiter*.xlsx 文件")
        sys.exit(1)
        
    except Exception as e:
        print(f"❌ 生成过程中出现错误: {e}")
        print("💡 请检查Excel文件格式和内容是否正确")
        sys.exit(1)

if __name__ == "__main__":
    main()