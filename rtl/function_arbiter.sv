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
    parameter DDRC_SCRK_WIDTH = 8,
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
    input    [RK_NUM*SC_NUM-1:0]     pim_req,
    input    [7*RK_NUM*SC_NUM-1:0]   pim_type,
    input    [RK_NUM*SC_NUM-1:0]     pim_urgent,
    output   [RK_NUM*SC_NUM-1:0]     pim_grant,
    input    [2**DDRC_RK_WIDTH-1:0]       lp_req_rank,
    input    [2**DDRC_RK_WIDTH*4-1:0]     lp_req_type_rank,
    output   [2**DDRC_RK_WIDTH-1:0]       lp_req_grant,
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
    output                             mask,
    input                              func_load
);



// Internal Logic
// Declarations: wires first, then regs. Style-only consolidation.
wire [1:0] soft_req_type;
wire [28:0] func_req_arb;
wire soft_load_type1_rank;
wire soft_load_type2_rank;
wire zq_req_pim_h;
wire zq_req_pim_l;
wire mrrx_req_pim_h;
wire mrrx_req_pim_l;
wire mrr4_req_h;
wire refdb_req_ref_h;
wire refab_req_ref_h;
wire rfmpb_req_ref_h;
wire rfmab_req_ref_h;
wire prepb_req_ref_h;
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
// cas_off_lp_load_rank is a port; no redeclaration here
wire prepb_load_ref_l;
wire soft_cmd_load_h;
wire soft_cmd_load_l;
wire pim_h_grant;
wire ref_db_h_grant;
wire ref_ab_h_grant;
wire rfm_pb_h_grant;
wire rfm_ab_h_grant;
wire prepb_h_grant;
wire [RK_NUM*SC_NUM-1:0] mrr4_h_grant;
wire soft_req_grant;
// Priority/valid wires consolidated
wire [RK_NUM*SC_NUM-1:0] zq_req_pim_valid;
wire [RK_NUM*SC_NUM-1:0] zq_req_pim_priority;
wire [RK_NUM*SC_NUM-1:0] zq_req_pim_high_qos;
wire [RK_NUM*SC_NUM-1:0] zq_req_pim_low_qos;
wire [RK_NUM*SC_NUM-1:0] zq_req_pim_high_qos_priority;
wire [RK_NUM*SC_NUM-1:0] zq_req_pim_low_qos_priority;
// mrrx_req_pim_* consolidated to top for style consistency
wire [RK_NUM*SC_NUM-1:0] mrrx_req_pim_valid;
wire [RK_NUM*SC_NUM-1:0] mrrx_req_pim_priority;
wire [RK_NUM*SC_NUM-1:0] mrrx_req_pim_high_qos;
wire [RK_NUM*SC_NUM-1:0] mrrx_req_pim_low_qos;
wire [RK_NUM*SC_NUM-1:0] mrrx_req_pim_high_qos_priority;
wire [RK_NUM*SC_NUM-1:0] mrrx_req_pim_low_qos_priority;
// declarations moved to top (style-only)
wire pimx_req_pim_h, pimx_req_pim_l;
wire pimx_load_h, pimx_load_l;
wire [RK_NUM*SC_NUM-1:0] pimx_req_pim_valid;
wire [RK_NUM*SC_NUM-1:0] pimx_req_pim_priority;
wire [RK_NUM*SC_NUM-1:0] pimx_req_pim_high_qos;
wire [RK_NUM*SC_NUM-1:0] pimx_req_pim_low_qos;
wire [RK_NUM*SC_NUM-1:0] pimx_req_pim_high_qos_priority;
wire [RK_NUM*SC_NUM-1:0] pimx_req_pim_low_qos_priority;
wire [RK_NUM*SC_NUM-1:0] mrr4_req_ref_valid;
wire [RK_NUM*SC_NUM-1:0] mrr4_req_ref_priority;
wire [RK_NUM*SC_NUM-1:0] mrr4_req_ref_high_qos;
wire [RK_NUM*SC_NUM-1:0] mrr4_req_ref_low_qos;
wire [RK_NUM*SC_NUM-1:0] mrr4_req_ref_high_qos_priority;
wire [RK_NUM*SC_NUM-1:0] mrr4_req_ref_low_qos_priority;
wire [RK_NUM*SC_NUM-1:0] refdb_req_ref_priority;
wire [RK_NUM*SC_NUM-1:0] refdb_req_ref_high_qos;
wire [RK_NUM*SC_NUM-1:0] refdb_req_ref_low_qos;
wire [RK_NUM*SC_NUM-1:0] refdb_req_ref_high_qos_priority;
wire [RK_NUM*SC_NUM-1:0] refdb_req_ref_low_qos_priority;
wire [RK_NUM*SC_NUM-1:0] refab_req_ref_priority;
wire [RK_NUM*SC_NUM-1:0] refab_req_ref_high_qos;
wire [RK_NUM*SC_NUM-1:0] refab_req_ref_low_qos;
wire [RK_NUM*SC_NUM-1:0] refab_req_ref_high_qos_priority;
wire [RK_NUM*SC_NUM-1:0] refab_req_ref_low_qos_priority;
wire [RK_NUM*SC_NUM-1:0] rfmpb_req_ref_priority;
wire [RK_NUM*SC_NUM-1:0] rfmpb_req_ref_high_qos;
wire [RK_NUM*SC_NUM-1:0] rfmpb_req_ref_low_qos;
wire [RK_NUM*SC_NUM-1:0] rfmpb_req_ref_high_qos_priority;
wire [RK_NUM*SC_NUM-1:0] rfmpb_req_ref_low_qos_priority;
wire [RK_NUM*SC_NUM-1:0] rfmab_req_ref_priority;
wire [RK_NUM*SC_NUM-1:0] rfmab_req_ref_high_qos;
wire [RK_NUM*SC_NUM-1:0] rfmab_req_ref_low_qos;
wire [RK_NUM*SC_NUM-1:0] rfmab_req_ref_high_qos_priority;
wire [RK_NUM*SC_NUM-1:0] rfmab_req_ref_low_qos_priority;
wire [RK_NUM*SC_NUM-1:0] prepb_req_ref_priority;
wire [RK_NUM*SC_NUM-1:0] prepb_req_ref_high_qos;
wire [RK_NUM*SC_NUM-1:0] prepb_req_ref_low_qos;
wire [RK_NUM*SC_NUM-1:0] prepb_req_ref_high_qos_priority;
wire [RK_NUM*SC_NUM-1:0] prepb_req_ref_low_qos_priority;
// LP grant candidates
wire [RK_NUM-1:0] lp_req_grant_candidates;

// LP rank request valid/priority (consolidated at top for style)
// moved to top declarations: pde_lp_req_rank_valid/priority
// moved to top declarations: pdx_lp_req_rank_valid/priority
// moved to top declarations: sre_lp_req_rank_valid/priority
// moved to top declarations: srpde_lp_req_rank_valid/priority
// moved to top declarations: srx_lp_req_rank_valid/priority
// moved to top declarations: nop_lp_req_rank_valid/priority
// moved to top declarations: mpc_lp_req_rank_valid/priority
// moved to top declarations: cas_lp_req_rank_valid/priority
// moved to top declarations: cas_off_lp_req_rank_valid/priority

// LP type masks (consolidated at top, split per line for readability)
wire [2**DDRC_PA_RK_WIDTH-1:0] type_mask_pde;
wire [2**DDRC_PA_RK_WIDTH-1:0] type_mask_pdx;
wire [2**DDRC_PA_RK_WIDTH-1:0] type_mask_sre;
wire [2**DDRC_PA_RK_WIDTH-1:0] type_mask_srpde;
wire [2**DDRC_PA_RK_WIDTH-1:0] type_mask_srx;
wire [2**DDRC_PA_RK_WIDTH-1:0] type_mask_nop;
wire [2**DDRC_PA_RK_WIDTH-1:0] type_mask_mpc;
wire [2**DDRC_PA_RK_WIDTH-1:0] type_mask_cas;
wire [2**DDRC_PA_RK_WIDTH-1:0] type_mask_cas_off;

// Reg declarations (grouped)
reg [28:0] func_load_arb;
reg pim_h_grant_reg, ref_db_h_grant_reg, ref_ab_h_grant_reg;
reg rfm_pb_h_grant_reg, rfm_ab_h_grant_reg;
reg mrr4_h_grant_reg;
reg lp_req_grant_reg;
reg prepb_h_req_grant_reg;
reg mrr4_load_h_reg; // register mrr4_load_h to break comb loop
reg cas_off_lock;
reg [RK_NUM-1:0] cas_off_lock_rank;
reg pdx_lock;
reg [RK_NUM-1:0] pdx_lock_rank;
reg pimx_lock;
reg pimx_lock_is_high;
reg mrr4_lock_is_high;
reg refdb_lock;
reg refab_lock;
reg rfmpb_lock;
reg rfmab_lock;

// Priority encoder to select the lowest index valid signal

// Base valid signal for ZQ requests
genvar gi_zq;
generate
    for (gi_zq = 0; gi_zq < RK_NUM*SC_NUM; gi_zq = gi_zq + 1) begin : gen_zq_req_valid
        assign zq_req_pim_valid[gi_zq] = pim_req[gi_zq] & (pim_type[7*gi_zq +: 7] == 7'b0000001);
    end
endgenerate


// Separate high QoS and low QoS requests
assign zq_req_pim_high_qos = zq_req_pim_valid & pim_urgent[RK_NUM*SC_NUM-1:0];
assign zq_req_pim_low_qos = zq_req_pim_valid & (~pim_urgent[RK_NUM*SC_NUM-1:0]);

/// Priority encoder for high QoS requests (lowest index first)
assign zq_req_pim_high_qos_priority = zq_req_pim_high_qos & (~zq_req_pim_high_qos + 1);

// Priority encoder for low QoS requests (lowest index first)
assign zq_req_pim_low_qos_priority = zq_req_pim_low_qos & (~zq_req_pim_low_qos + 1);

// High QoS has priority over low QoS
assign zq_req_pim_priority = |zq_req_pim_high_qos ? zq_req_pim_high_qos_priority : zq_req_pim_low_qos_priority;
assign zq_req_pim_h = |zq_req_pim_priority & | pim_urgent;
assign zq_req_pim_l = |zq_req_pim_priority & !(| pim_urgent);

// Priority encoder to select the lowest index valid signal

// Base valid signal for ZQ requests
// assign mrrx_req_pim_valid = pim_req[RK_NUM*SC_NUM-1:0] & {RK_NUM*SC_NUM{pim_type[7 * (RK_NUM*SC_NUM) -1 :0] == 56'd3}};
genvar gi_mrrx;
generate
    for (gi_mrrx = 0; gi_mrrx < RK_NUM*SC_NUM; gi_mrrx = gi_mrrx + 1) begin : gen_mrrx_req_valid
        assign mrrx_req_pim_valid[gi_mrrx] = pim_req[gi_mrrx] & (
            (pim_type[7*gi_mrrx +: 7] == 7'b0000100) |
            (pim_type[7*gi_mrrx +: 7] == 7'b0001000)
        );
    end
endgenerate

// Separate high QoS and low QoS requests
assign mrrx_req_pim_high_qos = mrrx_req_pim_valid & pim_urgent[RK_NUM*SC_NUM-1:0];
assign mrrx_req_pim_low_qos =  mrrx_req_pim_valid & (~pim_urgent[RK_NUM*SC_NUM-1:0]);
// Priority encoder for high QoS requests (lowest index first)
assign mrrx_req_pim_high_qos_priority = mrrx_req_pim_high_qos & (~mrrx_req_pim_high_qos + 1);

// Priority encoder for low QoS requests (lowest index first)
assign mrrx_req_pim_low_qos_priority = mrrx_req_pim_low_qos & (~mrrx_req_pim_low_qos + 1);

// High QoS has priority over low QoS
assign mrrx_req_pim_priority = |mrrx_req_pim_high_qos ? mrrx_req_pim_high_qos_priority : mrrx_req_pim_low_qos_priority;
assign mrrx_req_pim_h =        |mrrx_req_pim_priority & | pim_urgent;
assign mrrx_req_pim_l =        |mrrx_req_pim_priority & !(| pim_urgent);

// Priority encoder to select the lowest index valid signal
// declarations moved to top (style-only)
// Base valid signal for ZQ requests
genvar gi_pimx;
generate
    for (gi_pimx = 0; gi_pimx < RK_NUM*SC_NUM; gi_pimx = gi_pimx + 1) begin : gen_pimx_req_valid
        assign pimx_req_pim_valid[gi_pimx] = pim_req[gi_pimx] & (
            (pim_type[7*gi_pimx +: 7] == 7'b1000000) |
            (pim_type[7*gi_pimx +: 7] == 7'b0100000) |
            (pim_type[7*gi_pimx +: 7] == 7'b0010000)
        );
    end
endgenerate


// Separate high QoS and low QoS requests
assign pimx_req_pim_high_qos = pimx_req_pim_valid & pim_urgent[RK_NUM*SC_NUM-1:0];
assign pimx_req_pim_low_qos =  pimx_req_pim_valid & (~pim_urgent[RK_NUM*SC_NUM-1:0]);

// Priority encoder for high QoS requests (lowest index first)
assign pimx_req_pim_high_qos_priority = pimx_req_pim_high_qos & (~pimx_req_pim_high_qos + 1);
// Priority encoder for low QoS requests (lowest index first)
assign pimx_req_pim_low_qos_priority = pimx_req_pim_low_qos & (~pimx_req_pim_low_qos + 1);

// High QoS has priority over low QoS
assign pimx_req_pim_priority = |pimx_req_pim_high_qos ? pimx_req_pim_high_qos_priority : pimx_req_pim_low_qos_priority;
assign pimx_req_pim_h =        |pimx_req_pim_priority & | pim_urgent;
assign pimx_req_pim_l =        |pimx_req_pim_priority & !(| pim_urgent);

// declarations moved to top (style-only)

// Separate high QoS and low QoS requests
assign mrr4_req_ref_high_qos = mrr_req_ref[RK_NUM*SC_NUM-1:0] & mrr_req_qos_ref[RK_NUM*SC_NUM-1:0];
assign mrr4_req_ref_low_qos = mrr_req_ref[RK_NUM*SC_NUM-1:0] & (~mrr_req_qos_ref[RK_NUM*SC_NUM-1:0]);

// Priority encoder for high QoS requests (lowest index first)
assign mrr4_req_ref_high_qos_priority = mrr4_req_ref_high_qos & (~mrr4_req_ref_high_qos + 1);

// Priority encoder for low QoS requests (lowest index first)
assign mrr4_req_ref_low_qos_priority = mrr4_req_ref_low_qos & (~mrr4_req_ref_low_qos + 1);

// High QoS has priority over low QoS
assign mrr4_req_ref_priority = |mrr4_req_ref_high_qos ? mrr4_req_ref_high_qos_priority : mrr4_req_ref_low_qos_priority;
assign mrr4_req_h = |mrr4_req_ref_priority & |mrr_req_qos_ref;
assign mrr4_req_l = |mrr4_req_ref_priority & !(|mrr_req_qos_ref);

// declarations moved to top (style-only)

// Separate high QoS and low QoS requests
assign refdb_req_ref_high_qos = refdb_req_ref[RK_NUM*SC_NUM-1:0] & refdb_req_qos_ref[RK_NUM*SC_NUM-1:0];
assign refdb_req_ref_low_qos = refdb_req_ref[RK_NUM*SC_NUM-1:0] & (~refdb_req_qos_ref[RK_NUM*SC_NUM-1:0]);

// Priority encoder for high QoS requests (lowest index first)
assign refdb_req_ref_high_qos_priority = refdb_req_ref_high_qos & (~refdb_req_ref_high_qos + 1);

// Priority encoder for low QoS requests (lowest index first)
assign refdb_req_ref_low_qos_priority = refdb_req_ref_low_qos & (~refdb_req_ref_low_qos + 1);

// High QoS has priority over low QoS
assign refdb_req_ref_priority = |refdb_req_ref_high_qos ? refdb_req_ref_high_qos_priority : refdb_req_ref_low_qos_priority;
assign refdb_req_ref_h = |refdb_req_ref_priority & |refdb_req_qos_ref;
assign refdb_req_ref_l = |refdb_req_ref_priority & !(|refdb_req_qos_ref);


// declarations moved to top (style-only)

// Separate high QoS and low QoS requests
assign refab_req_ref_high_qos = refab_req_ref[RK_NUM*SC_NUM-1:0] & refab_req_qos_ref[RK_NUM*SC_NUM-1:0];
assign refab_req_ref_low_qos = refab_req_ref[RK_NUM*SC_NUM-1:0] & (~refab_req_qos_ref[RK_NUM*SC_NUM-1:0]);

// Priority encoder for high QoS requests (lowest index first)
assign refab_req_ref_high_qos_priority = refab_req_ref_high_qos & (~refab_req_ref_high_qos + 1);

// Priority encoder for low QoS requests (lowest index first)
assign refab_req_ref_low_qos_priority = refab_req_ref_low_qos & (~refab_req_ref_low_qos + 1);

// High QoS has priority over low QoS
assign refab_req_ref_priority = |refab_req_ref_high_qos ? refab_req_ref_high_qos_priority : refab_req_ref_low_qos_priority;
assign refab_req_ref_h = |refab_req_ref_priority & |refab_req_qos_ref;
assign refab_req_ref_l = |refab_req_ref_priority &!(|refab_req_qos_ref);

// declarations moved to top (style-only)

// Separate high QoS and low QoS requests
assign rfmpb_req_ref_high_qos = rfmpb_req_ref[RK_NUM*SC_NUM-1:0] & rfmpb_req_qos_ref[RK_NUM*SC_NUM-1:0];
assign rfmpb_req_ref_low_qos = rfmpb_req_ref[RK_NUM*SC_NUM-1:0] & (~rfmpb_req_qos_ref[RK_NUM*SC_NUM-1:0]);

// Priority encoder for high QoS requests (lowest index first)
assign rfmpb_req_ref_high_qos_priority = rfmpb_req_ref_high_qos & (~rfmpb_req_ref_high_qos + 1);

// Priority encoder for low QoS requests (lowest index first)
assign rfmpb_req_ref_low_qos_priority = rfmpb_req_ref_low_qos & (~rfmpb_req_ref_low_qos + 1);

// High QoS has priority over low QoS
assign rfmpb_req_ref_priority = |rfmpb_req_ref_high_qos ? rfmpb_req_ref_high_qos_priority : rfmpb_req_ref_low_qos_priority;
assign rfmpb_req_ref_h = |rfmpb_req_ref_priority & |rfmpb_req_qos_ref;
assign rfmpb_req_ref_l = |rfmpb_req_ref_priority & !(|rfmpb_req_qos_ref);


// declarations moved to top (style-only)

// Separate high QoS and low QoS requests
assign rfmab_req_ref_high_qos = rfmab_req_ref[RK_NUM*SC_NUM-1:0] & rfmab_req_qos_ref[RK_NUM*SC_NUM-1:0];
assign rfmab_req_ref_low_qos = rfmab_req_ref[RK_NUM*SC_NUM-1:0] & (~rfmab_req_qos_ref[RK_NUM*SC_NUM-1:0]);

// Priority encoder for high QoS requests (lowest index first)
assign rfmab_req_ref_high_qos_priority = rfmab_req_ref_high_qos & (~rfmab_req_ref_high_qos + 1);

// Priority encoder for low QoS requests (lowest index first)
assign rfmab_req_ref_low_qos_priority = rfmab_req_ref_low_qos & (~rfmab_req_ref_low_qos + 1);

// High QoS has priority over low QoS
assign rfmab_req_ref_priority = |rfmab_req_ref_high_qos ? rfmab_req_ref_high_qos_priority : rfmab_req_ref_low_qos_priority;
assign rfmab_req_ref_h = |rfmab_req_ref_priority & |rfmab_req_qos_ref;
assign rfmab_req_ref_l = |rfmab_req_ref_priority & !(|rfmab_req_qos_ref);

//assign prepb_req_be_h = (actpre_pa_cmd_vld & (actpre_pa_cmd_type == 2'b10) & (|actpre_pa_cmd_hqos));
//assign prepb_req_be_l = (actpre_pa_cmd_vld & (actpre_pa_cmd_type == 2'b10) & !(|actpre_pa_cmd_hqos));

// declarations moved to top (style-only)

// Separate high QoS and low QoS requests
assign prepb_req_ref_high_qos = prepb_req_ref[RK_NUM*SC_NUM-1:0] & prepb_req_qos_ref[RK_NUM*SC_NUM-1:0];
assign prepb_req_ref_low_qos =  prepb_req_ref[RK_NUM*SC_NUM-1:0] & (~prepb_req_qos_ref[RK_NUM*SC_NUM-1:0]);

// Priority encoder for high QoS requests (lowest index first)
assign prepb_req_ref_high_qos_priority = prepb_req_ref_high_qos & (~prepb_req_ref_high_qos + 1);

// Priority encoder for low QoS requests (lowest index first)
assign prepb_req_ref_low_qos_priority = prepb_req_ref_low_qos & (~prepb_req_ref_low_qos + 1);

// High QoS has priority over low QoS
assign prepb_req_ref_priority = |prepb_req_ref_high_qos ?    prepb_req_ref_high_qos_priority : prepb_req_ref_low_qos_priority;
assign prepb_req_ref_h =        |prepb_req_ref_priority &   |prepb_req_qos_ref;
assign prepb_req_ref_l =        |prepb_req_ref_priority & !(|prepb_req_qos_ref);

//assign prepb_req_be_ref_l = prepb_req_be_l | prepb_req_ref_l;

// Per-rank 4-bit type decode and lowest-index selection per type
// moved to top: type_mask_* declarations
genvar i;
generate
  for (i = 0; i < 2**DDRC_PA_RK_WIDTH; i = i + 1) begin : gen_lp_type_masks
    assign type_mask_pde[i]      = (lp_req_type_rank[i*4 +: 4] == 4'd0);
    assign type_mask_pdx[i]      = (lp_req_type_rank[i*4 +: 4] == 4'd1);
    assign type_mask_sre[i]      = (lp_req_type_rank[i*4 +: 4] == 4'd2);
    assign type_mask_srpde[i]    = (lp_req_type_rank[i*4 +: 4] == 4'd3);
    assign type_mask_srx[i]      = (lp_req_type_rank[i*4 +: 4] == 4'd4);
    assign type_mask_nop[i]      = (lp_req_type_rank[i*4 +: 4] == 4'd5);
    assign type_mask_mpc[i]      = (lp_req_type_rank[i*4 +: 4] == 4'd6);
    assign type_mask_cas[i]      = (lp_req_type_rank[i*4 +: 4] == 4'd7);
    assign type_mask_cas_off[i]  = (lp_req_type_rank[i*4 +: 4] == 4'd8);
  end
endgenerate

// For each type: valid bit, lowest-index priority encoding, existence (OR)
wire [2**DDRC_PA_RK_WIDTH-1:0] pde_lp_req_rank_valid;
wire [2**DDRC_PA_RK_WIDTH-1:0] pde_lp_req_rank_priority;
assign pde_lp_req_rank_valid    = lp_req_rank[2**DDRC_PA_RK_WIDTH-1:0] & type_mask_pde;
assign pde_lp_req_rank_priority = pde_lp_req_rank_valid & (~pde_lp_req_rank_valid + 1);
assign pde_lp_req_rank          = |pde_lp_req_rank_priority;

wire [2**DDRC_PA_RK_WIDTH-1:0] pdx_lp_req_rank_valid;
wire [2**DDRC_PA_RK_WIDTH-1:0] pdx_lp_req_rank_priority;
assign pdx_lp_req_rank_valid    = lp_req_rank[2**DDRC_PA_RK_WIDTH-1:0] & type_mask_pdx;
assign pdx_lp_req_rank_priority = pdx_lp_req_rank_valid & (~pdx_lp_req_rank_valid + 1);
assign pdx_lp_req_rank          = |pdx_lp_req_rank_priority;

wire [2**DDRC_PA_RK_WIDTH-1:0] sre_lp_req_rank_valid;
wire [2**DDRC_PA_RK_WIDTH-1:0] sre_lp_req_rank_priority;
assign sre_lp_req_rank_valid    = lp_req_rank[2**DDRC_PA_RK_WIDTH-1:0] & type_mask_sre;
assign sre_lp_req_rank_priority = sre_lp_req_rank_valid & (~sre_lp_req_rank_valid + 1);
assign sre_lp_req_rank          = |sre_lp_req_rank_priority;

wire [2**DDRC_PA_RK_WIDTH-1:0] srpde_lp_req_rank_valid;
wire [2**DDRC_PA_RK_WIDTH-1:0] srpde_lp_req_rank_priority;
assign srpde_lp_req_rank_valid    = lp_req_rank[2**DDRC_PA_RK_WIDTH-1:0] & type_mask_srpde;
assign srpde_lp_req_rank_priority = srpde_lp_req_rank_valid & (~srpde_lp_req_rank_valid + 1);
assign srpde_lp_req_rank          = |srpde_lp_req_rank_priority;

wire [2**DDRC_PA_RK_WIDTH-1:0] srx_lp_req_rank_valid;
wire [2**DDRC_PA_RK_WIDTH-1:0] srx_lp_req_rank_priority;
assign srx_lp_req_rank_valid    = lp_req_rank[2**DDRC_PA_RK_WIDTH-1:0] & type_mask_srx;
assign srx_lp_req_rank_priority = srx_lp_req_rank_valid & (~srx_lp_req_rank_valid + 1);
assign srx_lp_req_rank          = |srx_lp_req_rank_priority;

wire [2**DDRC_PA_RK_WIDTH-1:0] nop_lp_req_rank_valid;
wire [2**DDRC_PA_RK_WIDTH-1:0] nop_lp_req_rank_priority;
assign nop_lp_req_rank_valid    = lp_req_rank[2**DDRC_PA_RK_WIDTH-1:0] & type_mask_nop;
assign nop_lp_req_rank_priority = nop_lp_req_rank_valid & (~nop_lp_req_rank_valid + 1);
assign nop_lp_req_rank          = |nop_lp_req_rank_priority;

wire [2**DDRC_PA_RK_WIDTH-1:0] mpc_lp_req_rank_valid;
wire [2**DDRC_PA_RK_WIDTH-1:0] mpc_lp_req_rank_priority;
assign mpc_lp_req_rank_valid    = lp_req_rank[2**DDRC_PA_RK_WIDTH-1:0] & type_mask_mpc;
assign mpc_lp_req_rank_priority = mpc_lp_req_rank_valid & (~mpc_lp_req_rank_valid + 1);
assign mpc_lp_req_rank          = |mpc_lp_req_rank_priority;

wire [2**DDRC_PA_RK_WIDTH-1:0] cas_lp_req_rank_valid;
wire [2**DDRC_PA_RK_WIDTH-1:0] cas_lp_req_rank_priority;
assign cas_lp_req_rank_valid    = lp_req_rank[2**DDRC_PA_RK_WIDTH-1:0] & type_mask_cas;
assign cas_lp_req_rank_priority = cas_lp_req_rank_valid & (~cas_lp_req_rank_valid + 1);
assign cas_lp_req_rank          = |cas_lp_req_rank_priority;

wire [2**DDRC_PA_RK_WIDTH-1:0] cas_off_lp_req_rank_valid;
wire [2**DDRC_PA_RK_WIDTH-1:0] cas_off_lp_req_rank_priority;
assign cas_off_lp_req_rank_valid    = lp_req_rank[2**DDRC_PA_RK_WIDTH-1:0] & type_mask_cas_off;
assign cas_off_lp_req_rank_priority = cas_off_lp_req_rank_valid & (~cas_off_lp_req_rank_valid + 1);
assign cas_off_lp_req_rank          = |cas_off_lp_req_rank_priority;



// Priority encoder: select lowest index (rightmost bit)
assign soft_cmd_req_h = soft_cmd_req & soft_cmd_qos;
assign soft_cmd_req_l = soft_cmd_req & !soft_cmd_qos;

// Use registered versions of grant signals to break combinational loop
// reg declarations moved to top (style-only)


always @(posedge ddrc_clk or negedge ddrc_rst_n) begin
    if (~ddrc_rst_n) begin
        pim_h_grant_reg <= 1'b0;
        ref_db_h_grant_reg <= 1'b0;
        ref_ab_h_grant_reg <= 1'b0;
        rfm_pb_h_grant_reg <= 1'b0;
        rfm_ab_h_grant_reg <= 1'b0;
        mrr4_h_grant_reg <= 1'b0;
        lp_req_grant_reg <= 1'b0;
        prepb_h_req_grant_reg <= 1'b0;
        mrr4_load_h_reg <= 1'b0;
        cas_off_lock <= 1'b0;
        cas_off_lock_rank <= {RK_NUM{1'b0}};
        pdx_lock <= 1'b0;
        pdx_lock_rank <= {RK_NUM{1'b0}};
        pimx_lock <= 1'b0;
        pimx_lock_is_high <= 1'b0;
        mrr4_lock_is_high <= 1'b0;
        refdb_lock <= 1'b0;
        refab_lock <= 1'b0;
        rfmpb_lock <= 1'b0;
        rfmab_lock <= 1'b0;
    end else begin
        pim_h_grant_reg <= pim_h_grant;
        ref_db_h_grant_reg <= ref_db_h_grant;
        ref_ab_h_grant_reg <= ref_ab_h_grant;
        rfm_pb_h_grant_reg <= rfm_pb_h_grant;
        rfm_ab_h_grant_reg <= rfm_ab_h_grant;
        mrr4_h_grant_reg <= mrr4_h_grant;
        lp_req_grant_reg <= |lp_req_grant;
        prepb_h_req_grant_reg <= prepb_h_grant;
        mrr4_load_h_reg <= |mrr4_h_grant;
        if (cas_off_lock) begin
            if ((cas_off_lp_req_rank_valid & cas_off_lock_rank) == {RK_NUM{1'b0}}) begin
                cas_off_lock <= 1'b0;
                cas_off_lock_rank <= {RK_NUM{1'b0}};
            end
        end else begin
            if (func_load & cas_off_lp_load_rank) begin
                cas_off_lock <= 1'b1;
                cas_off_lock_rank <= cas_off_lp_req_rank_priority;
            end
        end
        if (pdx_lock) begin
            if ((pdx_lp_req_rank_valid & pdx_lock_rank) == {RK_NUM{1'b0}}) begin
                pdx_lock <= 1'b0;
                pdx_lock_rank <= {RK_NUM{1'b0}};
            end
        end else begin
            if (func_load & pdx_lp_load_rank) begin
                pdx_lock <= 1'b1;
                pdx_lock_rank <= pdx_lp_req_rank_priority;
            end
        end
        if (pimx_lock) begin
            if (~|pimx_req_pim_valid) begin
                pimx_lock <= 1'b0;
                pimx_lock_is_high <= 1'b0;
            end
        end else begin
            if (func_load & (pimx_load_h | pimx_load_l)) begin
                pimx_lock <= 1'b1;
                pimx_lock_is_high <= pimx_load_h;
            end
        end
        if (mrr4_lock_is_high) begin
            if (~|mrr4_req_ref_high_qos) begin
                mrr4_lock_is_high <= 1'b0;
            end
        end else begin
            if (func_load & mrr4_load_ref_h) begin
                mrr4_lock_is_high <= 1'b1;
            end
        end
        if (refdb_lock) begin
            if (~|refdb_req_ref_high_qos) refdb_lock <= 1'b0;
        end else begin
            if (func_load & refdb_load_ref_h) refdb_lock <= 1'b1;
        end
        if (refab_lock) begin
            if (~|refab_req_ref_high_qos) refab_lock <= 1'b0;
        end else begin
            if (func_load & refab_load_ref_h) refab_lock <= 1'b1;
        end
        if (rfmpb_lock) begin
            if (~|rfmpb_req_ref_high_qos) rfmpb_lock <= 1'b0;
        end else begin
            if (func_load & rfmpb_load_ref_h) rfmpb_lock <= 1'b1;
        end
        if (rfmab_lock) begin
            if (~|rfmab_req_ref_high_qos) rfmab_lock <= 1'b0;
        end else begin
            if (func_load & rfmab_load_ref_h) rfmab_lock <= 1'b1;
        end
    end
end


assign mask =  cas_off_lock | pdx_lock | pimx_lock | mrr4_lock_is_high |
               refdb_lock | refab_lock | rfmpb_lock | rfmab_lock |
               (pdx_lp_req_rank & lp_req_grant_reg) |
               ((|pim_urgent)) |
               (mrr4_req_h & mrr4_h_grant_reg) |
               (refdb_req_ref_h & ref_db_h_grant_reg)|
               (refab_req_ref_h & ref_ab_h_grant_reg) |
               (rfmpb_req_ref_h & rfm_pb_h_grant_reg) |
               (rfmab_req_ref_h & rfm_ab_h_grant_reg);


wire [28:0] func_req_arb_raw;
assign func_req_arb_raw = {zq_req_pim_h, mrrx_req_pim_h, pimx_req_pim_h, mrr4_req_h, refdb_req_ref_h, refab_req_ref_h, rfmpb_req_ref_h, rfmab_req_ref_h, prepb_req_ref_h, zq_req_pim_l, mrrx_req_pim_l, pimx_req_pim_l, mrr4_req_l, refdb_req_ref_l, refab_req_ref_l, rfmpb_req_ref_l, rfmab_req_ref_l, pde_lp_req_rank, pdx_lp_req_rank, sre_lp_req_rank, srpde_lp_req_rank, srx_lp_req_rank, nop_lp_req_rank, mpc_lp_req_rank, cas_lp_req_rank, cas_off_lp_req_rank, prepb_req_ref_l, soft_cmd_req_h, soft_cmd_req_l};
assign func_req_arb = cas_off_lock ? (29'b1 << 5'd3)
                      : (pdx_lock ? (29'b1 << 5'd10)
                      : (pimx_lock ? (pimx_lock_is_high ? (29'b1 << 5'd26) : (29'b1 << 5'd17))
                      : (mrr4_lock_is_high ? (29'b1 << 5'd25)
                      : (refdb_lock ? (29'b1 << 5'd24)
                      : (refab_lock ? (29'b1 << 5'd23)
                      : (rfmpb_lock ? (29'b1 << 5'd22)
                      : (rfmab_lock ? (29'b1 << 5'd21)
                      : func_req_arb_raw)))))));


always@(func_req_arb) begin:p_func_load_arb   
    integer i; 
    func_load_arb = 29'b0; 
    for(i=28; i>=0; i=i-1) begin 
        if(func_req_arb[i] && (func_load_arb == 29'b0))begin 
            func_load_arb = 29'b1 << i; 
        end
    end 
end 


assign {zq_load_pim_h,mrrx_load_pim_h,pimx_load_h,mrr4_load_ref_h,refdb_load_ref_h, refab_load_ref_h, rfmpb_load_ref_h, rfmab_load_ref_h, prepb_load_ref_h, zq_load_l, mrrx_load_l, pimx_load_l, mrr4_load_l, refdb_load_ref_l, refab_load_ref_l, rfmpb_load_ref_l, rfmab_load_ref_l, pde_lp_load_rank, pdx_lp_load_rank, sre_lp_load_rank, srpde_lp_load_rank, srx_lp_load_rank, nop_lp_load_rank, mpc_lp_load_rank, cas_lp_load_rank, cas_off_lp_load_rank, prepb_load_ref_l, soft_cmd_load_h, soft_cmd_load_l} = func_load_arb; 



assign zq_load_h       =      zq_load_pim_h;
assign mrrx_load_h     =      mrrx_load_pim_h;
assign mrr4_h_grant    =      func_load & mrr4_load_ref_h;
assign prepb_h_grant    =      func_load & prepb_load_ref_h;
assign mrr4_load_h     =      mrr4_load_h_reg;
assign refdb_grant_ref =      func_load & (refdb_load_ref_h | refdb_load_ref_l) ? refdb_req_ref_priority :  {RK_NUM*SC_NUM{1'b0}};
assign refab_grant_ref =      func_load & (refab_load_ref_h | refab_load_ref_l) ? refab_req_ref_priority :  {RK_NUM*SC_NUM{1'b0}};
assign rfmpb_grant_ref =      func_load & (rfmpb_load_ref_h | rfmpb_load_ref_l) ? rfmpb_req_ref_priority :  {RK_NUM*SC_NUM{1'b0}};
assign rfmab_grant_ref =      func_load & (rfmab_load_ref_h | rfmab_load_ref_l) ? rfmab_req_ref_priority :  {RK_NUM*SC_NUM{1'b0}};
assign prepb_grant_ref =      func_load & (prepb_load_ref_h | prepb_load_ref_l) ? prepb_req_ref_priority :  {RK_NUM*SC_NUM{1'b0}};   

   
// [MODIFIED 2025-11-15] PIMX grant broadcasts to all ranks when selected
assign pim_grant = (
    (func_load & zq_load_h)   ? zq_req_pim_high_qos_priority : {RK_NUM*SC_NUM{1'b0}}
  | (func_load & pimx_load_h) ? pimx_req_pim_high_qos : {RK_NUM*SC_NUM{1'b0}}
  | (func_load & mrrx_load_h) ? mrrx_req_pim_high_qos_priority: {RK_NUM*SC_NUM{1'b0}}
  | (func_load & zq_load_l)   ? zq_req_pim_low_qos_priority   : {RK_NUM*SC_NUM{1'b0}}
  | (func_load & pimx_load_l) ? pimx_req_pim_low_qos : {RK_NUM*SC_NUM{1'b0}}
  | (func_load & mrrx_load_l) ? mrrx_req_pim_low_qos_priority : {RK_NUM*SC_NUM{1'b0}}
);

assign mrr_grant_ref   =      func_load & (mrr4_load_ref_h | mrr4_load_l) ? mrr4_req_ref_priority : {RK_NUM*SC_NUM{1'b0}};  

// Select type first (main arbiter chooses one), then lowest-index rank within that type
assign lp_req_grant_candidates = func_load ? (
                               (pde_lp_load_rank   ? pde_lp_req_rank_priority   :
                               (pdx_lp_load_rank   ? pdx_lp_req_rank_priority   :
                               (sre_lp_load_rank   ? sre_lp_req_rank_priority   :
                               (srpde_lp_load_rank ? srpde_lp_req_rank_priority :
                               (srx_lp_load_rank   ? srx_lp_req_rank_priority   :
                               (nop_lp_load_rank   ? nop_lp_req_rank_priority   :
                               (mpc_lp_load_rank   ? mpc_lp_req_rank_priority   :
                               (cas_lp_load_rank   ? cas_lp_req_rank_valid      :
                               (cas_off_lp_load_rank ? cas_off_lp_req_rank_priority : {RK_NUM{1'b0}})))))))))
                               ) : {RK_NUM{1'b0}};
assign lp_req_grant    = cas_off_lock ? (cas_off_lock_rank & cas_off_lp_req_rank_valid)
                                      : (pdx_lock ? (pdx_lock_rank & pdx_lp_req_rank_valid)
                                                  : lp_req_grant_candidates);
assign soft_req_grant  =      func_load & soft_load_type1_rank | soft_load_type2_rank; //  
assign soft_cmd_grant  =      soft_req_grant;

assign mrr_zq_high_req = zq_load_pim_h | mrrx_load_pim_h | mrr4_load_ref_h | pimx_load_h;
assign mrr_zq_low_req = {RK_NUM*SC_NUM{zq_load_l & mrrx_load_l & mrr4_load_l}};
// Simple assignments for missing signals
assign soft_req_type = 2'b00;
assign soft_load_type1_rank = soft_req_type[0];
assign soft_load_type2_rank = soft_req_type[1];

// Grant signal assignments
assign pim_h_grant    = func_load & (zq_load_h | mrrx_load_h | pimx_load_h);
assign ref_db_h_grant = func_load & refdb_load_ref_h;
assign ref_ab_h_grant = func_load & refab_load_ref_h;
assign rfm_pb_h_grant = func_load & rfmpb_load_ref_h;
assign rfm_ab_h_grant = func_load & rfmab_load_ref_h;

// Grant signal assignments (deduplicated)

// Function request output
assign func_req = |func_req_arb;
assign func_hqos = |(zq_load_pim_h | mrrx_load_pim_h | pimx_load_h | mrr4_load_ref_h | refdb_load_ref_h | refab_load_ref_h | rfmpb_load_ref_h | rfmab_load_ref_h | prepb_load_ref_h);


//==============================================================================


endmodule

//==============================================================================
// End of Module
//==============================================================================