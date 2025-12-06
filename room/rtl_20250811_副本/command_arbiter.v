//==============================================================================
// Command_Arbiter Module
// Generated from Protocol_Arbiter (10).xlsx
// Auto-generated on 2025-08-11 23:22:31
//==============================================================================

module command_arbiter #(
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
    parameter RK_NUM = 4,
    parameter SC_NUM = 2
)(
    input                               act_pre_dfi_vld,
    output                              act_pre_load,
    input                               act_pre_type,
    input    [DDRC_PA_QOS_WIDTH-1:0] [RK_NUM*SC_NUM-1:0] act_pre_qos,
    input                               rdwr_dfi_vld,
    output                              rdwr_dfi_load,
    input                               rdwr_dfi_type,
    input    [DDRC_PA_QOS_WIDTH-1:0] [RK_NUM*SC_NUM-1:0] rdwr_dfi_hqos,
    input    [RK_NUM*SC_NUM-1:0]       preab_req_preall,
    input    [RK_NUM*SC_NUM-1:0]       preab_req_qos_preall,
    output   [RK_NUM*SC_NUM-1:0]       preab_grant_preall,
    input    [RK_NUM*SC_NUM-1:0]       func_req,
    output   [RK_NUM*SC_NUM-1:0]       func_load,
    output   [RK_NUM-1:0]              pa_act2_grant,
    input                               soft_req
);


//==============================================================================
// Internal Signals
//==============================================================================
wire rd_wr_load;
wire act2_req_vld;
wire mrr_zq_pre_req;

//==============================================================================
// Internal Logic
//==============================================================================

// Grant signals
assign pa_act2_grant = 2'b0; // TODO: Implement logic

// Request signals
assign mrr_zq_pre_req = 1'b0; // TODO: Implement logic
assign act2_req_vld = (act_pre_type == 2'b01) & act_pre_dfi_vld;
assign rdwr_dfi_load = mrr_zq_pre_req ? 1'b0 : rdwr_dfi_vld;
assign func_load = (rdwr_dfi_load | (act2_req_vld)) ? 8'b0 : func_req;
assign act_pre_load = rdwr_dfi_load ? 1'b0 : act2_req_vld ? act_pre_dfi_vld : (func_req | (|preab_req_preall)) ? 1'b0 : !mrr_zq_pre_req & act_pre_dfi_vld;
assign preab_grant_preall = (mrr_zq_pre_req | func_req | rdwr_dfi_load | act2_req_vld) ? 8'b0 : preab_req_preall;

endmodule

//==============================================================================
// End of Module
//==============================================================================
