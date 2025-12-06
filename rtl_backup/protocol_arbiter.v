//==============================================================================
// protocol_arbiter Module
// Generated from Protocol_Arbiter (6).xlsx
// Auto-generated on 2025-08-11 15:37:22
//==============================================================================

module protocol_arbiter #(
    parameter DDRC_PA_RK_WIDTH = 2,
    parameter DDRC_PA_ROW_WIDTH = 16,
    parameter DDRC_PA_BG_WIDTH = 2,
    parameter DDRC_PA_BK_WIDTH = 2,
    parameter DDRC_PA_SC_WIDTH = 1,
    parameter DDRC_PA_QOS_WIDTH = 4,
    parameter DDRC_PA_RD_INFO_WIDTH = 16,
    parameter DDRC_PA_WR_INFO_WIDTH = 16,
    parameter DDRC_PA_BQ_NUM = 4,
    parameter DDRC_PA_CMD_WIDTH = 5,
    parameter DDRC_PA_PHASE_WIDTH = 2
)(
    output                              pre_gnt_be,
    output                              pre_gnt_type_be,
    output   [DDRC_SCRKBK_WIDTH-1:0]   pre_gnt_bank_be,
    input    [RK_NUM*SC_NUM-1:0]       pre_all_intent_ref,
    input    [RK_NUM*SC_NUM-1:0]       pre_all_intent_qos_ref,
    output   [RK_NUM*SC_NUM-1:0]       pre_all_intent_grant_ref,
    input    [RK_NUM*SC_NUM-1:0]       prepb_req_ref,
    input    [RK_NUM*SC_NUM-1:0]       prepb_req_qos_ref,
    output   [RK_NUM*SC_NUM-1:0]       prepb_grant_ref,
    input    [RK_NUM*SC_NUM-1:0]       pre_ab_all_req_intent_pim,
    input    [RK_NUM*SC_NUM-1:0]       pre_ab_all_req_intent_urgent_qos_pim,
    input    [3*RK_NUM*SC_NUM-1:0]     pre_ab_all_req_type_pim,
    output   [RK_NUM*SC_NUM-1:0]       pre_ab_all_ack_grant_pim,
    input    [RK_NUM-1:0]              pre_ab_all_req_intent_lp,
    input    [RK_NUM-1:0]              pre_ab_all_req_intent_qos_lp,
    output   [3*RK_NUM*SC_NUM-1:0]     pre_ab_all_grant_lp,
    output   [RK_NUM-1:0]              pa_pre_all_grant,
    output   [RK_NUM-1:0]              pa_pre_pb_grant,
    output   [2**RK_NUM-1:0]           pre_vld,
    output   [2*2**RK_NUM-1:0]         pre_ph,
    output   [2**RK_NUM-1:0]           pre_addr,
    output   [2*2**RK_NUM-1:0]         pre_type,
    input    [2**RK_NUM-1:0]           pre_ab_allow,
    input    [2*2**RK_NUM-1:0]         pre_ab_allow_ph,
    input    [2**RK_NUM-1:0]           spre_ab_allow,
    input    [2*2**RK_NUM-1:0]         spre_ab_allow_ph,
    output                              pa_cmd_vld,
    output   [DDRC_PA_CMD_WIDTH-1:0]   pa_dfi_cmd_type,
    output   [RK_NUM-1:0]              pa_dfi_cmd_rank,
    output   [DDRC_PA_PHASE_WIDTH-1:0] pa_dfi_cmd_phase,
    output                              pa_dfi_cmd_sc,
    input                               act_pre_dfi_vld,
    output                              act_pre_load,
    input                               act_pre_type,
    input    [DDRC_PA_QOS_WIDTH-1:0] [RK_NUM*SC_NUM-1:0] act_pre_qos,
    input                               rdwr_dfi_vld,
    output                              rdwr_dfi_load,
    input                               rdwr_dfi_type,
    input    [DDRC_PA_QOS_WIDTH-1:0] [RK_NUM*SC_NUM-1:0] rdwr_dfi_hqos,
    output   [RK_NUM-1:0]              pa_act2_grant,
    input                               soft_req,
    input    [RK_NUM*SC_NUM-1:0]       mrr_req_ref,
    input    [RK_NUM*SC_NUM-1:0]       mrr_req_qos_ref,
    output   [RK_NUM*SC_NUM-1:0]       mrr_grant_ref,
    input    [RK_NUM*SC_NUM-1:0]       pim_req,
    input    [7*RK_NUM*SC_NUM-1:0]     pim_type,
    input    [RK_NUM*SC_NUM-1:0]       pim_urgent,
    output   [RK_NUM*SC_NUM-1:0]       pim_grant,
    input    [RK_NUM-1:0]              lp_req_rank,
    input    [3*RK_NUM-1:0]            lp_req_typerank,
    input    [RK_NUM*SC_NUM-1:0]       refdb_req_ref,
    input    [RK_NUM*SC_NUM-1:0]       refdb_req_qos_ref,
    input    [RK_NUM*SC_NUM-1:0]       refab_req_ref,
    input    [RK_NUM*SC_NUM-1:0]       refab_req_qos_ref,
    input    [RK_NUM*SC_NUM-1:0]       rfmpb_req_ref,
    input    [RK_NUM*SC_NUM-1:0]       rfmpb_req_qos_ref,
    input    [RK_NUM*SC_NUM-1:0]       rfmab_req_ref,
    input    [RK_NUM*SC_NUM-1:0]       rfmab_req_qos_ref,
    output   [RK_NUM*SC_NUM-1:0]       refdb_grant_ref,
    output   [RK_NUM*SC_NUM-1:0]       refab_grant_ref,
    output   [RK_NUM*SC_NUM-1:0]       rfmsb_grant_ref,
    output   [RK_NUM*SC_NUM-1:0]       rfmab_grant_ref,
    input    [RK_NUM*SC_NUM-1:0]       bp_req_ref,
    input    [RK_NUM*SC_NUM-1:0]       bp_type_ref,
    input    [DDRC_PA_SCRKBGBK_WIDTH*RK_NUM*SC_NUM] bp_rnkbgbk_0_ref,
    input    [DDRC_PA_SCRKBGBK_WIDTH*RK_NUM*SC_NUM] bp_rnkbgbk_1_ref,
    input    [RK_NUM-1:0]              backpressure_pim_bp_req_pim,
    input    [RK_NUM-1:0]              backpressure_urgent_pim_bp_hqos_pim,
    input    [RK_NUM*SC_NUM-1:0]       bp_req_lp
);

//==============================================================================
// Internal Signals
//==============================================================================

    wire [RK_NUM*SC_NUM-1:0]                    bp_req_fe;
    wire [DDRC_PA_SCRKBGBK_WIDTH*RK_NUM*SC_NUM] bp_rnkbgbk_0_pa;
    wire [DDRC_PA_SCRKBGBK_WIDTH*RK_NUM*SC_NUM] bp_rnkbgbk_1_pa;
    localparam DDRC_PA_DDRC_PA_RKBKBG_WIDTH = DDRC_PA_RK_WIDTH + DDRC_PA_BG_WIDTH + DDRC_PA_BK_WIDTH;
    localparam DDRC_PA_RDWR_INFO_WIDTH = DDRC_PA_RD_INFO_WIDTH + DDRC_PA_WR_INFO_WIDTH;
    wire [RK_NUM*SC_NUM-1:0]                    bp_type_fe;
    wire core_clk;
    wire core_rstn;
    wire [RK_NUM*SC_NUM-1:0]                    func_load;
    wire [RK_NUM*SC_NUM-1:0]                    func_req;
wire bp_req_fe;
wire bp_rnkbgbk_0_pa;
wire bp_rnkbgbk_1_pa;
wire bp_type_fe;
wire core_clk;
wire core_rstn;
wire preab_grant_preall;
wire preab_req_preall;
wire preab_req_qos_preall;
    .DDRC_PA_QOS_WIDTH(DDRC_PA_QOS_WIDTH),
    .DDRC_PA_RD_INFO_WIDTH(DDRC_PA_RD_INFO_WIDTH),
pre_all #(
    .DDRC_PA_BQ_NUM(DDRC_PA_BQ_NUM),
    .DDRC_PA_CMD_WIDTH(DDRC_PA_CMD_WIDTH),
    .DDRC_PA_PHASE_WIDTH(DDRC_PA_PHASE_WIDTH)
    ) pre_all_inst (
    .core_clk(core_clk),
    .core_rstn(core_rstn),
    .pre_gnt_be(pre_gnt_be),
    .pre_gnt_type_be(pre_gnt_type_be),
    .pre_gnt_bank_be(pre_gnt_bank_be),
    .pre_all_intent_ref(pre_all_intent_ref),
    .pre_all_intent_qos_ref(pre_all_intent_qos_ref),
) pre_all_inst (
    .prepb_req_ref(prepb_req_ref),
    .prepb_req_qos_ref(prepb_req_qos_ref),
    .prepb_grant_ref(prepb_grant_ref),
    .pre_ab_all_req_intent_pim(pre_ab_all_req_intent_pim),
    .pre_ab_all_req_intent_urgent_qos_pim(pre_ab_all_req_intent_urgent_qos_pim),
    .pre_ab_all_req_type_pim(pre_ab_all_req_type_pim),
    .pre_ab_all_ack_grant_pim(pre_ab_all_ack_grant_pim),
    .pre_ab_all_req_intent_lp(pre_ab_all_req_intent_lp),
    .pre_ab_all_req_intent_qos_lp(pre_ab_all_req_intent_qos_lp),
    .pre_ab_all_grant_lp(pre_ab_all_grant_lp),
    .pa_pre_all_grant(pa_pre_all_grant),
    .pa_pre_pb_grant(pa_pre_pb_grant),
    .pre_vld(pre_vld),
    .pre_ph(pre_ph),
    .pre_addr(pre_addr),
    .pre_type(pre_type),
    .pre_ab_allow(pre_ab_allow),
    .pre_ab_allow_ph(pre_ab_allow_ph),
    .spre_ab_allow(spre_ab_allow),
    .spre_ab_allow_ph(spre_ab_allow_ph),
    .pa_cmd_vld(pa_cmd_vld),
    .pa_dfi_cmd_type(pa_dfi_cmd_type),
    .pa_dfi_cmd_rank(pa_dfi_cmd_rank),
    .pa_dfi_cmd_phase(pa_dfi_cmd_phase),
    .pa_dfi_cmd_sc(pa_dfi_cmd_sc),
    .preab_req_preall(preab_req_preall),
    .preab_req_qos_preall(preab_req_qos_preall),
    .preab_grant_preall(preab_grant_preall)
    );

// Command_Arbiter instantiation
    command_arbiter #(
    .pa_dfi_cmd_sc(pa_dfi_cmd_sc)
);
    .DDRC_PA_QOS_WIDTH(DDRC_PA_QOS_WIDTH),
    .DDRC_PA_RD_INFO_WIDTH(DDRC_PA_RD_INFO_WIDTH),
command_arbiter #(
    .DDRC_PA_BQ_NUM(DDRC_PA_BQ_NUM),
    .DDRC_PA_CMD_WIDTH(DDRC_PA_CMD_WIDTH),
    .DDRC_PA_PHASE_WIDTH(DDRC_PA_PHASE_WIDTH)
    ) command_arbiter_inst (
    .act_pre_dfi_vld(act_pre_dfi_vld),
    .act_pre_load(act_pre_load),
    .act_pre_type(act_pre_type),
    .act_pre_qos(act_pre_qos),
    .rdwr_dfi_vld(rdwr_dfi_vld),
    .rdwr_dfi_load(rdwr_dfi_load),
    .rdwr_dfi_type(rdwr_dfi_type),
) command_arbiter_inst (
    .preab_req_preall(preab_req_preall),
    .preab_req_qos_preall(preab_req_qos_preall),
    .preab_grant_preall(preab_grant_preall),
    .func_req(func_req),
    .func_load(func_load),
    .pa_act2_grant(pa_act2_grant),
    .soft_req(soft_req)
    );

// Function_Arbiter instantiation
    function_arbiter #(
    .DDRC_PA_BG_WIDTH(DDRC_PA_BG_WIDTH),
    .DDRC_PA_BK_WIDTH(DDRC_PA_BK_WIDTH),
);
    .DDRC_PA_QOS_WIDTH(DDRC_PA_QOS_WIDTH),
    .DDRC_PA_RD_INFO_WIDTH(DDRC_PA_RD_INFO_WIDTH),
function_arbiter #(
    .DDRC_PA_BQ_NUM(DDRC_PA_BQ_NUM),
    .DDRC_PA_CMD_WIDTH(DDRC_PA_CMD_WIDTH),
    .DDRC_PA_PHASE_WIDTH(DDRC_PA_PHASE_WIDTH)
    ) function_arbiter_inst (
    .mrr_req_ref(mrr_req_ref),
    .mrr_req_qos_ref(mrr_req_qos_ref),
    .mrr_grant_ref(mrr_grant_ref),
    .pim_req(pim_req),
    .pim_type(pim_type),
    .pim_urgent(pim_urgent),
    .pim_grant(pim_grant),
) function_arbiter_inst (
    .lp_req_typerank(lp_req_typerank),
    .prepb_req_ref(prepb_req_ref),
    .prepb_req_qos_ref(prepb_req_qos_ref),
    .prepb_grant_ref(prepb_grant_ref),
    .refdb_req_ref(refdb_req_ref),
    .refdb_req_qos_ref(refdb_req_qos_ref),
    .refab_req_ref(refab_req_ref),
    .refab_req_qos_ref(refab_req_qos_ref),
    .rfmpb_req_ref(rfmpb_req_ref),
    .rfmpb_req_qos_ref(rfmpb_req_qos_ref),
    .rfmab_req_ref(rfmab_req_ref),
    .rfmab_req_qos_ref(rfmab_req_qos_ref),
    .refdb_grant_ref(refdb_grant_ref),
    .refab_grant_ref(refab_grant_ref),
    .rfmsb_grant_ref(rfmsb_grant_ref),
    .rfmab_grant_ref(rfmab_grant_ref),
    .func_req(func_req),
    .func_load(func_load),
    .soft_req(soft_req)
    );

// BP_If instantiation
    bp_if #(
        .DDRC_PA_RK_WIDTH(DDRC_PA_RK_WIDTH),
        .DDRC_PA_BK_WIDTH(DDRC_PA_BK_WIDTH),
);
        .DDRC_PA_QOS_WIDTH(DDRC_PA_QOS_WIDTH),
        .DDRC_PA_RD_INFO_WIDTH(DDRC_PA_RD_INFO_WIDTH),
bp_if #(
    .DDRC_PA_RK_WIDTH(DDRC_PA_RK_WIDTH),
    .DDRC_PA_ROW_WIDTH(DDRC_PA_ROW_WIDTH),
    .DDRC_PA_BG_WIDTH(DDRC_PA_BG_WIDTH),
    .DDRC_PA_BK_WIDTH(DDRC_PA_BK_WIDTH),
    .DDRC_PA_SC_WIDTH(DDRC_PA_SC_WIDTH),
    .DDRC_PA_QOS_WIDTH(DDRC_PA_QOS_WIDTH),
    .DDRC_PA_RD_INFO_WIDTH(DDRC_PA_RD_INFO_WIDTH),
    .DDRC_PA_WR_INFO_WIDTH(DDRC_PA_WR_INFO_WIDTH),
    .DDRC_PA_BQ_NUM(DDRC_PA_BQ_NUM),
    .DDRC_PA_CMD_WIDTH(DDRC_PA_CMD_WIDTH),
    .DDRC_PA_PHASE_WIDTH(DDRC_PA_PHASE_WIDTH)
) bp_if_inst (
    .core_clk(core_clk),
    .core_rstn(core_rstn),
    .bp_req_ref(bp_req_ref),
    .bp_type_ref(bp_type_ref),
    .bp_rnkbgbk_0_ref(bp_rnkbgbk_0_ref),
    .bp_rnkbgbk_1_ref(bp_rnkbgbk_1_ref),
    .backpressure_pim_bp_req_pim(backpressure_pim_bp_req_pim),
    .backpressure_urgent_pim_bp_hqos_pim(backpressure_urgent_pim_bp_hqos_pim),
    .bp_req_lp(bp_req_lp),
    .bp_req_fe(bp_req_fe),
    .bp_type_fe(bp_type_fe),
    .bp_rnkbgbk_0_pa(bp_rnkbgbk_0_pa),
    .bp_rnkbgbk_1_pa(bp_rnkbgbk_1_pa)
);

//==============================================================================
// End of Module
//==============================================================================
