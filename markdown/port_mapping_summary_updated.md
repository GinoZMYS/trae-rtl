# RTL模块与Excel表格端口对应关系总结报告

**基于最新表格**: Protocol_Arbiter (23).xlsx  
**分析时间**: 2024年  
**RTL文件目录**: rtl/  

---

## 📊 总体统计

| 模块名 | Excel端口数 | RTL端口数 | 匹配端口数 | 仅Excel | 仅RTL | 匹配率 |
|--------|-------------|-----------|------------|---------|-------|--------|
| Protocol_Arbiter | 80 | 80 | 80 | 0 | 0 | 100% |
| Function_Arbiter | 50 | 50 | 50 | 0 | 0 | 100% |
| Command_Arbiter | 43 | 43 | 43 | 0 | 0 | 100% |
| Pre_All | 29 | 36 | 22 | 7 | 14 | 75.9% |
| BP_If | 13 | 13 | 9 | 4 | 4 | 69.2% |
| **总计** | **215** | **222** | **204** | **11** | **18** | **94.8%** |

---

## ✅ 完全对应的模块

### 1. Protocol_Arbiter 模块
- **状态**: ✅ 端口完全对应
- **Excel端口**: 80个
- **RTL端口**: 80个
- **匹配情况**: 所有端口名称完全匹配
- **主要问题**: 位宽格式差异
  - Excel格式: `[1-1:0]`, `[RK_NUM*SC_NUM-1:0]`
  - RTL格式: `0`, `RK_NUM*SC_NUM-1:0`

### 2. Function_Arbiter 模块
- **状态**: ✅ 端口完全对应
- **Excel端口**: 50个
- **RTL端口**: 50个
- **匹配情况**: 所有端口名称完全匹配
- **主要问题**: 位宽格式差异
  - Excel格式: `1`, `RK_NUM*SC_NUM`
  - RTL格式: `0`, `RK_NUM*SC_NUM-1:0`

### 3. Command_Arbiter 模块
- **状态**: ✅ 端口完全对应
- **Excel端口**: 43个
- **RTL端口**: 43个
- **匹配情况**: 所有端口名称完全匹配
- **主要问题**: 位宽格式差异
  - Excel格式: `1`, `2`
  - RTL格式: `0`, `2-1:0`

---

## ⚠️ 部分对应的模块

### 4. Pre_All 模块
- **状态**: ⚠️ 部分对应
- **Excel端口**: 29个
- **RTL端口**: 36个
- **匹配端口**: 22个 (75.9%)

#### 仅在Excel中定义的端口 (7个):
1. `pre_all_grant_lp` - output [2**DDRC_RK_WIDTH-1:0]
2. `pre_all_grant_pim` - input [RK_NUM*SC_NUM-1:0]
3. `pre_all_req_pim` - input [RK_NUM*SC_NUM-1:0]
4. `pre_all_req_type_pim` - input [3*RK_NUM*SC_NUM-1:0]
5. `pre_all_req_urgent_pim` - output [RK_NUM*SC_NUM-1:0]
6. `prea_cmd_rk` - output [DDRC_RK_WIDTH-1:0]
7. `prea_cmd_sc` - output [1-1:0]

#### 仅在RTL中定义的端口 (14个):
1. `pre_ab_all_ack_grant_pim` - output [RK_NUM*SC_NUM-1:0]
2. `pre_ab_all_grant_lp` - output [2**RK_NUM-1:0]
3. `pre_ab_all_req_intent_lp` - input [2**RK_NUM-1:0]
4. `pre_ab_all_req_intent_pim` - input [RK_NUM*SC_NUM-1:0]
5. `pre_ab_all_req_intent_qos_lp` - input [2**RK_NUM-1:0]
6. `pre_ab_all_req_intent_urgent_qos_pim` - input [RK_NUM*SC_NUM-1:0]
7. `pre_ab_all_req_type_pim` - input [3*RK_NUM*SC_NUM-1:0]
8. `pre_addr` - output [2**RK_NUM-1:0]
9. `pre_gnt_bank_be` - output [DDRC_SCRKBK_WIDTH-1:0]
10. `pre_gnt_be` - output [0]
11. `pre_gnt_type_be` - output [0]
12. `pre_type` - output [2*2**RK_NUM-1:0]
13. `spre_ab_allow` - input [2**RK_NUM-1:0]
14. `spre_ab_allow_ph` - input [2*2**RK_NUM-1:0]

### 5. BP_If 模块
- **状态**: ⚠️ 部分对应
- **Excel端口**: 13个
- **RTL端口**: 13个
- **匹配端口**: 9个 (69.2%)

#### 仅在Excel中定义的端口 (4个):
1. `bp_req_pim` - input [RK_NUM-1:0]
2. `bp_rnkbgbk_0_ref` - output [DDRC_BGBK_WIDTH*RK_NUM*SC_NUM-1:0]
3. `bp_rnkbgbk_1_ref` - output [DDRC_BGBK_WIDTH*RK_NUM*SC_NUM-1:0]
4. (其他端口)

#### 仅在RTL中定义的端口 (4个):
1. `backpressure_pim_bp_req_pim` - input [RK_NUM-1:0]
2. `backpressure_urgent_pim_bp_hqos_pim` - input [RK_NUM-1:0]
3. `bp_rnkbgbk_0_pa` - output [DDRC_SCRKBGBK_WIDTH*RK_NUM*SC_NUM-1:0]
4. `bp_rnkbgbk_1_pa` - output [DDRC_SCRKBGBK_WIDTH*RK_NUM*SC_NUM-1:0]

---

## 🔍 主要问题分析

### 1. 位宽格式差异
**Excel表格格式**:
- 单bit: `1` 或 `[1-1:0]`
- 多bit: `RK_NUM*SC_NUM` 或 `[RK_NUM*SC_NUM-1:0]`

**RTL代码格式**:
- 单bit: `0` (表示单bit信号)
- 多bit: `RK_NUM*SC_NUM-1:0`

### 2. 参数名称不一致
- Excel: `DDRC_RK_WIDTH`
- RTL: `RK_NUM`

### 3. 端口名称差异
某些模块中存在端口名称的细微差异，如:
- Excel: `bp_rnkbgbk_0_ref`
- RTL: `bp_rnkbgbk_0_pa`

### 4. 端口定义不同步
`Pre_All`和`BP_If`模块存在端口定义不同步的问题，可能是由于:
- RTL代码更新但Excel未同步
- Excel规格更新但RTL未实现
- 端口重命名导致的不匹配

---

## 📋 修复建议

### 高优先级
1. **统一Pre_All模块端口定义**
   - 确认Excel中7个独有端口是否需要在RTL中实现
   - 确认RTL中14个独有端口是否需要在Excel中添加

2. **统一BP_If模块端口定义**
   - 解决4个仅在Excel中的端口
   - 解决4个仅在RTL中的端口

### 中优先级
3. **统一位宽表示格式**
   - 建议Excel采用RTL标准格式
   - 或在代码生成时进行格式转换

4. **统一参数命名**
   - 确定使用`DDRC_RK_WIDTH`还是`RK_NUM`
   - 在所有文档和代码中保持一致

### 低优先级
5. **完善端口描述**
   - 为所有端口添加详细的功能描述
   - 统一描述格式和术语

---

## 📈 验证结果

✅ **成功验证的模块**: 3个 (Protocol_Arbiter, Function_Arbiter, Command_Arbiter)  
⚠️ **需要修复的模块**: 2个 (Pre_All, BP_If)  
📊 **总体匹配率**: 94.8%  

**结论**: 大部分模块的端口定义已经很好地对应，主要问题集中在`Pre_All`和`BP_If`模块的端口同步上。建议优先解决这两个模块的端口定义不一致问题。