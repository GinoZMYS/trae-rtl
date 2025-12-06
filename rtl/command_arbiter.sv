//==============================================================================
// Command Arbiter module
// Source: generated from Protocol_Arbiter (21).xlsx
// Generated on: 2025-09-23 09:54:57
// Style: 4-space indent, keep signal names, max line 100 chars
// Note: style-only edits; no changes to logic, timing, or interfaces
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
    input      [RK_NUM*SC_NUM-1:0]    preab_req_preall,
    input      [RK_NUM*SC_NUM-1:0]    preab_req_qos_preall,
    output     [RK_NUM*SC_NUM-1:0]    preab_grant_preall,
    input                              pre_vld,
    input      [DDRC_PA_RK_WIDTH-1:0] prea_cmd_rk,
    input                              prea_cmd_sc,
    input                              func_req,
    input                              func_hqos,
    output                             func_load,
    input                              mrr_zq_high_req,
    input                              mrr_zq_low_req,
    output                             mrr_zq_high_load,
    output                             mrr_zq_low_load,
    input                              soft_req,
    output                             soft_req_grant,
    input                              mask,
    output                             mrr4_h_grant,
    output                             ref_ab_h_grant,
    output                             ref_db_h_grant,
    output                             rfm_ab_h_grant,
    output                             rfm_pb_h_grant,
    output                             pim_h_grant,
    input                              pdx_lp_load_rank,
    input                              cas_off_lp_load_rank,
    input                              mrr4_load_h,
    input                              refab_load_ref_h,
    input                              refdb_load_ref_h,
    input                              rfmab_load_ref_h,
    input                              rfmpb_load_ref_h,
    input                              mrrx_load_h,
    input                              zq_load_h,
    input                              func_type_pre_sb,
    input                              clk_en,
    input    [DDRC_SCRKBGBK_WIDTH*RK_NUM*SC_NUM-1:0] prepb_req_bank_ref,
    input    [RK_NUM*SC_NUM-1:0]       prepb_req_qos_ref,
    input    [RK_NUM*SC_NUM-1:0]       prepb_req_ref,
    input    [RK_NUM*SC_NUM-1:0]       prepb_grant_ref,
    output                             pre_gnt_be,
    output                             pre_gnt_type_be,
    output   [DDRC_SCRKBGBK_WIDTH-1:0] pre_gnt_bank_be
);



//==============================================================================
// Internal declarations (by usage order; wires first, then regs)
// Note: reordering/formatting only; no logic changes
//==============================================================================
// wire
wire act_pre_dfi_vld;
wire [13:0] cmd_req_arb;
wire rd_wr_hqos_req, act_2_hqos_req, func_hqos_req, pre_all_hqos_req, act_1_hqos_req;
wire rd_wr_low_req, act_2_low_req, func_low_req, pre_all_low_req, act_1_low_req;
wire [RK_NUM*SC_NUM-1:0] pre_all_hqos_vec;
wire [RK_NUM*SC_NUM-1:0] pre_all_low_vec;
wire [RK_NUM*SC_NUM-1:0] pre_all_hqos_priority;
wire [RK_NUM*SC_NUM-1:0] pre_all_low_priority;
wire pre_pb_hqos_req;
wire pre_pb_low_req;
wire rd_wr_hqos_load, act_2_hqos_load, func_hqos_load, pre_all_hqos_load,
    pre_pb_hqos_load, pre_pb_low_load, act_1_hqos_load;
wire rd_wr_low_load, act_2_low_load, func_low_load, pre_all_low_load, act_1_low_load;
wire act_pre_load;
wire rdwr_dfi_load;
wire [7:0] rdwr_dfi_hqos;

// reg
reg [13:0] cmd_load_arb;
reg act1_lock;
reg mrr4_h_grant_reg;
reg ref_ab_h_grant_reg;
reg ref_db_h_grant_reg;
reg rfm_ab_h_grant_reg;
reg rfm_pb_h_grant_reg;
reg pim_h_grant_reg;
reg pre_pb_load_reg;
reg pre_gnt_be_reg;
reg [1:0] pre_gnt_type_be_reg;
reg [DDRC_SCRKBGBK_WIDTH-1:0] pre_gnt_bank_be_reg;
reg [DDRC_SCRKBGBK_WIDTH-1:0] pre_gnt_bank_sel;

// Output bindings (interface preserved)
assign mrr4_h_grant = mrr4_h_grant_reg;
assign ref_ab_h_grant = ref_ab_h_grant_reg;
assign ref_db_h_grant = ref_db_h_grant_reg;
assign rfm_ab_h_grant = rfm_ab_h_grant_reg;
assign rfm_pb_h_grant = rfm_pb_h_grant_reg;
assign pim_h_grant = pim_h_grant_reg;
assign pre_gnt_be       = pre_gnt_be_reg;
assign pre_gnt_type_be  = pre_gnt_type_be_reg;
assign pre_gnt_bank_be  = pre_gnt_bank_be_reg;

// Basic assignments (placeholders / original semantics preserved)
assign act_pre_dfi_vld = actpre_pa_cmd_vld;
assign rdwr_dfi_hqos = 8'h00; // placeholder
assign soft_req_grant = 1'b0; // placeholder

// Requests and priority vectors
assign func_hqos_req  = act1_lock ? 1'b0 : (func_req & (func_hqos));
assign rd_wr_hqos_req = act1_lock ? (rdwr_pa_cmd_vld & rdwr_pa_cmd_hqos)
    : (mask ? 1'b0 : rdwr_pa_cmd_vld & rdwr_pa_cmd_hqos);
assign act_2_hqos_req = act1_lock ? ((actpre_pa_cmd_type[1] == 1'b1) & act_pre_dfi_vld & (actpre_pa_cmd_hqos))
    : (mask ? 1'b0 : (actpre_pa_cmd_type[1] == 1'b1) & act_pre_dfi_vld & (actpre_pa_cmd_hqos));
assign pre_all_hqos_req = |pre_all_hqos_vec;
assign pre_pb_hqos_req = act1_lock ? 1'b0
    : (mask ? 1'b0 : (actpre_pa_cmd_type[1] == 1'b0) & act_pre_dfi_vld & (actpre_pa_cmd_hqos));
assign act_1_hqos_req = act1_lock ? 1'b0
    : (mask ? 1'b0 : (actpre_pa_cmd_type[1] == 1'b0) & act_pre_dfi_vld & (actpre_pa_cmd_hqos));
assign func_low_req = act1_lock ? 1'b0 : (func_req & ~(func_hqos));
assign rd_wr_low_req = act1_lock ? (rdwr_pa_cmd_vld & ~rdwr_pa_cmd_hqos)
    : (mask ? 1'b0 : rdwr_pa_cmd_vld & ~rdwr_pa_cmd_hqos);
assign act_2_low_req = act1_lock ? ((actpre_pa_cmd_type[1] == 1'b1) & act_pre_dfi_vld & (!actpre_pa_cmd_hqos))
    : (mask ? 1'b0 : (actpre_pa_cmd_type[1] == 1'b1) & act_pre_dfi_vld & (!actpre_pa_cmd_hqos));
assign pre_all_low_req = |pre_all_low_vec;
assign pre_pb_low_req = act1_lock ? 1'b0
    : (mask ? 1'b0 : (actpre_pa_cmd_type[1] == 1'b0) & act_pre_dfi_vld & (!actpre_pa_cmd_hqos));
assign act_1_low_req = act1_lock ? 1'b0
    : (mask ? 1'b0 : (actpre_pa_cmd_type[1] == 1'b0) & act_pre_dfi_vld & (!actpre_pa_cmd_hqos));

assign pre_all_hqos_priority = pre_all_hqos_vec & (~pre_all_hqos_vec + 1);
assign pre_all_low_priority  = pre_all_low_vec  & (~pre_all_low_vec  + 1);
assign pre_all_hqos_vec = act1_lock ? {RK_NUM*SC_NUM{1'b0}}
    : (mask ? {RK_NUM*SC_NUM{1'b0}} : (preab_req_preall & preab_req_qos_preall));
assign pre_all_low_vec = act1_lock ? {RK_NUM*SC_NUM{1'b0}}
    : (mask ? {RK_NUM*SC_NUM{1'b0}} : (preab_req_preall & ~preab_req_qos_preall));

assign cmd_req_arb = {
    mrr_zq_high_req,
    rd_wr_hqos_req,
    act_2_hqos_req,
    func_hqos_req,
    pre_all_hqos_req,
    act_1_hqos_req,
    pre_pb_hqos_req,
    rd_wr_low_req,
    act_2_low_req,
    func_low_req,
    pre_all_low_req,
    act_1_low_req,
    pre_pb_low_req
};

// Combinational: priority-encode request vector to generate cmd_load_arb
always @(cmd_req_arb) begin : p_cmd_load_arb
    integer i;
    cmd_load_arb = 14'b0;
    for (i = 13; i >= 0; i = i - 1) begin
        if (cmd_req_arb[i] && (cmd_load_arb == 14'b0)) begin
            cmd_load_arb = 14'b1 << i;
        end
    end
end


assign {
    mrr_zq_high_load,
    rd_wr_hqos_load,
    act_2_hqos_load,
    func_hqos_load,
    pre_all_hqos_load,
    act_1_hqos_load,
    pre_pb_hqos_load,
    rd_wr_low_load,
    act_2_low_load,
    func_low_load,
    pre_all_low_load,
    act_1_low_load,
    pre_pb_low_load
} = cmd_load_arb;

assign act_pre_load = (act_2_hqos_load | act_1_hqos_load | act_2_low_load
    | act_1_low_load | pre_pb_hqos_load | pre_pb_low_load);
assign rdwr_dfi_load = (rd_wr_hqos_load | rd_wr_low_load);
assign preab_grant_preall = pre_all_hqos_load ? pre_all_hqos_priority
    : pre_all_low_load ? pre_all_low_priority : {RK_NUM*SC_NUM{1'b0}};
assign func_load = act1_lock ? 1'b0 : |{mrr_zq_high_load, func_hqos_load, func_low_load};

always @* begin
    integer k;
    pre_gnt_bank_sel = {DDRC_SCRKBGBK_WIDTH{1'b0}};
    for (k = 0; k < RK_NUM*SC_NUM; k = k + 1) begin
        if (prepb_grant_ref[k]) begin
            pre_gnt_bank_sel = prepb_req_bank_ref[k*DDRC_SCRKBGBK_WIDTH +: DDRC_SCRKBGBK_WIDTH];
        end
    end
end

// [PB-grant policy]
// - Low QoS PB grant only when low PB request is active
// (reverted) remove HQoS falling-edge PB grant overlay logic

// Removed redundant/commented logic snippets (no functional impact)


// Sequential: mrr4_h_grant_reg update
always @(posedge ddrc_clk or negedge ddrc_rst_n) begin
    if(~ddrc_rst_n) begin
        mrr4_h_grant_reg <= 1'b0;
    end
    else if( (pim_h_grant_reg | ref_ab_h_grant_reg | ref_db_h_grant_reg | rfm_ab_h_grant_reg | rfm_pb_h_grant_reg) & clk_en) begin
        mrr4_h_grant_reg <= 1'b0;
    end
    else if( func_load & mrr4_load_h) begin
        mrr4_h_grant_reg <= func_load;
    end
    else begin
        mrr4_h_grant_reg <= mrr4_h_grant_reg;
    end
end


// Sequential: ref_ab_h_grant_reg update
always @(posedge ddrc_clk or negedge ddrc_rst_n) begin
    if(~ddrc_rst_n) begin
        ref_ab_h_grant_reg <= 1'b0;
    end
    else if( (pim_h_grant_reg | mrr4_h_grant_reg | ref_db_h_grant_reg | rfm_ab_h_grant_reg | rfm_pb_h_grant_reg) & clk_en) begin
        ref_ab_h_grant_reg <= 1'b0;
    end
    else if( func_load & refab_load_ref_h) begin
        ref_ab_h_grant_reg <= func_load;
    end
    else begin
        ref_ab_h_grant_reg <= ref_ab_h_grant_reg;
    end
end


// Sequential: ref_db_h_grant_reg update
always @(posedge ddrc_clk or negedge ddrc_rst_n) begin
    if(~ddrc_rst_n) begin
        ref_db_h_grant_reg <= 1'b0;
    end
    else if( (pim_h_grant_reg | mrr4_h_grant_reg | ref_ab_h_grant_reg | rfm_ab_h_grant_reg | rfm_pb_h_grant_reg) & clk_en) begin
        ref_db_h_grant_reg <= 1'b0;
    end
    else if( func_load & refdb_load_ref_h) begin
        ref_db_h_grant_reg <= func_load;
    end
    else begin
        ref_db_h_grant_reg <= ref_db_h_grant_reg;
    end
end


// Sequential: rfm_ab_h_grant_reg update
always @(posedge ddrc_clk or negedge ddrc_rst_n) begin
    if(~ddrc_rst_n) begin
        rfm_ab_h_grant_reg <= 1'b0;
    end
    else if( (pim_h_grant_reg | mrr4_h_grant_reg | ref_ab_h_grant_reg | ref_db_h_grant_reg | rfm_pb_h_grant_reg) & clk_en) begin
        rfm_ab_h_grant_reg <= 1'b0;
    end
    else if( func_load & rfmab_load_ref_h) begin
        rfm_ab_h_grant_reg <= func_load;
    end
    else begin
        rfm_ab_h_grant_reg <= rfm_ab_h_grant_reg;
    end
end


always @(posedge ddrc_clk or negedge ddrc_rst_n) begin
    if(~ddrc_rst_n) begin
        rfm_pb_h_grant_reg <= 1'b0;
    end
    else if( (pim_h_grant_reg | mrr4_h_grant_reg | ref_ab_h_grant_reg | ref_db_h_grant_reg | rfm_ab_h_grant_reg) & clk_en) begin
        rfm_pb_h_grant_reg <= 1'b0;
    end
    else if( func_load & rfmpb_load_ref_h ) begin
        rfm_pb_h_grant_reg <= func_load;
    end
    else begin
        rfm_pb_h_grant_reg <= rfm_pb_h_grant_reg;
    end
end

// Sequential: pim_h_grant_reg update
always @(posedge ddrc_clk or negedge ddrc_rst_n) begin
    if(~ddrc_rst_n) begin
        pim_h_grant_reg <= 1'b0;
    end
    else if( (mrr4_h_grant_reg | ref_ab_h_grant_reg | ref_db_h_grant_reg | rfm_ab_h_grant_reg | rfm_pb_h_grant_reg) & clk_en) begin
        pim_h_grant_reg <= 1'b0;
    end
    else if( func_hqos_load & (mrrx_load_h | zq_load_h) ) begin
        pim_h_grant_reg <= func_hqos_load;
    end
    else begin
        pim_h_grant_reg <= pim_h_grant_reg;
    end
end

// Sequential: pre_pb_load_reg update (latch precharge-priority request)
always @(posedge ddrc_clk or negedge ddrc_rst_n) begin
    if (~ddrc_rst_n) begin
        pre_pb_load_reg <= 1'b0;
    end
    else if (clk_en) begin
        pre_pb_load_reg <= (pre_pb_hqos_req | pre_pb_low_req);
    end
end


// Sequential: precharge grant registers update
always @(posedge ddrc_clk or negedge ddrc_rst_n) begin
    if (~ddrc_rst_n) begin
        pre_gnt_be_reg <= 1'b0;
        pre_gnt_type_be_reg <= 2'b0;
        pre_gnt_bank_be_reg <= 7'b0;
    end
    else if (pre_vld & clk_en) begin
        pre_gnt_be_reg      <= 1'b1;
        pre_gnt_type_be_reg <= 2'b01;
        pre_gnt_bank_be_reg <= {
            prea_cmd_rk[DDRC_PA_RK_WIDTH-1:0],
            prea_cmd_sc,
            {DDRC_PA_BK_WIDTH{1'b0}},
            {DDRC_PA_BG_WIDTH{1'b0}}
        };
    end
    else if ((|prepb_grant_ref) & clk_en) begin
        pre_gnt_be_reg <= 1'b1;
        pre_gnt_type_be_reg <= 2'b00;
        pre_gnt_bank_be_reg <= pre_gnt_bank_sel;
    end
    else begin
        pre_gnt_be_reg <= 1'b0;
        pre_gnt_type_be_reg <= 2'b00;
        pre_gnt_bank_be_reg <= 7'b0;
    end
end


// Output ready signals
assign actpre_pa_cmd_rdy = act_pre_load;
assign rdwr_pa_cmd_rdy = rdwr_dfi_load;


// Lock command arbiter when ACT_1 is granted; release on ACT_2 grant
always @(posedge ddrc_clk or negedge ddrc_rst_n) begin
    if (~ddrc_rst_n) begin
        act1_lock <= 1'b0;
    end else begin
        if (act1_lock) begin
            if (act_2_hqos_load | act_2_low_load) begin
                act1_lock <= 1'b0;
            end else begin
                act1_lock <= 1'b1;
            end
        end else begin
            if ( (actpre_pa_cmd_type[1:0] == 2'b00) & (act_1_hqos_load | act_1_low_load)) begin
                act1_lock <= 1'b1;
            end else begin
                act1_lock <= 1'b0;
            end
        end
    end
end
//==============================================================================

endmodule

//==============================================================================
// End of Module
//==============================================================================