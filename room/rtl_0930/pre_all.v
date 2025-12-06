//==============================================================================
// Pre_All Module
// Generated from Protocol_Arbiter (23).xlsx
// Auto-generated on 2025-01-25 10:00:00
//==============================================================================

module pre_all #(
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
    parameter DDRC_RK_WIDTH = 2
)(
    // Clock and Reset
    input                              ddrc_clk,
    input                              ddrc_rst_n,
    
    // Pre_All Intent Signals
    input    [RK_NUM*SC_NUM-1:0]       pre_all_intent_ref,
    input    [RK_NUM*SC_NUM-1:0]       pre_all_intent_qos_ref,
    output   [RK_NUM*SC_NUM-1:0]       pre_all_intent_grant_ref,
    
    // Prepb Signals
    input    [RK_NUM*SC_NUM-1:0]       prepb_req_ref,
    input    [RK_NUM*SC_NUM-1:0]       prepb_req_qos_ref,
    output   [RK_NUM*SC_NUM-1:0]       prepb_grant_ref,
    
    // Pre_All PIM Signals
    input    [RK_NUM*SC_NUM-1:0]       pre_all_req_pim,
    output   [RK_NUM*SC_NUM-1:0]       pre_all_req_urgent_pim,
    input    [3*RK_NUM*SC_NUM-1:0]     pre_all_req_type_pim,
    input    [RK_NUM*SC_NUM-1:0]       pre_all_grant_pim,
    
    // Pre_All LP Signals
    output   [2**DDRC_RK_WIDTH-1:0]    pre_all_grant_lp,
    
    // PA Grant Signals
    output   [RK_NUM-1:0]              pa_pre_all_grant,
    output   [RK_NUM-1:0]              pa_pre_pb_grant,
    
    // Pre Signals
    output                             pre_vld,
    output   [1:0]                     pre_ph,
    output   [DDRC_RK_WIDTH-1:0]       prea_cmd_rk,
    output                             prea_cmd_sc,
    
    // Pre AB Allow Signals
    input    [2*2**DDRC_RK_WIDTH-1:0]  pre_ab_allow,
    input    [2*2*2**DDRC_RK_WIDTH-1:0] pre_ab_allow_ph,
    
    // PA DFI Command Signals
    output                             pa_cmd_vld,
    output   [DDRC_PA_CMD_WIDTH-1:0]   pa_dfi_cmd_type,
    output   [2**DDRC_RK_WIDTH-1:0]    pa_dfi_cmd_rank,
    output   [DDRC_PA_PHASE_WIDTH-1:0] pa_dfi_cmd_phase,
    output                             pa_dfi_cmd_sc,
    
    // Preab Signals
    output   [RK_NUM*SC_NUM-1:0]       preab_req_preall,
    output   [RK_NUM*SC_NUM-1:0]       preab_req_qos_preall,
    input    [RK_NUM*SC_NUM-1:0]       preab_grant_preall
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

//==============================================================================
// Internal Logic

// Pre_All Intent Signals
assign pre_all_intent_grant_ref = {RK_NUM*SC_NUM{1'b0}};

// Prepb Signals
assign prepb_grant_ref = {RK_NUM*SC_NUM{1'b0}};

// Pre_All PIM Signals
assign pre_all_req_urgent_pim = {RK_NUM*SC_NUM{1'b0}};

// Pre_All LP Signals
assign pre_all_grant_lp = {2**DDRC_RK_WIDTH{1'b0}};

// PA Grant Signals
assign pa_pre_all_grant = {RK_NUM{1'b0}};
assign pa_pre_pb_grant = {RK_NUM{1'b0}};

// Pre Signals
assign pre_vld = 1'b0;
assign pre_ph = 2'b00;
assign prea_cmd_rk = {DDRC_RK_WIDTH{1'b0}};
assign prea_cmd_sc = 1'b0;

// PA DFI Command Signals
assign pa_cmd_vld = 1'b0;
assign pa_dfi_cmd_type = {DDRC_PA_CMD_WIDTH{1'b0}};
assign pa_dfi_cmd_rank = {2**DDRC_RK_WIDTH{1'b0}};
assign pa_dfi_cmd_phase = {DDRC_PA_PHASE_WIDTH{1'b0}};
assign pa_dfi_cmd_sc = 1'b0;

// Preab Signals
assign preab_req_preall = {RK_NUM*SC_NUM{1'b0}};
assign preab_req_qos_preall = {RK_NUM*SC_NUM{1'b0}};  
//==============================================================================


endmodule

//==============================================================================
// End of Module
//==============================================================================
