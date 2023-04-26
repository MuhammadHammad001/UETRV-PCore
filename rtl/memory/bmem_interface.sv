`ifndef VERILATOR
`include "../defines/UETRV_PCore_ISA.svh"
`include "../defines/cache_defs.svh"
`else
`include "UETRV_PCore_ISA.svh"
`include "cache_defs.svh"
`endif

module bmem_interface (

    input   logic                                   rst_n,                     // reset
    input   logic                                   clk,                       // clock

  // Instruction (boot) memory interface
    input  wire type_if2icache_s                    if2bmem_i,                 // Bus interface from IF  
    output type_icache2if_s                         bmem2if_o,                 // From boot memory to IF

  // DBus <---> Boot memory interface
    input   wire type_dbus2peri_s                   dbus2bmem_i,               // Boot memory input signals
    output  type_peri2dbus_s                        bmem2dbus_o,               // Boot memory output signals
    input logic                                     bmem_d_sel_i,
    input logic                                     bmem_iaddr_match_i
   
);


// Boot memory instantiation and initialization
logic [`XLEN-1:0]          bmem[`BMEM_SIZE/4];

initial
begin
     // Reading the contents of bmem.txt file to memory variable
     $readmemh("bmem.txt", bmem); 
end

//================================= Ibus interface ==================================//
// Local signals
type_if2icache_s                      if2bmem;               
type_icache2if_s                      bmem2if_ff, bmem2if_next;

type_dbus2peri_s                      dbus2bmem;
type_peri2dbus_s                      bmem2dbus_ff, bmem2dbus_next;

logic [`XLEN-1:0]                     bmem_i_addr;
logic [`XLEN-1:0]                     bmem_d_addr;
logic [11:0]                          bmem_rd_addr;
logic [`XLEN-1:0]                     bmem_rdata;

logic                                 bmem_i_sel;
logic                                 bmem_d_sel;
logic                                 bmem_iaddr_match;

// Local signal assignments
assign if2bmem     = if2bmem_i;
assign bmem_i_addr = if2bmem.addr; 
assign dbus2bmem   = dbus2bmem_i;
assign bmem_d_addr = dbus2bmem.addr;
assign bmem_iaddr_match = bmem_iaddr_match_i;

assign bmem_i_sel  = (if2bmem.req & bmem_iaddr_match); 
assign bmem_d_sel  = (dbus2bmem.cyc & bmem_d_sel_i);

assign bmem_rd_addr = bmem_d_sel ? {2'b0, bmem_d_addr[11:2]} 
                    : bmem_i_sel ? {2'b0, bmem_i_addr[11:2]} : '0; 

assign bmem_rdata = bmem[bmem_rd_addr];

// Synchronous memory read operation for IF module interface
always_ff @ (negedge rst_n, posedge clk) begin 
    if (~rst_n) begin
        bmem2if_ff.ack    <= 1'b0;
        bmem2if_ff.r_data <= `INSTR_NOP;
    end else begin                         
        bmem2if_ff        <= bmem2if_next;   
    end
end

always_comb  begin 
    bmem2if_next = '0;
    if (bmem_i_sel & ~bmem_d_sel) begin                         
        bmem2if_next.ack    = 1'b1;
        bmem2if_next.r_data = bmem_rdata;   
    end
end


// Synchronous memory read operation for Dbus module interface
always_ff @ (negedge rst_n, posedge clk) begin 
    if (~rst_n) begin
        bmem2dbus_ff.ack    <= 1'b0;
        bmem2dbus_ff.r_data <= `INSTR_NOP;
    end else begin                         
        bmem2dbus_ff        <= bmem2dbus_next;   
    end
end

// Synchronous memory read operation
always_comb begin 
    bmem2dbus_next = '0;
    if (bmem_d_sel & ~bmem2dbus_ff.ack) begin                         
        bmem2dbus_next.ack    = 1'b1;
        bmem2dbus_next.r_data = bmem_rdata;   
    end
end

assign bmem2dbus_o = bmem2dbus_ff; 
assign bmem2if_o   = bmem2if_ff; 
// assign bmem_i_sel_o = bmem_i_sel;   

endmodule : bmem_interface

