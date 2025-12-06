//==============================================================================
// BP_If Module
// Generated from Protocol_Arbiter (9).xlsx
// Auto-generated on 2025-08-11 17:03:21
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
    parameter DDRC_PA_PHASE_WIDTH = 2
)(
    input                               core_clk,
    input                               core_rstn,
    input    [RK_NUM*SC_NUM-1:0]       bp_req_ref,
    input    [RK_NUM*SC_NUM-1:0]       bp_type_ref,
    input    [DDRC_PA_SCRKBGBK_WIDTH*RK_NUM*SC_NUM] bp_rnkbgbk_0_ref,
    input    [DDRC_PA_SCRKBGBK_WIDTH*RK_NUM*SC_NUM] bp_rnkbgbk_1_ref,
    input    [RK_NUM-1:0]              backpressure_pim_bp_req_pim,
    input    [RK_NUM-1:0]              backpressure_urgent_pim_bp_hqos_pim,
    input    [RK_NUM*SC_NUM-1:0]       bp_req_lp,
    output   [RK_NUM*SC_NUM-1:0]       bp_req_fe,
    output   [RK_NUM*SC_NUM-1:0]       bp_type_fe,
    output   [DDRC_PA_SCRKBGBK_WIDTH*RK_NUM*SC_NUM] bp_rnkbgbk_0_pa,
    output   [DDRC_PA_SCRKBGBK_WIDTH*RK_NUM*SC_NUM] bp_rnkbgbk_1_pa
);


//==============================================================================
// Internal Logic

// Request signals
assign bp_req_fe = {(RK_NUM*SC_NUM){1'b0}}; // TODO: Implement logic
// Other signals
    localparam DDRC_PA_DDRC_PA_RKBKBG_WIDTH = DDRC_PA_RK_WIDTH + DDRC_PA_BG_WIDTH + DDRC_PA_BK_WIDTH;
    localparam DDRC_PA_RDWR_INFO_WIDTH = DDRC_PA_RD_INFO_WIDTH + DDRC_PA_WR_INFO_WIDTH;

endmodule

//==============================================================================
// End of Module
//==============================================================================
assign bp_req_fe = 1'b0; // TODO: Implement logic
assign bp_type_fe = 1'b0; // TODO: Implement logic
assign bp_rnkbgbk_0_pa = 1'b0; // TODO: Implement logic
assign bp_rnkbgbk_1_pa = 1'b0; // TODO: Implement logic
