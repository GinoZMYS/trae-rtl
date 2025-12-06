#!/bin/bash

# RTL代码生成器运行脚本
# 用途：自动检测最新的Protocol_Arbiter*.xlsx文件并生成RTL代码

echo "======================================"
echo "RTL代码生成器"
echo "======================================"
echo ""

# 检查Python环境
if ! command -v python3 &> /dev/null; then
    echo "❌ 错误: 未找到python3命令"
    echo "请确保已安装Python 3"
    exit 1
fi

# 检查依赖包
echo "🔍 检查Python依赖包..."
python3 -c "import pandas, openpyxl, xlrd" 2>/dev/null
if [ $? -ne 0 ]; then
    echo "📦 安装依赖包..."
    python3 -m pip install -r requirements.txt
    if [ $? -ne 0 ]; then
        echo "❌ 依赖包安装失败"
        exit 1
    fi
else
    echo "✅ 依赖包检查通过"
fi

echo ""

# 检查Excel文件
echo "📊 检查Excel文件..."
if ls Protocol_Arbiter*.xlsx 1> /dev/null 2>&1; then
    echo "✅ 找到Protocol_Arbiter*.xlsx文件"
    ls -la Protocol_Arbiter*.xlsx
else
    echo "❌ 未找到Protocol_Arbiter*.xlsx文件"
    echo "请确保当前目录下有以Protocol_Arbiter开头的Excel文件"
    exit 1
fi

echo ""
echo "🚀 开始生成RTL代码..."
echo ""

# 运行RTL生成器
python3 generate_rtl_from_excel.py

# 检查生成结果
if [ $? -eq 0 ]; then
    echo ""
    echo "======================================"
    echo "✅ RTL代码生成完成!"
    echo "======================================"
    
    if [ -f "rtl/protocol_arbiter.v" ]; then
        echo "📁 生成的文件: rtl/protocol_arbiter.v"
        echo "📏 文件大小: $(wc -c < rtl/protocol_arbiter.v) 字节"
        echo "📄 代码行数: $(wc -l < rtl/protocol_arbiter.v) 行"
    fi
    
    echo ""
    echo "🔍 开始RTL语法验证..."
    echo ""
    
    # 运行语法验证
    if [ -f "verify_rtl.sh" ]; then
        chmod +x verify_rtl.sh
        ./verify_rtl.sh
        
        if [ $? -eq 0 ]; then
            echo ""
            echo "======================================"
            echo "🎉 RTL代码已准备好用于后续的综合和仿真流程!"
            echo "======================================"
            echo "✅ 所有RTL文件语法检查通过"
            echo "✅ 代码质量验证完成"
            echo ""
            echo "💡 提示: 可以使用以下命令查看生成的代码:"
             echo "   cat rtl/protocol_arbiter.v"
             echo "   或者用你喜欢的编辑器打开rtl目录下的文件"
        else
            echo ""
            echo "❌ RTL语法验证失败!"
            echo "请检查上述错误信息，代码存在语法问题需要修复"
            exit 1
        fi
    else
        echo "⚠️  警告: 未找到verify_rtl.sh验证脚本"
        echo "RTL代码已生成，但未进行语法验证"
    fi
else
    echo ""
    echo "❌ RTL代码生成失败!"
    echo "请检查错误信息并重试"
    exit 1
fi

echo ""
echo "🎉 任务完成!"