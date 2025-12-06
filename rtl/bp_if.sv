//==============================================================================
// BP_If Module
// Generated from Protocol_Arbiter (23).xlsx
// Auto-generated on 2025-01-25 10:00:00
//==============================================================================

module bp_if #(
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
    localparam DDRC_SCRKBKBG_WIDTH = DDRC_PA_SC_WIDTH+DDRC_PA_BK_WIDTH+DDRC_PA_BG_WIDTH+DDRC_PA_RK_WIDTH,
    localparam DDRC_SCRKBGBK_WIDTH = DDRC_PA_SC_WIDTH+DDRC_PA_BK_WIDTH+DDRC_PA_BG_WIDTH+DDRC_PA_RK_WIDTH,
    localparam DDRC_PA_DDRC_PA_RKBKBG_WIDTH = DDRC_PA_RK_WIDTH + DDRC_PA_BG_WIDTH + DDRC_PA_BK_WIDTH,
    localparam DDRC_PA_RDWR_INFO_WIDTH = DDRC_PA_RD_INFO_WIDTH + DDRC_PA_WR_INFO_WIDTH
)(
    // Clock and Reset
    input                              ddrc_clk,
    input                              ddrc_rst_n,
    
    // BP Request Signals
    input    [RK_NUM*SC_NUM-1:0]       bp_req_ref,
    input    [RK_NUM*SC_NUM-1:0]       bp_type_ref,
    input    [DDRC_BGBK_WIDTH*RK_NUM*SC_NUM-1:0] bp_bgbk_0_ref,
    input    [DDRC_BGBK_WIDTH*RK_NUM*SC_NUM-1:0] bp_bgbk_1_ref,
    
    // BP PIM Signals
    input    [RK_NUM-1:0]              bp_req_pim,
    
    // BP LP Signals
    input    [2**DDRC_RK_WIDTH-1:0]    bp_req_lp,
    
    // Soft BP All Request Signal
    input    [RK_NUM*SC_NUM-1:0]       soft_bp_all_req,
    
    // BP FE Output Signals
    output   [RK_NUM*SC_NUM-1:0]       bp_req_fe,
    output   [RK_NUM*SC_NUM-1:0]       bp_type_fe,
    
    // BP Rank BG BK Output Signals
    output   [DDRC_BGBK_WIDTH*RK_NUM*SC_NUM-1:0] bp_rnkbgbk_0_ref,
    output   [DDRC_BGBK_WIDTH*RK_NUM*SC_NUM-1:0] bp_rnkbgbk_1_ref
);



//==============================================================================
// Internal Logic

// BP FE Output Signals
assign bp_req_fe = bp_req_ref |
                   { {2{bp_req_pim[3]}}, {2{bp_req_pim[2]}}, {2{bp_req_pim[1]}}, {2{bp_req_pim[0]}} } |
                   { {2{bp_req_lp[3]}}, {2{bp_req_lp[2]}}, {2{bp_req_lp[1]}}, {2{bp_req_lp[0]}} } |
                   soft_bp_all_req;
assign bp_type_fe = bp_type_ref |
                    { {2{bp_req_pim[3]}}, {2{bp_req_pim[2]}}, {2{bp_req_pim[1]}}, {2{bp_req_pim[0]}} } |
                    { {2{bp_req_lp[3]}}, {2{bp_req_lp[2]}}, {2{bp_req_lp[1]}}, {2{bp_req_lp[0]}} } |
                    soft_bp_all_req;

// BP Rank BG BK Output Signals
assign bp_rnkbgbk_0_ref = bp_bgbk_0_ref;
assign bp_rnkbgbk_1_ref = bp_bgbk_1_ref;  

assign bp_req_rfm_fe = bp_req_rfm; 
assign bp_type_rfm_fe = bp_type_rfm; 
assign bp_bgbk_rfm_fe = bp_bgbk_rfm; 

//==============================================================================


endmodule

//==============================================================================
// End of Module
//==============================================================================
