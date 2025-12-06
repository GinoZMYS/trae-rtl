//==============================================================================
// Pre_All Module
// Generated from Protocol_Arbiter (9).xlsx
// Auto-generated on 2025-08-11 17:43:58
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
    parameter DDRC_PA_PHASE_WIDTH = 2
    )(
    input  core_clk,
    input  core_rstn,
    output pre_gnt_be,
    output pre_gnt_type_be,
    output [DDRC_SCRKBK_WIDTH-1:0]   pre_gnt_bank_be,
    input  [RK_NUM*SC_NUM-1:0]       pre_all_intent_ref,
    input  [RK_NUM*SC_NUM-1:0]       pre_all_intent_qos_ref,
    output [RK_NUM*SC_NUM-1:0]       pre_all_intent_grant_ref,
    input  [RK_NUM*SC_NUM-1:0]       prepb_req_ref,
    input  [RK_NUM*SC_NUM-1:0]       prepb_req_qos_ref,
    output [RK_NUM*SC_NUM-1:0]       prepb_grant_ref,
    input  [RK_NUM*SC_NUM-1:0]       pre_ab_all_req_intent_pim,
    input  [RK_NUM*SC_NUM-1:0]       pre_ab_all_req_intent_urgent_qos_pim,
    input  [3*RK_NUM*SC_NUM-1:0]     pre_ab_all_req_type_pim,
    output [RK_NUM*SC_NUM-1:0]       pre_ab_all_ack_grant_pim,
    input  [RK_NUM-1:0]              pre_ab_all_req_intent_lp,
    input  [RK_NUM-1:0]              pre_ab_all_req_intent_qos_lp,
    output [3*RK_NUM*SC_NUM-1:0]     pre_ab_all_grant_lp,
    output [RK_NUM-1:0]              pa_pre_all_grant,
    output [RK_NUM-1:0]              pa_pre_pb_grant,
    output [2**RK_NUM-1:0]           pre_vld,
    output [2*2**RK_NUM-1:0]         pre_ph,
    output [2**RK_NUM-1:0]           pre_addr,
    output [2*2**RK_NUM-1:0]         pre_type,
    input  [2**RK_NUM-1:0]           pre_ab_allow,
    input  [2*2**RK_NUM-1:0]         pre_ab_allow_ph,
    input  [2**RK_NUM-1:0]           spre_ab_allow,
    input  [2*2**RK_NUM-1:0]         spre_ab_allow_ph,
    output pa_cmd_vld,
    output [DDRC_PA_CMD_WIDTH-1:0]   pa_dfi_cmd_type,
    output [RK_NUM-1:0]              pa_dfi_cmd_rank,
    output [DDRC_PA_PHASE_WIDTH-1:0] pa_dfi_cmd_phase,
    output pa_dfi_cmd_sc,
    output [RK_NUM*SC_NUM-1:0]       preab_req_preall,
    output [RK_NUM*SC_NUM-1:0]       preab_req_qos_preall,
    input  [RK_NUM*SC_NUM-1:0]       preab_grant_preall
    );


//==============================================================================
// Internal Logic

// Grant signals
    assign prepb_grant_ref = 1'b0; // TODO: Implement logic
// Command signals
    localparam DDRC_PA_DDRC_PA_RKBKBG_WIDTH = DDRC_PA_RK_WIDTH + DDRC_PA_BG_WIDTH + DDRC_PA_BK_WIDTH;
    localparam DDRC_PA_RDWR_INFO_WIDTH = DDRC_PA_RD_INFO_WIDTH + DDRC_PA_WR_INFO_WIDTH;

// Other signals

endmodule

//==============================================================================
    assign pre_all_intent_grant_ref = 1'b0;// TODO : Implement logic
    assign prepb_grant_ref = 1'b0;// TODO : Implement logic
    assign pre_ab_all_ack_grant_pim = 1'b0;// TODO : Implement logic
    assign pre_ab_all_grant_lp = 1'b0;// TODO : Implement logic
    assign pa_pre_all_grant = 1'b0;// TODO : Implement logic
    assign pa_pre_pb_grant = 1'b0;// TODO : Implement logic

//==============================================================================
    assign pa_cmd_vld = 1'b0;// TODO : Implement logic
    assign pa_dfi_cmd_type = 1'b0;// TODO : Implement logic
    assign pa_dfi_cmd_rank = 1'b0;// TODO : Implement logic
    assign pa_dfi_cmd_phase = 1'b0;// TODO : Implement logic
    assign pa_dfi_cmd_sc = 1'b0;// TODO : Implement logic

// Request signals
    assign preab_req_preall = 1'b0;// TODO : Implement logic
    assign preab_req_qos_preall = 1'b0;// TODO : Implement logic

    assign pre_gnt_be = 1'b0;// TODO : Implement logic
    assign pre_gnt_type_be = 1'b0;// TODO : Implement logic
    assign pre_gnt_bank_be = 1'b0;// TODO : Implement logic
    assign pre_vld = 1'b0;// TODO : Implement logic
    assign pre_ph = 1'b0;// TODO : Implement logic
    assign pre_addr = 1'b0;// TODO : Implement logic
    assign pre_type = 1'b0;// TODO : Implement logic
