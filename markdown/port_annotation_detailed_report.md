# 子模块端口与Excel表格对应关系详细标注

本报告详细标注了每个子模块的RTL端口与Excel表格中定义的对应关系。

---

# Protocol_Arbiter 模块端口标注报告

**Excel文件**: Protocol_Arbiter (23).xlsx
**工作表**: Protocol_Arbiter
**RTL文件**: rtl/protocol_arbiter.sv

## 统计信息

- Excel中定义的端口数: 80
- RTL中定义的端口数: 80
- 匹配的端口数: 80
- 仅在Excel中的端口数: 0
- 仅在RTL中的端口数: 0

## 匹配的端口 (80个)

| 端口名 | Excel行号 | RTL行号 | 方向匹配 | 位宽匹配 | Excel位宽 | RTL位宽 | 描述 |
|--------|----------|---------|----------|----------|-----------|---------|------|
| actpre_pa_cmd_hqos | 7 | 37 | ✅ | ❌ | [1-1:0] | 0 | ACT/PRE QoS... |
| actpre_pa_cmd_rdy | 5 | 35 | ✅ | ❌ | [1-1:0] | 0 | act_pre_load(Load is connected, Grant will be conn... |
| actpre_pa_cmd_type | 6 | 36 | ✅ | ❌ | [2-1:0] | 2-1:0 | 2'b00: ACT-1
2'b01: ACT-2
2'b10: PREpb... |
| actpre_pa_cmd_vld | 4 | 34 | ✅ | ❌ | [1-1:0] | 0 | ACT/PRE command valid... |
| bank_close_info | 17 | 47 | ✅ | ❌ | [RK_NUM*SC_NUM-1:0] | RK_NUM*SC_NUM-1:0 | pre_al_if... |
| bp_bgbk_0_ref | 20 | 50 | ✅ | ❌ | [DDRC_BGBK_WIDTH*RK_NUM*SC_NUM-1:0] | DDRC_BGBK_WIDTH*RK_NUM*SC_NUM-1:0 | bp_rnkbgbk_0_ref... |
| bp_bgbk_1_ref | 21 | 51 | ✅ | ❌ | [DDRC_BGBK_WIDTH*RK_NUM*SC_NUM-1:0] | DDRC_BGBK_WIDTH*RK_NUM*SC_NUM-1:0 | bp_rnkbgbk_1_ref... |
| bp_req_fe | 60 | 90 | ✅ | ❌ | [RK_NUM*SC_NUM-1:0] | RK_NUM*SC_NUM-1:0 | bp_req_fe... |
| bp_req_lp | 59 | 89 | ✅ | ❌ | [2**DDRC_RK_WIDTH-1:0] | 2**DDRC_RK_WIDTH-1:0 | bp_req_lp... |
| bp_req_pim | 52 | 82 | ✅ | ❌ | [RK_NUM-1:0] | RK_NUM-1:0 | backpressure_pim(bp_req_pim)... |
| bp_req_ref | 18 | 48 | ✅ | ❌ | [RK_NUM*SC_NUM-1:0] | RK_NUM*SC_NUM-1:0 | 3DS will be dropped in Protocol arbiter... |
| bp_rnkbgbk_0_ref | 62 | 92 | ✅ | ❌ | [DDRC_BGBK_WIDTH*RK_NUM*SC_NUM-1:0] | DDRC_BGBK_WIDTH*RK_NUM*SC_NUM-1:0 | bp_rnkbgbk_0_ref... |
| bp_rnkbgbk_1_ref | 63 | 93 | ✅ | ❌ | [DDRC_BGBK_WIDTH*RK_NUM*SC_NUM-1:0] | DDRC_BGBK_WIDTH*RK_NUM*SC_NUM-1:0 | bp_rnkbgbk_0_ref... |
| bp_type_fe | 61 | 91 | ✅ | ❌ | [RK_NUM*SC_NUM-1:0] | RK_NUM*SC_NUM-1:0 | bp_rnkbnk_fe... |
| bq_type_ref | 19 | 49 | ✅ | ❌ | [RK_NUM*SC_NUM-1:0] | RK_NUM*SC_NUM-1:0 | bq_type_ref 0 dual bank 1 all bank... |
| ddrc_clk | 2 | 32 | ✅ | ❌ | [1-1:0] | 0 | core_clk... |
| ddrc_rst_n | 3 | 33 | ✅ | ❌ | [1-1:0] | 0 | core_rstn... |
| flush_done | 16 | 46 | ✅ | ❌ | [1-1:0] | 0 | pb_bp_if... |
| flush_req | 15 | 45 | ✅ | ❌ | [RK_NUM*SC_NUM-1:0] | RK_NUM*SC_NUM-1:0 | pb_bp_if... |
| lp_req_grant | 55 | 85 | ✅ | ❌ | [2**DDRC_RK_WIDTH-1:0] | 2**DDRC_RK_WIDTH-1:0 | Default,PDE,PDX,SRE,SRX,CTRLUPD... |
| lp_req_rank | 53 | 83 | ✅ | ❌ | [2**DDRC_RK_WIDTH-1:0] | 2**DDRC_RK_WIDTH-1:0 | Default,PDE,PDX,SRE,SRX,CTRLUPD... |
| lp_req_type_rank | 54 | 84 | ✅ | ❌ | [2**DDRC_RK_WIDTH*4-1:0] | 2**DDRC_RK_WIDTH*4-1:0 | Default,PDE,PDX,SRE,SRX,CTRLUPD... |
| mrr_grant_ref | 31 | 61 | ✅ | ❌ | [RK_NUM*SC_NUM-1:0] | RK_NUM*SC_NUM-1:0 | mrr_grant_ref... |
| mrr_req_qos_ref | 29 | 59 | ✅ | ❌ | [RK_NUM*SC_NUM-1:0] | RK_NUM*SC_NUM-1:0 | mrr_req_qos_ref... |
| mrr_req_ref | 28 | 58 | ✅ | ❌ | [RK_NUM*SC_NUM-1:0] | RK_NUM*SC_NUM-1:0 | mrr_req_ref... |
| pa_cmd_vld | 70 | 100 | ✅ | ❌ | [1-1:0] | 0 | pa_cmd_vld... |
| pa_dfi_cmd_phase | 73 | 103 | ✅ | ❌ | [DDRC_PA_PHASE_WIDTH-1:0] | DDRC_PA_PHASE_WIDTH-1:0 | pa_dfI_cmd_phase... |
| pa_dfi_cmd_rank | 72 | 102 | ✅ | ❌ | [2**DDRC_RK_WIDTH-1:0] | 2**DDRC_RK_WIDTH-1:0 | pa_dfi_cmd_rank_pre_all... |
| pa_dfi_cmd_sc | 74 | 104 | ✅ | ❌ | [1-1:0] | 0 | pa_dfi_cmd_sc_pre_all... |
| pa_dfi_cmd_type | 71 | 101 | ✅ | ❌ | [DDRC_PA_CMD_WIDTH-1:0] | DDRC_PA_CMD_WIDTH-1:0 | pa_cmd_pre_all... |
| pim_grant | 51 | 81 | ✅ | ❌ | [RK_NUM*SC_NUM-1:0] | RK_NUM*SC_NUM-1:0 | pim_grant... |
| pim_req | 48 | 78 | ✅ | ❌ | [RK_NUM*SC_NUM-1:0] | RK_NUM*SC_NUM-1:0 | pim_req... |
| pim_type | 49 | 79 | ✅ | ❌ | [7*RK_NUM*SC_NUM-1:0] | 7*RK_NUM*SC_NUM-1:0 | pim_type... |
| pim_urgent | 50 | 80 | ✅ | ❌ | [RK_NUM*SC_NUM-1:0] | RK_NUM*SC_NUM-1:0 | pim_urgent... |
| pre_ab_allow | 68 | 98 | ✅ | ❌ | [2*2**DDRC_RK_WIDTH-1:0] | 2*2**DDRC_RK_WIDTH-1:0 | pre_ab_allow... |
| pre_ab_allow_ph | 69 | 99 | ✅ | ❌ | [2*2*2**DDRC_RK_WIDTH-1:0] | 2*2*2**DDRC_RK_WIDTH-1:0 | pre_ab_allow_ph... |
| pre_all_grant_lp | 58 | 88 | ✅ | ❌ | [2**DDRC_RK_WIDTH-1:0] | 2**DDRC_RK_WIDTH-1:0 | pre_ab(all)_grant_lp... |
| pre_all_grant_pim | 47 | 77 | ✅ | ❌ | [RK_NUM*SC_NUM-1:0] | RK_NUM*SC_NUM-1:0 | pre_ab(all)_ack(grant)_pim... |
| pre_all_intent_grant_ref | 24 | 54 | ✅ | ❌ | [RK_NUM*SC_NUM-1:0] | RK_NUM*SC_NUM-1:0 | pre_all_intent_grant_ref... |
| pre_all_intent_lp | 56 | 86 | ✅ | ❌ | [2**DDRC_RK_WIDTH-1:0] | 2**DDRC_RK_WIDTH-1:0 | pre_ab(all)_req(intent)_lp... |
| pre_all_intent_qos_lp | 57 | 87 | ✅ | ❌ | [2**DDRC_RK_WIDTH-1:0] | 2**DDRC_RK_WIDTH-1:0 | pre_ab(all)_req(intent)_(_qos)_lp... |
| pre_all_intent_qos_ref | 23 | 53 | ✅ | ❌ | [RK_NUM*SC_NUM-1:0] | RK_NUM*SC_NUM-1:0 | pre_all_intent_qos_ref... |
| pre_all_intent_ref | 22 | 52 | ✅ | ❌ | [RK_NUM*SC_NUM-1:0] | RK_NUM*SC_NUM-1:0 | pre_all_intent_ref... |
| pre_all_req_pim | 44 | 74 | ✅ | ❌ | [RK_NUM*SC_NUM-1:0] | RK_NUM*SC_NUM-1:0 | pre_ab(all)_req_pim... |
| pre_all_req_type_pim | 46 | 76 | ✅ | ❌ | [3*RK_NUM*SC_NUM-1:0] | 3*RK_NUM*SC_NUM-1:0 | pre_ab(all)_req_type_pim... |
| pre_all_req_urgent_pim | 45 | 75 | ✅ | ❌ | [RK_NUM*SC_NUM-1:0] | RK_NUM*SC_NUM-1:0 | pre_ab(all)_req_urgent(_qos)_pim... |
| pre_gnt_bank_be | 14 | 44 | ✅ | ❌ | [DDRC_SCRKBGBK_WIDTH-1:0] | DDRC_SCRKBGBK_WIDTH-1:0 | Gnt Type Pulse... |
| pre_gnt_be | 12 | 42 | ✅ | ❌ | [1-1:0] | 0 | Gnt Type Pulse... |
| pre_gnt_type_be | 13 | 43 | ✅ | ❌ | [1-1:0] | 0 | Gnt Type Pulse... |
| pre_ph | 65 | 95 | ✅ | ❌ | [2-1:0] | 2-1:0 | pre_ph... |
| pre_vld | 64 | 94 | ✅ | ❌ | [1-1:0] | 0 | pre_vld... |
| prea_cmd_rk | 66 | 96 | ✅ | ❌ | [DDRC_RK_WIDTH-1:0] | DDRC_RK_WIDTH-1:0 | pre_addr... |
| prea_cmd_sc | 67 | 97 | ✅ | ❌ | [1-1:0] | 0 | pre_addr... |
| prepb_grant_ref | 30 | 60 | ✅ | ❌ | [RK_NUM*SC_NUM-1:0] | RK_NUM*SC_NUM-1:0 | prepb_grant_ref... |
| prepb_req_bank_ref | 27 | 57 | ✅ | ❌ | [DDRC_SCRKBGBK_WIDTH*RK_NUM*SC_NUM-1:0] | DDRC_SCRKBGBK_WIDTH*RK_NUM*SC_NUM-1:0 | ... |
| prepb_req_qos_ref | 26 | 56 | ✅ | ❌ | [RK_NUM*SC_NUM-1:0] | RK_NUM*SC_NUM-1:0 | prepb_req_qos_ref... |
| prepb_req_ref | 25 | 55 | ✅ | ❌ | [RK_NUM*SC_NUM-1:0] | RK_NUM*SC_NUM-1:0 | prepb_req_ref... |
| rdwr_pa_cmd_hqos | 11 | 41 | ✅ | ❌ | [1-1:0] | 0 | QoS... |
| rdwr_pa_cmd_rdy | 9 | 39 | ✅ | ❌ | [1-1:0] | 0 | load(Load is connected, Grant will be connected if... |
| rdwr_pa_cmd_type | 10 | 40 | ✅ | ❌ | [2-1:0] | 2-1:0 | RD
WR
RDA
WRA... |
| rdwr_pa_cmd_vld | 8 | 38 | ✅ | ❌ | [1-1:0] | 0 | command valid... |
| refab_grant_ref | 41 | 71 | ✅ | ❌ | [RK_NUM*SC_NUM-1:0] | RK_NUM*SC_NUM-1:0 | refab_grant_ref... |
| refab_req_qos_ref | 35 | 65 | ✅ | ❌ | [RK_NUM*SC_NUM-1:0] | RK_NUM*SC_NUM-1:0 | refab_req_qos_ref... |
| refab_req_ref | 34 | 64 | ✅ | ❌ | [RK_NUM*SC_NUM-1:0] | RK_NUM*SC_NUM-1:0 | refab_req_ref... |
| refdb_grant_ref | 40 | 70 | ✅ | ❌ | [RK_NUM*SC_NUM-1:0] | RK_NUM*SC_NUM-1:0 | refdb_grant_ref... |
| refdb_req_qos_ref | 33 | 63 | ✅ | ❌ | [RK_NUM*SC_NUM-1:0] | RK_NUM*SC_NUM-1:0 | refdb_req_qos_ref... |
| refdb_req_ref | 32 | 62 | ✅ | ❌ | [RK_NUM*SC_NUM-1:0] | RK_NUM*SC_NUM-1:0 | refdb_req_ref... |
| rfmab_grant_ref | 43 | 73 | ✅ | ❌ | [RK_NUM*SC_NUM-1:0] | RK_NUM*SC_NUM-1:0 | rfmab_grant_ref... |
| rfmab_req_qos_ref | 39 | 69 | ✅ | ❌ | [RK_NUM*SC_NUM-1:0] | RK_NUM*SC_NUM-1:0 | rfmab_req_qos_ref... |
| rfmab_req_ref | 38 | 68 | ✅ | ❌ | [RK_NUM*SC_NUM-1:0] | RK_NUM*SC_NUM-1:0 | rfmab_req_ref... |
| rfmpb_grant_ref | 42 | 72 | ✅ | ❌ | [RK_NUM*SC_NUM-1:0] | RK_NUM*SC_NUM-1:0 | rfmsb_grant_ref... |
| rfmpb_req_qos_ref | 37 | 67 | ✅ | ❌ | [RK_NUM*SC_NUM-1:0] | RK_NUM*SC_NUM-1:0 | rfmpb_req_qos_ref... |
| rfmpb_req_ref | 36 | 66 | ✅ | ❌ | [RK_NUM*SC_NUM-1:0] | RK_NUM*SC_NUM-1:0 | rfmpb_req_ref... |
| soft_bp_all_req | 78 | 108 | ✅ | ❌ | [RK_NUM*SC_NUM-1:0] | RK_NUM*SC_NUM-1:0 | SOFT_REQ backpressure request... |
| soft_cmd_grant | 81 | 111 | ✅ | ❌ | [1-1:0] | 0 | cmd grant... |
| soft_cmd_qos | 80 | 110 | ✅ | ❌ | [1-1:0] | 0 | cmd hiqh qos... |
| soft_cmd_req | 79 | 109 | ✅ | ❌ | [1-1:0] | 0 | cmd req... |
| soft_pre_all_grant | 77 | 107 | ✅ | ❌ | [RK_NUM*SC_NUM-1:0] | RK_NUM*SC_NUM-1:0 | pa grant to precharge all... |
| soft_pre_all_qos | 76 | 106 | ✅ | ❌ | [RK_NUM*SC_NUM-1:0] | RK_NUM*SC_NUM-1:0 | SOFT_REQ precharge all high qos... |
| soft_pre_all_req | 75 | 105 | ✅ | ❌ | [RK_NUM*SC_NUM-1:0] | RK_NUM*SC_NUM-1:0 | SOFT_REQ precharge all request... |

## 不匹配的端口详情 (80个)

### prepb_req_qos_ref
- **Excel定义** (行26): input [[RK_NUM*SC_NUM-1:0]] - prepb_req_qos_ref
- **RTL定义** (行56): input [RK_NUM*SC_NUM-1:0] - `input    [RK_NUM*SC_NUM-1:0]       prepb_req_qos_ref,`

### pim_grant
- **Excel定义** (行51): output [[RK_NUM*SC_NUM-1:0]] - pim_grant
- **RTL定义** (行81): output [RK_NUM*SC_NUM-1:0] - `output   [RK_NUM*SC_NUM-1:0]       pim_grant,`

### pim_urgent
- **Excel定义** (行50): input [[RK_NUM*SC_NUM-1:0]] - pim_urgent
- **RTL定义** (行80): input [RK_NUM*SC_NUM-1:0] - `input    [RK_NUM*SC_NUM-1:0]       pim_urgent,`

### pim_req
- **Excel定义** (行48): input [[RK_NUM*SC_NUM-1:0]] - pim_req
- **RTL定义** (行78): input [RK_NUM*SC_NUM-1:0] - `input    [RK_NUM*SC_NUM-1:0]       pim_req,`

### flush_done
- **Excel定义** (行16): input [[1-1:0]] - pb_bp_if
- **RTL定义** (行46): input [0] - `input                              flush_done,`

### actpre_pa_cmd_hqos
- **Excel定义** (行7): input [[1-1:0]] - ACT/PRE QoS
- **RTL定义** (行37): input [0] - `input                              actpre_pa_cmd_hqos,`

### refdb_req_ref
- **Excel定义** (行32): input [[RK_NUM*SC_NUM-1:0]] - refdb_req_ref
- **RTL定义** (行62): input [RK_NUM*SC_NUM-1:0] - `input    [RK_NUM*SC_NUM-1:0]       refdb_req_ref,`

### soft_pre_all_qos
- **Excel定义** (行76): input [[RK_NUM*SC_NUM-1:0]] - SOFT_REQ precharge all high qos
- **RTL定义** (行106): input [RK_NUM*SC_NUM-1:0] - `input    [RK_NUM*SC_NUM-1:0]       soft_pre_all_qos,`

### bank_close_info
- **Excel定义** (行17): input [[RK_NUM*SC_NUM-1:0]] - pre_al_if
- **RTL定义** (行47): input [RK_NUM*SC_NUM-1:0] - `input    [RK_NUM*SC_NUM-1:0]       bank_close_info,`

### flush_req
- **Excel定义** (行15): output [[RK_NUM*SC_NUM-1:0]] - pb_bp_if
- **RTL定义** (行45): output [RK_NUM*SC_NUM-1:0] - `output   [RK_NUM*SC_NUM-1:0]       flush_req,`

### bq_type_ref
- **Excel定义** (行19): input [[RK_NUM*SC_NUM-1:0]] - bq_type_ref 0 dual bank 1 all bank
- **RTL定义** (行49): input [RK_NUM*SC_NUM-1:0] - `input    [RK_NUM*SC_NUM-1:0]       bq_type_ref,`

### rfmab_req_qos_ref
- **Excel定义** (行39): input [[RK_NUM*SC_NUM-1:0]] - rfmab_req_qos_ref
- **RTL定义** (行69): input [RK_NUM*SC_NUM-1:0] - `input    [RK_NUM*SC_NUM-1:0]       rfmab_req_qos_ref,`

### pre_all_grant_pim
- **Excel定义** (行47): output [[RK_NUM*SC_NUM-1:0]] - pre_ab(all)_ack(grant)_pim
- **RTL定义** (行77): output [RK_NUM*SC_NUM-1:0] - `output   [RK_NUM*SC_NUM-1:0]       pre_all_grant_pim,`

### bp_rnkbgbk_0_ref
- **Excel定义** (行62): output [[DDRC_BGBK_WIDTH*RK_NUM*SC_NUM-1:0]] - bp_rnkbgbk_0_ref
- **RTL定义** (行92): output [DDRC_BGBK_WIDTH*RK_NUM*SC_NUM-1:0] - `output   [DDRC_BGBK_WIDTH*RK_NUM*SC_NUM-1:0] bp_rnkbgbk_0_ref,`

### mrr_req_ref
- **Excel定义** (行28): input [[RK_NUM*SC_NUM-1:0]] - mrr_req_ref
- **RTL定义** (行58): input [RK_NUM*SC_NUM-1:0] - `input    [RK_NUM*SC_NUM-1:0]       mrr_req_ref,`

### pre_all_intent_qos_ref
- **Excel定义** (行23): input [[RK_NUM*SC_NUM-1:0]] - pre_all_intent_qos_ref
- **RTL定义** (行53): input [RK_NUM*SC_NUM-1:0] - `input    [RK_NUM*SC_NUM-1:0]       pre_all_intent_qos_ref,`

### lp_req_type_rank
- **Excel定义** (行54): input [[2**DDRC_RK_WIDTH*4-1:0]] - Default,PDE,PDX,SRE,SRX,CTRLUPD
- **RTL定义** (行84): input [2**DDRC_RK_WIDTH*4-1:0] - `input    [2**DDRC_RK_WIDTH*4-1:0]     lp_req_type_rank,`

### ddrc_rst_n
- **Excel定义** (行3): input [[1-1:0]] - core_rstn
- **RTL定义** (行33): input [0] - `input                              ddrc_rst_n,`

### soft_cmd_qos
- **Excel定义** (行80): input [[1-1:0]] - cmd hiqh qos
- **RTL定义** (行110): input [0] - `input                              soft_cmd_qos,`

### prepb_req_bank_ref
- **Excel定义** (行27): input [[DDRC_SCRKBGBK_WIDTH*RK_NUM*SC_NUM-1:0]] - 
- **RTL定义** (行57): input [DDRC_SCRKBGBK_WIDTH*RK_NUM*SC_NUM-1:0] - `input    [DDRC_SCRKBGBK_WIDTH*RK_NUM*SC_NUM-1:0] prepb_req_bank_ref,`

### pre_all_req_pim
- **Excel定义** (行44): input [[RK_NUM*SC_NUM-1:0]] - pre_ab(all)_req_pim
- **RTL定义** (行74): input [RK_NUM*SC_NUM-1:0] - `input    [RK_NUM*SC_NUM-1:0]       pre_all_req_pim,`

### pre_all_req_type_pim
- **Excel定义** (行46): input [[3*RK_NUM*SC_NUM-1:0]] - pre_ab(all)_req_type_pim
- **RTL定义** (行76): input [3*RK_NUM*SC_NUM-1:0] - `input    [3*RK_NUM*SC_NUM-1:0]     pre_all_req_type_pim,`

### prea_cmd_sc
- **Excel定义** (行67): output [[1-1:0]] - pre_addr
- **RTL定义** (行97): output [0] - `output                             prea_cmd_sc,`

### rfmab_req_ref
- **Excel定义** (行38): input [[RK_NUM*SC_NUM-1:0]] - rfmab_req_ref
- **RTL定义** (行68): input [RK_NUM*SC_NUM-1:0] - `input    [RK_NUM*SC_NUM-1:0]       rfmab_req_ref,`

### pa_dfi_cmd_sc
- **Excel定义** (行74): output [[1-1:0]] - pa_dfi_cmd_sc_pre_all
- **RTL定义** (行104): output [0] - `output                             pa_dfi_cmd_sc,`

### bp_bgbk_0_ref
- **Excel定义** (行20): input [[DDRC_BGBK_WIDTH*RK_NUM*SC_NUM-1:0]] - bp_rnkbgbk_0_ref
- **RTL定义** (行50): input [DDRC_BGBK_WIDTH*RK_NUM*SC_NUM-1:0] - `input    [DDRC_BGBK_WIDTH*RK_NUM*SC_NUM-1:0] bp_bgbk_0_ref,`

### prea_cmd_rk
- **Excel定义** (行66): output [[DDRC_RK_WIDTH-1:0]] - pre_addr
- **RTL定义** (行96): output [DDRC_RK_WIDTH-1:0] - `output   [DDRC_RK_WIDTH-1:0]       prea_cmd_rk,`

### mrr_grant_ref
- **Excel定义** (行31): output [[RK_NUM*SC_NUM-1:0]] - mrr_grant_ref
- **RTL定义** (行61): output [RK_NUM*SC_NUM-1:0] - `output   [RK_NUM*SC_NUM-1:0]       mrr_grant_ref,`

### pre_all_req_urgent_pim
- **Excel定义** (行45): input [[RK_NUM*SC_NUM-1:0]] - pre_ab(all)_req_urgent(_qos)_pim
- **RTL定义** (行75): input [RK_NUM*SC_NUM-1:0] - `input    [RK_NUM*SC_NUM-1:0]       pre_all_req_urgent_pim,`

### bp_bgbk_1_ref
- **Excel定义** (行21): input [[DDRC_BGBK_WIDTH*RK_NUM*SC_NUM-1:0]] - bp_rnkbgbk_1_ref
- **RTL定义** (行51): input [DDRC_BGBK_WIDTH*RK_NUM*SC_NUM-1:0] - `input    [DDRC_BGBK_WIDTH*RK_NUM*SC_NUM-1:0] bp_bgbk_1_ref,`

### pre_all_intent_qos_lp
- **Excel定义** (行57): input [[2**DDRC_RK_WIDTH-1:0]] - pre_ab(all)_req(intent)_(_qos)_lp
- **RTL定义** (行87): input [2**DDRC_RK_WIDTH-1:0] - `input    [2**DDRC_RK_WIDTH-1:0]       pre_all_intent_qos_lp,`

### bp_req_fe
- **Excel定义** (行60): output [[RK_NUM*SC_NUM-1:0]] - bp_req_fe
- **RTL定义** (行90): output [RK_NUM*SC_NUM-1:0] - `output   [RK_NUM*SC_NUM-1:0]       bp_req_fe,`

### actpre_pa_cmd_rdy
- **Excel定义** (行5): output [[1-1:0]] - act_pre_load(Load is connected, Grant will be connected if timing could not meet)
- **RTL定义** (行35): output [0] - `output                             actpre_pa_cmd_rdy,`

### soft_cmd_grant
- **Excel定义** (行81): output [[1-1:0]] - cmd grant
- **RTL定义** (行111): output [0] - `output                             soft_cmd_grant`

### pre_vld
- **Excel定义** (行64): output [[1-1:0]] - pre_vld
- **RTL定义** (行94): output [0] - `output                             pre_vld,`

### rfmab_grant_ref
- **Excel定义** (行43): output [[RK_NUM*SC_NUM-1:0]] - rfmab_grant_ref
- **RTL定义** (行73): output [RK_NUM*SC_NUM-1:0] - `output   [RK_NUM*SC_NUM-1:0]       rfmab_grant_ref,`

### rdwr_pa_cmd_hqos
- **Excel定义** (行11): input [[1-1:0]] - QoS
- **RTL定义** (行41): input [0] - `input                              rdwr_pa_cmd_hqos,`

### refab_grant_ref
- **Excel定义** (行41): output [[RK_NUM*SC_NUM-1:0]] - refab_grant_ref
- **RTL定义** (行71): output [RK_NUM*SC_NUM-1:0] - `output   [RK_NUM*SC_NUM-1:0]       refab_grant_ref,`

### pre_gnt_be
- **Excel定义** (行12): output [[1-1:0]] - Gnt Type Pulse
- **RTL定义** (行42): output [0] - `output                             pre_gnt_be,`

### lp_req_rank
- **Excel定义** (行53): input [[2**DDRC_RK_WIDTH-1:0]] - Default,PDE,PDX,SRE,SRX,CTRLUPD
- **RTL定义** (行83): input [2**DDRC_RK_WIDTH-1:0] - `input    [2**DDRC_RK_WIDTH-1:0]       lp_req_rank,`

### bp_req_lp
- **Excel定义** (行59): input [[2**DDRC_RK_WIDTH-1:0]] - bp_req_lp
- **RTL定义** (行89): input [2**DDRC_RK_WIDTH-1:0] - `input    [2**DDRC_RK_WIDTH-1:0]       bp_req_lp,`

### pre_gnt_bank_be
- **Excel定义** (行14): output [[DDRC_SCRKBGBK_WIDTH-1:0]] - Gnt Type Pulse
- **RTL定义** (行44): output [DDRC_SCRKBGBK_WIDTH-1:0] - `output   [DDRC_SCRKBGBK_WIDTH-1:0] pre_gnt_bank_be,`

### pre_ab_allow
- **Excel定义** (行68): input [[2*2**DDRC_RK_WIDTH-1:0]] - pre_ab_allow
- **RTL定义** (行98): input [2*2**DDRC_RK_WIDTH-1:0] - `input    [2*2**DDRC_RK_WIDTH-1:0]  pre_ab_allow,`

### pa_dfi_cmd_phase
- **Excel定义** (行73): output [[DDRC_PA_PHASE_WIDTH-1:0]] - pa_dfI_cmd_phase
- **RTL定义** (行103): output [DDRC_PA_PHASE_WIDTH-1:0] - `output   [DDRC_PA_PHASE_WIDTH-1:0] pa_dfi_cmd_phase,`

### pre_ph
- **Excel定义** (行65): output [[2-1:0]] - pre_ph
- **RTL定义** (行95): output [2-1:0] - `output   [2-1:0]                   pre_ph,`

### rfmpb_req_ref
- **Excel定义** (行36): input [[RK_NUM*SC_NUM-1:0]] - rfmpb_req_ref
- **RTL定义** (行66): input [RK_NUM*SC_NUM-1:0] - `input    [RK_NUM*SC_NUM-1:0]       rfmpb_req_ref,`

### mrr_req_qos_ref
- **Excel定义** (行29): input [[RK_NUM*SC_NUM-1:0]] - mrr_req_qos_ref
- **RTL定义** (行59): input [RK_NUM*SC_NUM-1:0] - `input    [RK_NUM*SC_NUM-1:0]       mrr_req_qos_ref,`

### refdb_grant_ref
- **Excel定义** (行40): output [[RK_NUM*SC_NUM-1:0]] - refdb_grant_ref
- **RTL定义** (行70): output [RK_NUM*SC_NUM-1:0] - `output   [RK_NUM*SC_NUM-1:0]       refdb_grant_ref,`

### pa_dfi_cmd_rank
- **Excel定义** (行72): output [[2**DDRC_RK_WIDTH-1:0]] - pa_dfi_cmd_rank_pre_all
- **RTL定义** (行102): output [2**DDRC_RK_WIDTH-1:0] - `output   [2**DDRC_RK_WIDTH-1:0]       pa_dfi_cmd_rank,`

### refab_req_ref
- **Excel定义** (行34): input [[RK_NUM*SC_NUM-1:0]] - refab_req_ref
- **RTL定义** (行64): input [RK_NUM*SC_NUM-1:0] - `input    [RK_NUM*SC_NUM-1:0]       refab_req_ref,`

### pre_all_intent_ref
- **Excel定义** (行22): input [[RK_NUM*SC_NUM-1:0]] - pre_all_intent_ref
- **RTL定义** (行52): input [RK_NUM*SC_NUM-1:0] - `input    [RK_NUM*SC_NUM-1:0]       pre_all_intent_ref,`

### soft_bp_all_req
- **Excel定义** (行78): input [[RK_NUM*SC_NUM-1:0]] - SOFT_REQ backpressure request
- **RTL定义** (行108): input [RK_NUM*SC_NUM-1:0] - `input    [RK_NUM*SC_NUM-1:0]       soft_bp_all_req,`

### bp_req_pim
- **Excel定义** (行52): input [[RK_NUM-1:0]] - backpressure_pim(bp_req_pim)
- **RTL定义** (行82): input [RK_NUM-1:0] - `input    [RK_NUM-1:0]              bp_req_pim,`

### rdwr_pa_cmd_type
- **Excel定义** (行10): input [[2-1:0]] - RD
WR
RDA
WRA
- **RTL定义** (行40): input [2-1:0] - `input    [2-1:0]                   rdwr_pa_cmd_type,`

### actpre_pa_cmd_type
- **Excel定义** (行6): input [[2-1:0]] - 2'b00: ACT-1
2'b01: ACT-2
2'b10: PREpb
- **RTL定义** (行36): input [2-1:0] - `input    [2-1:0]                   actpre_pa_cmd_type,`

### prepb_grant_ref
- **Excel定义** (行30): output [[RK_NUM*SC_NUM-1:0]] - prepb_grant_ref
- **RTL定义** (行60): output [RK_NUM*SC_NUM-1:0] - `output   [RK_NUM*SC_NUM-1:0]       prepb_grant_ref,`

### pa_cmd_vld
- **Excel定义** (行70): output [[1-1:0]] - pa_cmd_vld
- **RTL定义** (行100): output [0] - `output                             pa_cmd_vld,`

### rdwr_pa_cmd_vld
- **Excel定义** (行8): input [[1-1:0]] - command valid
- **RTL定义** (行38): input [0] - `input                              rdwr_pa_cmd_vld,`

### pre_gnt_type_be
- **Excel定义** (行13): output [[1-1:0]] - Gnt Type Pulse
- **RTL定义** (行43): output [0] - `output                             pre_gnt_type_be,`

### soft_pre_all_grant
- **Excel定义** (行77): output [[RK_NUM*SC_NUM-1:0]] - pa grant to precharge all
- **RTL定义** (行107): output [RK_NUM*SC_NUM-1:0] - `output   [RK_NUM*SC_NUM-1:0]       soft_pre_all_grant,`

### refab_req_qos_ref
- **Excel定义** (行35): input [[RK_NUM*SC_NUM-1:0]] - refab_req_qos_ref
- **RTL定义** (行65): input [RK_NUM*SC_NUM-1:0] - `input    [RK_NUM*SC_NUM-1:0]       refab_req_qos_ref,`

### pim_type
- **Excel定义** (行49): input [[7*RK_NUM*SC_NUM-1:0]] - pim_type
- **RTL定义** (行79): input [7*RK_NUM*SC_NUM-1:0] - `input    [7*RK_NUM*SC_NUM-1:0]     pim_type,`

### refdb_req_qos_ref
- **Excel定义** (行33): input [[RK_NUM*SC_NUM-1:0]] - refdb_req_qos_ref
- **RTL定义** (行63): input [RK_NUM*SC_NUM-1:0] - `input    [RK_NUM*SC_NUM-1:0]       refdb_req_qos_ref,`

### soft_pre_all_req
- **Excel定义** (行75): input [[RK_NUM*SC_NUM-1:0]] - SOFT_REQ precharge all request
- **RTL定义** (行105): input [RK_NUM*SC_NUM-1:0] - `input    [RK_NUM*SC_NUM-1:0]       soft_pre_all_req,`

### rfmpb_req_qos_ref
- **Excel定义** (行37): input [[RK_NUM*SC_NUM-1:0]] - rfmpb_req_qos_ref
- **RTL定义** (行67): input [RK_NUM*SC_NUM-1:0] - `input    [RK_NUM*SC_NUM-1:0]       rfmpb_req_qos_ref,`

### pre_all_intent_lp
- **Excel定义** (行56): input [[2**DDRC_RK_WIDTH-1:0]] - pre_ab(all)_req(intent)_lp
- **RTL定义** (行86): input [2**DDRC_RK_WIDTH-1:0] - `input    [2**DDRC_RK_WIDTH-1:0]       pre_all_intent_lp,`

### pre_ab_allow_ph
- **Excel定义** (行69): input [[2*2*2**DDRC_RK_WIDTH-1:0]] - pre_ab_allow_ph
- **RTL定义** (行99): input [2*2*2**DDRC_RK_WIDTH-1:0] - `input    [2*2*2**DDRC_RK_WIDTH-1:0] pre_ab_allow_ph,`

### soft_cmd_req
- **Excel定义** (行79): input [[1-1:0]] - cmd req
- **RTL定义** (行109): input [0] - `input                              soft_cmd_req,`

### ddrc_clk
- **Excel定义** (行2): input [[1-1:0]] - core_clk
- **RTL定义** (行32): input [0] - `input                              ddrc_clk,`

### pre_all_grant_lp
- **Excel定义** (行58): output [[2**DDRC_RK_WIDTH-1:0]] - pre_ab(all)_grant_lp
- **RTL定义** (行88): output [2**DDRC_RK_WIDTH-1:0] - `output   [2**DDRC_RK_WIDTH-1:0]     pre_all_grant_lp,`

### pre_all_intent_grant_ref
- **Excel定义** (行24): output [[RK_NUM*SC_NUM-1:0]] - pre_all_intent_grant_ref
- **RTL定义** (行54): output [RK_NUM*SC_NUM-1:0] - `output   [RK_NUM*SC_NUM-1:0]       pre_all_intent_grant_ref,`

### bp_type_fe
- **Excel定义** (行61): output [[RK_NUM*SC_NUM-1:0]] - bp_rnkbnk_fe
- **RTL定义** (行91): output [RK_NUM*SC_NUM-1:0] - `output   [RK_NUM*SC_NUM-1:0]       bp_type_fe,`

### bp_rnkbgbk_1_ref
- **Excel定义** (行63): output [[DDRC_BGBK_WIDTH*RK_NUM*SC_NUM-1:0]] - bp_rnkbgbk_0_ref
- **RTL定义** (行93): output [DDRC_BGBK_WIDTH*RK_NUM*SC_NUM-1:0] - `output   [DDRC_BGBK_WIDTH*RK_NUM*SC_NUM-1:0] bp_rnkbgbk_1_ref,`

### pa_dfi_cmd_type
- **Excel定义** (行71): output [[DDRC_PA_CMD_WIDTH-1:0]] - pa_cmd_pre_all
- **RTL定义** (行101): output [DDRC_PA_CMD_WIDTH-1:0] - `output   [DDRC_PA_CMD_WIDTH-1:0] pa_dfi_cmd_type,`

### prepb_req_ref
- **Excel定义** (行25): input [[RK_NUM*SC_NUM-1:0]] - prepb_req_ref
- **RTL定义** (行55): input [RK_NUM*SC_NUM-1:0] - `input    [RK_NUM*SC_NUM-1:0]       prepb_req_ref,`

### rfmpb_grant_ref
- **Excel定义** (行42): output [[RK_NUM*SC_NUM-1:0]] - rfmsb_grant_ref
- **RTL定义** (行72): output [RK_NUM*SC_NUM-1:0] - `output   [RK_NUM*SC_NUM-1:0]       rfmpb_grant_ref,`

### bp_req_ref
- **Excel定义** (行18): input [[RK_NUM*SC_NUM-1:0]] - 3DS will be dropped in Protocol arbiter
- **RTL定义** (行48): input [RK_NUM*SC_NUM-1:0] - `input    [RK_NUM*SC_NUM-1:0]       bp_req_ref,`

### rdwr_pa_cmd_rdy
- **Excel定义** (行9): output [[1-1:0]] - load(Load is connected, Grant will be connected if timing could not meet)
- **RTL定义** (行39): output [0] - `output                             rdwr_pa_cmd_rdy,`

### actpre_pa_cmd_vld
- **Excel定义** (行4): input [[1-1:0]] - ACT/PRE command valid
- **RTL定义** (行34): input [0] - `input                              actpre_pa_cmd_vld,`

### lp_req_grant
- **Excel定义** (行55): output [[2**DDRC_RK_WIDTH-1:0]] - Default,PDE,PDX,SRE,SRX,CTRLUPD
- **RTL定义** (行85): output [2**DDRC_RK_WIDTH-1:0] - `output   [2**DDRC_RK_WIDTH-1:0]       lp_req_grant,`


---

# Function_Arbiter 模块端口标注报告

**Excel文件**: Protocol_Arbiter (23).xlsx
**工作表**: Function_Arbiter
**RTL文件**: rtl/function_arbiter.v

## 统计信息

- Excel中定义的端口数: 50
- RTL中定义的端口数: 50
- 匹配的端口数: 50
- 仅在Excel中的端口数: 0
- 仅在RTL中的端口数: 0

## 匹配的端口 (50个)

| 端口名 | Excel行号 | RTL行号 | 方向匹配 | 位宽匹配 | Excel位宽 | RTL位宽 | 描述 |
|--------|----------|---------|----------|----------|-----------|---------|------|
| actpre_pa_cmd_hqos | 48 | 69 | ✅ | ❌ | 1 | 0 | ... |
| actpre_pa_cmd_type | 47 | 68 | ✅ | ❌ | 1 | 0 | ... |
| actpre_pa_cmd_vld | 46 | 67 | ✅ | ❌ | 1 | 0 | ... |
| cas_off_lp_load_rank | 41 | 62 | ✅ | ❌ | 1 | 0 | ... |
| ddrc_clk | 2 | 23 | ✅ | ❌ | 1 | 0 | ... |
| ddrc_rst_n | 3 | 24 | ✅ | ❌ | 1 | 0 | ... |
| func_hqos | 50 | 71 | ✅ | ❌ | 1 | 0 | ... |
| func_load | 51 | 72 | ✅ | ❌ | 1 | 0 | func_load... |
| func_req | 49 | 70 | ✅ | ❌ | 1 | 0 | func_req... |
| lp_req_grant | 29 | 50 | ✅ | ❌ | [2**DDRC_RK_WIDTH-1:0] | 2**DDRC_RK_WIDTH-1:0 | Default,PDE,PDX,SRE,SRX,CTRLUPD(Load is connected,... |
| lp_req_rank | 27 | 48 | ✅ | ❌ | [2**DDRC_RK_WIDTH-1:0] | 2**DDRC_RK_WIDTH-1:0 | Default,PDE,PDX,SRE,SRX,CTRLUPD... |
| lp_req_type_rank | 28 | 49 | ✅ | ❌ | [2**DDRC_RK_WIDTH*4-1:0] | 2**DDRC_RK_WIDTH*4-1:0 | lp_req_typerank... |
| mrr4_load_h | 39 | 60 | ✅ | ❌ | 1 | 0 | ... |
| mrr_grant_ref | 10 | 31 | ✅ | ❌ | RK_NUM*SC_NUM | RK_NUM*SC_NUM-1:0 | mrr_grant_ref... |
| mrr_req_qos_ref | 9 | 30 | ✅ | ❌ | RK_NUM*SC_NUM | RK_NUM*SC_NUM-1:0 | mrr_req_qos_ref... |
| mrr_req_ref | 8 | 29 | ✅ | ❌ | RK_NUM*SC_NUM | RK_NUM*SC_NUM-1:0 | mrr_req_ref... |
| mrr_zq_high_load | 35 | 56 | ✅ | ❌ | [RK_NUM*SC_NUM-1:0] | RK_NUM*SC_NUM-1:0 | ... |
| mrr_zq_high_req | 33 | 54 | ✅ | ❌ | 1 | 0 | ... |
| mrr_zq_low_load | 36 | 57 | ✅ | ❌ | [RK_NUM*SC_NUM-1:0] | RK_NUM*SC_NUM-1:0 | ... |
| mrr_zq_low_req | 34 | 55 | ✅ | ❌ | 1 | 0 | ... |
| mrrx_load_h | 38 | 59 | ✅ | ❌ | 1 | 0 | ... |
| pdx_lp_load_rank | 40 | 61 | ✅ | ❌ | 1 | 0 | ... |
| pim_grant | 26 | 47 | ✅ | ❌ | [DDRC_SCRK_WIDTH-1:0] | DDRC_SCRK_WIDTH-1:0 | pim_urgent... |
| pim_req | 23 | 44 | ✅ | ❌ | [DDRC_SCRK_WIDTH-1:0] | DDRC_SCRK_WIDTH-1:0 | pim_req... |
| pim_type | 24 | 45 | ✅ | ❌ | [7*DDRC_SCRK_WIDTH-1:0] | 7*DDRC_SCRK_WIDTH-1:0 | pim_type... |
| pim_urgent | 25 | 46 | ✅ | ❌ | [DDRC_SCRK_WIDTH-1:0] | DDRC_SCRK_WIDTH-1:0 | pim_grant... |
| prepb_grant_ref | 7 | 28 | ✅ | ❌ | RK_NUM*SC_NUM | RK_NUM*SC_NUM-1:0 | prepb_grant_ref... |
| prepb_req_bank_ref | 6 | 27 | ✅ | ❌ | DDRC_SCRKBGBK_WIDTH*RK_NUM*SC_NUM | DDRC_SCRKBGBK_WIDTH*RK_NUM*SC_NUM-1:0 | ... |
| prepb_req_qos_ref | 5 | 26 | ✅ | ❌ | RK_NUM*SC_NUM | RK_NUM*SC_NUM-1:0 | prepb_req_qos_ref... |
| prepb_req_ref | 4 | 25 | ✅ | ❌ | RK_NUM*SC_NUM | RK_NUM*SC_NUM-1:0 | prepb_req_ref... |
| refab_grant_ref | 20 | 41 | ✅ | ❌ | RK_NUM*SC_NUM | RK_NUM*SC_NUM-1:0 | refab_grant_ref... |
| refab_load_ref_h | 42 | 63 | ✅ | ❌ | 1 | 0 | ... |
| refab_req_qos_ref | 14 | 35 | ✅ | ❌ | RK_NUM*SC_NUM | RK_NUM*SC_NUM-1:0 | refab_req_qos_ref... |
| refab_req_ref | 13 | 34 | ✅ | ❌ | RK_NUM*SC_NUM | RK_NUM*SC_NUM-1:0 | refab_req_ref... |
| refdb_grant_ref | 19 | 40 | ✅ | ❌ | RK_NUM*SC_NUM | RK_NUM*SC_NUM-1:0 | refdb_grant_ref... |
| refdb_load_ref_h | 43 | 64 | ✅ | ❌ | 1 | 0 | ... |
| refdb_req_qos_ref | 12 | 33 | ✅ | ❌ | RK_NUM*SC_NUM | RK_NUM*SC_NUM-1:0 | refdb_req_qos_ref... |
| refdb_req_ref | 11 | 32 | ✅ | ❌ | RK_NUM*SC_NUM | RK_NUM*SC_NUM-1:0 | refdb_req_ref... |
| rfmab_grant_ref | 22 | 43 | ✅ | ❌ | RK_NUM*SC_NUM | RK_NUM*SC_NUM-1:0 | rfmab_grant_ref... |
| rfmab_load_ref_h | 44 | 65 | ✅ | ❌ | 1 | 0 | ... |
| rfmab_req_qos_ref | 18 | 39 | ✅ | ❌ | RK_NUM*SC_NUM | RK_NUM*SC_NUM-1:0 | rfmab_req_qos_ref... |
| rfmab_req_ref | 17 | 38 | ✅ | ❌ | RK_NUM*SC_NUM | RK_NUM*SC_NUM-1:0 | rfmab_req_ref... |
| rfmpb_grant_ref | 21 | 42 | ✅ | ❌ | RK_NUM*SC_NUM | RK_NUM*SC_NUM-1:0 | rfmsb_grant_ref... |
| rfmpb_load_ref_h | 45 | 66 | ✅ | ❌ | 1 | 0 | ... |
| rfmpb_req_qos_ref | 16 | 37 | ✅ | ❌ | RK_NUM*SC_NUM | RK_NUM*SC_NUM-1:0 | rfmpb_req_qos_ref... |
| rfmpb_req_ref | 15 | 36 | ✅ | ❌ | RK_NUM*SC_NUM | RK_NUM*SC_NUM-1:0 | rfmpb_req_ref... |
| soft_cmd_grant | 32 | 53 | ✅ | ❌ | 1 | 0 | ... |
| soft_cmd_qos | 31 | 52 | ✅ | ❌ | 1 | 0 | soft_grant/load(Load is connected, Grant will be c... |
| soft_cmd_req | 30 | 51 | ✅ | ❌ | 1 | 0 | soft_req... |
| zq_load_h | 37 | 58 | ✅ | ❌ | 1 | 0 | ... |

## 不匹配的端口详情 (50个)

### mrr_req_qos_ref
- **Excel定义** (行9): input [RK_NUM*SC_NUM] - mrr_req_qos_ref
- **RTL定义** (行30): input [RK_NUM*SC_NUM-1:0] - `input    [RK_NUM*SC_NUM-1:0]       mrr_req_qos_ref,`

### refdb_grant_ref
- **Excel定义** (行19): output [RK_NUM*SC_NUM] - refdb_grant_ref
- **RTL定义** (行40): output [RK_NUM*SC_NUM-1:0] - `output   [RK_NUM*SC_NUM-1:0]       refdb_grant_ref,`

### prepb_req_qos_ref
- **Excel定义** (行5): input [RK_NUM*SC_NUM] - prepb_req_qos_ref
- **RTL定义** (行26): input [RK_NUM*SC_NUM-1:0] - `input    [RK_NUM*SC_NUM-1:0]       prepb_req_qos_ref,`

### pim_grant
- **Excel定义** (行26): output [[DDRC_SCRK_WIDTH-1:0]] - pim_urgent
- **RTL定义** (行47): output [DDRC_SCRK_WIDTH-1:0] - `output   [DDRC_SCRK_WIDTH-1:0]     pim_grant,`

### pdx_lp_load_rank
- **Excel定义** (行40): output [1] - 
- **RTL定义** (行61): output [0] - `output                             pdx_lp_load_rank,`

### refab_req_ref
- **Excel定义** (行13): input [RK_NUM*SC_NUM] - refab_req_ref
- **RTL定义** (行34): input [RK_NUM*SC_NUM-1:0] - `input    [RK_NUM*SC_NUM-1:0]       refab_req_ref,`

### rfmpb_req_qos_ref
- **Excel定义** (行16): input [RK_NUM*SC_NUM] - rfmpb_req_qos_ref
- **RTL定义** (行37): input [RK_NUM*SC_NUM-1:0] - `input    [RK_NUM*SC_NUM-1:0]       rfmpb_req_qos_ref,`

### rfmpb_load_ref_h
- **Excel定义** (行45): output [1] - 
- **RTL定义** (行66): output [0] - `output                             rfmpb_load_ref_h,`

### refdb_load_ref_h
- **Excel定义** (行43): output [1] - 
- **RTL定义** (行64): output [0] - `output                             refdb_load_ref_h,`

### pim_urgent
- **Excel定义** (行25): input [[DDRC_SCRK_WIDTH-1:0]] - pim_grant
- **RTL定义** (行46): input [DDRC_SCRK_WIDTH-1:0] - `input    [DDRC_SCRK_WIDTH-1:0]     pim_urgent,`

### refab_load_ref_h
- **Excel定义** (行42): output [1] - 
- **RTL定义** (行63): output [0] - `output                             refab_load_ref_h,`

### pim_req
- **Excel定义** (行23): input [[DDRC_SCRK_WIDTH-1:0]] - pim_req
- **RTL定义** (行44): input [DDRC_SCRK_WIDTH-1:0] - `input    [DDRC_SCRK_WIDTH-1:0]     pim_req,`

### mrr_grant_ref
- **Excel定义** (行10): output [RK_NUM*SC_NUM] - mrr_grant_ref
- **RTL定义** (行31): output [RK_NUM*SC_NUM-1:0] - `output   [RK_NUM*SC_NUM-1:0]       mrr_grant_ref,`

### rfmab_req_ref
- **Excel定义** (行17): input [RK_NUM*SC_NUM] - rfmab_req_ref
- **RTL定义** (行38): input [RK_NUM*SC_NUM-1:0] - `input    [RK_NUM*SC_NUM-1:0]       rfmab_req_ref,`

### mrr_zq_low_req
- **Excel定义** (行34): output [1] - 
- **RTL定义** (行55): output [0] - `output                             mrr_zq_low_req,`

### actpre_pa_cmd_hqos
- **Excel定义** (行48): input [1] - 
- **RTL定义** (行69): input [0] - `input                              actpre_pa_cmd_hqos,`

### refdb_req_ref
- **Excel定义** (行11): input [RK_NUM*SC_NUM] - refdb_req_ref
- **RTL定义** (行32): input [RK_NUM*SC_NUM-1:0] - `input    [RK_NUM*SC_NUM-1:0]       refdb_req_ref,`

### pim_type
- **Excel定义** (行24): input [[7*DDRC_SCRK_WIDTH-1:0]] - pim_type
- **RTL定义** (行45): input [7*DDRC_SCRK_WIDTH-1:0] - `input    [7*DDRC_SCRK_WIDTH-1:0]   pim_type,`

### soft_cmd_req
- **Excel定义** (行30): input [1] - soft_req
- **RTL定义** (行51): input [0] - `input                              soft_cmd_req,`

### mrr_zq_high_load
- **Excel定义** (行35): output [[RK_NUM*SC_NUM-1:0]] - 
- **RTL定义** (行56): output [RK_NUM*SC_NUM-1:0] - `output   [RK_NUM*SC_NUM-1:0]       mrr_zq_high_load,`

### func_hqos
- **Excel定义** (行50): output [1] - 
- **RTL定义** (行71): output [0] - `output                             func_hqos,`

### ddrc_clk
- **Excel定义** (行2): input [1] - 
- **RTL定义** (行23): input [0] - `input                              ddrc_clk,`

### func_load
- **Excel定义** (行51): input [1] - func_load
- **RTL定义** (行72): input [0] - `input                              func_load`

### soft_cmd_grant
- **Excel定义** (行32): output [1] - 
- **RTL定义** (行53): output [0] - `output                             soft_cmd_grant,`

### prepb_grant_ref
- **Excel定义** (行7): output [RK_NUM*SC_NUM] - prepb_grant_ref
- **RTL定义** (行28): output [RK_NUM*SC_NUM-1:0] - `output   [RK_NUM*SC_NUM-1:0]       prepb_grant_ref,`

### actpre_pa_cmd_type
- **Excel定义** (行47): input [1] - 
- **RTL定义** (行68): input [0] - `input                              actpre_pa_cmd_type,`

### rfmab_grant_ref
- **Excel定义** (行22): output [RK_NUM*SC_NUM] - rfmab_grant_ref
- **RTL定义** (行43): output [RK_NUM*SC_NUM-1:0] - `output   [RK_NUM*SC_NUM-1:0]       rfmab_grant_ref,`

### func_req
- **Excel定义** (行49): output [1] - func_req
- **RTL定义** (行70): output [0] - `output                             func_req,`

### refdb_req_qos_ref
- **Excel定义** (行12): input [RK_NUM*SC_NUM] - refdb_req_qos_ref
- **RTL定义** (行33): input [RK_NUM*SC_NUM-1:0] - `input    [RK_NUM*SC_NUM-1:0]       refdb_req_qos_ref,`

### mrr_zq_high_req
- **Excel定义** (行33): output [1] - 
- **RTL定义** (行54): output [0] - `output                             mrr_zq_high_req,`

### rfmab_req_qos_ref
- **Excel定义** (行18): input [RK_NUM*SC_NUM] - rfmab_req_qos_ref
- **RTL定义** (行39): input [RK_NUM*SC_NUM-1:0] - `input    [RK_NUM*SC_NUM-1:0]       rfmab_req_qos_ref,`

### mrr_zq_low_load
- **Excel定义** (行36): output [[RK_NUM*SC_NUM-1:0]] - 
- **RTL定义** (行57): output [RK_NUM*SC_NUM-1:0] - `output   [RK_NUM*SC_NUM-1:0]       mrr_zq_low_load,`

### refab_req_qos_ref
- **Excel定义** (行14): input [RK_NUM*SC_NUM] - refab_req_qos_ref
- **RTL定义** (行35): input [RK_NUM*SC_NUM-1:0] - `input    [RK_NUM*SC_NUM-1:0]       refab_req_qos_ref,`

### refab_grant_ref
- **Excel定义** (行20): output [RK_NUM*SC_NUM] - refab_grant_ref
- **RTL定义** (行41): output [RK_NUM*SC_NUM-1:0] - `output   [RK_NUM*SC_NUM-1:0]       refab_grant_ref,`

### prepb_req_ref
- **Excel定义** (行4): input [RK_NUM*SC_NUM] - prepb_req_ref
- **RTL定义** (行25): input [RK_NUM*SC_NUM-1:0] - `input    [RK_NUM*SC_NUM-1:0]       prepb_req_ref,`

### rfmpb_grant_ref
- **Excel定义** (行21): output [RK_NUM*SC_NUM] - rfmsb_grant_ref
- **RTL定义** (行42): output [RK_NUM*SC_NUM-1:0] - `output   [RK_NUM*SC_NUM-1:0]       rfmpb_grant_ref,`

### lp_req_rank
- **Excel定义** (行27): input [[2**DDRC_RK_WIDTH-1:0]] - Default,PDE,PDX,SRE,SRX,CTRLUPD
- **RTL定义** (行48): input [2**DDRC_RK_WIDTH-1:0] - `input    [2**DDRC_RK_WIDTH-1:0]       lp_req_rank,`

### mrr_req_ref
- **Excel定义** (行8): input [RK_NUM*SC_NUM] - mrr_req_ref
- **RTL定义** (行29): input [RK_NUM*SC_NUM-1:0] - `input    [RK_NUM*SC_NUM-1:0]       mrr_req_ref,`

### actpre_pa_cmd_vld
- **Excel定义** (行46): input [1] - 
- **RTL定义** (行67): input [0] - `input                              actpre_pa_cmd_vld,`

### lp_req_type_rank
- **Excel定义** (行28): input [[2**DDRC_RK_WIDTH*4-1:0]] - lp_req_typerank
- **RTL定义** (行49): input [2**DDRC_RK_WIDTH*4-1:0] - `input    [2**DDRC_RK_WIDTH*4-1:0]     lp_req_type_rank,`

### mrrx_load_h
- **Excel定义** (行38): output [1] - 
- **RTL定义** (行59): output [0] - `output                             mrrx_load_h,`

### ddrc_rst_n
- **Excel定义** (行3): input [1] - 
- **RTL定义** (行24): input [0] - `input                              ddrc_rst_n,`

### mrr4_load_h
- **Excel定义** (行39): output [1] - 
- **RTL定义** (行60): output [0] - `output                             mrr4_load_h,`

### soft_cmd_qos
- **Excel定义** (行31): input [1] - soft_grant/load(Load is connected, Grant will be connected if timing could not meet)
- **RTL定义** (行52): input [0] - `input                              soft_cmd_qos,`

### prepb_req_bank_ref
- **Excel定义** (行6): input [DDRC_SCRKBGBK_WIDTH*RK_NUM*SC_NUM] - 
- **RTL定义** (行27): input [DDRC_SCRKBGBK_WIDTH*RK_NUM*SC_NUM-1:0] - `input    [DDRC_SCRKBGBK_WIDTH*RK_NUM*SC_NUM-1:0] prepb_req_bank_ref,`

### cas_off_lp_load_rank
- **Excel定义** (行41): output [1] - 
- **RTL定义** (行62): output [0] - `output                             cas_off_lp_load_rank,`

### rfmab_load_ref_h
- **Excel定义** (行44): output [1] - 
- **RTL定义** (行65): output [0] - `output                             rfmab_load_ref_h,`

### lp_req_grant
- **Excel定义** (行29): output [[2**DDRC_RK_WIDTH-1:0]] - Default,PDE,PDX,SRE,SRX,CTRLUPD(Load is connected, Grant will be connected if timing could not meet)
- **RTL定义** (行50): output [2**DDRC_RK_WIDTH-1:0] - `output   [2**DDRC_RK_WIDTH-1:0]       lp_req_grant,`

### zq_load_h
- **Excel定义** (行37): output [1] - 
- **RTL定义** (行58): output [0] - `output                             zq_load_h,`

### rfmpb_req_ref
- **Excel定义** (行15): input [RK_NUM*SC_NUM] - rfmpb_req_ref
- **RTL定义** (行36): input [RK_NUM*SC_NUM-1:0] - `input    [RK_NUM*SC_NUM-1:0]       rfmpb_req_ref,`


---

# Command_Arbiter 模块端口标注报告

**Excel文件**: Protocol_Arbiter (23).xlsx
**工作表**: Command_Arbiter
**RTL文件**: rtl/command_arbiter.v

## 统计信息

- Excel中定义的端口数: 43
- RTL中定义的端口数: 43
- 匹配的端口数: 43
- 仅在Excel中的端口数: 0
- 仅在RTL中的端口数: 0

## 匹配的端口 (43个)

| 端口名 | Excel行号 | RTL行号 | 方向匹配 | 位宽匹配 | Excel位宽 | RTL位宽 | 描述 |
|--------|----------|---------|----------|----------|-----------|---------|------|
| actpre_pa_cmd_hqos | 7 | 25 | ✅ | ❌ | 1 | 0 | ACT/PRE QoS... |
| actpre_pa_cmd_rdy | 5 | 23 | ✅ | ❌ | 1 | 0 | act_pre_load(Load is connected, Grant will be conn... |
| actpre_pa_cmd_type | 6 | 24 | ✅ | ❌ | 2 | 2-1:0 | ACT/PRE command type.0: ACT1: PRE... |
| actpre_pa_cmd_vld | 4 | 22 | ✅ | ❌ | 1 | 0 | ACT/PRE command valid... |
| cas_off_lp_load_rank | 32 | 49 | ✅ | ❌ | 1 | 0 | ... |
| clk_en | 41 | 58 | ✅ | ❌ | 1 | 0 | ... |
| ddrc_clk | 2 | 20 | ✅ | ❌ | 1 | 0 | core_clk... |
| ddrc_rst_n | 3 | 21 | ✅ | ❌ | 1 | 0 | core_rstn... |
| func_hqos | 16 | 34 | ✅ | ❌ | 1 | 0 | ... |
| func_load | 17 | 35 | ✅ | ❌ | 1 | 0 | func_load... |
| func_req | 15 | 33 | ✅ | ❌ | 1 | 0 | func_req... |
| func_type_pre_sb | 40 | 57 | ✅ | ❌ | 1 | 0 | ... |
| mask | 24 | 42 | ✅ | ❌ | 1 | 0 | ... |
| mrr4_h_grant | 25 | 43 | ✅ | ❌ | 1 | 0 | ... |
| mrr4_load_h | 33 | 50 | ✅ | ❌ | 1 | 0 | ... |
| mrr_zq_high_load | 20 | 38 | ✅ | ❌ | 1 | 0 | ... |
| mrr_zq_high_req | 18 | 36 | ✅ | ❌ | 1 | 0 | ... |
| mrr_zq_low_load | 21 | 39 | ✅ | ❌ | 1 | 0 | ... |
| mrr_zq_low_req | 19 | 37 | ✅ | ❌ | 1 | 0 | ... |
| mrrx_load_h | 38 | 55 | ✅ | ❌ | 1 | 0 | ... |
| pdx_lp_load_rank | 31 | 48 | ✅ | ❌ | 1 | 0 | ... |
| pim_h_grant | 30 | 47 | ✅ | ❌ | 1 | 0 | ... |
| pre_gnt_bank_be | 45 | 62 | ✅ | ❌ | [DDRC_SCRKBGBK_WIDTH-1:0] | DDRC_SCRKBGBK_WIDTH-1:0 | ... |
| pre_gnt_be | 43 | 60 | ✅ | ❌ | 1 | 0 | ... |
| pre_gnt_type_be | 44 | 61 | ✅ | ❌ | 1 | 0 | ... |
| preab_grant_preall | 14 | 32 | ✅ | ❌ | 1 | 0 | preab_req_preall... |
| preab_req_preall | 12 | 30 | ✅ | ❌ | 1 | 0 | preab_req_preall... |
| preab_req_qos_preall | 13 | 31 | ✅ | ❌ | 1 | 0 | preab_req_preall... |
| prepb_req_bank_ref | 42 | 59 | ✅ | ❌ | DDRC_SCRKBGBK_WIDTH*RK_NUM*SC_NUM | DDRC_SCRKBGBK_WIDTH*RK_NUM*SC_NUM-1:0 | ... |
| rdwr_pa_cmd_hqos | 11 | 29 | ✅ | ❌ | 1 | 0 | QoS... |
| rdwr_pa_cmd_rdy | 9 | 27 | ✅ | ❌ | 1 | 0 | load(Load is connected, Grant will be connected if... |
| rdwr_pa_cmd_type | 10 | 28 | ✅ | ❌ | 2 | 2-1:0 | command type... |
| rdwr_pa_cmd_vld | 8 | 26 | ✅ | ❌ | 1 | 0 | command valid... |
| ref_ab_h_grant | 26 | 44 | ✅ | ❌ | 1 | 0 | ... |
| ref_db_h_grant | 27 | 45 | ✅ | ❌ | 1 | 0 | ... |
| refab_load_ref_h | 34 | 51 | ✅ | ❌ | 1 | 0 | ... |
| refdb_load_ref_h | 35 | 52 | ✅ | ❌ | 1 | 0 | ... |
| rfm_ab_h_grant | 29 | 46 | ✅ | ❌ | 1 | 0 | ... |
| rfmab_load_ref_h | 36 | 53 | ✅ | ❌ | 1 | 0 | ... |
| rfmpb_load_ref_h | 37 | 54 | ✅ | ❌ | 1 | 0 | ... |
| soft_req | 22 | 40 | ✅ | ❌ | 1 | 0 | soft_req... |
| soft_req_grant | 23 | 41 | ✅ | ❌ | 1 | 0 | soft_grant/load(Load is connected, Grant will be c... |
| zq_load_h | 39 | 56 | ✅ | ❌ | 1 | 0 | ... |

## 不匹配的端口详情 (43个)

### soft_req_grant
- **Excel定义** (行23): output [1] - soft_grant/load(Load is connected, Grant will be connected if timing could not meet)
- **RTL定义** (行41): output [0] - `output                             soft_req_grant,`

### func_type_pre_sb
- **Excel定义** (行40): input [1] - 
- **RTL定义** (行57): input [0] - `input                              func_type_pre_sb,`

### pdx_lp_load_rank
- **Excel定义** (行31): input [1] - 
- **RTL定义** (行48): input [0] - `input                              pdx_lp_load_rank,`

### rfm_ab_h_grant
- **Excel定义** (行29): output [1] - 
- **RTL定义** (行46): output [0] - `output                             rfm_ab_h_grant,`

### rfmpb_load_ref_h
- **Excel定义** (行37): input [1] - 
- **RTL定义** (行54): input [0] - `input                              rfmpb_load_ref_h,`

### refdb_load_ref_h
- **Excel定义** (行35): input [1] - 
- **RTL定义** (行52): input [0] - `input                              refdb_load_ref_h,`

### refab_load_ref_h
- **Excel定义** (行34): input [1] - 
- **RTL定义** (行51): input [0] - `input                              refab_load_ref_h,`

### pim_h_grant
- **Excel定义** (行30): output [1] - 
- **RTL定义** (行47): output [0] - `output                             pim_h_grant,`

### preab_req_qos_preall
- **Excel定义** (行13): input [1] - preab_req_preall
- **RTL定义** (行31): input [0] - `input                              preab_req_qos_preall,`

### mrr_zq_low_req
- **Excel定义** (行19): input [1] - 
- **RTL定义** (行37): input [0] - `input                              mrr_zq_low_req,`

### actpre_pa_cmd_hqos
- **Excel定义** (行7): input [1] - ACT/PRE QoS
- **RTL定义** (行25): input [0] - `input                              actpre_pa_cmd_hqos,`

### ref_db_h_grant
- **Excel定义** (行27): output [1] - 
- **RTL定义** (行45): output [0] - `output                             ref_db_h_grant,`

### preab_grant_preall
- **Excel定义** (行14): output [1] - preab_req_preall
- **RTL定义** (行32): output [0] - `output                             preab_grant_preall,`

### rdwr_pa_cmd_type
- **Excel定义** (行10): input [2] - command type
- **RTL定义** (行28): input [2-1:0] - `input    [2-1:0]                   rdwr_pa_cmd_type,`

### mrr_zq_high_load
- **Excel定义** (行20): output [1] - 
- **RTL定义** (行38): output [0] - `output                             mrr_zq_high_load,`

### ref_ab_h_grant
- **Excel定义** (行26): output [1] - 
- **RTL定义** (行44): output [0] - `output                             ref_ab_h_grant,`

### func_hqos
- **Excel定义** (行16): input [1] - 
- **RTL定义** (行34): input [0] - `input                              func_hqos,`

### ddrc_clk
- **Excel定义** (行2): input [1] - core_clk
- **RTL定义** (行20): input [0] - `input                              ddrc_clk,`

### func_load
- **Excel定义** (行17): output [1] - func_load
- **RTL定义** (行35): output [0] - `output                             func_load,`

### actpre_pa_cmd_rdy
- **Excel定义** (行5): output [1] - act_pre_load(Load is connected, Grant will be connected if timing could not meet)
- **RTL定义** (行23): output [0] - `output                             actpre_pa_cmd_rdy,`

### preab_req_preall
- **Excel定义** (行12): input [1] - preab_req_preall
- **RTL定义** (行30): input [0] - `input                              preab_req_preall,`

### actpre_pa_cmd_type
- **Excel定义** (行6): input [2] - ACT/PRE command type.0: ACT1: PRE
- **RTL定义** (行24): input [2-1:0] - `input    [2-1:0]                   actpre_pa_cmd_type,`

### rdwr_pa_cmd_vld
- **Excel定义** (行8): input [1] - command valid
- **RTL定义** (行26): input [0] - `input                              rdwr_pa_cmd_vld,`

### pre_gnt_type_be
- **Excel定义** (行44): output [1] - 
- **RTL定义** (行61): output [0] - `output                             pre_gnt_type_be,`

### rdwr_pa_cmd_hqos
- **Excel定义** (行11): input [1] - QoS
- **RTL定义** (行29): input [0] - `input                              rdwr_pa_cmd_hqos,`

### func_req
- **Excel定义** (行15): input [1] - func_req
- **RTL定义** (行33): input [0] - `input                              func_req,`

### mrr_zq_low_load
- **Excel定义** (行21): output [1] - 
- **RTL定义** (行39): output [0] - `output                             mrr_zq_low_load,`

### pre_gnt_be
- **Excel定义** (行43): output [1] - 
- **RTL定义** (行60): output [0] - `output                             pre_gnt_be,`

### mrr4_h_grant
- **Excel定义** (行25): output [1] - 
- **RTL定义** (行43): output [0] - `output                             mrr4_h_grant,`

### rdwr_pa_cmd_rdy
- **Excel定义** (行9): output [1] - load(Load is connected, Grant will be connected if timing could not meet)
- **RTL定义** (行27): output [0] - `output                             rdwr_pa_cmd_rdy,`

### actpre_pa_cmd_vld
- **Excel定义** (行4): input [1] - ACT/PRE command valid
- **RTL定义** (行22): input [0] - `input                              actpre_pa_cmd_vld,`

### mrrx_load_h
- **Excel定义** (行38): input [1] - 
- **RTL定义** (行55): input [0] - `input                              mrrx_load_h,`

### ddrc_rst_n
- **Excel定义** (行3): input [1] - core_rstn
- **RTL定义** (行21): input [0] - `input                              ddrc_rst_n,`

### mask
- **Excel定义** (行24): input [1] - 
- **RTL定义** (行42): input [0] - `input                              mask,`

### mrr4_load_h
- **Excel定义** (行33): input [1] - 
- **RTL定义** (行50): input [0] - `input                              mrr4_load_h,`

### cas_off_lp_load_rank
- **Excel定义** (行32): input [1] - 
- **RTL定义** (行49): input [0] - `input                              cas_off_lp_load_rank,`

### rfmab_load_ref_h
- **Excel定义** (行36): input [1] - 
- **RTL定义** (行53): input [0] - `input                              rfmab_load_ref_h,`

### prepb_req_bank_ref
- **Excel定义** (行42): input [DDRC_SCRKBGBK_WIDTH*RK_NUM*SC_NUM] - 
- **RTL定义** (行59): input [DDRC_SCRKBGBK_WIDTH*RK_NUM*SC_NUM-1:0] - `input    [DDRC_SCRKBGBK_WIDTH*RK_NUM*SC_NUM-1:0] prepb_req_bank_ref,`

### pre_gnt_bank_be
- **Excel定义** (行45): output [[DDRC_SCRKBGBK_WIDTH-1:0]] - 
- **RTL定义** (行62): output [DDRC_SCRKBGBK_WIDTH-1:0] - `output   [DDRC_SCRKBGBK_WIDTH-1:0] pre_gnt_bank_be`

### mrr_zq_high_req
- **Excel定义** (行18): input [1] - 
- **RTL定义** (行36): input [0] - `input                              mrr_zq_high_req,`

### zq_load_h
- **Excel定义** (行39): input [1] - 
- **RTL定义** (行56): input [0] - `input                              zq_load_h,`

### soft_req
- **Excel定义** (行22): input [1] - soft_req
- **RTL定义** (行40): input [0] - `input                              soft_req,`

### clk_en
- **Excel定义** (行41): input [1] - 
- **RTL定义** (行58): input [0] - `input                              clk_en,`


---

# Pre_All 模块端口标注报告

**Excel文件**: Protocol_Arbiter (23).xlsx
**工作表**: Pre_All
**RTL文件**: rtl/pre_all.v

## 统计信息

- Excel中定义的端口数: 29
- RTL中定义的端口数: 29
- 匹配的端口数: 29
- 仅在Excel中的端口数: 0
- 仅在RTL中的端口数: 0

## 匹配的端口 (29个)

| 端口名 | Excel行号 | RTL行号 | 方向匹配 | 位宽匹配 | Excel位宽 | RTL位宽 | 描述 |
|--------|----------|---------|----------|----------|-----------|---------|------|
| ddrc_clk | 2 | 22 | ✅ | ❌ | 1 | 0 | core_clk... |
| ddrc_rst_n | 3 | 23 | ✅ | ❌ | 1 | 0 | core_rstn... |
| pa_cmd_vld | 23 | 59 | ✅ | ❌ | [1-1:0] | 0 | pa_cmd_vld... |
| pa_dfi_cmd_phase | 26 | 62 | ✅ | ❌ | [DDRC_PA_PHASE_WIDTH-1:0] | DDRC_PA_PHASE_WIDTH-1:0 | pa_dfI_cmd_phase... |
| pa_dfi_cmd_rank | 25 | 61 | ✅ | ❌ | [2**DDRC_RK_WIDTH-1:0] | 2**DDRC_RK_WIDTH-1:0 | pa_dfi_cmd_rank_pre_all... |
| pa_dfi_cmd_sc | 27 | 63 | ✅ | ❌ | [1-1:0] | 0 | pa_dfi_cmd_sc_pre_all... |
| pa_dfi_cmd_type | 24 | 60 | ✅ | ❌ | [DDRC_PA_CMD_WIDTH-1:0] | DDRC_PA_CMD_WIDTH-1:0 | pa_cmd_pre_all... |
| pa_pre_all_grant | 15 | 45 | ✅ | ❌ | [RK_NUM-1:0] | RK_NUM-1:0 | pa_pre_all_grant... |
| pa_pre_pb_grant | 16 | 46 | ✅ | ❌ | [RK_NUM-1:0] | RK_NUM-1:0 | pa_pre_pb_grant... |
| pre_ab_allow | 21 | 55 | ✅ | ❌ | [2*2**DDRC_RK_WIDTH-1:0] | 2*2**DDRC_RK_WIDTH-1:0 | pre_ab_allow... |
| pre_ab_allow_ph | 22 | 56 | ✅ | ❌ | [2*2*2**DDRC_RK_WIDTH-1:0] | 2*2*2**DDRC_RK_WIDTH-1:0 | pre_ab_allow_ph... |
| pre_all_grant_lp | 14 | 42 | ✅ | ❌ | [2**DDRC_RK_WIDTH-1:0] | 2**DDRC_RK_WIDTH-1:0 | pre_ab(all)_grant_lp... |
| pre_all_grant_pim | 13 | 39 | ✅ | ❌ | [RK_NUM*SC_NUM-1:0] | RK_NUM*SC_NUM-1:0 | pre_ab(all)_req(intent)_(_qos)_lp... |
| pre_all_intent_grant_ref | 6 | 28 | ✅ | ❌ | RK_NUM*SC_NUM | RK_NUM*SC_NUM-1:0 | pre_all_intent_grant_ref... |
| pre_all_intent_qos_ref | 5 | 27 | ✅ | ❌ | RK_NUM*SC_NUM | RK_NUM*SC_NUM-1:0 | pre_all_intent_qos_ref... |
| pre_all_intent_ref | 4 | 26 | ✅ | ❌ | RK_NUM*SC_NUM | RK_NUM*SC_NUM-1:0 | pre_all_intent_ref... |
| pre_all_req_pim | 10 | 36 | ✅ | ❌ | [RK_NUM*SC_NUM-1:0] | RK_NUM*SC_NUM-1:0 | pre_ab(all)_req_type_pim... |
| pre_all_req_type_pim | 12 | 38 | ✅ | ❌ | [3*RK_NUM*SC_NUM-1:0] | 3*RK_NUM*SC_NUM-1:0 | pre_ab(all)_req(intent)_lp... |
| pre_all_req_urgent_pim | 11 | 37 | ✅ | ❌ | [RK_NUM*SC_NUM-1:0] | RK_NUM*SC_NUM-1:0 | pre_ab(all)_ack(grant)_pim... |
| pre_ph | 18 | 50 | ✅ | ❌ | [2-1:0] | 1:0 | pre_ph... |
| pre_vld | 17 | 49 | ✅ | ❌ | [1-1:0] | 0 | pre_vld... |
| prea_cmd_rk | 19 | 51 | ✅ | ❌ | [DDRC_RK_WIDTH-1:0] | DDRC_RK_WIDTH-1:0 | pre_addr... |
| prea_cmd_sc | 20 | 52 | ✅ | ❌ | [1-1:0] | 0 | pre_type... |
| preab_grant_preall | 30 | 68 | ✅ | ❌ | [RK_NUM*SC_NUM-1:0] | RK_NUM*SC_NUM-1:0 | preab_req_preall... |
| preab_req_preall | 28 | 66 | ✅ | ❌ | [RK_NUM*SC_NUM-1:0] | RK_NUM*SC_NUM-1:0 | preab_req_preall... |
| preab_req_qos_preall | 29 | 67 | ✅ | ❌ | [RK_NUM*SC_NUM-1:0] | RK_NUM*SC_NUM-1:0 | preab_req_preall... |
| prepb_grant_ref | 9 | 33 | ✅ | ❌ | [RK_NUM*SC_NUM-1:0] | RK_NUM*SC_NUM-1:0 | prepb_grant_ref... |
| prepb_req_qos_ref | 8 | 32 | ✅ | ❌ | [RK_NUM*SC_NUM-1:0] | RK_NUM*SC_NUM-1:0 | prepb_req_qos_ref... |
| prepb_req_ref | 7 | 31 | ✅ | ❌ | [RK_NUM*SC_NUM-1:0] | RK_NUM*SC_NUM-1:0 | prepb_req_ref... |

## 不匹配的端口详情 (29个)

### prepb_req_qos_ref
- **Excel定义** (行8): input [[RK_NUM*SC_NUM-1:0]] - prepb_req_qos_ref
- **RTL定义** (行32): input [RK_NUM*SC_NUM-1:0] - `input    [RK_NUM*SC_NUM-1:0]       prepb_req_qos_ref,`

### pa_pre_pb_grant
- **Excel定义** (行16): output [[RK_NUM-1:0]] - pa_pre_pb_grant
- **RTL定义** (行46): output [RK_NUM-1:0] - `output   [RK_NUM-1:0]              pa_pre_pb_grant,`

### pa_dfi_cmd_rank
- **Excel定义** (行25): output [[2**DDRC_RK_WIDTH-1:0]] - pa_dfi_cmd_rank_pre_all
- **RTL定义** (行61): output [2**DDRC_RK_WIDTH-1:0] - `output   [2**DDRC_RK_WIDTH-1:0]    pa_dfi_cmd_rank,`

### pa_dfi_cmd_sc
- **Excel定义** (行27): output [[1-1:0]] - pa_dfi_cmd_sc_pre_all
- **RTL定义** (行63): output [0] - `output                             pa_dfi_cmd_sc,`

### pre_all_intent_ref
- **Excel定义** (行4): input [RK_NUM*SC_NUM] - pre_all_intent_ref
- **RTL定义** (行26): input [RK_NUM*SC_NUM-1:0] - `input    [RK_NUM*SC_NUM-1:0]       pre_all_intent_ref,`

### prea_cmd_rk
- **Excel定义** (行19): output [[DDRC_RK_WIDTH-1:0]] - pre_addr
- **RTL定义** (行51): output [DDRC_RK_WIDTH-1:0] - `output   [DDRC_RK_WIDTH-1:0]       prea_cmd_rk,`

### preab_req_qos_preall
- **Excel定义** (行29): output [[RK_NUM*SC_NUM-1:0]] - preab_req_preall
- **RTL定义** (行67): output [RK_NUM*SC_NUM-1:0] - `output   [RK_NUM*SC_NUM-1:0]       preab_req_qos_preall,`

### pre_ab_allow_ph
- **Excel定义** (行22): input [[2*2*2**DDRC_RK_WIDTH-1:0]] - pre_ab_allow_ph
- **RTL定义** (行56): input [2*2*2**DDRC_RK_WIDTH-1:0] - `input    [2*2*2**DDRC_RK_WIDTH-1:0] pre_ab_allow_ph,`

### preab_grant_preall
- **Excel定义** (行30): input [[RK_NUM*SC_NUM-1:0]] - preab_req_preall
- **RTL定义** (行68): input [RK_NUM*SC_NUM-1:0] - `input    [RK_NUM*SC_NUM-1:0]       preab_grant_preall`

### pre_all_req_urgent_pim
- **Excel定义** (行11): output [[RK_NUM*SC_NUM-1:0]] - pre_ab(all)_ack(grant)_pim
- **RTL定义** (行37): output [RK_NUM*SC_NUM-1:0] - `output   [RK_NUM*SC_NUM-1:0]       pre_all_req_urgent_pim,`

### ddrc_clk
- **Excel定义** (行2): input [1] - core_clk
- **RTL定义** (行22): input [0] - `input                              ddrc_clk,`

### pre_all_grant_lp
- **Excel定义** (行14): output [[2**DDRC_RK_WIDTH-1:0]] - pre_ab(all)_grant_lp
- **RTL定义** (行42): output [2**DDRC_RK_WIDTH-1:0] - `output   [2**DDRC_RK_WIDTH-1:0]    pre_all_grant_lp,`

### preab_req_preall
- **Excel定义** (行28): output [[RK_NUM*SC_NUM-1:0]] - preab_req_preall
- **RTL定义** (行66): output [RK_NUM*SC_NUM-1:0] - `output   [RK_NUM*SC_NUM-1:0]       preab_req_preall,`

### prepb_grant_ref
- **Excel定义** (行9): output [[RK_NUM*SC_NUM-1:0]] - prepb_grant_ref
- **RTL定义** (行33): output [RK_NUM*SC_NUM-1:0] - `output   [RK_NUM*SC_NUM-1:0]       prepb_grant_ref,`

### pre_all_intent_grant_ref
- **Excel定义** (行6): output [RK_NUM*SC_NUM] - pre_all_intent_grant_ref
- **RTL定义** (行28): output [RK_NUM*SC_NUM-1:0] - `output   [RK_NUM*SC_NUM-1:0]       pre_all_intent_grant_ref,`

### pa_pre_all_grant
- **Excel定义** (行15): output [[RK_NUM-1:0]] - pa_pre_all_grant
- **RTL定义** (行45): output [RK_NUM-1:0] - `output   [RK_NUM-1:0]              pa_pre_all_grant,`

### pa_cmd_vld
- **Excel定义** (行23): output [[1-1:0]] - pa_cmd_vld
- **RTL定义** (行59): output [0] - `output                             pa_cmd_vld,`

### pre_vld
- **Excel定义** (行17): output [[1-1:0]] - pre_vld
- **RTL定义** (行49): output [0] - `output                             pre_vld,`

### prepb_req_ref
- **Excel定义** (行7): input [[RK_NUM*SC_NUM-1:0]] - prepb_req_ref
- **RTL定义** (行31): input [RK_NUM*SC_NUM-1:0] - `input    [RK_NUM*SC_NUM-1:0]       prepb_req_ref,`

### pre_all_grant_pim
- **Excel定义** (行13): input [[RK_NUM*SC_NUM-1:0]] - pre_ab(all)_req(intent)_(_qos)_lp
- **RTL定义** (行39): input [RK_NUM*SC_NUM-1:0] - `input    [RK_NUM*SC_NUM-1:0]       pre_all_grant_pim,`

### pa_dfi_cmd_type
- **Excel定义** (行24): output [[DDRC_PA_CMD_WIDTH-1:0]] - pa_cmd_pre_all
- **RTL定义** (行60): output [DDRC_PA_CMD_WIDTH-1:0] - `output   [DDRC_PA_CMD_WIDTH-1:0]   pa_dfi_cmd_type,`

### pre_all_intent_qos_ref
- **Excel定义** (行5): input [RK_NUM*SC_NUM] - pre_all_intent_qos_ref
- **RTL定义** (行27): input [RK_NUM*SC_NUM-1:0] - `input    [RK_NUM*SC_NUM-1:0]       pre_all_intent_qos_ref,`

### ddrc_rst_n
- **Excel定义** (行3): input [1] - core_rstn
- **RTL定义** (行23): input [0] - `input                              ddrc_rst_n,`

### pre_all_req_type_pim
- **Excel定义** (行12): input [[3*RK_NUM*SC_NUM-1:0]] - pre_ab(all)_req(intent)_lp
- **RTL定义** (行38): input [3*RK_NUM*SC_NUM-1:0] - `input    [3*RK_NUM*SC_NUM-1:0]     pre_all_req_type_pim,`

### pre_all_req_pim
- **Excel定义** (行10): input [[RK_NUM*SC_NUM-1:0]] - pre_ab(all)_req_type_pim
- **RTL定义** (行36): input [RK_NUM*SC_NUM-1:0] - `input    [RK_NUM*SC_NUM-1:0]       pre_all_req_pim,`

### prea_cmd_sc
- **Excel定义** (行20): output [[1-1:0]] - pre_type
- **RTL定义** (行52): output [0] - `output                             prea_cmd_sc,`

### pre_ab_allow
- **Excel定义** (行21): input [[2*2**DDRC_RK_WIDTH-1:0]] - pre_ab_allow
- **RTL定义** (行55): input [2*2**DDRC_RK_WIDTH-1:0] - `input    [2*2**DDRC_RK_WIDTH-1:0]  pre_ab_allow,`

### pa_dfi_cmd_phase
- **Excel定义** (行26): output [[DDRC_PA_PHASE_WIDTH-1:0]] - pa_dfI_cmd_phase
- **RTL定义** (行62): output [DDRC_PA_PHASE_WIDTH-1:0] - `output   [DDRC_PA_PHASE_WIDTH-1:0] pa_dfi_cmd_phase,`

### pre_ph
- **Excel定义** (行18): output [[2-1:0]] - pre_ph
- **RTL定义** (行50): output [1:0] - `output   [1:0]                     pre_ph,`


---

# BP_If 模块端口标注报告

**Excel文件**: Protocol_Arbiter (23).xlsx
**工作表**: BP_If
**RTL文件**: rtl/bp_if.v

## 统计信息

- Excel中定义的端口数: 12
- RTL中定义的端口数: 12
- 匹配的端口数: 12
- 仅在Excel中的端口数: 0
- 仅在RTL中的端口数: 0

## 匹配的端口 (12个)

| 端口名 | Excel行号 | RTL行号 | 方向匹配 | 位宽匹配 | Excel位宽 | RTL位宽 | 描述 |
|--------|----------|---------|----------|----------|-----------|---------|------|
| bp_bgbk_0_ref | 6 | 30 | ✅ | ❌ | [DDRC_BGBK_WIDTH*RK_NUM*SC_NUM-1:0] | DDRC_BGBK_WIDTH*RK_NUM*SC_NUM-1:0 | bp_rnkbgbk_0_ref... |
| bp_bgbk_1_ref | 7 | 31 | ✅ | ❌ | [DDRC_BGBK_WIDTH*RK_NUM*SC_NUM-1:0] | DDRC_BGBK_WIDTH*RK_NUM*SC_NUM-1:0 | bp_rnkbgbk_1_ref... |
| bp_req_fe | 10 | 40 | ✅ | ❌ | [RK_NUM*SC_NUM-1:0] | RK_NUM*SC_NUM-1:0 | bp_req_fe... |
| bp_req_lp | 9 | 37 | ✅ | ❌ | [2**DDRC_RK_WIDTH-1:0] | 2**DDRC_RK_WIDTH-1:0 | bp_req_lp... |
| bp_req_pim | 8 | 34 | ✅ | ❌ | [RK_NUM-1:0] | RK_NUM-1:0 | backpressure_pim(bp_req_pim)... |
| bp_req_ref | 4 | 28 | ✅ | ❌ | [RK_NUM*SC_NUM-1:0] | RK_NUM*SC_NUM-1:0 | 3DS will be dropped in Protocol arbiter... |
| bp_rnkbgbk_0_ref | 12 | 44 | ✅ | ❌ | [DDRC_BGBK_WIDTH*RK_NUM*SC_NUM-1:0] | DDRC_BGBK_WIDTH*RK_NUM*SC_NUM-1:0 | bp_rnkbgbk_0_pa... |
| bp_rnkbgbk_1_ref | 13 | 45 | ✅ | ❌ | [DDRC_BGBK_WIDTH*RK_NUM*SC_NUM-1:0] | DDRC_BGBK_WIDTH*RK_NUM*SC_NUM-1:0 | bp_rnkbgbk_1_pa... |
| bp_type_fe | 11 | 41 | ✅ | ❌ | [RK_NUM*SC_NUM-1:0] | RK_NUM*SC_NUM-1:0 | bp_rnkbnk_fe... |
| bq_type_ref | 5 | 29 | ✅ | ❌ | [RK_NUM*SC_NUM-1:0] | RK_NUM*SC_NUM-1:0 | bq_type_ref 0 dual bank 1 all bank... |
| ddrc_clk | 2 | 24 | ✅ | ❌ | 1 | 0 | core_clk... |
| ddrc_rst_n | 3 | 25 | ✅ | ❌ | 1 | 0 | core_rstn... |

## 不匹配的端口详情 (12个)

### bp_req_ref
- **Excel定义** (行4): input [[RK_NUM*SC_NUM-1:0]] - 3DS will be dropped in Protocol arbiter
- **RTL定义** (行28): input [RK_NUM*SC_NUM-1:0] - `input    [RK_NUM*SC_NUM-1:0]       bp_req_ref,`

### bp_req_lp
- **Excel定义** (行9): input [[2**DDRC_RK_WIDTH-1:0]] - bp_req_lp
- **RTL定义** (行37): input [2**DDRC_RK_WIDTH-1:0] - `input    [2**DDRC_RK_WIDTH-1:0]    bp_req_lp,`

### bp_type_fe
- **Excel定义** (行11): output [[RK_NUM*SC_NUM-1:0]] - bp_rnkbnk_fe
- **RTL定义** (行41): output [RK_NUM*SC_NUM-1:0] - `output   [RK_NUM*SC_NUM-1:0]       bp_type_fe,`

### bq_type_ref
- **Excel定义** (行5): input [[RK_NUM*SC_NUM-1:0]] - bq_type_ref 0 dual bank 1 all bank
- **RTL定义** (行29): input [RK_NUM*SC_NUM-1:0] - `input    [RK_NUM*SC_NUM-1:0]       bq_type_ref,`

### bp_req_pim
- **Excel定义** (行8): input [[RK_NUM-1:0]] - backpressure_pim(bp_req_pim)
- **RTL定义** (行34): input [RK_NUM-1:0] - `input    [RK_NUM-1:0]              bp_req_pim,`

### ddrc_rst_n
- **Excel定义** (行3): input [1] - core_rstn
- **RTL定义** (行25): input [0] - `input                              ddrc_rst_n,`

### bp_bgbk_0_ref
- **Excel定义** (行6): input [[DDRC_BGBK_WIDTH*RK_NUM*SC_NUM-1:0]] - bp_rnkbgbk_0_ref
- **RTL定义** (行30): input [DDRC_BGBK_WIDTH*RK_NUM*SC_NUM-1:0] - `input    [DDRC_BGBK_WIDTH*RK_NUM*SC_NUM-1:0] bp_bgbk_0_ref,`

### bp_bgbk_1_ref
- **Excel定义** (行7): input [[DDRC_BGBK_WIDTH*RK_NUM*SC_NUM-1:0]] - bp_rnkbgbk_1_ref
- **RTL定义** (行31): input [DDRC_BGBK_WIDTH*RK_NUM*SC_NUM-1:0] - `input    [DDRC_BGBK_WIDTH*RK_NUM*SC_NUM-1:0] bp_bgbk_1_ref,`

### bp_rnkbgbk_1_ref
- **Excel定义** (行13): output [[DDRC_BGBK_WIDTH*RK_NUM*SC_NUM-1:0]] - bp_rnkbgbk_1_pa
- **RTL定义** (行45): output [DDRC_BGBK_WIDTH*RK_NUM*SC_NUM-1:0] - `output   [DDRC_BGBK_WIDTH*RK_NUM*SC_NUM-1:0] bp_rnkbgbk_1_ref`

### ddrc_clk
- **Excel定义** (行2): input [1] - core_clk
- **RTL定义** (行24): input [0] - `input                              ddrc_clk,`

### bp_req_fe
- **Excel定义** (行10): output [[RK_NUM*SC_NUM-1:0]] - bp_req_fe
- **RTL定义** (行40): output [RK_NUM*SC_NUM-1:0] - `output   [RK_NUM*SC_NUM-1:0]       bp_req_fe,`

### bp_rnkbgbk_0_ref
- **Excel定义** (行12): output [[DDRC_BGBK_WIDTH*RK_NUM*SC_NUM-1:0]] - bp_rnkbgbk_0_pa
- **RTL定义** (行44): output [DDRC_BGBK_WIDTH*RK_NUM*SC_NUM-1:0] - `output   [DDRC_BGBK_WIDTH*RK_NUM*SC_NUM-1:0] bp_rnkbgbk_0_ref,`


---

