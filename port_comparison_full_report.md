# 全模块RTL与Excel端口对比详细报告

## 对比概览

**对比时间**: 2024年最新更新  
**Excel文件**: Protocol_Arbiter (22).xlsx  
**RTL文件目录**: rtl/  

## 统计结果

| 模块 | Excel端口 | RTL端口 | 匹配端口 | 问题数量 | 状态 |
|------|-----------|---------|----------|----------|------|
| Protocol_Arbiter | 80 | 80 | 80 | 0 | ✅ 完全匹配 |
| Function_Arbiter | 50 | 50 | 50 | 0 | ✅ 完全匹配 |
| Command_Arbiter | 43 | 43 | 43 | 0 | ✅ 完全匹配 |
| Pre_All | 44 | 35 | 27 | 17 | ❌ 需要修复 |
| BP_If | 13 | 13 | 9 | 6 | ❌ 需要修复 |
| **总计** | **230** | **221** | **209** | **23** | **⚠️ 部分问题** |

## 详细问题分析

### ✅ 完全匹配的模块

#### 1. Protocol_Arbiter 模块
- **状态**: ✅ 完全匹配
- **端口数量**: 80个端口全部匹配
- **说明**: 顶层模块端口定义完全符合Excel规范

#### 2. Function_Arbiter 模块
- **状态**: ✅ 完全匹配
- **端口数量**: 50个端口全部匹配
- **说明**: 功能仲裁模块端口定义完全符合Excel规范

#### 3. Command_Arbiter 模块
- **状态**: ✅ 完全匹配
- **端口数量**: 43个端口全部匹配
- **说明**: 命令仲裁模块端口定义完全符合Excel规范

### ❌ 需要修复的模块

#### 4. Pre_All 模块
- **状态**: ❌ 17个问题需要解决
- **匹配端口**: 27个
- **主要问题**:

##### 位宽不匹配问题 (1个)
- `pa_dfi_cmd_rank`: 
  - Excel: `output [2**DDRC_RK_WIDTH-1:0]`
  - RTL: `output [2**RK_NUM-1:0]`
  - **问题**: 参数名称不一致
  - **修复建议**: 统一使用 `DDRC_RK_WIDTH` 或 `RK_NUM`

##### 仅在Excel中的端口 (8个)
这些端口在Excel中定义但RTL中缺失：
1. `pa_dfi_cmd_rank_wide` - output [2**RK_NUM-1:0]
2. `pre_all_grant_fe` - output [RK_NUM*SC_NUM-1:0]
3. `pre_all_grant_lp` - output [2**DDRC_RK_WIDTH-1:0]
4. `pre_all_grant_pim` - input [RK_NUM*SC_NUM-1:0]
5. `pre_all_req_pim` - input [RK_NUM*SC_NUM-1:0]
6. `pre_all_req_type_pim` - input [3*RK_NUM*SC_NUM-1:0]
7. `pre_all_req_urgent_pim` - output [RK_NUM*SC_NUM-1:0]
8. `pre_all_intent_ref` - input [RK_NUM*SC_NUM-1:0]

##### 仅在RTL中的端口 (8个)
这些端口在RTL中存在但Excel中未定义：
1. `pa_dfi_cmd_rank_wide` - output [2**RK_NUM-1:0]
2. `pre_all_grant_fe` - output [RK_NUM*SC_NUM-1:0]
3. `pre_all_grant_lp` - output [2**DDRC_RK_WIDTH-1:0]
4. `pre_all_grant_pim` - input [RK_NUM*SC_NUM-1:0]
5. `pre_all_req_pim` - input [RK_NUM*SC_NUM-1:0]
6. `pre_all_req_type_pim` - input [3*RK_NUM*SC_NUM-1:0]
7. `pre_all_req_urgent_pim` - output [RK_NUM*SC_NUM-1:0]
8. `pre_all_intent_ref` - input [RK_NUM*SC_NUM-1:0]

#### 5. BP_If 模块
- **状态**: ❌ 6个问题需要解决
- **匹配端口**: 9个
- **主要问题**:

##### 位宽不匹配问题 (2个)
1. `bp_rnkbgbk_0_pa`:
   - Excel: `output [DDRC_BGBK_WIDTH*RK_NUM*SC_NUM-1:0]`
   - RTL: `output [DDRC_SCRKBGBK_WIDTH*RK_NUM*SC_NUM-1:0]`
   - **问题**: 参数名称不一致 (`DDRC_BGBK_WIDTH` vs `DDRC_SCRKBGBK_WIDTH`)

2. `bp_rnkbgbk_1_pa`:
   - Excel: `output [DDRC_BGBK_WIDTH*RK_NUM*SC_NUM-1:0]`
   - RTL: `output [DDRC_SCRKBGBK_WIDTH*RK_NUM*SC_NUM-1:0]`
   - **问题**: 参数名称不一致 (`DDRC_BGBK_WIDTH` vs `DDRC_SCRKBGBK_WIDTH`)

##### 端口命名不匹配问题 (4个)
1. Excel: `backpressure_pim(bp_req_pim)` vs RTL: `backpressure_pim_bp_req_pim`
2. Excel: `backpressure_urgent_pim(bp_hqos_pim)` vs RTL: `backpressure_urgent_pim_bp_hqos_pim`

## 修复建议

### 优先级1: 参数名称统一
1. **Pre_All模块**: 统一 `DDRC_RK_WIDTH` 和 `RK_NUM` 的使用
2. **BP_If模块**: 统一 `DDRC_BGBK_WIDTH` 和 `DDRC_SCRKBGBK_WIDTH` 的使用

### 优先级2: 端口定义同步
1. **Pre_All模块**: 确认8个不匹配端口的正确定义，更新Excel或RTL
2. **BP_If模块**: 统一端口命名规范

### 优先级3: 验证和测试
1. 修复后重新运行端口比较脚本
2. 确保所有模块编译通过
3. 运行功能验证测试

## 技术细节

### 位宽匹配规则
- 单位端口: Excel `[1-1:0]` ↔ RTL `1`
- 参数化位宽: Excel `[PARAM-1:0]` ↔ RTL `PARAM-1:0`
- 复杂表达式: Excel `[PARAM1*PARAM2-1:0]` ↔ RTL `PARAM1*PARAM2-1:0`

### 参数映射关系
需要确认以下参数的正确映射：
- `DDRC_RK_WIDTH` ↔ `RK_NUM`
- `DDRC_BGBK_WIDTH` ↔ `DDRC_SCRKBGBK_WIDTH`

## 下一步行动

1. **立即修复**: 修复BP_If模块的参数名称不一致问题
2. **确认需求**: 与设计团队确认Pre_All模块的端口需求
3. **更新文档**: 根据最终确定的端口定义更新Excel表格
4. **验证测试**: 完成修复后进行全面的编译和功能测试

---

**报告生成时间**: 2024年最新  
**工具版本**: compare_all_modules.py v1.0  
**状态**: 需要进一步修复和验证