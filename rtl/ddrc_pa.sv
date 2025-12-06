//==============================================================================
// protocol_arbiter Module
// Generated from Protocol_Arbiter (21).xlsx
// Auto-generated on 2025-09-23 09:54:57
//==============================================================================

module ddrc_pa #(
    parameter DDRC_PA_RK_WIDTH = 2,
    parameter DDRC_PA_ROW_WIDTH = 16,
    parameter DDRC_PA_BG_WIDTH = 2,
    parameter DDRC_PA_BK_WIDTH = 2,
    parameter DDRC_PA_SC_WIDTH = 1,
    parameter DDRC_PA_QOS_WIDTH = 4,
    parameter DDRC_PA_RD_INFO_WIDTH = 16,
    parameter DDRC_PA_WR_INFO_WIDTH = 16,
    parameter DDRC_PA_BQ_NUM = 4,
    parameter DDRC_RK_WIDTH = 2,
    parameter DDRC_BGBK_WIDTH = 4,
    parameter DDRC_SCRK_WIDTH = 8,
    parameter DDRC_PA_CMD_WIDTH = 5,
    parameter DDRC_PA_PHASE_WIDTH = 2,
//==============================================================================
// Local Parameters
//==============================================================================
    localparam RK_NUM = 2**DDRC_PA_RK_WIDTH,
    localparam SC_NUM = 2**DDRC_PA_SC_WIDTH,
    localparam DDRC_SCRKBK_WIDTH = DDRC_PA_SC_WIDTH+DDRC_PA_BK_WIDTH+DDRC_PA_BG_WIDTH+DDRC_PA_RK_WIDTH,
    localparam DDRC_SCRKBGBK_WIDTH = DDRC_PA_SC_WIDTH+DDRC_PA_BK_WIDTH+DDRC_PA_BG_WIDTH+DDRC_PA_RK_WIDTH,
    localparam DDRC_PA_DDRC_PA_RKBKBG_WIDTH = DDRC_PA_RK_WIDTH + DDRC_PA_BG_WIDTH + DDRC_PA_BK_WIDTH,
    localparam DDRC_PA_RDWR_INFO_WIDTH = DDRC_PA_RD_INFO_WIDTH + DDRC_PA_WR_INFO_WIDTH
)(
    input                              ddrc_clk,
    input                              ddrc_rst_n,
    input                              actpre_pa_cmd_vld,
    output                             actpre_pa_cmd_rdy,
    input    [2-1:0]                   actpre_pa_cmd_type,
    input                              actpre_pa_cmd_hqos,
    input                              rdwr_pa_cmd_vld,
    output                             rdwr_pa_cmd_rdy,
    input    [2-1:0]                   rdwr_pa_cmd_type,
    input                              rdwr_pa_cmd_hqos,
    output                             pre_gnt_be,
    output                             pre_gnt_type_be,
    output   [DDRC_SCRKBGBK_WIDTH-1:0] pre_gnt_bank_be,
    output   [RK_NUM*SC_NUM-1:0]       flush_req,
    input                              flush_done,
    input    [RK_NUM*SC_NUM-1:0]       bank_close_info,
    input    [RK_NUM*SC_NUM-1:0]       bp_req_ref,
    input    [RK_NUM*SC_NUM-1:0]       bp_type_ref,
    input    [DDRC_BGBK_WIDTH*RK_NUM*SC_NUM-1:0] bp_bgbk_0_ref,
    input    [DDRC_BGBK_WIDTH*RK_NUM*SC_NUM-1:0] bp_bgbk_1_ref,
    input    [RK_NUM*SC_NUM-1:0]       pre_all_intent_ref,
    input    [RK_NUM*SC_NUM-1:0]       pre_all_intent_qos_ref,
    output   [RK_NUM*SC_NUM-1:0]       pre_all_intent_grant_ref,
    input    [RK_NUM*SC_NUM-1:0]       prepb_req_ref,
    input    [RK_NUM*SC_NUM-1:0]       prepb_req_qos_ref,
    input    [DDRC_SCRKBGBK_WIDTH*RK_NUM*SC_NUM-1:0] prepb_req_bank_ref,
    input    [RK_NUM*SC_NUM-1:0]       mrr_req_ref,
    input    [RK_NUM*SC_NUM-1:0]       mrr_req_qos_ref,
    output   [RK_NUM*SC_NUM-1:0]       prepb_grant_ref,
    output   [RK_NUM*SC_NUM-1:0]       mrr_grant_ref,
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
    output   [RK_NUM*SC_NUM-1:0]       rfmpb_grant_ref,
    output   [RK_NUM*SC_NUM-1:0]       rfmab_grant_ref,
    input    [RK_NUM*SC_NUM-1:0]       pre_all_req_pim,
    input    [RK_NUM*SC_NUM-1:0]       pre_all_req_urgent_pim,
    input    [3*RK_NUM*SC_NUM-1:0]     pre_all_req_type_pim,
    output   [RK_NUM*SC_NUM-1:0]       pre_all_grant_pim,
    input    [RK_NUM*SC_NUM-1:0]       pim_req,
    input    [7*RK_NUM*SC_NUM-1:0]     pim_type,
    input    [RK_NUM*SC_NUM-1:0]       pim_urgent,
    output   [RK_NUM*SC_NUM-1:0]       pim_grant,
    input    [RK_NUM-1:0]              bp_req_pim,
    input    [2**DDRC_RK_WIDTH-1:0]       lp_req_rank,
    input    [2**DDRC_RK_WIDTH*4-1:0]     lp_req_type_rank,
    output   [2**DDRC_RK_WIDTH-1:0]       lp_req_grant,
    input    [2*2**DDRC_RK_WIDTH-1:0]     pre_all_intent_lp,
    input    [2*2**DDRC_RK_WIDTH-1:0]     pre_all_intent_qos_lp,
    output   [2*2**DDRC_RK_WIDTH-1:0]     pre_all_grant_lp,
    input    [2**DDRC_RK_WIDTH-1:0]       bp_req_lp,
    output   [RK_NUM*SC_NUM-1:0]       bp_req_fe,
    output   [RK_NUM*SC_NUM-1:0]       bp_type_fe,
    output   [DDRC_BGBK_WIDTH*RK_NUM*SC_NUM-1:0] bp_rnkbgbk_0_ref,
    output   [DDRC_BGBK_WIDTH*RK_NUM*SC_NUM-1:0] bp_rnkbgbk_1_ref,
    output                             pre_vld,
    output   [2-1:0]                   pre_ph,
    output   [DDRC_RK_WIDTH-1:0]       prea_cmd_rk,
    output                             prea_cmd_sc,
    input    [2*2**DDRC_RK_WIDTH-1:0]  pre_ab_allow,
    input    [2*2*2**DDRC_RK_WIDTH-1:0] pre_ab_allow_ph,
    output                             pa_cmd_vld,
    output   [DDRC_PA_CMD_WIDTH-1:0] pa_dfi_cmd_type,
    output   [2**DDRC_RK_WIDTH-1:0]       pa_dfi_cmd_rank,
    output   [DDRC_PA_PHASE_WIDTH-1:0] pa_dfi_cmd_phase,
    output                             pa_dfi_cmd_sc,
    input    [RK_NUM*SC_NUM-1:0]       soft_pre_all_req,
    input    [RK_NUM*SC_NUM-1:0]       soft_pre_all_qos,
    output   [RK_NUM*SC_NUM-1:0]       soft_pre_all_grant,
    input    [RK_NUM*SC_NUM-1:0]       soft_bp_all_req,
    input                              soft_cmd_req,
    input                              soft_cmd_qos,
    output                             soft_cmd_grant,
    // Explicitly declare previously implicit ports
    output   [RK_NUM-1:0]              pa_pre_all_grant,
    output   [RK_NUM-1:0]              pa_pre_pb_grant,
    output   [DDRC_PA_RK_WIDTH-1:0]    pre_addr,
    output                             pre_type,
    input                              soft_req,
    output                             soft_req_grant,
    input                              clk_en
);


//==============================================================================
// Internal Signals
//==============================================================================

wire [DDRC_BGBK_WIDTH*RK_NUM*SC_NUM-1:0] bp_rnkbgbk_0_pa;
wire [DDRC_BGBK_WIDTH*RK_NUM*SC_NUM-1:0] bp_rnkbgbk_1_pa;
wire cas_off_lp_load_rank;
wire func_hqos;
wire [RK_NUM*SC_NUM-1:0] func_load;
wire [RK_NUM*SC_NUM-1:0] func_req;
wire mask;
wire mrr4_h_grant;
wire mrr4_load_h;
wire mrr_zq_high_load;
wire mrr_zq_high_req;
wire mrr_zq_low_load;
wire mrr_zq_low_req;
wire mrrx_load_h;
wire pdx_lp_load_rank;
wire pim_h_grant;
wire [RK_NUM*SC_NUM-1:0] preab_grant_preall;
wire [RK_NUM*SC_NUM-1:0] preab_req_preall;
wire [RK_NUM*SC_NUM-1:0] preab_req_qos_preall;
wire ref_ab_h_grant;
wire ref_db_h_grant;
wire refab_load_ref_h;
wire refdb_load_ref_h;
wire rfm_ab_h_grant;
wire rfmab_load_ref_h;
wire rfmpb_load_ref_h;
wire zq_load_h;

//==============================================================================
// Glue Logic for Width Conversion
//==============================================================================

// Width conversion signals for function_arbiter
wire [RK_NUM*SC_NUM-1:0] mrr_zq_high_load_wide;
wire [RK_NUM*SC_NUM-1:0] mrr_zq_low_load_wide;
wire [0:0] actpre_pa_cmd_type_narrow;
wire [0:0] func_req_narrow;
wire [0:0] func_load_narrow;

// Width conversion signals for pre_all
wire [RK_NUM-1:0] pa_pre_all_grant_wide;
wire [RK_NUM-1:0] pa_pre_pb_grant_wide;
wire [0:0] pre_vld_wide;
wire [1:0] pre_ph_wide;
wire [DDRC_PA_RK_WIDTH-1:0] pre_addr_wide;
wire [0:0] pre_type_wide;
wire [2*2**DDRC_RK_WIDTH-1:0] pre_ab_allow_wide;
wire [2*2*2**DDRC_RK_WIDTH-1:0] pre_ab_allow_ph_wide;
wire [(2**RK_NUM)-1:0] spre_ab_allow_wide;
wire [2*(2**RK_NUM)-1:0] spre_ab_allow_ph_wide;
wire [2**DDRC_RK_WIDTH-1:0] pa_dfi_cmd_rank_wide;

// Width conversion signals for bp_if
wire [RK_NUM-1:0] backpressure_pim_bp_req_pim_wide;
wire [RK_NUM-1:0] backpressure_urgent_pim_bp_hqos_pim_wide;
wire [2**DDRC_RK_WIDTH-1:0] bp_req_lp_wide;
wire [RK_NUM*SC_NUM-1:0] bp_req_fe_wide;
wire [RK_NUM*SC_NUM-1:0] bp_type_fe_wide;

// Width conversion signals for command_arbiter
wire [0:0] preab_req_preall_narrow;
wire [0:0] preab_req_qos_preall_narrow;
wire [0:0] preab_grant_preall_narrow;
wire [0:0] func_req_ca_narrow;
wire [0:0] func_load_ca_narrow;

// Width conversion signals for pre_all additional ports
wire [RK_NUM*SC_NUM-1:0] prepb_grant_ref_narrow;
wire [RK_NUM*SC_NUM-1:0] pre_all_req_pim_wide;
wire [RK_NUM*SC_NUM-1:0] pre_all_req_urgent_pim_wide;
wire [3*RK_NUM*SC_NUM-1:0] pre_all_req_type_pim_wide;
wire [RK_NUM*SC_NUM-1:0] pre_all_grant_pim_narrow;
wire [2*2**DDRC_RK_WIDTH-1:0] pre_all_intent_lp_wide;
wire [2*2**DDRC_RK_WIDTH-1:0] pre_all_intent_qos_lp_wide;
wire [2*2**DDRC_RK_WIDTH-1:0] pre_all_grant_lp_narrow;

// Glue logic assignments
assign mrr_zq_high_load_wide = {{(RK_NUM*SC_NUM-1){1'b0}}, mrr_zq_high_load};
assign mrr_zq_low_load_wide = {{(RK_NUM*SC_NUM-1){1'b0}}, mrr_zq_low_load};
assign actpre_pa_cmd_type_narrow = actpre_pa_cmd_type[0];
assign func_req_narrow = func_req[0];
assign func_load_narrow = func_load[0];

// Pre_all output to input conversions
assign pa_pre_all_grant = pa_pre_all_grant_wide;
assign pa_pre_pb_grant = pa_pre_pb_grant_wide;
assign pre_vld = pre_vld_wide;
assign pre_ph = pre_ph_wide;
assign pre_addr = pre_addr_wide;
assign pre_type = pre_type_wide;

// Pre_all input conversions
assign pre_ab_allow_wide = pre_ab_allow;
assign pre_ab_allow_ph_wide = pre_ab_allow_ph;
assign spre_ab_allow_wide = {(2**RK_NUM){1'b0}};
assign spre_ab_allow_ph_wide = {(2*(2**RK_NUM)){1'b0}};
assign pa_dfi_cmd_rank_wide = {{(2**DDRC_RK_WIDTH-DDRC_RK_WIDTH){1'b0}}, pa_dfi_cmd_rank};

assign backpressure_pim_bp_req_pim_wide = {{(RK_NUM-2){1'b0}}, bp_req_pim};
assign backpressure_urgent_pim_bp_hqos_pim_wide = {RK_NUM{1'b0}};
assign bp_req_lp_wide = {{(2**DDRC_RK_WIDTH-2){1'b0}}, bp_req_lp};
assign bp_req_fe = bp_req_fe_wide[1:0];
assign bp_type_fe = bp_type_fe_wide[1:0];

// removed narrow conversions; use wide vectors directly between pre_all and command_arbiter
assign func_req = {{(RK_NUM*SC_NUM-1){1'b0}}, func_req_ca_narrow};
assign func_load = {{(RK_NUM*SC_NUM-1){1'b0}}, func_load_ca_narrow};

// Pre_all additional port conversions
assign prepb_grant_ref = prepb_grant_ref_narrow;
assign pre_all_req_pim_wide = pre_all_req_pim;
assign pre_all_req_urgent_pim_wide = pre_all_req_urgent_pim;
assign pre_all_req_type_pim_wide = pre_all_req_type_pim;
assign pre_all_grant_pim = pre_all_grant_pim_narrow;
assign pre_all_intent_lp_wide = pre_all_intent_lp;
assign pre_all_intent_qos_lp_wide = pre_all_intent_qos_lp;
assign pre_all_grant_lp = pre_all_grant_lp_narrow;

// Signal assignments -  
// bp_rnkbgbk_0_pa and bp_rnkbgbk_1_pa should come from bp_if output
// removed erroneous zeroing; preab_req_preall and preab_req_qos_preall are driven by pre_all outputs

// Function_Arbiter instantiation
function_arbiter #(
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
    .DDRC_PA_PHASE_WIDTH(DDRC_PA_PHASE_WIDTH),
    .DDRC_RK_WIDTH(DDRC_RK_WIDTH),
    .DDRC_BGBK_WIDTH(DDRC_BGBK_WIDTH),
    .DDRC_SCRK_WIDTH(DDRC_SCRK_WIDTH)
) function_arbiter_inst (
    .ddrc_clk(ddrc_clk),
    .ddrc_rst_n(ddrc_rst_n),
    .prepb_req_ref(prepb_req_ref),
    .prepb_req_qos_ref(prepb_req_qos_ref),
    .prepb_req_bank_ref(prepb_req_bank_ref),
    .prepb_grant_ref(prepb_grant_ref_narrow),
    .mrr_req_ref(mrr_req_ref),
    .mrr_req_qos_ref(mrr_req_qos_ref),
    .mrr_grant_ref(mrr_grant_ref),
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
    .rfmpb_grant_ref(rfmpb_grant_ref),
    .rfmab_grant_ref(rfmab_grant_ref),
    .pim_req(pim_req),
    .pim_type(pim_type),
    .pim_urgent(pim_urgent),
    .pim_grant(pim_grant),
    .lp_req_rank(lp_req_rank),
    .lp_req_type_rank(lp_req_type_rank),
    .lp_req_grant(lp_req_grant),
    .soft_cmd_req(soft_cmd_req),
    .soft_cmd_qos(soft_cmd_qos),
    .soft_cmd_grant(soft_cmd_grant),
    .mrr_zq_high_req(mrr_zq_high_req),
    .mrr_zq_low_req(mrr_zq_low_req),
    .mrr_zq_high_load(mrr_zq_high_load_wide),
    .mrr_zq_low_load(mrr_zq_low_load_wide),
    .zq_load_h(zq_load_h),
    .mrrx_load_h(mrrx_load_h),
    .mrr4_load_h(mrr4_load_h),
    .pdx_lp_load_rank(pdx_lp_load_rank),
    .cas_off_lp_load_rank(cas_off_lp_load_rank),
    .refab_load_ref_h(refab_load_ref_h),
    .refdb_load_ref_h(refdb_load_ref_h),
    .rfmab_load_ref_h(rfmab_load_ref_h),
    .rfmpb_load_ref_h(rfmpb_load_ref_h),
    .actpre_pa_cmd_vld(actpre_pa_cmd_vld),
    .actpre_pa_cmd_type(actpre_pa_cmd_type_narrow),
    .actpre_pa_cmd_hqos(actpre_pa_cmd_hqos),
    .func_req(func_req_narrow),
    .func_hqos(func_hqos),
    .func_load(func_load_narrow)
);

// Command_Arbiter instantiation
command_arbiter #(
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
) command_arbiter_inst (
    .ddrc_clk(ddrc_clk),
    .ddrc_rst_n(ddrc_rst_n),
    .actpre_pa_cmd_vld(actpre_pa_cmd_vld),
    .actpre_pa_cmd_rdy(actpre_pa_cmd_rdy),
    .actpre_pa_cmd_type(actpre_pa_cmd_type),
    .actpre_pa_cmd_hqos(actpre_pa_cmd_hqos),
    .rdwr_pa_cmd_vld(rdwr_pa_cmd_vld),
    .rdwr_pa_cmd_rdy(rdwr_pa_cmd_rdy),
    .rdwr_pa_cmd_type(rdwr_pa_cmd_type),
    .rdwr_pa_cmd_hqos(rdwr_pa_cmd_hqos),
    .preab_req_preall(preab_req_preall),
    .preab_req_qos_preall(preab_req_qos_preall),
    .preab_grant_preall(preab_grant_preall),
    .pre_vld(pre_vld_wide[0]),
    .prea_cmd_rk(pre_addr_wide),
    .prea_cmd_sc(pre_type_wide[0]),
    .func_req(func_req_ca_narrow),
    .func_hqos(func_hqos),
    .func_load(func_load_ca_narrow),
    .mrr_zq_high_req(mrr_zq_high_req),
    .mrr_zq_low_req(mrr_zq_low_req),
    .mrr_zq_high_load(mrr_zq_high_load),
    .mrr_zq_low_load(mrr_zq_low_load),
    .soft_req(soft_req),
    .soft_req_grant(soft_req_grant),
    .mask(mask),
    .mrr4_h_grant(mrr4_h_grant),
    .ref_ab_h_grant(ref_ab_h_grant),
    .ref_db_h_grant(ref_db_h_grant),
    .rfm_ab_h_grant(rfm_ab_h_grant),
    .pim_h_grant(pim_h_grant),
    .pdx_lp_load_rank(pdx_lp_load_rank),
    .cas_off_lp_load_rank(cas_off_lp_load_rank),
    .mrr4_load_h(mrr4_load_h),
    .refab_load_ref_h(refab_load_ref_h),
    .refdb_load_ref_h(refdb_load_ref_h),
    .rfmab_load_ref_h(rfmab_load_ref_h),
    .rfmpb_load_ref_h(rfmpb_load_ref_h),
    .mrrx_load_h(mrrx_load_h),
    .zq_load_h(zq_load_h),
    .clk_en(clk_en),
    .prepb_req_bank_ref(prepb_req_bank_ref),
    .pre_gnt_be(pre_gnt_be),
    .pre_gnt_type_be(pre_gnt_type_be),
    .pre_gnt_bank_be(pre_gnt_bank_be)
);

// Pre_All instantiation
pre_all #(
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
) pre_all_inst (
    .ddrc_clk(ddrc_clk),
    .ddrc_rst_n(ddrc_rst_n),
    .pre_all_intent_ref(pre_all_intent_ref),
    .pre_all_intent_qos_ref(pre_all_intent_qos_ref),
    .pre_all_intent_grant_ref(pre_all_intent_grant_ref),
    // prepb signals removed from pre_all ports
    .bank_close_info(bank_close_info),
    .pre_all_req_pim(pre_all_req_pim_wide),
    .pre_all_req_urgent_pim(pre_all_req_urgent_pim_wide),
    .pre_all_req_type_pim(pre_all_req_type_pim_wide),
    .pre_all_grant_pim(pre_all_grant_pim_narrow),
    .pre_all_intent_lp(pre_all_intent_lp_wide),
    .pre_all_intent_qos_lp(pre_all_intent_qos_lp_wide),
    .pre_all_grant_lp(pre_all_grant_lp_narrow),
    .flush_req(flush_req),
    .flush_done(flush_done),
    .pa_pre_all_grant(pa_pre_all_grant_wide),
    .pa_pre_pb_grant(pa_pre_pb_grant_wide),
    .pre_vld(pre_vld_wide),
    .pre_ph(pre_ph_wide),
    .prea_cmd_rk(pre_addr_wide),
    .prea_cmd_sc(pre_type_wide),
    .pre_ab_allow(pre_ab_allow_wide),
    .pre_ab_allow_ph(pre_ab_allow_ph_wide),
    .pa_cmd_vld(pa_cmd_vld),
    .pa_dfi_cmd_type(pa_dfi_cmd_type),
    .pa_dfi_cmd_rank(pa_dfi_cmd_rank_wide),
    .pa_dfi_cmd_phase(pa_dfi_cmd_phase),
    .pa_dfi_cmd_sc(pa_dfi_cmd_sc),
    .soft_pre_all_req(soft_pre_all_req),
    .soft_pre_all_qos(soft_pre_all_qos),
    .soft_pre_all_grant(soft_pre_all_grant),
    .preab_req_preall(preab_req_preall),
    .preab_req_qos_preall(preab_req_qos_preall),
    .preab_grant_preall(preab_grant_preall)
);

// BP_If instantiation
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
    .DDRC_PA_PHASE_WIDTH(DDRC_PA_PHASE_WIDTH),
    .DDRC_RK_WIDTH(DDRC_RK_WIDTH),
    .DDRC_BGBK_WIDTH(DDRC_BGBK_WIDTH),
    .DDRC_SCRK_WIDTH(DDRC_SCRK_WIDTH)
) bp_if_inst (
    .ddrc_clk(ddrc_clk),
    .ddrc_rst_n(ddrc_rst_n),
    .bp_req_ref(bp_req_ref),
    .bp_type_ref(bp_type_ref),
    .bp_bgbk_0_ref(bp_bgbk_0_ref),
    .bp_bgbk_1_ref(bp_bgbk_1_ref),
    .bp_req_pim(bp_req_pim),
    .bp_req_lp(bp_req_lp_wide),
    .soft_bp_all_req(soft_bp_all_req),
    .bp_req_fe(bp_req_fe_wide),
    .bp_type_fe(bp_type_fe_wide),
    .bp_rnkbgbk_0_ref(bp_rnkbgbk_0_pa),
    .bp_rnkbgbk_1_ref(bp_rnkbgbk_1_pa)
);

endmodule

//==============================================================================
// End of Module
//==============================================================================
