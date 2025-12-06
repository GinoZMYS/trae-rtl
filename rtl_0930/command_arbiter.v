//==============================================================================
// Command_Arbiter Module
// Generated from Protocol_Arbiter (21).xlsx
// Auto-generated on 2025-09-23 09:54:57
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
    parameter DDRC_PA_PHASE_WIDTH = 2
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
    input                              preab_req_preall,
    input                              preab_req_qos_preall,
    output                             preab_grant_preall,
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
    output                             pre_gnt_be,
    output                             pre_gnt_type_be,
    output   [DDRC_SCRKBGBK_WIDTH-1:0] pre_gnt_bank_be
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
// Wire declarations
wire [11:0] cmd_req_arb;
reg [11:0] cmd_load_arb;
wire rd_wr_hqos_req, act_2_hqos_req, func_hqos_req, pre_all_hqos_req, act_1_hqos_req;
wire rd_wr_low_req, act_2_low_req, func_low_req, pre_all_low_req, act_1_low_req;
wire rd_wr_hqos_load, act_2_hqos_load, func_hqos_load, pre_all_hqos_load, act_1_hqos_load;
wire rd_wr_low_load, act_2_low_load, func_low_load, pre_all_low_load, act_1_low_load;
wire act_pre_dfi_vld;

// Grant signals as reg for always block assignments
reg mrr4_h_grant_reg;
reg ref_ab_h_grant_reg;
reg ref_db_h_grant_reg;
reg rfm_ab_h_grant_reg;
reg rfm_pb_h_grant_reg;
reg pim_h_grant_reg;
reg lp_req_grant;

// Pre-charge grant signals as reg
reg pre_gnt_be_reg;
reg [1:0] pre_gnt_type_be_reg;
reg [20:0] pre_gnt_bank_be_reg;

// Assign outputs
assign mrr4_h_grant = mrr4_h_grant_reg;
assign ref_ab_h_grant = ref_ab_h_grant_reg;
assign ref_db_h_grant = ref_db_h_grant_reg;
assign rfm_ab_h_grant = rfm_ab_h_grant_reg;
assign rfm_pb_h_grant = rfm_pb_h_grant_reg;
assign pim_h_grant = pim_h_grant_reg;
assign pre_gnt_be = pre_gnt_be_reg;
assign pre_gnt_type_be = pre_gnt_type_be_reg;
assign pre_gnt_bank_be = pre_gnt_bank_be_reg;
wire rdwr_dfi_vld;
wire [7:0] rdwr_dfi_hqos;

// Simple signal assignments
assign act_pre_dfi_vld = actpre_pa_cmd_vld;
assign rdwr_dfi_vld = 1'b1; // Placeholder
assign rdwr_dfi_hqos = 8'h00; // Placeholder
// Duplicate signal declarations removed

assign func_hqos_req  =   func_req & (func_hqos); 
assign rd_wr_hqos_req =   mask ? 1'b0 : rdwr_dfi_vld & (|rdwr_dfi_hqos);   
assign act_2_hqos_req =   mask ? 1'b0 : (actpre_pa_cmd_type == 2'b01) & act_pre_dfi_vld & (actpre_pa_cmd_hqos); 
assign pre_all_hqos_req = mask ? 1'b0 : preab_req_preall & (preab_req_qos_preall); 
assign act_1_hqos_req =   mask ? 1'b0 : (actpre_pa_cmd_type == 2'b00) & act_pre_dfi_vld & (actpre_pa_cmd_hqos); 
assign rd_wr_low_req =    mask ? 1'b0 : rdwr_dfi_vld & ~(rdwr_dfi_hqos); 
assign act_2_low_req =    mask ? 1'b0 : (actpre_pa_cmd_type == 2'b10) & act_pre_dfi_vld & (actpre_pa_cmd_hqos); 
assign func_low_req =     func_req & ~(func_hqos); 
assign pre_all_low_req =  mask ? 1'b0 : preab_req_preall & ~(preab_req_qos_preall); 
assign act_1_low_req =    mask ? 1'b0 : (actpre_pa_cmd_type == 2'b11) & act_pre_dfi_vld & (actpre_pa_cmd_hqos); 

assign cmd_req_arb = {mrr_zq_high_req, rd_wr_hqos_req, act_2_hqos_req, func_hqos_req, pre_all_hqos_req, act_1_hqos_req, rd_wr_low_req, act_2_low_req, func_low_req, pre_all_low_req, act_1_low_req}; 

always@(cmd_req_arb) begin:p_cmd_load_arb   
    integer i; 
    cmd_load_arb = 12'b0; 
    for(i=11; i>=0; i=i-1) begin 
        if(cmd_req_arb[i])begin 
            cmd_load_arb = 12'b1 << i; 
        end
    end 
end 

assign {mrr_zq_high_load, rd_wr_hqos_load, act_2_hqos_load, func_hqos_load, pre_all_hqos_load, act_1_hqos_load, rd_wr_low_load, act_2_low_load, func_low_load, pre_all_low_load, act_1_low_load} = cmd_load_arb; 

assign act_pre_load       = (act_2_hqos_load | act_1_hqos_load | act_2_low_load | act_1_low_load); 
assign rdwr_dfi_load      = (rd_wr_hqos_load | rd_wr_low_load); 
assign preab_grant_preall = (pre_all_hqos_load | pre_all_low_load); 
assign func_load          = (|mrr_zq_high_load | |func_hqos_load | |func_low_load); 

always @(posedge ddrc_clk or negedge ddrc_rst_n) begin
    if(~ddrc_rst_n) begin
        lp_req_grant <= 1'b0;
    end
    else if( (pim_h_grant | mrr4_h_grant | ref_ab_h_grant | ref_db_h_grant | rfm_ab_h_grant | rfm_pb_h_grant) & clk_en) begin
        lp_req_grant <= 1'b0;
    end
    else if( func_load & (pdx_lp_load_rank | cas_off_lp_load_rank) ) begin
        lp_req_grant <= func_load;
    end
    else begin
        lp_req_grant <= lp_req_grant;
    end
end

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

always@(posedge ddrc_clk or negedge ddrc_rst_n) begin
    if(~ddrc_rst_n) begin
        pre_gnt_be_reg <= 1'b0;
        pre_gnt_type_be_reg <= 2'b0;
        pre_gnt_bank_be_reg <= 21'b0;
    end
    else if((|preab_grant_preall & func_load & func_type_pre_sb) & clk_en) begin
        pre_gnt_be_reg <= 1'b1;
        pre_gnt_type_be_reg <= 2'b01;
        pre_gnt_bank_be_reg <= 21'b0;
    end
    else if((func_load & func_type_pre_sb) & clk_en) begin
        pre_gnt_be_reg <= 1'b1;
        pre_gnt_type_be_reg <= 2'b00;
        pre_gnt_bank_be_reg <= prepb_req_bank_ref;
    end
    else begin
        pre_gnt_be_reg <= 1'b0;
        pre_gnt_type_be_reg <= 2'b00;
        pre_gnt_bank_be_reg <= 21'b0;
    end
end
//==============================================================================

endmodule

//==============================================================================
// End of Module
//==============================================================================
