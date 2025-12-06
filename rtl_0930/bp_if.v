// BP_If Module
// Generated from Protocol_Arbiter (23).xlsx
// Auto-generated on 2025-01-25 10:00:00
module bp_if #(
parameter DDRC_PA_RK_WIDTH = 2,
parameter DDRC_PA_ROW_WIDTH = 16,
parameter DDRC_PA_BG_WIDTH = 2,
parameter DDRC_PA_BK_WIDTH = 2
parameter DDRC_PA_SC_WIDTH = 1,
parameter DDRC_PA_QOS_WIDTH = 4,
parameter DDRC_PA_RD_INFO_WIDTH = 16,
parameter DDRC_PA_WR_INFO_WIDTH = 16,
parameter DDRC_PA_BQ_NUM = 4,
parameter DDRC_PA_CMD_WIDTH = 5
parameter DDRC_PA_PHASE_WIDTH = 2,
parameter DDRC_RK_WIDTH = 2,
parameter DDRC_BGBK_WIDTH = 4,
parameter DDRC_SCRK_WIDTH = 8,
// Local Parameters
localparam RK_NUM = 2**DDRC_PA_RK_WIDTH,
localparam SC_NUM = 2**DDRC_PA_SC_WIDTH,
localparam DDRC_SCRKBK_WIDTH = DDRC_PA_SC_WIDTH+DDRC_PA_BK_WIDTH+DDRC_PA_BG_WIDTH+DDRC_PA_RK_WIDTH,
localparam DDRC_SCRKBGBK_WIDTH = DDRC_PA_SC_WIDTH+DDRO_PA_BK_WIDTH+DDRC_PA_BG_WIDTH+DDRC_PA_RK_WIDTH,
localparam DDRC_PA_DDRC_PA_RKBKBG_WIDTH = DDRC_PA_RK_WIDTH + DDRC_PA_BG_WIDTH + DDRC_PA_BK_WIDTH,
localparam DDRC_PA_RDWR_INFO_WIDTH = DDRC_PA_RD_INFO_WIDTH + DDRC_PA_WR_INFO_WIDTH
)(
// Clock and Reset
input ddrc_clk,
input ddrc_rst_n,
// BP Request Signals
input [RK_NUM*SC_NUM-1:0] bp_req_ref,
input [RK_NUM*SC_NUM-1:0] bq_type_ref,
input [DDRC_BGBK_WIDTH*RK_NUM*SC_NUM-1:0] bp_bgbk_0_ref,
input [DDRC_BGBK_WIDTH*RK_NUM*SC_NUM-1:0] bp_bgbk_1_ref,
// BP PIM Signals
input [RK_NUM-1:0] bp_req_pim,
// BP LP Signals
input [2**DDRC_RK_WIDTH-1:0] bp_req_lp,
// BP FE Output Signals
output [RK_NUM*SC_NUM-1:0] bp_req_fe,
output [RK_NUM*SC_NUM-1:0] bp_type_fe,
// BP Rank BG BK Output Signals
output [DDRC_BGBK_WIDTH*RK_NUM SC_NUM-1:0] bp_rnkbgbk_0_ref,
output [DDRC_BGBK_WIDTH*RK_NUM SC_NUM-1:0] bp_rnkbgbk_1_ref,
);
//==============================================================================
// Internal Logic

// BP FE Output Signals
assign bp_req_fe = {RK_NUM*SC_NUM{1'b0}};
assign bp_type_fe = {RK_NUM*SC_NUM{1'b0}};
// BP Rank BG BK Output Signals
assign bp_rnkbgbk_0_ref = {DDRC_BGBK_WIDTH*RK_NUM*SC_NUM{1'b0}};
assign bp_rnkbgbk_1_ref = {DDRC_BGBK_WIDTH*RK_NUM*SC_NUM{1'b0}};  
//==============================================================================


endmodule

//==============================================================================
// End of Module
//==============================================================================
