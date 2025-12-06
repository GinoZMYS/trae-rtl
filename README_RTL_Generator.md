# RTL代码生成器使用说明

## 功能概述

这个Python脚本能够自动检测最新的`Protocol_Arbiter*.xlsx`表格文件，并根据表格内容生成对应的Verilog RTL代码。

## 文件说明

- `generate_rtl_from_excel.py` - 主要的RTL生成脚本
- `requirements.txt` - Python依赖包列表
- `protocol_arbiter.v` - 生成的RTL代码文件

## 安装依赖

在运行脚本之前，请先安装必要的Python包：

```bash
pip install -r requirements.txt
```

或者单独安装：

```bash
pip install pandas openpyxl xlrd
```

## 使用方法

### 1. 基本使用

直接运行脚本：

```bash
python generate_rtl_from_excel.py
```

脚本会自动：
- 搜索当前目录下所有`Protocol_Arbiter*.xlsx`文件
- 选择最新修改的文件
- 解析表格内容
- 生成`protocol_arbiter.v`文件

### 2. 表格文件要求

#### 文件命名
- 文件名必须以`Protocol_Arbiter`开头
- 文件扩展名为`.xlsx`
- 例如：`Protocol_Arbiter.xlsx`、`Protocol_Arbiter_v2.xlsx`、`Protocol_Arbiter_20231201.xlsx`

#### 表格结构

脚本支持以下工作表：

**参数工作表（可选）：**
- 工作表名：`Parameters`
- 格式：第一列为参数名，第二列为参数值
- 支持的参数：
  - `Rank_Num`
  - `SC_NUM`
  - `DDRC_SCRK_WIDTH`
  - `DDRC_RK_WIDTH`
  - `DDRC_SCRKBGBK_WIDTH`
  - `RKBGBK_WIDTH`
  - `DDRC_Cmd_width`
  - `DDRC_Phase_width`

**接口工作表（可选）：**
- 工作表名：`Interfaces`、`Interface`、`Ports`或`IO`
- 格式：
  - 第一列：信号名称
  - 第二列：方向（input/output）
  - 第三列：位宽
  - 第四列：描述（可选）

### 3. 输出文件

生成的`protocol_arbiter.v`文件包含：
- 模块头部注释（包含源表格文件名和生成时间）
- 参数化的模块定义
- 端口声明
- 基本的内部逻辑实现
- 输出信号赋值

## 脚本特性

### 自动检测最新文件
- 脚本会自动搜索所有匹配的Excel文件
- 根据文件修改时间选择最新的文件
- 避免手动指定文件名的麻烦

### 灵活的表格解析
- 支持多种工作表命名方式
- 对缺失的工作表使用默认值
- 容错处理，避免因表格格式问题导致脚本失败

### 代码生成特性
- 自动添加时间戳和源文件信息
- 参数化设计，便于后续修改
- 规范的Verilog代码格式
- 包含基本的时钟复位逻辑

## 使用示例

假设你有以下文件：
- `Protocol_Arbiter_v1.xlsx`（修改时间：2023-12-01 10:00）
- `Protocol_Arbiter_v2.xlsx`（修改时间：2023-12-01 15:00）

运行脚本后，会自动选择`Protocol_Arbiter_v2.xlsx`作为源文件。

## 故障排除

### 常见错误

1. **找不到Excel文件**
   ```
   FileNotFoundError: 未找到Protocol_Arbiter*.xlsx文件
   ```
   - 确保当前目录下有以`Protocol_Arbiter`开头的Excel文件

2. **依赖包缺失**
   ```
   ModuleNotFoundError: No module named 'pandas'
   ```
   - 运行`pip install -r requirements.txt`安装依赖

3. **Excel文件读取失败**
   - 确保Excel文件没有被其他程序占用
   - 检查文件是否损坏

### 调试信息

脚本运行时会输出详细的调试信息：
- 找到的Excel文件名
- 解析到的参数
- 解析到的接口数量
- 生成状态

## 扩展功能

如需添加新的功能，可以修改脚本中的以下部分：
- `parse_parameters()` - 添加新的参数解析
- `parse_interfaces()` - 修改接口解析逻辑
- `generate_internal_logic()` - 自定义内部逻辑生成

## 注意事项

1. 确保Excel文件格式正确
2. 备份重要的RTL文件，避免被覆盖
3. 生成的代码仅包含基本框架，可能需要手动添加具体的业务逻辑
4. 建议在版本控制系统中管理生成的代码

---

如有问题或建议，请联系开发团队。