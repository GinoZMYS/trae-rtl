# QoS优先级逻辑修改报告

## 修改概述

本次修改针对`function_arbiter.v`文件中的MRR4请求仲裁逻辑，实现了基于QoS的优先级仲裁机制。

## 修改内容

### 文件：`rtl/function_arbiter.v`

**修改位置：** 第159-163行

**原始逻辑：**
- 简单的优先级编码器，选择最低索引的有效请求
- 不区分QoS级别，所有请求按位置优先级处理

**新逻辑：**
- 将请求分为高QoS和低QoS两类
- 高QoS请求具有绝对优先权
- 在同一QoS级别内，低位索引具有更高优先级

### 具体实现

1. **信号分离：**
   ```verilog
   assign mrr4_req_ref_high_qos = mrr_req_ref[RK_NUM*SC_NUM-1:0] & mrr_req_qos_ref[RK_NUM*SC_NUM-1:0];
   assign mrr4_req_ref_low_qos = mrr_req_ref[RK_NUM*SC_NUM-1:0] & (~mrr_req_qos_ref[RK_NUM*SC_NUM-1:0]);
   ```

2. **分别进行优先级编码：**
   ```verilog
   assign mrr4_req_ref_high_qos_priority = mrr4_req_ref_high_qos & (~mrr4_req_ref_high_qos + 1);
   assign mrr4_req_ref_low_qos_priority = mrr4_req_ref_low_qos & (~mrr4_req_ref_low_qos + 1);
   ```

3. **QoS优先级选择：**
   ```verilog
   assign mrr4_req_ref_priority = |mrr4_req_ref_high_qos ? mrr4_req_ref_high_qos_priority : mrr4_req_ref_low_qos_priority;
   ```

## 仲裁规则

1. **高QoS优先：** 当存在任何高QoS请求（QoS位为1）时，优先处理高QoS请求
2. **低位优先：** 在同一QoS级别内，低位索引的请求具有更高优先级
3. **回退机制：** 当没有高QoS请求时，按原有规则处理低QoS请求

## 编译验证

- ✅ 语法检查通过
- ✅ 整体编译成功
- ✅ 无新增警告或错误
- ⚠️ 保留原有的3个非关键端口类型警告

## 修改日期

修改完成时间：当前会话

## 影响范围

此修改仅影响MRR4类型的DDR命令请求仲裁逻辑，不影响其他类型的请求处理。