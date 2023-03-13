`ifndef VERILATOR
`include "../../defines/UETRV_PCore_defs.svh"
`include "../../defines/UETRV_PCore_ISA.svh"
`include "../../defines/MMU_defs.svh"
`include "../../defines/M_EXT_defs.svh"
`else
`include "UETRV_PCore_defs.svh"
`include "UETRV_PCore_ISA.svh"
`include "MMU_defs.svh"
`include "M_EXT_defs.svh"
`endif

module lsu (

    input   logic                           rst_n,                    // reset
    input   logic                           clk,                      // clock

    // EXE <---> LSU interface
    input  wire type_exe2lsu_data_s         exe2lsu_data_i,
    input  wire type_exe2lsu_ctrl_s         exe2lsu_ctrl_i,            // Structure for control signals from execute to memory 

    // M-extension <---> LSU interface
    input  wire type_mul2lsu_s              mul2lsu_i,

    // LSU <---> CSR interface
    input wire type_csr2lsu_data_s          csr2lsu_data_i,
    output type_lsu2csr_data_s              lsu2csr_data_o,
    output type_lsu2csr_ctrl_s              lsu2csr_ctrl_o,

    // LSU <---> WRB interface
    output type_lsu2wrb_data_s              lsu2wrb_data_o,
    output type_lsu2wrb_ctrl_s              lsu2wrb_ctrl_o,

    // LSU <---> EXE interface for feedback signals
    output logic [`XLEN-1:0]                lsu2exe_fb_alu_result_o,

    // LSU <---> Forward_stall interface for forwarding
    output type_lsu2fwd_s                   lsu2fwd_o,
    input wire type_fwd2lsu_s               fwd2lsu_i,

    // LSU <---> Data Bus (dbus) interface
    input  wire type_dbus2lsu_s             dbus2lsu_i,
    output type_lsu2dbus_s                  lsu2dbus_o,                // Signal to data bus 

    // LSU <---> MMU interface 
    input wire type_mmu2lsu_s               mmu2lsu_i, 
    output type_lsu2mmu_s                   lsu2mmu_o 

);

//============================= Local signals and their assignments =============================//
// Local signals
type_exe2lsu_data_s          exe2lsu_data;
type_exe2lsu_ctrl_s          exe2lsu_ctrl;
type_lsu2wrb_data_s          lsu2wrb_data;
type_lsu2wrb_ctrl_s          lsu2wrb_ctrl;
type_lsu2dbus_s              lsu2dbus;
type_dbus2lsu_s              dbus2lsu;
type_lsu2csr_data_s          lsu2csr_data;
type_lsu2csr_ctrl_s          lsu2csr_ctrl;
type_csr2lsu_data_s          csr2lsu_data;

type_lsu2fwd_s               lsu2fwd;
type_lsu2mmu_s               lsu2mmu;
type_mmu2lsu_s               mmu2lsu;

type_mul2lsu_s               mul2lsu;

logic [`XLEN-1:0]            ld_st_addr;
logic [`XLEN-1:0]            rdata_word;
logic [15:0]                 rdata_hword;
logic [7:0]                  rdata_byte;
logic                        ld_req;
type_ld_ops_e                ld_ops;
logic                        st_req;

// Signals for LSU request/response                                                          
logic                        ld_amo_req;
logic                        ld_amo_ack; 


// A-Extension signals
type_amo_ops_e               amo_ops;              // Signal added for AMO instructions
logic                        is_amo;               // A flag to check if the current instruction is ANO
logic                        is_lr;                // A flag to check if current instruction is LR.
logic [31:0]                 amo_buffer_data;      // Data buffer to keep a copy of data accessed via LR instruction
logic [31:0]                 amo_buffer_data_ff;   // Signal used for latching the buffer data.
logic [31:0]                 amo_buffer_addr;      // Address buffer to keep a copy of address accessed via LR instruction
logic [31:0]                 amo_buffer_addr_ff;   // Signal used for latching the buffer data
logic [31:0]                 amo_operand_a;        // To fetch amo operand1 (i.e, value from data memory)
logic [31:0]                 amo_operand_a_ff;     // Signal used for latching the value of amo_operand_a
logic [31:0]                 amo_operand_b;        // To fetch amo operand2 (i.e, data from register file pointed by rs2)
logic [31:0]                 amo_result_o;         // Variable to store the result of amo_alu
logic                        amo_done;             // A flag to show the completeness of amo instruction
logic                        amo_load_ack_ff;      // To latch the valid signal generated by dbus
logic                        a_slt_b, a_uslt_b;    // Two flags used to compare amo_operand_a and amo_operand_b (signed/unsigned comparators)
logic                        is_sc;                // A signal to check if current instruction is SC.
logic                        sc_pass;              // A flag to verify if SC instruction was successfully completed
logic                        amo_reserve;          // A flag to keep track if Data buffer and address buffer has valid value or not
logic                        amo_reserve_ff;       // Signal used for latching the reserve signal.
logic                        amo_save;


// Signals for AMO State Machine
type_amo_states_e            state, state_next;

// Signal assignments
assign exe2lsu_data  = exe2lsu_data_i;
assign exe2lsu_ctrl  = exe2lsu_ctrl_i;
assign dbus2lsu      = dbus2lsu_i;
assign csr2lsu_data  = csr2lsu_data_i;
assign mmu2lsu       = mmu2lsu_i;

assign mul2lsu       = mul2lsu_i;

// Prepare the signals to perform load/store operations      
assign ld_ops        = exe2lsu_ctrl.ld_ops;
// Moved in AMO State Machine
// assign ld_req        = |ld_ops; 
// assign st_req        = |(exe2lsu_ctrl.st_ops);

//=================================== Memory load operation =====================================//
// Extract the right size from the read data  
always_comb begin
   rdata_byte  = '0;
   rdata_hword = '0;
   rdata_word  = '0;

   case (ld_ops)
      LD_OPS_LB,
      LD_OPS_LBU : begin
         case (lsu2dbus.addr[1:0]) 
            2'b00 : begin 
               rdata_byte = dbus2lsu.r_data[7:0]; 
            end 
            2'b01 : begin
               rdata_byte = dbus2lsu.r_data[15:8];
            end
            2'b10 : begin
               rdata_byte = dbus2lsu.r_data[23:16];
            end
            2'b11 : begin
               rdata_byte = dbus2lsu.r_data[31:24];
            end
            default : begin    
            end  
         endcase
      end // LD_OPS_LB, LD_OPS_LBU 
      LD_OPS_LH,
      LD_OPS_LHU : begin 
         case (lsu2dbus.addr[1]) 
            1'b0 : begin
               rdata_hword = dbus2lsu.r_data[15:0];
            end 
            1'b1 : begin
               rdata_hword = dbus2lsu.r_data[31:16];
            end
            default : begin    
            end  
         endcase
      end // LD_OPS_LH, LD_OPS_LHU
      LD_OPS_LW : begin
         rdata_word = dbus2lsu.r_data;
      end
      default : begin
      end
   endcase // ld_ops
end


// Extend the load data for sign/zero
always_comb begin
    lsu2wrb_data.r_data = '0;
   
    if (amo_done) begin // // A-Extension
        // In case SC passes return 0 else return 1 (non-zero value)
        if (is_sc) begin
            lsu2wrb_data.r_data = { 31'b0, ~sc_pass};
        end else begin
            lsu2wrb_data.r_data = amo_operand_a; // For other AMO operations send the load data
        end
    end else if (dbus2lsu.ack) begin // Normal load operation
        case (ld_ops)
            LD_OPS_LB  : lsu2wrb_data.r_data = {{24{rdata_byte[7]}},   rdata_byte};
            LD_OPS_LBU : lsu2wrb_data.r_data = { 24'b0,                rdata_byte};
            LD_OPS_LH  : lsu2wrb_data.r_data = {{16{rdata_hword[15]}}, rdata_hword};
            LD_OPS_LHU : lsu2wrb_data.r_data = { 16'b0,                rdata_hword};
            LD_OPS_LW  : lsu2wrb_data.r_data = {                       rdata_word};
            default    : lsu2wrb_data.r_data = '0;
        endcase // ld_ops
    end 
end

//=================================== A-Extension implementation =====================================//
// Signal assignments
assign amo_ops = exe2lsu_ctrl.amo_ops;

assign is_amo  = |amo_ops;                 // Assignment of is_amo
                                           // is_amo if true, then it will command the following variations in the existing LSU:
                                           //   1. FOR AMO, the first part of instruction execution is 
                                           //      to load the data from the data memory, thus ld_ops will 
                                           //      be assigned as LW opcode to read data word from dbus.
                                           //   2. If its an AMO instruction, then lsu2fwd.ld_ack will 
                                           //      subjected to the completeness of amo instruction,
                                           //      thus, lsu2fwd.ld_ack will be updated to amo_done flag 
                                           //      instead of regular dbus2lsu.ack

assign is_lr  = amo_ops == AMO_OPS_LR;     // Assignment of is_lr
                                           // When 'is_lr' is set then following becomes true:
                                           //   1. The execution will be similar to LW instruction except
                                           //      that data and address will be saved in the respective buffer
                                           //   2. amo_reserve will be enabled
                                           //   3. Instruction will be considered completed after 
                                           //      dbus2lsu.ack will come, so amo_done logic will be 
                                           //      adjusted accordingly

assign is_sc  = amo_ops == AMO_OPS_SC;     // Assignment of is_sc
                                           // When 'is_sc' is set then following becomes true:
                                           //   1. Determine if current address and data matches with the 
                                           //      data/address stored in amo_buffer
                                           //   2. Determine if amo_reserve was enabled previously due to 
                                           //      earlier LR instruction
                                           //   3. Based on the above checks, determine if SC instruction 
                                           //      was successfull or not. Set sc_pass flag accordingly
                                           //   4. Update data to write_back stage.
                                           //       4a. lsu2wrb_data.alu_result will become equal to !sc_pass. 
                                           //           (0 if successfull, 1 if unsuccessfull)
                                           //       4b. lsu2wrb_ctrl.rd_wrb_sel will become equal to RD_WRB_ALU (1)
                                           //       4c. lsu2wrb_ctrl.rd_wr_req will be set (1). REMEMBER: for normal
                                           //           store, it was zero as there is no write basck for normal store

// Prepare the AMO operands                        
assign amo_operand_b   = exe2lsu_data.rs2_data;
assign amo_operand_a   = (ld_req & dbus2lsu.ack) ? dbus2lsu.r_data : amo_operand_a_ff;

// Prepare the signals to perform load/store operations      
assign a_slt_b  = $signed(amo_operand_a) < $signed(amo_operand_b);    // Comparison between operand_a and operand_b ==> To be used by AMO_ALU
assign a_uslt_b = amo_operand_a < amo_operand_b;                      // Comparison between operand_a and operand_b ==> To be used by AMO_ALU
// assign amo_done = is_lr ? dbus2lsu.ack : amo_load_ack_ff;             // Logic to amo_done ==> TO BE USED TO END THE AMO INSTRUCTION EXECTION

// Logic for sc_pass, evaluation if instruction is SC, and amo_reserve was set (by 
// some LR instruction) and Data/Address of buffer matches with the current data
assign sc_pass  =  is_sc
                & (amo_buffer_addr_ff == exe2lsu_data.alu_result) 
                & (amo_buffer_data_ff == amo_operand_a);

// AMO operation
always_comb begin
    amo_result_o = '0;

    case (amo_ops)
        AMO_OPS_SC  : amo_result_o = amo_operand_b;
        AMO_OPS_SWAP: amo_result_o = amo_operand_b;
        AMO_OPS_ADD : amo_result_o = amo_operand_a + amo_operand_b;
        AMO_OPS_XOR : amo_result_o = amo_operand_a ^ amo_operand_b;
        AMO_OPS_AND : amo_result_o = amo_operand_a & amo_operand_b;
        AMO_OPS_OR  : amo_result_o = amo_operand_a | amo_operand_b;
        AMO_OPS_MIN : amo_result_o = a_slt_b  ? amo_operand_a : amo_operand_b;
        AMO_OPS_MAX : amo_result_o = a_slt_b  ? amo_operand_b : amo_operand_a;
        AMO_OPS_MINU: amo_result_o = a_uslt_b ? amo_operand_a : amo_operand_b;
        AMO_OPS_MAXU: amo_result_o = a_uslt_b ? amo_operand_b : amo_operand_a;
        default: amo_result_o = amo_operand_b;
    endcase
end

always_ff @( posedge clk or negedge rst_n) begin 
   if (~rst_n | (is_sc & amo_done))
   begin
      amo_buffer_data_ff <= 0;
      amo_buffer_addr_ff <= 0;
      amo_reserve_ff     <= 0;
   end
   else if(amo_save) 
   begin
      amo_buffer_data_ff <= lsu2wrb_data.r_data;
      amo_buffer_addr_ff <= exe2lsu_data.alu_result;
      amo_reserve_ff     <= 1;
   end   
end

always_ff @( posedge clk or negedge rst_n) begin 
   if (~rst_n | is_lr)
      amo_load_ack_ff <= 0;
   else
      amo_load_ack_ff <= dbus2lsu.ack;   
end

always_ff @( posedge clk ) begin 
   if (~rst_n)
      amo_operand_a_ff <= 0;
   else if(ld_req & dbus2lsu.ack)
      amo_operand_a_ff <= dbus2lsu.r_data; 
   else 
      amo_operand_a_ff <= amo_operand_a_ff;   
end

// State register synchronous update
always_ff @ (posedge clk or negedge rst_n) begin
    if (!rst_n | fwd2lsu_i.lsu_flush) begin
	     state        <= AMO_IDLE;
    end else begin
	     state        <= state_next;
    end
end
// Add register file write and store write data as part of the FSM
// Next_state and output always block
always_comb begin
   amo_done = 0; 
   amo_save = 0; 
   state_next              = AMO_IDLE;
   ld_req                  = |ld_ops; 
   st_req                  = |(exe2lsu_ctrl.st_ops);
   lsu2dbus.w_data         = exe2lsu_data.rs2_data;
   lsu2wrb_ctrl.rd_wr_req  = exe2lsu_ctrl.rd_wr_req;

   case (state)
      AMO_IDLE: begin   
         if(is_amo) begin
            state_next = AMO_LOAD;
            ld_req     = 1;
            st_req     = 0;
            lsu2wrb_ctrl.rd_wr_req  = 0;
         end else begin
            state_next              = AMO_IDLE;
            ld_req                  = |ld_ops; 
            st_req                  = |(exe2lsu_ctrl.st_ops);
            lsu2dbus.w_data         = exe2lsu_data.rs2_data;
            lsu2wrb_ctrl.rd_wr_req  = exe2lsu_ctrl.rd_wr_req;
         end
      end 
      AMO_LOAD: begin
         lsu2wrb_ctrl.rd_wr_req  = 0;
         if(dbus2lsu.ack) begin
            state_next = AMO_OP;
            ld_req     = 1;
            st_req     = 0;
            amo_save   = is_lr;
         end else begin
            state_next = AMO_LOAD;
            ld_req     = 1;
            st_req     = 0;
         end
      end

      AMO_OP: begin
            lsu2wrb_ctrl.rd_wr_req  = 0;
          //  state_next = AMO_ST;
            ld_req     = 0;
            st_req     = 0;
            // Donot Store in case of LR or when SC fails
            if(is_lr | (is_sc && !sc_pass)) begin
               state_next = AMO_DONE;
            end else  begin
             //  st_req     = 1;
               state_next = AMO_ST;
            end
      end

      AMO_ST: begin
         lsu2wrb_ctrl.rd_wr_req  = 0;
         ld_req     = 0;
         st_req     = 1;

         if(is_sc) begin
            lsu2dbus.w_data = exe2lsu_data.rs2_data;
         end else  begin
            lsu2dbus.w_data = amo_result_o;
         end
     
         if(dbus2lsu.ack) begin
            state_next = AMO_DONE;
         end else begin
            state_next = AMO_ST;         
         end
      end

      AMO_DONE: begin
            lsu2wrb_ctrl.rd_wr_req = 1;
            state_next = AMO_IDLE;
            ld_req     = 0;
            st_req     = 0;
            amo_done   = 1;
      end

      default: begin
         state_next              = AMO_IDLE;
         ld_req                  = |ld_ops; 
         st_req                  = |(exe2lsu_ctrl.st_ops);
         lsu2dbus.w_data         = exe2lsu_data.rs2_data;
         lsu2wrb_ctrl.rd_wr_req  = exe2lsu_ctrl.rd_wr_req;
      end
   endcase
end

//=================================== Output signals update =====================================//

assign ld_st_addr = exe2lsu_data.alu_result;

// Feedback signals to EXE module
assign lsu2exe_fb_alu_result_o = exe2lsu_data.alu_result; 

// Update data for CSR module
assign lsu2csr_data.pc_next   = exe2lsu_data.pc_next;
assign lsu2csr_data.dbus_addr = ld_st_addr;

// Update control signals for CSR module
assign lsu2csr_ctrl.ld_ops = exe2lsu_ctrl.ld_ops;
assign lsu2csr_ctrl.st_ops = exe2lsu_ctrl.st_ops;

assign lsu2csr_ctrl.ld_page_fault   = mmu2lsu.ld_page_fault;
assign lsu2csr_ctrl.st_page_fault   = mmu2lsu.st_page_fault;
assign lsu2csr_ctrl.inst_page_fault = mmu2lsu.inst_page_fault;
assign lsu2csr_ctrl.vaddr           = mmu2lsu.vaddr;

// Update data for writeback
// If instruction is SC, then either 1 (in case of fail) or 0 (in case of PASS) will be provided to write back stage
// assign lsu2wrb_data.alu_result = is_sc ? !sc_pass : exe2lsu_data.alu_result;  
assign lsu2wrb_data.alu_result = exe2lsu_data.alu_result;  
assign lsu2wrb_data.pc_next    = exe2lsu_data.pc_next;
assign lsu2wrb_data.rd_addr    = exe2lsu_ctrl.rd_addr; 
assign lsu2wrb_data.alu_m_result = mul2lsu.alu_m_result;              

// Update control signals for writeback
// If instruction is SC, then write back control signals will be updated to propagate 1 or 0 into rd
assign lsu2wrb_ctrl.rd_wrb_sel = exe2lsu_ctrl.rd_wrb_sel;

// Signals for forwarding module
assign lsu2fwd.rd_addr   = exe2lsu_ctrl.rd_addr; 
assign lsu2fwd.rd_wr_req = exe2lsu_ctrl.rd_wr_req;  // For SC, forwarding loop will also be updated

assign ld_amo_req = ld_req | is_amo | st_req;
assign ld_amo_ack = is_amo ? amo_done : dbus2lsu.ack;   // Ack will be based on amo_done in case of 
                                                             // amo_instruction

//assign lsu2fwd.mul_req   = (exe2lsu_ctrl.rd_wrb_sel == RD_WRB_M_ALU) ? '1 : '0;
assign lsu2fwd.ld_req   = ld_amo_req;
assign lsu2fwd.ld_ack   = ld_amo_ack;

assign lsu2fwd.mul_req  = mul2lsu.alu_m_req;
assign lsu2fwd.mul_ack  = mul2lsu.alu_m_ack;

// Signals to data memory interface
assign lsu2dbus.addr   =  mmu2lsu.d_paddr[`XLEN-1:0]; // ld_st_addr;
assign lsu2dbus.ld_req = ld_req & (mmu2lsu.d_hit);
assign lsu2dbus.st_req = st_req & (mmu2lsu.d_hit);
// MT: assign lsu2dbus.w_data = exe2lsu_data.rs2_data;
assign lsu2dbus.st_ops = exe2lsu_ctrl.st_ops;

// Signals for MMU
assign lsu2mmu.satp_ppn       = csr2lsu_data.satp_ppn;
assign lsu2mmu.en_vaddr       = csr2lsu_data.en_vaddr;
assign lsu2mmu.en_ld_st_vaddr = csr2lsu_data.en_ld_st_vaddr;
assign lsu2mmu.mxr            = csr2lsu_data.mxr;
assign lsu2mmu.tlb_flush      = csr2lsu_data.tlb_flush;
assign lsu2mmu.lsu_flush      = csr2lsu_data.lsu_flush;
assign lsu2mmu.d_req          = ld_req | st_req;
assign lsu2mmu.st_req         = st_req;
assign lsu2mmu.d_vaddr        = ld_st_addr;

// Update the output signals with proper assignment
assign lsu2csr_data_o = lsu2csr_data;
assign lsu2csr_ctrl_o = lsu2csr_ctrl;
assign lsu2wrb_data_o = lsu2wrb_data;
assign lsu2wrb_ctrl_o = lsu2wrb_ctrl;   
assign lsu2dbus_o     = lsu2dbus; 
assign lsu2fwd_o      = lsu2fwd;
assign lsu2mmu_o      = lsu2mmu;

endmodule : lsu
