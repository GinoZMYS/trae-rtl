#!/bin/bash

# RTL语法与警告检查脚本（支持 SystemVerilog .sv）
echo "======================================"
echo "RTL代码语法与警告检查"
echo "======================================"

# 检查rtl目录是否存在
if [ ! -d "rtl" ]; then
    echo "❌ 错误: rtl目录不存在"
    echo "请先运行RTL生成器创建RTL文件"
    exit 1
fi

# 进入rtl目录
cd rtl

# 检查是否安装了iverilog
if ! command -v iverilog &> /dev/null; then
    echo "⚠️  警告: iverilog未安装，无法进行语法检查"
    echo "💡 提示: 可以通过 'brew install icarus-verilog' 安装"
    echo ""
    exit 0
fi

# 使用 SystemVerilog 2012 语法
IVFLAGS="-g2012"

# 子模块检查（.sv）
echo "🔍 使用iverilog进行语法检查 (.sv) ..."
echo ""
echo "检查子模块:"
for file in pre_all.sv command_arbiter.sv function_arbiter.sv bp_if.sv; do
    if [ -f "$file" ]; then
        echo "检查文件: $file"
        if iverilog $IVFLAGS -t null "$file" 2>/dev/null; then
            echo "✅ $file - 语法正确"
        else
            echo "❌ $file - 语法错误:"
            iverilog $IVFLAGS -t null "$file"
        fi
        echo ""
    fi
done

# 顶层集成检查（ddrc_pa.sv + 子模块）
echo "检查顶层集成（ddrc_pa.sv + 子模块）:"
TOP_FILES=(ddrc_pa.sv pre_all.sv function_arbiter.sv command_arbiter.sv bp_if.sv)
if iverilog $IVFLAGS -t null "${TOP_FILES[@]}" 2>/dev/null; then
    echo "✅ ddrc_pa.sv (完整系统) - 语法正确"
else
    echo "❌ ddrc_pa.sv (完整系统) - 语法错误:"
    iverilog $IVFLAGS -t null "${TOP_FILES[@]}"
fi
echo ""

# 警告检查（-Wall）
echo "进行警告检查（-Wall）:"
iverilog $IVFLAGS -Wall -t null "${TOP_FILES[@]}"
echo ""

# 显示文件统计信息（同时统计 .sv 和 .v）
echo "📊 RTL文件统计:"
echo "======================================"
shopt -s nullglob
for file in *.sv *.v; do
    lines=$(wc -l < "$file")
    size=$(ls -lh "$file" | awk '{print $5}')
    echo "📄 $file: $lines 行, $size"
done
shopt -u nullglob

echo ""
echo "🎉 验证完成!"