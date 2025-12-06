//==============================================================================
// Function_Arbiter Module
// Generated from Protocol_Arbiter (20).xlsx
// Auto-generated on 2025-09-23 09:37:09
//==============================================================================

module function_arbiter #(
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
    parameter DDRC_PA_PHASE_WIDTH = 2,
    parameter DDRC_RK_WIDTH = 2,
    parameter DDRC_BGBK_WIDTH = 4,
    parameter DDRC_SCRK_WIDTH = 8
)(
    input                              ddrc_clk,
    input                              ddrc_rst_n,
    input    [RK_NUM*SC_NUM-1:0]       prepb_req_ref,
    input    [RK_NUM*SC_NUM-1:0]       prepb_req_qos_ref,
    input    [DDRC_SCRKBGBK_WIDTH*RK_NUM*SC_NUM-1:0] prepb_req_bank_ref,
    output   [RK_NUM*SC_NUM-1:0]       prepb_grant_ref,
    input    [RK_NUM*SC_NUM-1:0]       mrr_req_ref,
    input    [RK_NUM*SC_NUM-1:0]       mrr_req_qos_ref,
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
    input    [DDRC_SCRK_WIDTH-1:0]     pim_req,
    input    [7*DDRC_SCRK_WIDTH-1:0]   pim_type,
    input    [DDRC_SCRK_WIDTH-1:0]     pim_urgent,
    output   [DDRC_SCRK_WIDTH-1:0]     pim_grant,
    input    [2**DDRC_RK_WIDTH-1:0]    lp_req_rank,
    input    [2**DDRC_RK_WIDTH*4-1:0]  lp_req_type_rank,
    output   [2**DDRC_RK_WIDTH-1:0]    lp_req_grant,
    input                              soft_cmd_req,
    input                              soft_cmd_qos,
    output                             soft_cmd_grant,
    output                             mrr_zq_high_req,
    output                             mrr_zq_low_req,
    output   [RK_NUM*SC_NUM-1:0]       mrr_zq_high_load,
    output   [RK_NUM*SC_NUM-1:0]       mrr_zq_low_load,
    output                             zq_load_h,
    output                             mrrx_load_h,
    output                             mrr4_load_h,
    output                             pdx_lp_load_rank,
    output                             cas_off_lp_load_rank,
    output                             refab_load_ref_h,
    output                             refdb_load_ref_h,
    output                             rfmab_load_ref_h,
    output                             rfmpb_load_ref_h,
    input                              actpre_pa_cmd_vld,
    input                              actpre_pa_cmd_type,
    input                              actpre_pa_cmd_hqos,
    output                             func_req,
    output                             func_hqos,
    input                              func_load
);

//==============================================================================
// Local Parameters
//==============================================================================
    localparam RK_NUM = 2**DDRC_PA_RK_WIDTH;
    localparam SC_NUM = 2**DDRC_PA_SC_WIDTH;
    localparam DDRC_SCRKBK_WIDTH = DDRC_PA_SC_WIDTH+DDRC_PA_BK_WIDTH+DDRC_PA_BG_WIDTH+DDRC_PA_RK_WIDTH;
    localparam DDRC_SCRKBGBK_WIDTH = DDRC_PA_SC_WIDTH+DDRC_PA_BK_WIDTH+DDRC_PA_BG_WIDTH+DDRC_PA_RK_WIDTH;
    localparam DDRC_PA_DDRC_PA_RKBKBG_WIDTH = DDRC_PA_RK_WIDTH + DDRC_PA_BG_WIDTH + DDRC_PA_BK_WIDTH;
    localparam DDRC_PA_RDWR_INFO_WIDTH = DDRC_PA_RD_INFO_WIDTH + DDRC_PA_WR_INFO_WIDTH;

// Internal Logic
wire bq_be_pre_pb;
wire [1:0] soft_req_type;
reg [12:0] func_load_arb;
wire soft_load_type1_rank;
wire soft_load_type2_rank;
wire [DDRC_PA_RK_WIDTH+DDRC_PA_SC_WIDTH-1:0] zq_req_pim_h;
wire [DDRC_PA_RK_WIDTH+DDRC_PA_SC_WIDTH-1:0] mrrx_req_pim_h;
wire mrr4_req_ref_h;
wire refdb_req_ref_h;
wire refab_req_ref_h;
wire rfmpb_req_ref_h;
wire rfmab_req_ref_h;
wire prepb_req_ref_h;
wire zq_req_l;
wire mrrx_req_l;
wire mrr4_req_l;
wire refdb_req_ref_l;
wire refab_req_ref_l;
wire rfmpb_req_ref_l;
wire rfmab_req_ref_l;
wire pde_lp_req_rank;
wire pdx_lp_req_rank;
wire sre_lp_req_rank;
wire srpde_lp_req_rank;
wire srx_lp_req_rank;
wire nop_lp_req_rank;
wire mpc_lp_req_rank;
wire cas_lp_req_rank;
wire cas_off_lp_req_rank;
wire prepb_req_ref_l;
wire soft_cmd_req_h;
wire soft_cmd_req_l;
wire [26:0] func_req_arb;
wire zq_load_pim_h;
wire mrrx_load_pim_h;
wire mrr4_load_ref_h;

wire prepb_load_ref_h;
wire zq_load_l;
wire mrrx_load_l;
wire mrr4_load_l;
wire refdb_load_ref_l;
wire refab_load_ref_l;
wire rfmpb_load_ref_l;
wire rfmab_load_ref_l;
wire pde_lp_load_rank;
wire sre_lp_load_rank;
wire srpde_lp_load_rank;
wire srx_lp_load_rank;
wire nop_lp_load_rank;
wire mpc_lp_load_rank;
wire cas_lp_load_rank;
wire prepb_load_ref_l;
wire soft_cmd_load_h;
wire soft_cmd_load_l;


// Priority encoder to select the lowest index valid signal
wire [RK_NUM*SC_NUM-1:0] zq_req_pim_valid;
wire [RK_NUM*SC_NUM-1:0] zq_req_pim_priority;
wire [RK_NUM*SC_NUM-1:0] zq_req_pim_high_qos;
wire [RK_NUM*SC_NUM-1:0] zq_req_pim_low_qos;
wire [RK_NUM*SC_NUM-1:0] zq_req_pim_high_qos_priority;
wire [RK_NUM*SC_NUM-1:0] zq_req_pim_low_qos_priority;


// Base valid signal for ZQ requests
assign zq_req_pim_valid = pim_req[RK_NUM*SC_NUM-1:0] & (pim_type[7 * (RK_NUM*SC_NUM) -1 :0] == 56'b00000001);

// Separate high QoS and low QoS requests
assign zq_req_pim_high_qos = zq_req_pim_valid & pim_urgent[RK_NUM*SC_NUM-1:0];
assign zq_req_pim_low_qos = zq_req_pim_valid & (~pim_urgent[RK_NUM*SC_NUM-1:0]);


// Priority encoder for high QoS requests (lowest index first)
assign zq_req_pim_high_qos_priority = zq_req_pim_high_qos & (~zq_req_pim_high_qos + 1);

// Priority encoder for low QoS requests (lowest index first)
assign zq_req_pim_low_qos_priority = zq_req_pim_low_qos & (~zq_req_pim_low_qos + 1);

// High QoS has priority over low QoS
assign zq_req_pim_priority = |zq_req_pim_high_qos ? zq_req_pim_high_qos_priority : zq_req_pim_low_qos_priority;
assign zq_req_pim_h = |zq_req_pim_priority;


// Priority encoder to select the lowest index valid signal
wire [DDRC_PA_RK_WIDTH+DDRC_PA_SC_WIDTH-1:0] mrrx_req_pim_valid;
wire [DDRC_PA_RK_WIDTH+DDRC_PA_SC_WIDTH-1:0] mrrx_req_pim_priority;
assign mrrx_req_pim_valid = pim_req[DDRC_PA_RK_WIDTH+DDRC_PA_SC_WIDTH-1:0] & (pim_type[7 * (DDRC_PA_RK_WIDTH+DDRC_PA_SC_WIDTH) -1 :0] == 8'b00000010) & pim_urgent [DDRC_PA_RK_WIDTH+DDRC_PA_SC_WIDTH-1:0];
// Priority encoder: select lowest index (rightmost bit)
assign mrrx_req_pim_priority = mrrx_req_pim_valid & (~mrrx_req_pim_valid + 1);
assign mrrx_req_pim_h = |mrrx_req_pim_priority;

wire [RK_NUM*SC_NUM-1:0] mrr4_req_ref_valid;
wire [RK_NUM*SC_NUM-1:0] mrr4_req_ref_priority;
wire [RK_NUM*SC_NUM-1:0] mrr4_req_ref_high_qos;
wire [RK_NUM*SC_NUM-1:0] mrr4_req_ref_low_qos;
wire [RK_NUM*SC_NUM-1:0] mrr4_req_ref_high_qos_priority;
wire [RK_NUM*SC_NUM-1:0] mrr4_req_ref_low_qos_priority;

// Separate high QoS and low QoS requests
assign mrr4_req_ref_high_qos = mrr_req_ref[RK_NUM*SC_NUM-1:0] & mrr_req_qos_ref[RK_NUM*SC_NUM-1:0];
assign mrr4_req_ref_low_qos = mrr_req_ref[RK_NUM*SC_NUM-1:0] & (~mrr_req_qos_ref[RK_NUM*SC_NUM-1:0]);

// Priority encoder for high QoS requests (lowest index first)
assign mrr4_req_ref_high_qos_priority = mrr4_req_ref_high_qos & (~mrr4_req_ref_high_qos + 1);

// Priority encoder for low QoS requests (lowest index first)
assign mrr4_req_ref_low_qos_priority = mrr4_req_ref_low_qos & (~mrr4_req_ref_low_qos + 1);

// High QoS has priority over low QoS
assign mrr4_req_ref_priority = |mrr4_req_ref_high_qos ? mrr4_req_ref_high_qos_priority : mrr4_req_ref_low_qos_priority;
assign mrr4_req_ref_h = |mrr4_req_ref_priority;

wire [RK_NUM*SC_NUM-1:0] refdb_req_ref_priority;
wire [RK_NUM*SC_NUM-1:0] refdb_req_ref_high_qos;
wire [RK_NUM*SC_NUM-1:0] refdb_req_ref_low_qos;
wire [RK_NUM*SC_NUM-1:0] refdb_req_ref_high_qos_priority;
wire [RK_NUM*SC_NUM-1:0] refdb_req_ref_low_qos_priority;

// Separate high QoS and low QoS requests
assign refdb_req_ref_high_qos = refdb_req_ref[RK_NUM*SC_NUM-1:0] & refdb_req_qos_ref[RK_NUM*SC_NUM-1:0];
assign refdb_req_ref_low_qos = refdb_req_ref[RK_NUM*SC_NUM-1:0] & (~refdb_req_qos_ref[RK_NUM*SC_NUM-1:0]);

// Priority encoder for high QoS requests (lowest index first)
assign refdb_req_ref_high_qos_priority = refdb_req_ref_high_qos & (~refdb_req_ref_high_qos + 1);

// Priority encoder for low QoS requests (lowest index first)
assign refdb_req_ref_low_qos_priority = refdb_req_ref_low_qos & (~refdb_req_ref_low_qos + 1);

// High QoS has priority over low QoS
assign refdb_req_ref_priority = |refdb_req_ref_high_qos ? refdb_req_ref_high_qos_priority : refdb_req_ref_low_qos_priority;
assign refdb_req_ref_h = |refdb_req_ref_priority;

wire [RK_NUM*SC_NUM-1:0] refab_req_ref_priority;
wire [RK_NUM*SC_NUM-1:0] refab_req_ref_high_qos;
wire [RK_NUM*SC_NUM-1:0] refab_req_ref_low_qos;
wire [RK_NUM*SC_NUM-1:0] refab_req_ref_high_qos_priority;
wire [RK_NUM*SC_NUM-1:0] refab_req_ref_low_qos_priority;

// Separate high QoS and low QoS requests
assign refab_req_ref_high_qos = refab_req_ref[RK_NUM*SC_NUM-1:0] & refab_req_qos_ref[RK_NUM*SC_NUM-1:0];
assign refab_req_ref_low_qos = refab_req_ref[RK_NUM*SC_NUM-1:0] & (~refab_req_qos_ref[RK_NUM*SC_NUM-1:0]);

// Priority encoder for high QoS requests (lowest index first)
assign refab_req_ref_high_qos_priority = refab_req_ref_high_qos & (~refab_req_ref_high_qos + 1);

// Priority encoder for low QoS requests (lowest index first)
assign refab_req_ref_low_qos_priority = refab_req_ref_low_qos & (~refab_req_ref_low_qos + 1);

// High QoS has priority over low QoS
assign refab_req_ref_priority = |refab_req_ref_high_qos ? refab_req_ref_high_qos_priority : refab_req_ref_low_qos_priority;
assign refab_req_ref_h = |refab_req_ref_priority;

wire [RK_NUM*SC_NUM-1:0] rfmpb_req_ref_priority;
wire [RK_NUM*SC_NUM-1:0] rfmpb_req_ref_high_qos;
wire [RK_NUM*SC_NUM-1:0] rfmpb_req_ref_low_qos;
wire [RK_NUM*SC_NUM-1:0] rfmpb_req_ref_high_qos_priority;
wire [RK_NUM*SC_NUM-1:0] rfmpb_req_ref_low_qos_priority;

// Separate high QoS and low QoS requests
assign rfmpb_req_ref_high_qos = rfmpb_req_ref[RK_NUM*SC_NUM-1:0] & rfmpb_req_qos_ref[RK_NUM*SC_NUM-1:0];
assign rfmpb_req_ref_low_qos = rfmpb_req_ref[RK_NUM*SC_NUM-1:0] & (~rfmpb_req_qos_ref[RK_NUM*SC_NUM-1:0]);

// Priority encoder for high QoS requests (lowest index first)
assign rfmpb_req_ref_high_qos_priority = rfmpb_req_ref_high_qos & (~rfmpb_req_ref_high_qos + 1);

// Priority encoder for low QoS requests (lowest index first)
assign rfmpb_req_ref_low_qos_priority = rfmpb_req_ref_low_qos & (~rfmpb_req_ref_low_qos + 1);

// High QoS has priority over low QoS
assign rfmpb_req_ref_priority = |rfmpb_req_ref_high_qos ? rfmpb_req_ref_high_qos_priority : rfmpb_req_ref_low_qos_priority;
assign rfmpb_req_ref_h = |rfmpb_req_ref_priority;

wire [RK_NUM*SC_NUM-1:0] rfmab_req_ref_priority;
wire [RK_NUM*SC_NUM-1:0] rfmab_req_ref_high_qos;
wire [RK_NUM*SC_NUM-1:0] rfmab_req_ref_low_qos;
wire [RK_NUM*SC_NUM-1:0] rfmab_req_ref_high_qos_priority;
wire [RK_NUM*SC_NUM-1:0] rfmab_req_ref_low_qos_priority;

// Separate high QoS and low QoS requests
assign rfmab_req_ref_high_qos = rfmab_req_ref[RK_NUM*SC_NUM-1:0] & rfmab_req_qos_ref[RK_NUM*SC_NUM-1:0];
assign rfmab_req_ref_low_qos = rfmab_req_ref[RK_NUM*SC_NUM-1:0] & (~rfmab_req_qos_ref[RK_NUM*SC_NUM-1:0]);

// Priority encoder for high QoS requests (lowest index first)
assign rfmab_req_ref_high_qos_priority = rfmab_req_ref_high_qos & (~rfmab_req_ref_high_qos + 1);

// Priority encoder for low QoS requests (lowest index first)
assign rfmab_req_ref_low_qos_priority = rfmab_req_ref_low_qos & (~rfmab_req_ref_low_qos + 1);

// High QoS has priority over low QoS
assign rfmab_req_ref_priority = |rfmab_req_ref_high_qos ? rfmab_req_ref_high_qos_priority : rfmab_req_ref_low_qos_priority;
assign rfmab_req_ref_h = |rfmab_req_ref_priority;

assign prepb_req_be_h = (actpre_pa_cmd_vld & (actpre_pa_cmd_type == 2'b10) & actpre_pa_cmd_hqos);

wire [DDRC_PA_RK_WIDTH+DDRC_PA_SC_WIDTH-1:0] prepb_req_ref_valid;
wire [DDRC_PA_RK_WIDTH+DDRC_PA_SC_WIDTH-1:0] prepb_req_ref_priority;
assign prepb_req_ref_valid = prepb_req_ref[RK_NUM*SC_NUM-1:0] & prepb_req_qos_ref[RK_NUM*SC_NUM-1:0];
assign prepb_req_ref_priority = prepb_req_ref_valid & (~prepb_req_ref_valid + 1);
assign prepb_req_ref_h = |prepb_req_ref_priority;

assign prepb_req_be_ref_h = prepb_req_be_h | prepb_req_ref_h;

// Priority encoder: select lowest index (rightmost bit)
wire [DDRC_PA_RK_WIDTH+DDRC_PA_SC_WIDTH-1:0] zq_req_pim_valid_l;
wire [DDRC_PA_RK_WIDTH+DDRC_PA_SC_WIDTH-1:0] zq_req_pim_priority_l;
assign zq_req_pim_valid_l = pim_req[DDRC_PA_RK_WIDTH+DDRC_PA_SC_WIDTH-1:0] & (pim_type[7 * (DDRC_PA_RK_WIDTH+DDRC_PA_SC_WIDTH) -1 :0] == 8'b00000001);
assign zq_req_pim_priority_l = zq_req_pim_valid_l & (~zq_req_pim_valid_l + 1);
assign zq_req_l = |zq_req_pim_priority_l;

// Priority encoder: select lowest index (rightmost bit)
wire [DDRC_PA_RK_WIDTH+DDRC_PA_SC_WIDTH-1:0] mrrx_req_pim_valid_l;
wire [DDRC_PA_RK_WIDTH+DDRC_PA_SC_WIDTH-1:0] mrrx_req_pim_priority_l;
assign mrrx_req_pim_valid_l = pim_req[DDRC_PA_RK_WIDTH+DDRC_PA_SC_WIDTH-1:0] & (pim_type[7 * (DDRC_PA_RK_WIDTH+DDRC_PA_SC_WIDTH) -1 :0] == 8'b00000010);
assign mrrx_req_pim_priority_l = mrrx_req_pim_valid_l & (~mrrx_req_pim_valid_l + 1);
assign mrrx_req_l = |mrrx_req_pim_priority_l;

//// Priority encoder: select lowest index (rightmost bit)
//wire [DDRC_PA_RK_WIDTH+DDRC_PA_SC_WIDTH-1:0] mrr4_req_ref_valid_l;
//wire [DDRC_PA_RK_WIDTH+DDRC_PA_SC_WIDTH-1:0] mrr4_req_ref_priority_l;
//assign mrr4_req_ref_valid_l = mrr_req_ref[RK_NUM*SC_NUM-1:0] & mrr_req_qos_ref[RK_NUM*SC_NUM-1:0];
//assign mrr4_req_ref_priority_l = mrr4_req_ref_valid_l & (~mrr4_req_ref_valid_l + 1);
//assign mrr4_req_l = |mrr4_req_ref_priority_l;
assign mrr4_req_l = |mrr4_req_ref_priority & !(|mrr_req_qos_ref);

//// Priority encoder: select lowest index (rightmost bit)
//wire [DDRC_PA_RK_WIDTH+DDRC_PA_SC_WIDTH-1:0] refdb_req_ref_valid_l;
//wire [DDRC_PA_RK_WIDTH+DDRC_PA_SC_WIDTH-1:0] refdb_req_ref_priority_l;
//assign refdb_req_ref_valid_l = refdb_req_ref[RK_NUM*SC_NUM-1:0] & !refdb_req_qos_ref[RK_NUM*SC_NUM-1:0];
//assign refdb_req_ref_priority_l = refdb_req_ref_valid_l & (~refdb_req_ref_valid_l + 1);
//assign refdb_req_ref_l = |refdb_req_ref_priority_l;
//
//// Priority encoder: select lowest index (rightmost bit)
//wire [DDRC_PA_RK_WIDTH+DDRC_PA_SC_WIDTH-1:0] refab_req_ref_valid_l;
//wire [DDRC_PA_RK_WIDTH+DDRC_PA_SC_WIDTH-1:0] refab_req_ref_priority_l;
//assign refab_req_ref_valid_l = refab_req_ref[RK_NUM*SC_NUM-1:0] & !refab_req_qos_ref[RK_NUM*SC_NUM-1:0];
//assign refab_req_ref_priority_l = refab_req_ref_valid_l & (~refab_req_ref_valid_l + 1);
//assign refab_req_ref_l = |refab_req_ref_priority_l;
//
//wire [DDRC_PA_RK_WIDTH+DDRC_PA_SC_WIDTH-1:0] rfmpb_req_ref_valid_l;
//wire [DDRC_PA_RK_WIDTH+DDRC_PA_SC_WIDTH-1:0] rfmpb_req_ref_priority_l;
//assign rfmpb_req_ref_valid_l = rfmpb_req_ref[RK_NUM*SC_NUM-1:0] & !rfmpb_req_qos_ref[RK_NUM*SC_NUM-1:0];
//assign rfmpb_req_ref_priority_l = rfmpb_req_ref_valid_l & (~rfmpb_req_ref_valid_l + 1);
//assign rfmpb_req_ref_l = |rfmpb_req_ref_priority_l;
//
//// Priority encoder: select lowest index (rightmost bit)
//wire [DDRC_PA_RK_WIDTH+DDRC_PA_SC_WIDTH-1:0] rfmab_req_ref_valid_l;
//wire [DDRC_PA_RK_WIDTH+DDRC_PA_SC_WIDTH-1:0] rfmab_req_ref_priority_l;
//assign rfmab_req_ref_valid_l = rfmab_req_ref[RK_NUM*SC_NUM-1:0] & !rfmab_req_qos_ref[RK_NUM*SC_NUM-1:0];
//assign rfmab_req_ref_priority_l = rfmab_req_ref_valid_l & (~rfmab_req_ref_valid_l + 1);
//assign rfmab_req_ref_l = |rfmab_req_ref_priority_l;

// Priority encoder: select lowest index (rightmost bit)
wire [2**DDRC_PA_RK_WIDTH-1:0] pde_lp_req_rank_valid;
wire [2**DDRC_PA_RK_WIDTH-1:0] pde_lp_req_rank_priority;
assign pde_lp_req_rank_valid = lp_req_rank [2**DDRC_PA_RK_WIDTH-1:0] & {2**DDRC_PA_RK_WIDTH{lp_req_type_rank == 16'b00000001}};
assign pde_lp_req_rank_priority = pde_lp_req_rank_valid & (~pde_lp_req_rank_valid + 1);
assign pde_lp_req_rank = |pde_lp_req_rank_priority;

// Priority encoder: select lowest index (rightmost bit)
wire [DDRC_PA_RK_WIDTH-1:0] pdx_lp_req_rank_valid;
wire [DDRC_PA_RK_WIDTH-1:0] pdx_lp_req_rank_priority; 
assign pdx_lp_req_rank_valid = lp_req_rank [DDRC_PA_RK_WIDTH-1:0] & (lp_req_type_rank == 8'b00000010);
assign pdx_lp_req_rank_priority = pdx_lp_req_rank_valid & (~pdx_lp_req_rank_valid + 1);
assign pdx_lp_req_rank = |pdx_lp_req_rank_priority;

// Priority encoder: select lowest index (rightmost bit)
wire [DDRC_PA_RK_WIDTH-1:0] sre_lp_req_rank_valid;
wire [DDRC_PA_RK_WIDTH-1:0] sre_lp_req_rank_priority;
assign sre_lp_req_rank_valid = lp_req_rank [DDRC_PA_RK_WIDTH-1:0] & (lp_req_type_rank == 8'b00000100);
assign sre_lp_req_rank_priority = sre_lp_req_rank_valid & (~sre_lp_req_rank_valid + 1);
assign sre_lp_req_rank = |sre_lp_req_rank_priority;

// Priority encoder: select lowest index (rightmost bit)
wire [DDRC_PA_RK_WIDTH-1:0] srpde_lp_req_rank_valid;
wire [DDRC_PA_RK_WIDTH-1:0] srpde_lp_req_rank_priority;
assign srpde_lp_req_rank_valid = lp_req_rank [DDRC_PA_RK_WIDTH-1:0] & (lp_req_type_rank == 8'b00001000);
assign srpde_lp_req_rank_priority = srpde_lp_req_rank_valid & (~srpde_lp_req_rank_valid + 1);
assign srpde_lp_req_rank = |srpde_lp_req_rank_priority;

// Priority encoder: select lowest index (rightmost bit)
wire [DDRC_PA_RK_WIDTH-1:0] srx_lp_req_rank_valid;
wire [DDRC_PA_RK_WIDTH-1:0] srx_lp_req_rank_priority;
assign srx_lp_req_rank_valid = lp_req_rank [DDRC_PA_RK_WIDTH-1:0] & (lp_req_type_rank == 8'b00010000);
assign srx_lp_req_rank_priority = srx_lp_req_rank_valid & (~srx_lp_req_rank_valid + 1);
assign srx_lp_req_rank = |srx_lp_req_rank_priority;

// Priority encoder: select lowest index (rightmost bit)
wire [DDRC_PA_RK_WIDTH-1:0] nop_lp_req_rank_valid;
wire [DDRC_PA_RK_WIDTH-1:0] nop_lp_req_rank_priority;
assign nop_lp_req_rank_valid = lp_req_rank [DDRC_PA_RK_WIDTH-1:0] & (lp_req_type_rank == 8'b00100000);
assign nop_lp_req_rank_priority = nop_lp_req_rank_valid & (~nop_lp_req_rank_valid + 1);
assign nop_lp_req_rank = |nop_lp_req_rank_priority;

// Priority encoder: select lowest index (rightmost bit)
wire [DDRC_PA_RK_WIDTH-1:0] mpc_lp_req_rank_valid;
wire [DDRC_PA_RK_WIDTH-1:0] mpc_lp_req_rank_priority;
assign mpc_lp_req_rank_valid = lp_req_rank [DDRC_PA_RK_WIDTH-1:0] & (lp_req_type_rank == 8'b01000000);
assign mpc_lp_req_rank_priority = mpc_lp_req_rank_valid & (~mpc_lp_req_rank_valid + 1);
assign mpc_lp_req_rank = |mpc_lp_req_rank_priority;

// Priority encoder: select lowest index (rightmost bit)
wire [DDRC_PA_RK_WIDTH-1:0] cas_lp_req_rank_valid;
wire [DDRC_PA_RK_WIDTH-1:0] cas_lp_req_rank_priority;
assign cas_lp_req_rank_valid = lp_req_rank [DDRC_PA_RK_WIDTH-1:0] & (lp_req_type_rank == 8'b10000000);
assign cas_lp_req_rank_priority = cas_lp_req_rank_valid & (~cas_lp_req_rank_valid + 1);
assign cas_lp_req_rank = |cas_lp_req_rank_priority;

// Priority encoder: select lowest index (rightmost bit)
wire [DDRC_PA_RK_WIDTH-1:0] cas_off_lp_req_rank_valid;
wire [DDRC_PA_RK_WIDTH-1:0] cas_off_lp_req_rank_priority;
assign cas_off_lp_req_rank_valid = lp_req_rank [DDRC_PA_RK_WIDTH-1:0] & (lp_req_type_rank == 8'b10000000);
assign cas_off_lp_req_rank_priority = cas_off_lp_req_rank_valid & (~cas_off_lp_req_rank_valid + 1);
assign cas_off_lp_req_rank = |cas_off_lp_req_rank_priority;

// Priority encoder: select lowest index (rightmost bit)
assign prepb_req_be_l  = (actpre_pa_cmd_vld & (actpre_pa_cmd_type == 2'b10) );

wire [DDRC_PA_RK_WIDTH+DDRC_PA_SC_WIDTH-1:0] prepb_req_ref_valid_l;
wire [DDRC_PA_RK_WIDTH+DDRC_PA_SC_WIDTH-1:0] prepb_req_ref_priority_l;
assign prepb_req_ref_valid_l = prepb_req_ref[RK_NUM*SC_NUM-1:0] ;
assign prepb_req_ref_priority_l = prepb_req_ref_valid_l & (~prepb_req_ref_valid_l + 1);
assign prepb_req_ref_l = |prepb_req_ref_priority_l;

assign prepb_req_be_ref_l = prepb_req_be_l | prepb_req_ref_l;

// Priority encoder: select lowest index (rightmost bit)
assign soft_cmd_req_h = soft_cmd_req & soft_cmd_qos;
assign soft_cmd_req_l = soft_cmd_req & !soft_cmd_qos;
//assign soft_req_type1_rank = soft_cmd_req & (soft_req_type == 2'b01);
//assign soft_req_type2_rank = soft_req & (soft_req_type == 2'b10); //Type 2 command

assign mask = (pdx_lp_req_rank & lp_req_grant) | (zq_req_pim_h & pim_h_grant) | (mrrx_req_pim_h & pim_h_grant) | (mrr4_req_ref_h & mrr4_h_grant) | (refdb_req_ref_h & ref_db_h_grant)| (refab_req_ref_h & ref_ab_h_grant) | (rfmpb_req_ref_h & rfm_pb_h_grant) | (rfmab_req_ref_h & rfm_ab_h_grant);

assign func_req_arb = {zq_req_pim_h, mrrx_req_pim_h, mrr4_req_ref_h, refdb_req_ref_h, refab_req_ref_h, rfmpb_req_ref_h, rfmab_req_ref_h, prepb_req_ref_h, zq_req_l, mrrx_req_l, mrr4_req_l, refdb_req_ref_l, refab_req_ref_l, rfmpb_req_ref_l, rfmab_req_ref_l, pde_lp_req_rank, pdx_lp_req_rank, sre_lp_req_rank, srpde_lp_req_rank, srx_lp_req_rank, nop_lp_req_rank, mpc_lp_req_rank, cas_lp_req_rank, cas_off_lp_req_rank, prepb_req_ref_l, soft_cmd_req_h, soft_cmd_req_l}; 

always@(func_req_arb) begin:p_func_load_arb   
    integer i; 
    func_load_arb = 27'b0; 
    for(i=11; i>=0; i=i-1) begin 
        if(func_req_arb[i])begin 
            func_load_arb = 27'b1 << i; 
        end
    end 
end 

assign {zq_load_pim_h,mrrx_load_pim_h,mrr4_load_ref_h,refdb_load_ref_h, refab_load_ref_h, rfmpb_load_ref_h, rfmab_load_ref_h, prepb_load_ref_h, zq_load_l, mrrx_load_l, mrr4_load_l, refdb_load_ref_l, refab_load_ref_l, rfmpb_load_ref_l, rfmab_load_ref_l, pde_lp_load_rank, pdx_lp_load_rank, sre_lp_load_rank, srpde_lp_load_rank, srx_lp_load_rank, nop_lp_load_rank, mpc_lp_load_rank, cas_lp_load_rank, cas_off_lp_load_rank, prepb_load_ref_l, soft_cmd_load_h, soft_cmd_load_l} = func_load_arb ; 

assign zq_h_grant      =      func_load & zq_load_h;
assign mrrx_h_grant    =      func_load & mrrx_load_h;
assign refdb_grant_ref =      func_load & (refdb_load_ref_h | refdb_load_ref_l);
assign refab_grant_ref =      func_load & (refab_load_ref_h | refab_load_ref_l);
assign rfmpb_grant_ref =      func_load & (rfmpb_load_ref_h | rfmpb_load_ref_l);   
assign rfmab_grant_ref =      func_load & (rfmab_load_ref_h | rfmab_load_ref_l);  
assign prepb_grant_ref =      func_load & (prepb_load_ref_h | prepb_load_ref_l);   
assign pim_grant       =      func_load & (zq_load_h | mrrx_load_h | zq_load_l | mrrx_load_l); //  
assign mrr4_h_grant    =      func_load & mrr4_load_ref_h;
assign mrr4_load_h     =      |mrr4_h_grant;
assign mrr_grant_ref   =      func_load & (mrr4_load_h | mrr4_load_l) ? mrr4_req_ref_priority : {RK_NUM*SC_NUM{1'b0}};   
assign lp_req_grant    =      func_load & (pde_lp_load_rank | pdx_lp_load_rank | sre_lp_load_rank | srpde_lp_load_rank | srx_lp_load_rank | nop_lp_load_rank | mpc_lp_load_rank | cas_lp_load_rank | cas_off_lp_load_rank);
assign soft_req_grant  =      func_load & soft_load_type1_rank | soft_load_type2_rank; //  

assign mrr_zq_high_req = {RK_NUM*SC_NUM{zq_load_h & mrrx_load_h & mrr4_load_h}};
assign mrr_zq_low_req = {RK_NUM*SC_NUM{zq_load_l & mrrx_load_l & mrr4_load_l}};

// Simple assignments for missing signals
assign soft_load_type1_rank = soft_req_type[0];
assign soft_load_type2_rank = soft_req_type[1];
assign zq_req_pim_h = zq_req_pim_valid;
assign mrrx_req_pim_h = mrrx_req_pim_valid;
assign mrr4_req_ref_h = |mrr_req_ref & |mrr_req_qos_ref;
assign refdb_req_ref_h = |refdb_req_ref & |refdb_req_qos_ref;
assign refab_req_ref_h = |refab_req_ref & |refab_req_qos_ref;
assign rfmpb_req_ref_h = |rfmpb_req_ref & |rfmpb_req_qos_ref;
assign rfmab_req_ref_h = |rfmab_req_ref & |rfmab_req_qos_ref;
assign prepb_req_ref_h = |prepb_req_ref & |prepb_req_qos_ref;
assign prepb_req_ref_l = |prepb_req_ref & ~|prepb_req_qos_ref;
assign soft_cmd_req_h = soft_cmd_req & |soft_req_type;
assign soft_cmd_req_l = soft_cmd_req & ~|soft_req_type;

// Grant signal assignments
assign pim_h_grant = func_load & (zq_load_h | mrrx_load_h);
assign ref_db_h_grant = func_load & refdb_load_ref_h;
assign ref_ab_h_grant = func_load & refab_load_ref_h;
assign rfm_pb_h_grant = func_load & rfmpb_load_ref_h;
assign rfm_ab_h_grant = func_load & rfmab_load_ref_h;
assign mrr4_h_grant = func_load & mrr4_load_ref_h;

// Function request output
assign func_req = |func_req_arb;

//==============================================================================


endmodule

//==============================================================================
// End of Module
//==============================================================================
