//==============================================================================
// PRE ALL module
// Source: generated from Protocol_Arbiter (23).xlsx
// Generated on: 2025-01-25 10:00:00
// Style: 4-space indent, lower_snake_case signals, max line 100 chars
// Note: style-only edits; no changes to logic, timing, or interfaces
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
    parameter DDRC_RK_WIDTH = 2,
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
    // Clock and Reset
    input                              ddrc_clk,
    input                              ddrc_rst_n,
    
    // Pre_All Intent Signals
    input    [RK_NUM*SC_NUM-1:0]       pre_all_intent_ref,
    input    [RK_NUM*SC_NUM-1:0]       pre_all_intent_qos_ref,
    output   [RK_NUM*SC_NUM-1:0]       pre_all_intent_grant_ref,
    
    // Prepb Signals (removed - no longer needed as ports)
    input    [RK_NUM*SC_NUM-1:0]        prepb_req_ref,
    input    [RK_NUM*SC_NUM-1:0]        prepb_req_qos_ref,
//    output   [RK_NUM*SC_NUM-1:0]       prepb_grant_ref,
 
    // Bank Close Info Signal
    input    [RK_NUM*SC_NUM-1:0]       bank_close_info,
    
    // Pre_All PIM Signals
    input    [RK_NUM*SC_NUM-1:0]       pre_all_req_pim,
    input   [RK_NUM*SC_NUM-1:0]       pre_all_req_urgent_pim,
    input    [3*RK_NUM*SC_NUM-1:0]     pre_all_req_type_pim,
    output    [RK_NUM*SC_NUM-1:0]       pre_all_grant_pim,
    
    // Pre_All LP Signals
    input    [2*2**DDRC_RK_WIDTH-1:0]  pre_all_intent_lp,
    input    [2*2**DDRC_RK_WIDTH-1:0]  pre_all_intent_qos_lp,
    output   [2*2**DDRC_RK_WIDTH-1:0]  pre_all_grant_lp,

    // Pre_All LP Signals
    input    [RK_NUM*SC_NUM-1:0]        soft_pre_all_req,
    input    [RK_NUM*SC_NUM-1:0]        soft_pre_all_qos,
    output   [RK_NUM*SC_NUM-1:0]        soft_pre_all_grant,

    // Flush Signals
    output   [RK_NUM*SC_NUM-1:0]       flush_req,
    input                              flush_done,
    
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
    
//    // Soft Pre All Signals
//    input    [RK_NUM*SC_NUM-1:0]       soft_pre_all_req,
//    input    [RK_NUM*SC_NUM-1:0]       soft_pre_all_qos,
//    output   [RK_NUM*SC_NUM-1:0]       soft_pre_all_grant,
//    input    [RK_NUM*SC_NUM-1:0]       soft_bp_all_req,
    
    // Preab Signals
    output   [RK_NUM*SC_NUM-1:0]       preab_req_preall,
    output   [RK_NUM*SC_NUM-1:0]       preab_req_qos_preall,
    input    [RK_NUM*SC_NUM-1:0]       preab_grant_preall
);

//==============================================================================
// Internal declarations (by usage order; wires first, then regs)
//==============================================================================
// wire
wire [RK_NUM*SC_NUM-1:0] pre_all_intent_lp_sc;
wire [RK_NUM*SC_NUM-1:0] pre_all_intent_qos_lp_sc;
wire [RK_NUM*SC_NUM-1:0] intent_all;
wire [RK_NUM*SC_NUM-1:0] intent_qos;
wire any_intent_all_hqos;
wire any_intent_all_lqos;
wire all_bank_close;

// reg
reg [3*RK_NUM*SC_NUM-1:0] pa_state_vec;
reg [3*RK_NUM*SC_NUM-1:0] pa_state_nxt_vec;
reg [RK_NUM*SC_NUM-1:0] flush_req_r;
reg [RK_NUM*SC_NUM-1:0] preab_req_preall_r;
reg [RK_NUM*SC_NUM-1:0] preab_req_qos_preall_r;
reg [RK_NUM*SC_NUM-1:0] intent_sync_vec;
reg [RK_NUM*SC_NUM-1:0] intent_sync_ref_vec;
reg [RK_NUM*SC_NUM-1:0] intent_sync_pim_vec;
reg [RK_NUM*SC_NUM-1:0] intent_sync_lp_vec;
reg [RK_NUM*SC_NUM-1:0] intent_sync_soft_vec;
reg [RK_NUM*SC_NUM-1:0] intent_sync_prev_vec;
reg [RK_NUM-1:0]        pa_pre_all_grant_r;
reg                     pa_cmd_vld_r;
reg [DDRC_PA_CMD_WIDTH-1:0]   pa_dfi_cmd_type_r;
reg [2**DDRC_RK_WIDTH-1:0]    pa_dfi_cmd_rank_r;
reg [DDRC_PA_PHASE_WIDTH-1:0] pa_dfi_cmd_phase_r;
reg                           pa_dfi_cmd_sc_r;
// Combinational command fields
reg [2**DDRC_RK_WIDTH-1:0]    pa_dfi_cmd_rank_c;
reg [DDRC_PA_PHASE_WIDTH-1:0] pa_dfi_cmd_phase_c;
reg                           pa_dfi_cmd_sc_c;
reg                           sc_sel;
reg [RK_NUM*SC_NUM-1:0]       req_seen_ref_vec, req_seen_pim_vec;
reg [RK_NUM*SC_NUM-1:0]       req_seen_lp_vec;

//==============================================================================
// Internal Logic
assign soft_pre_all_grant = 4'b0;
// State encoding (per (rank,sc))
localparam logic [2:0] S_IDLE = 3'd0;
localparam logic [2:0] S_FLUSH_CMD_AB = 3'd1;
localparam logic [2:0] S_TIMER_AB_PROCESS = 3'd2;

// Intent decoding
// Expand rank-level LP intent into (rank,sc) vector (declared above)
genvar rk;
generate
    for (rk = 0; rk < RK_NUM; rk = rk + 1) begin : g_lp_expand
        assign pre_all_intent_lp_sc[rk*SC_NUM +: SC_NUM] = pre_all_intent_lp[rk*SC_NUM +: SC_NUM];
        assign pre_all_intent_qos_lp_sc[rk*SC_NUM +: SC_NUM] = pre_all_intent_qos_lp[rk*SC_NUM +: SC_NUM];
    end
endgenerate
assign intent_all = pre_all_intent_ref | pre_all_req_pim | pre_all_intent_lp_sc
    | soft_pre_all_req;
assign intent_qos = pre_all_intent_qos_ref | pre_all_req_urgent_pim
    | pre_all_intent_qos_lp_sc
    | soft_pre_all_qos;
assign any_intent_all_hqos = |(intent_all & intent_qos);
assign any_intent_all_lqos = |(intent_all & ~intent_qos);

// Bank close condition
assign all_bank_close = &bank_close_info;

// Rank reduction helper for mapping SC-wide intent to per-rank mask
function automatic [RK_NUM-1:0] reduce_rank_mask(input [RK_NUM*SC_NUM-1:0] v);
    integer r;
    reg [RK_NUM-1:0] mask;
    begin
        mask = {RK_NUM{1'b0}};
        for (r = 0; r < RK_NUM; r = r + 1) begin
            mask[r] = |v[r*SC_NUM +: SC_NUM];
        end
        reduce_rank_mask = mask;
    end
endfunction

// New: build per-rank mask for a specific sub-channel (sc)
function automatic [RK_NUM-1:0] reduce_rank_mask_by_sc(
    input [RK_NUM*SC_NUM-1:0] v,
    input logic sc_sel
);
    integer r;
    reg [RK_NUM-1:0] mask;
    begin
        mask = {RK_NUM{1'b0}};
        for (r = 0; r < RK_NUM; r = r + 1) begin
            mask[r] = v[r*SC_NUM + sc_sel];
        end
        reduce_rank_mask_by_sc = mask;
    end
endfunction

// New: detect whether any bit is set for a specific sub-channel (sc)
function automatic logic any_sc_bits(
    input [RK_NUM*SC_NUM-1:0] v,
    input logic sc_sel
);
    integer r;
    logic agg;
    begin
        agg = 1'b0;
        for (r = 0; r < RK_NUM; r = r + 1) begin
            agg = agg | v[r*SC_NUM + sc_sel];
        end
        any_sc_bits = agg;
    end
endfunction

// Sticky request-seen registers for gating grants (now consolidated in declarations)
// Pick one-hot rank (lowest index) from a rank mask
function automatic [2**DDRC_RK_WIDTH-1:0] pick_onehot_rank(input [2**DDRC_RK_WIDTH-1:0] v);
    integer i;
    reg [2**DDRC_RK_WIDTH-1:0] oh;
    begin
        oh = {2**DDRC_RK_WIDTH{1'b0}};
        for (i = 0; i < 2**DDRC_RK_WIDTH; i = i + 1) begin
            if (!(|oh) && v[i]) begin
                oh[i] = 1'b1;
            end
        end
        pick_onehot_rank = oh;
    end
endfunction

// New: onehot rank mask from index
function automatic [2**DDRC_RK_WIDTH-1:0] onehot_rank_mask_int(input integer rk_idx);
    integer i;
    reg [2**DDRC_RK_WIDTH-1:0] oh;
    begin
        oh = {2**DDRC_RK_WIDTH{1'b0}};
        for (i = 0; i < 2**DDRC_RK_WIDTH; i = i + 1) begin
            if (i == rk_idx) oh[i] = 1'b1;
        end
        onehot_rank_mask_int = oh;
    end
endfunction

// New: convert onehot rank to binary encoded rank index
function automatic [DDRC_RK_WIDTH-1:0] onehot_rank_to_bin(
    input [2**DDRC_RK_WIDTH-1:0] v
);
    integer i;
    reg [DDRC_RK_WIDTH-1:0] idx;
    begin
        idx = {DDRC_RK_WIDTH{1'b0}};
        for (i = 0; i < 2**DDRC_RK_WIDTH; i = i + 1) begin
            if (v[i]) idx = i[DDRC_RK_WIDTH-1:0];
        end
        onehot_rank_to_bin = idx;
    end
endfunction

// Expand rank+sc onehot into a (rank,sc) mask
function automatic [RK_NUM*SC_NUM-1:0] expand_rank_sc_mask(
    input [2**DDRC_RK_WIDTH-1:0] rank_onehot,
    input logic sc_sel
);
    integer r;
    reg [RK_NUM*SC_NUM-1:0] mask;
    begin
        mask = {RK_NUM*SC_NUM{1'b0}};
        for (r = 0; r < RK_NUM; r = r + 1) begin
            if (rank_onehot[r]) begin
                mask[r*SC_NUM + sc_sel] = 1'b1;
            end
        end
        expand_rank_sc_mask = mask;
    end
endfunction

// Pre_All Intent/PIM/LP Grants: fire on command issue or acknowledge when all banks closed
reg  [RK_NUM*SC_NUM-1:0] grant_ref_mask_c;
always @* begin
    integer jr;
    for (jr = 0; jr < RK_NUM*SC_NUM; jr = jr + 1) begin
        grant_ref_mask_c[jr] = bank_close_info[jr]
                               && (pa_state_vec[jr*3 +: 3] == S_TIMER_AB_PROCESS) // FIXME There is a possibility to increase grant speed when all bank close info are all 1 for identical rank, to make sure it will not introduce the complexity and avoiding the competiiveness, keep the intent to be able to grant the req when the state machine is on processing state.

                               && intent_sync_ref_vec[jr];
    end
end
assign pre_all_intent_grant_ref = ((pa_cmd_vld ? expand_rank_sc_mask(pick_onehot_rank(pa_dfi_cmd_rank_r), pa_dfi_cmd_sc_r)
                                             : {RK_NUM*SC_NUM{1'b0}})
                                  | grant_ref_mask_c)
                                 & req_seen_ref_vec
                                 & pre_all_intent_ref;
wire [RK_NUM*SC_NUM-1:0] sel_rank_sc_mask;
assign sel_rank_sc_mask = expand_rank_sc_mask(pick_onehot_rank(pa_dfi_cmd_rank_r), pa_dfi_cmd_sc_r);
reg  [RK_NUM*SC_NUM-1:0] grant_pim_mask_c;
always @* begin
    integer j;
    for (j = 0; j < RK_NUM*SC_NUM; j = j + 1) begin
        grant_pim_mask_c[j] = bank_close_info[j]
                              && (pa_state_vec[j*3 +: 3] == S_TIMER_AB_PROCESS)
                              && intent_sync_pim_vec[j];
    end
end
assign pre_all_grant_pim = ((pa_cmd_vld ? sel_rank_sc_mask : {RK_NUM*SC_NUM{1'b0}})
                            | grant_pim_mask_c)
                           & req_seen_pim_vec
                           & (pre_all_req_pim | pre_all_req_urgent_pim);
reg  [RK_NUM*SC_NUM-1:0] grant_lp_mask_c;
always @* begin
    integer jl;
    for (jl = 0; jl < RK_NUM*SC_NUM; jl = jl + 1) begin
        grant_lp_mask_c[jl] = bank_close_info[jl]
                              && (pa_state_vec[jl*3 +: 3] == S_TIMER_AB_PROCESS)
                              && intent_sync_lp_vec[jl];
    end
end
assign pre_all_grant_lp = ((pa_cmd_vld ? expand_rank_sc_mask(pick_onehot_rank(pa_dfi_cmd_rank_r), pa_dfi_cmd_sc_r)
                                       : {RK_NUM*SC_NUM{1'b0}})
                           | grant_lp_mask_c)
                          & req_seen_lp_vec
                          & pre_all_intent_lp_sc;

// Combinational: compute next state and outputs per (rank, sc)
always @* begin
    integer i;
    logic [RK_NUM*SC_NUM-1:0] intent_i_vec, qos_i_vec, bank_close_i_vec;
    integer rk_i_local;
    logic allow_hit_local;
    
    // default comb outputs
    flush_req_r            = {RK_NUM*SC_NUM{1'b0}};
    preab_req_preall_r     = {RK_NUM*SC_NUM{1'b0}};
    preab_req_qos_preall_r = {RK_NUM*SC_NUM{1'b0}};

    // default next-state hold
    for (i = 0; i < RK_NUM*SC_NUM; i = i + 1) begin
        pa_state_nxt_vec[i*3 +: 3] = pa_state_vec[i*3 +: 3];
    end

    // per-(rank,sc) FSM
    for (i = 0; i < RK_NUM*SC_NUM; i = i + 1) begin
        intent_i_vec[i]     = intent_all[i];
        qos_i_vec[i]        = intent_qos[i];
        bank_close_i_vec[i] = bank_close_info[i];
        rk_i_local = i / SC_NUM;
        allow_hit_local = pre_ab_allow[i];

        unique case (pa_state_vec[i*3 +: 3])
            S_IDLE: begin
                // Use previous-cycle intent (intent_sync_vec) to align with current bank_close_i_vec
                if ((intent_sync_vec[i] && intent_i_vec[i]) && !bank_close_i_vec[i]) begin
                    flush_req_r[i]            = ((intent_sync_vec[i] & ~intent_sync_prev_vec[i])
                                                ? (intent_sync_ref_vec[i] | intent_sync_lp_vec[i] | intent_sync_soft_vec[i] | intent_sync_pim_vec[i])
                                                : 1'b0);
                    pa_state_nxt_vec[i*3 +: 3] = S_FLUSH_CMD_AB;
                end else if ((intent_sync_vec[i] && intent_i_vec[i]) && bank_close_i_vec[i]) begin
                    pa_state_nxt_vec[i*3 +: 3] = S_TIMER_AB_PROCESS;
                end
            end

            S_FLUSH_CMD_AB: begin
                // keep asserting flush and requests for this (rank,sc)
                // cancellation: if intent drops during processing, return to IDLE and stop outputs
                if (!intent_sync_vec[i]) begin
                    pa_state_nxt_vec[i*3 +: 3] = S_IDLE;
                end else if (flush_done) begin
                    pa_state_nxt_vec[i*3 +: 3] = S_TIMER_AB_PROCESS;
                end else if (bank_close_i_vec[i]) begin
                    pa_state_nxt_vec[i*3 +: 3] = S_IDLE;
                end
            end

            S_TIMER_AB_PROCESS: begin
                // keep requesting while processing
                preab_req_preall_r[i]     = intent_sync_vec[i] & intent_i_vec[i] & allow_hit_local;
                preab_req_qos_preall_r[i] = (
                    (pre_all_intent_ref[i]     & pre_all_intent_qos_ref[i])     |
                    (pre_all_intent_lp_sc[i]   & pre_all_intent_qos_lp_sc[i])   |
                    (pre_all_req_pim[i]        & pre_all_req_urgent_pim[i])     |
                    (soft_pre_all_req[i]       & soft_pre_all_qos[i])
                ) & allow_hit_local;
                // cancellation: if intent drops, return to IDLE immediately
                if (!intent_sync_vec[i]) begin
                    pa_state_nxt_vec[i*3 +: 3] = S_IDLE;
                end else if (bank_close_i_vec[i]) begin
                    pa_state_nxt_vec[i*3 +: 3] = S_IDLE;
                end
            end

            default: begin
                pa_state_nxt_vec[i*3 +: 3] = S_IDLE;
            end
        endcase
    end
end

 // Sequential: state registers and command issuance control
 always @(posedge ddrc_clk or negedge ddrc_rst_n) begin
     if (!ddrc_rst_n) begin
         integer i;
         for (i = 0; i < RK_NUM*SC_NUM; i = i + 1) begin
             pa_state_vec[i*3 +: 3] <= S_IDLE;
         end
        req_seen_ref_vec    <= {RK_NUM*SC_NUM{1'b0}};
        req_seen_pim_vec    <= {RK_NUM*SC_NUM{1'b0}};
        req_seen_lp_vec     <= {RK_NUM*SC_NUM{1'b0}};
        sc_sel              <= 1'b0;
        intent_sync_vec     <= {RK_NUM*SC_NUM{1'b0}};
        intent_sync_ref_vec <= {RK_NUM*SC_NUM{1'b0}};
        intent_sync_pim_vec <= {RK_NUM*SC_NUM{1'b0}};
        intent_sync_lp_vec  <= {RK_NUM*SC_NUM{1'b0}};
        intent_sync_soft_vec<= {RK_NUM*SC_NUM{1'b0}};
        intent_sync_prev_vec<= {RK_NUM*SC_NUM{1'b0}};
     end else begin
         // Declarations must come first in the block for iverilog
     integer i;
     integer sel_idx;
     integer sel_rank_i;
     integer rank_i; // temporary rank index per-iteration
     logic sel_s;
     logic sel_found;
     logic ready_i;
     logic ab_allow_rank_phase0, ab_allow_rank_phase1;
     logic [1:0] sel_phase;
     logic [1:0] allow_phase_vec;

         // default: no selection
         sel_found   = 1'b0;
         sel_idx     = 0;
         sel_rank_i  = 0;

         // update states per (rank,sc)
         for (i = 0; i < RK_NUM*SC_NUM; i = i + 1) begin
             // state update
             pa_state_vec[i*3 +: 3] <= pa_state_nxt_vec[i*3 +: 3];
             // remove internal timer handling; external pre_ab_allow gates readiness
         end

         // sticky request history
         req_seen_ref_vec <= req_seen_ref_vec | pre_all_intent_ref;
         req_seen_pim_vec <= req_seen_pim_vec | (pre_all_req_pim | pre_all_req_urgent_pim);
         req_seen_lp_vec  <= req_seen_lp_vec | pre_all_intent_lp_sc;
         // align bank_close with previous-cycle intent
       intent_sync_prev_vec <= intent_sync_vec;
       intent_sync_vec      <= intent_all;
       intent_sync_ref_vec  <= pre_all_intent_ref;
       intent_sync_pim_vec  <= pre_all_req_pim;
       intent_sync_lp_vec   <= pre_all_intent_lp_sc;
       intent_sync_soft_vec <= soft_pre_all_req;

         // HQoS first
         for (i = 0; i < RK_NUM*SC_NUM; i = i + 1) begin
             rank_i = i / SC_NUM;
             
            // [MODIFIED 2025-11-13] Phase validity per (rank, sc): slice 2 bits
            // for the current subchannel; previously rank-only slicing caused
            // cross-SC misuse, so now compute sel_phase directly from the slice
             
            // Do not gate readiness by pre_ab_allow_ph here; it may be 0 on certain DFI edges.
            // Only require the FSM processing state and command arbiter grant.
            ready_i = (pa_state_vec[i*3 +: 3] == S_TIMER_AB_PROCESS) && 
                      (preab_grant_preall[i]);
                       
             if (!sel_found && ready_i && preab_req_qos_preall_r[i]) begin
                 sel_found  = 1'b1;
                 sel_idx    = i;
                 sel_rank_i = rank_i; // write once when hit
                 sel_s      = (i % SC_NUM);
              sel_phase  = pre_ab_allow_ph[(rank_i*SC_NUM + (i % SC_NUM))*2 +: 2];
             end
         end

         // LQoS fallback
         if (!sel_found) begin
             for (i = 0; i < RK_NUM*SC_NUM; i = i + 1) begin
                 rank_i = i / SC_NUM;
                 
                // phase validity from pre_ab_allow_ph (rank slice); used only for phase selection
                 
                // Do not gate readiness by pre_ab_allow_ph; rely on pa_cmd_vld downstream gating.
                ready_i = (pa_state_vec[i*3 +: 3] == S_TIMER_AB_PROCESS) && 
                          (preab_grant_preall[i]);
                           
                 if (!sel_found && ready_i && !preab_req_qos_preall_r[i]) begin
                     sel_found  = 1'b1;
                     sel_idx    = i;
                     sel_rank_i = rank_i; // write once when hit
                     sel_s      = (i % SC_NUM);
                   sel_phase  = pre_ab_allow_ph[(rank_i*SC_NUM + (i % SC_NUM))*2 +: 2];
                 end
             end
         end

       if (sel_found && !all_bank_close && (pre_ab_allow[sel_idx] != 1'b0) && preab_grant_preall[sel_idx]) begin
            // Issue PRE ALL command
            sc_sel              <= sel_s;
            // complete selected (rank,sc)
            pa_state_vec[sel_idx*3 +: 3] <= S_IDLE;
        end else if (sel_found && all_bank_close && preab_grant_preall[sel_idx]) begin
            // Acknowledge without issuing command when all banks are already closed
            sc_sel              <= sel_s;
            // complete selected (rank,sc) without command
            pa_state_vec[sel_idx*3 +: 3] <= S_IDLE;
        end
     end
 end

// Assign outputs from registers
assign flush_req           = flush_req_r;
assign pa_pre_all_grant    = pa_pre_all_grant_r;
assign pa_pre_pb_grant     = {RK_NUM{1'b0}};
assign preab_req_preall    = preab_req_preall_r;
assign preab_req_qos_preall= preab_req_qos_preall_r;
assign pa_cmd_vld = pa_cmd_vld_r;
assign pa_dfi_cmd_type     = pa_cmd_vld ? pa_dfi_cmd_type_r  : '0;
assign pa_dfi_cmd_rank     = pa_cmd_vld ? pa_dfi_cmd_rank_r  : '0;
assign pa_dfi_cmd_phase    = pa_cmd_vld ? pa_dfi_cmd_phase_r : '0;
assign pa_dfi_cmd_sc       = pa_cmd_vld ? pa_dfi_cmd_sc_r    : '0;

// Combinational generation of pa_cmd_vld_r and command fields from current preab_grant_preall
always @* begin
    integer ksel;
    integer rk_i;
    pa_cmd_vld_r        = 1'b0;
    pa_dfi_cmd_type_r   = 5'd0;
    pa_dfi_cmd_rank_r   = {2**DDRC_RK_WIDTH{1'b0}};
    pa_dfi_cmd_phase_r  = {DDRC_PA_PHASE_WIDTH{1'b0}};
    pa_dfi_cmd_sc_r     = 1'b0;
    for (ksel = 0; ksel < RK_NUM*SC_NUM; ksel = ksel + 1) begin
        rk_i = ksel / SC_NUM;
        if (!pa_cmd_vld_r && preab_grant_preall[ksel]
            && (pa_state_vec[ksel*3 +: 3] == S_TIMER_AB_PROCESS)
            && intent_sync_vec[ksel]
            && (pre_all_intent_ref[ksel] || pre_all_req_pim[ksel] || pre_all_req_urgent_pim[ksel] || pre_all_intent_lp_sc[ksel])
            && (!intent_sync_lp_vec[ksel] || pre_all_intent_lp_sc[ksel] 
                || pre_all_intent_ref[ksel] || pre_all_req_pim[ksel] || pre_all_req_urgent_pim[ksel])) begin
            // gate by allow matrices (SC-specific): only check current (rank, sc)
            if (pre_ab_allow[ksel] != 1'b0) begin
                // drive phase as one-hot directly from pre_ab_allow_ph slice
                begin
                    logic [1:0] allow_mask;
                    allow_mask = pre_ab_allow_ph[(rk_i*SC_NUM + (ksel % SC_NUM))*2 +: 2];
                    pa_dfi_cmd_phase_r = allow_mask;
                end
                pa_cmd_vld_r      = 1'b1;
                pa_dfi_cmd_type_r = 5'd5;
                pa_dfi_cmd_rank_r = onehot_rank_mask_int(rk_i);
                pa_dfi_cmd_sc_r   = (ksel % SC_NUM);
            end
        end
    end
end

// Pre signals derive directly from PA command outputs for PRE ALL
// [MODIFIED 2025-11-13] PRE interface uses the same combinational gating as pa_cmd_vld
assign pre_vld    = pa_cmd_vld;
// [MODIFIED 2025-11-13] pre_ph is combinationally gated: zero when not triggered,
// selected phase when triggered.
assign pre_ph     = pa_cmd_vld ? pa_dfi_cmd_phase_r : '0;
assign prea_cmd_rk= pa_cmd_vld ? onehot_rank_to_bin(pa_dfi_cmd_rank_r) : '0;
assign prea_cmd_sc= pa_cmd_vld ? pa_dfi_cmd_sc_r : '0;
 //==============================================================================

 endmodule

 //==============================================================================
 // End of Module
 //==============================================================================
