/*
 * Generated by Bluespec Compiler, version 2023.01-6-g034050db (build 034050db)
 * 
 * On Thu Jun  8 01:01:22 PDT 2023
 * 
 */
#include "bluesim_primitives.h"
#include "mkDecoder.h"


/* Constructor */
MOD_mkDecoder::MOD_mkDecoder(tSimStateHdl simHdl, char const *name, Module *parent)
  : Module(simHdl, name, parent), __clk_handle_0(BAD_CLOCK_HANDLE), PORT_RST_N((tUInt8)1u)
{
  symbol_count = 0u;
  init_symbols_0();
}


/* Symbol init fns */

void MOD_mkDecoder::init_symbols_0()
{
}


/* Rule actions */


/* Methods */

tUInt64 MOD_mkDecoder::METH_decode(tUInt32 ARG_decode_insn)
{
  tUInt64 DEF_decode_insn_BITS_19_TO_15_9_CONCAT_decode_insn_ETC___d77;
  tUInt8 DEF_IF_decode_insn_BITS_14_TO_12_EQ_0_THEN_1_ELSE__ETC___d63;
  tUInt8 DEF_IF_decode_insn_BITS_14_TO_12_EQ_0_THEN_1_ELSE__ETC___d56;
  tUInt8 DEF_IF_decode_insn_BITS_6_TO_0_EQ_0x13_THEN_2_ELSE_1___d34;
  tUInt8 DEF_IF_decode_insn_BITS_6_TO_0_EQ_0x33_OR_decode_i_ETC___d38;
  tUInt8 DEF_IF_decode_insn_BITS_14_TO_12_EQ_0_OR_decode_in_ETC___d27;
  tUInt8 DEF_IF_decode_insn_BITS_14_TO_12_EQ_0_THEN_1_ELSE__ETC___d21;
  tUInt8 DEF_IF_decode_insn_BITS_6_TO_0_EQ_0x33_OR_decode_i_ETC___d33;
  tUInt32 DEF_SEXT_decode_insn_BITS_31_TO_20_5___d47;
  tUInt8 DEF_decode_insn_BITS_6_TO_0_EQ_0x13___d3;
  tUInt32 DEF__0_CONCAT_decode_insn_BITS_24_TO_20_0___d44;
  tUInt32 DEF_IF_decode_insn_BITS_14_TO_12_EQ_1_OR_decode_in_ETC___d49;
  tUInt64 DEF_IF_decode_insn_BITS_6_TO_0_EQ_0x13_THEN_IF_dec_ETC___d51;
  tUInt64 DEF_IF_decode_insn_BITS_6_TO_0_EQ_0x33_OR_decode_i_ETC___d76;
  tUInt8 DEF_spliced_bits__h731;
  tUInt8 DEF_spliced_bits__h787;
  tUInt8 DEF_funct3__h27;
  tUInt8 DEF_spliced_bits__h532;
  tUInt8 DEF_x__h336;
  tUInt8 DEF_decode_insn_BITS_24_TO_20___d40;
  tUInt8 DEF_opcode__h26;
  tUInt8 DEF_spliced_bits__h560;
  tUInt8 DEF_spliced_bits__h759;
  tUInt32 DEF_spliced_bits__h703;
  tUInt32 DEF_decode_insn_BITS_31_TO_20___d45;
  tUInt64 PORT_decode;
  DEF_decode_insn_BITS_31_TO_20___d45 = (tUInt32)(ARG_decode_insn >> 20u);
  DEF_spliced_bits__h703 = (tUInt32)(1023u & (ARG_decode_insn >> 21u));
  DEF_spliced_bits__h759 = (tUInt8)((tUInt8)255u & (ARG_decode_insn >> 12u));
  DEF_spliced_bits__h560 = (tUInt8)(ARG_decode_insn >> 25u);
  DEF_decode_insn_BITS_24_TO_20___d40 = (tUInt8)((tUInt8)31u & (ARG_decode_insn >> 20u));
  DEF_opcode__h26 = (tUInt8)((tUInt8)127u & ARG_decode_insn);
  DEF_x__h336 = (tUInt8)((tUInt8)31u & (ARG_decode_insn >> 15u));
  DEF_spliced_bits__h532 = (tUInt8)((tUInt8)31u & (ARG_decode_insn >> 7u));
  DEF_funct3__h27 = (tUInt8)((tUInt8)7u & (ARG_decode_insn >> 12u));
  DEF_spliced_bits__h787 = (tUInt8)(ARG_decode_insn >> 31u);
  DEF_spliced_bits__h731 = (tUInt8)((tUInt8)1u & (ARG_decode_insn >> 20u));
  DEF__0_CONCAT_decode_insn_BITS_24_TO_20_0___d44 = (tUInt32)(DEF_decode_insn_BITS_24_TO_20___d40);
  DEF_decode_insn_BITS_6_TO_0_EQ_0x13___d3 = DEF_opcode__h26 == (tUInt8)19u;
  DEF_SEXT_decode_insn_BITS_31_TO_20_5___d47 = primSignExt32(32u,
							     12u,
							     (tUInt32)(DEF_decode_insn_BITS_31_TO_20___d45));
  switch (DEF_funct3__h27) {
  case (tUInt8)1u:
  case (tUInt8)5u:
    DEF_IF_decode_insn_BITS_14_TO_12_EQ_1_OR_decode_in_ETC___d49 = DEF__0_CONCAT_decode_insn_BITS_24_TO_20_0___d44;
    break;
  case (tUInt8)3u:
    DEF_IF_decode_insn_BITS_14_TO_12_EQ_1_OR_decode_in_ETC___d49 = DEF_decode_insn_BITS_31_TO_20___d45;
    break;
  default:
    DEF_IF_decode_insn_BITS_14_TO_12_EQ_1_OR_decode_in_ETC___d49 = DEF_SEXT_decode_insn_BITS_31_TO_20_5___d47;
  }
  DEF_IF_decode_insn_BITS_6_TO_0_EQ_0x13_THEN_IF_dec_ETC___d51 = 17179869183llu & ((((tUInt64)(DEF_decode_insn_BITS_6_TO_0_EQ_0x13___d3 ? DEF_IF_decode_insn_BITS_14_TO_12_EQ_1_OR_decode_in_ETC___d49 : 0u)) << 2u) | (tUInt64)((tUInt8)0u));
  switch (DEF_funct3__h27) {
  case (tUInt8)0u:
    DEF_IF_decode_insn_BITS_14_TO_12_EQ_0_THEN_1_ELSE__ETC___d21 = (tUInt8)1u;
    break;
  case (tUInt8)1u:
    DEF_IF_decode_insn_BITS_14_TO_12_EQ_0_THEN_1_ELSE__ETC___d21 = (tUInt8)2u;
    break;
  case (tUInt8)2u:
    DEF_IF_decode_insn_BITS_14_TO_12_EQ_0_THEN_1_ELSE__ETC___d21 = (tUInt8)3u;
    break;
  case (tUInt8)3u:
    DEF_IF_decode_insn_BITS_14_TO_12_EQ_0_THEN_1_ELSE__ETC___d21 = (tUInt8)4u;
    break;
  case (tUInt8)4u:
    DEF_IF_decode_insn_BITS_14_TO_12_EQ_0_THEN_1_ELSE__ETC___d21 = (tUInt8)5u;
    break;
  case (tUInt8)5u:
    DEF_IF_decode_insn_BITS_14_TO_12_EQ_0_THEN_1_ELSE__ETC___d21 = (tUInt8)6u;
    break;
  case (tUInt8)6u:
    DEF_IF_decode_insn_BITS_14_TO_12_EQ_0_THEN_1_ELSE__ETC___d21 = (tUInt8)7u;
    break;
  case (tUInt8)7u:
    DEF_IF_decode_insn_BITS_14_TO_12_EQ_0_THEN_1_ELSE__ETC___d21 = (tUInt8)8u;
    break;
  default:
    DEF_IF_decode_insn_BITS_14_TO_12_EQ_0_THEN_1_ELSE__ETC___d21 = (tUInt8)0u;
  }
  switch (DEF_funct3__h27) {
  case (tUInt8)0u:
  case (tUInt8)1u:
  case (tUInt8)2u:
    DEF_IF_decode_insn_BITS_14_TO_12_EQ_0_OR_decode_in_ETC___d27 = (tUInt8)10u;
    break;
  case (tUInt8)4u:
  case (tUInt8)5u:
    DEF_IF_decode_insn_BITS_14_TO_12_EQ_0_OR_decode_in_ETC___d27 = (tUInt8)11u;
    break;
  default:
    DEF_IF_decode_insn_BITS_14_TO_12_EQ_0_OR_decode_in_ETC___d27 = (tUInt8)0u;
  }
  switch (DEF_opcode__h26) {
  case (tUInt8)19u:
  case (tUInt8)51u:
    DEF_IF_decode_insn_BITS_6_TO_0_EQ_0x33_OR_decode_i_ETC___d33 = DEF_IF_decode_insn_BITS_14_TO_12_EQ_0_THEN_1_ELSE__ETC___d21;
    break;
  case (tUInt8)3u:
    DEF_IF_decode_insn_BITS_6_TO_0_EQ_0x33_OR_decode_i_ETC___d33 = DEF_IF_decode_insn_BITS_14_TO_12_EQ_0_OR_decode_in_ETC___d27;
    break;
  case (tUInt8)35u:
    DEF_IF_decode_insn_BITS_6_TO_0_EQ_0x33_OR_decode_i_ETC___d33 = (tUInt8)9u;
    break;
  case (tUInt8)111u:
    DEF_IF_decode_insn_BITS_6_TO_0_EQ_0x33_OR_decode_i_ETC___d33 = (tUInt8)12u;
    break;
  default:
    DEF_IF_decode_insn_BITS_6_TO_0_EQ_0x33_OR_decode_i_ETC___d33 = (tUInt8)0u;
  }
  switch (DEF_funct3__h27) {
  case (tUInt8)0u:
    DEF_IF_decode_insn_BITS_14_TO_12_EQ_0_THEN_1_ELSE__ETC___d63 = (tUInt8)1u;
    break;
  case (tUInt8)1u:
    DEF_IF_decode_insn_BITS_14_TO_12_EQ_0_THEN_1_ELSE__ETC___d63 = (tUInt8)2u;
    break;
  case (tUInt8)2u:
    DEF_IF_decode_insn_BITS_14_TO_12_EQ_0_THEN_1_ELSE__ETC___d63 = (tUInt8)3u;
    break;
  default:
    DEF_IF_decode_insn_BITS_14_TO_12_EQ_0_THEN_1_ELSE__ETC___d63 = (tUInt8)0u;
  }
  DEF_IF_decode_insn_BITS_6_TO_0_EQ_0x13_THEN_2_ELSE_1___d34 = DEF_decode_insn_BITS_6_TO_0_EQ_0x13___d3 ? (tUInt8)2u : (tUInt8)1u;
  switch (DEF_opcode__h26) {
  case (tUInt8)19u:
  case (tUInt8)51u:
    DEF_IF_decode_insn_BITS_6_TO_0_EQ_0x33_OR_decode_i_ETC___d38 = DEF_IF_decode_insn_BITS_6_TO_0_EQ_0x13_THEN_2_ELSE_1___d34;
    break;
  case (tUInt8)3u:
    DEF_IF_decode_insn_BITS_6_TO_0_EQ_0x33_OR_decode_i_ETC___d38 = (tUInt8)2u;
    break;
  case (tUInt8)35u:
    DEF_IF_decode_insn_BITS_6_TO_0_EQ_0x33_OR_decode_i_ETC___d38 = (tUInt8)3u;
    break;
  case (tUInt8)111u:
    DEF_IF_decode_insn_BITS_6_TO_0_EQ_0x33_OR_decode_i_ETC___d38 = (tUInt8)4u;
    break;
  default:
    DEF_IF_decode_insn_BITS_6_TO_0_EQ_0x33_OR_decode_i_ETC___d38 = (tUInt8)0u;
  }
  switch (DEF_funct3__h27) {
  case (tUInt8)0u:
  case (tUInt8)4u:
    DEF_IF_decode_insn_BITS_14_TO_12_EQ_0_THEN_1_ELSE__ETC___d56 = (tUInt8)1u;
    break;
  case (tUInt8)1u:
  case (tUInt8)5u:
    DEF_IF_decode_insn_BITS_14_TO_12_EQ_0_THEN_1_ELSE__ETC___d56 = (tUInt8)2u;
    break;
  case (tUInt8)2u:
    DEF_IF_decode_insn_BITS_14_TO_12_EQ_0_THEN_1_ELSE__ETC___d56 = (tUInt8)3u;
    break;
  default:
    DEF_IF_decode_insn_BITS_14_TO_12_EQ_0_THEN_1_ELSE__ETC___d56 = (tUInt8)0u;
  }
  switch (DEF_opcode__h26) {
  case (tUInt8)19u:
  case (tUInt8)51u:
    DEF_IF_decode_insn_BITS_6_TO_0_EQ_0x33_OR_decode_i_ETC___d76 = DEF_IF_decode_insn_BITS_6_TO_0_EQ_0x13_THEN_IF_dec_ETC___d51;
    break;
  case (tUInt8)3u:
    DEF_IF_decode_insn_BITS_6_TO_0_EQ_0x33_OR_decode_i_ETC___d76 = 17179869183llu & ((((tUInt64)(DEF_SEXT_decode_insn_BITS_31_TO_20_5___d47)) << 2u) | (tUInt64)(DEF_IF_decode_insn_BITS_14_TO_12_EQ_0_THEN_1_ELSE__ETC___d56));
    break;
  case (tUInt8)35u:
    DEF_IF_decode_insn_BITS_6_TO_0_EQ_0x33_OR_decode_i_ETC___d76 = 17179869183llu & ((((tUInt64)(primSignExt32(32u,
													       12u,
													       (tUInt32)(4095u & ((((tUInt32)(DEF_spliced_bits__h560)) << 5u) | (tUInt32)(DEF_spliced_bits__h532)))))) << 2u) | (tUInt64)(DEF_IF_decode_insn_BITS_14_TO_12_EQ_0_THEN_1_ELSE__ETC___d63));
    break;
  default:
    DEF_IF_decode_insn_BITS_6_TO_0_EQ_0x33_OR_decode_i_ETC___d76 = 17179869183llu & ((((tUInt64)(DEF_opcode__h26 == (tUInt8)111u ? primSignExt32(32u,
																		 21u,
																		 (tUInt32)(2097151u & (((((((tUInt32)(DEF_spliced_bits__h787)) << 20u) | (((tUInt32)(DEF_spliced_bits__h759)) << 12u)) | (((tUInt32)(DEF_spliced_bits__h731)) << 11u)) | (DEF_spliced_bits__h703 << 1u)) | (tUInt32)((tUInt8)0u)))) : 0u)) << 2u) | (tUInt64)((tUInt8)0u));
  }
  DEF_decode_insn_BITS_19_TO_15_9_CONCAT_decode_insn_ETC___d77 = 562949953421311llu & ((((((tUInt64)(DEF_x__h336)) << 44u) | (((tUInt64)(DEF_decode_insn_BITS_24_TO_20___d40)) << 39u)) | (((tUInt64)(DEF_spliced_bits__h532)) << 34u)) | DEF_IF_decode_insn_BITS_6_TO_0_EQ_0x33_OR_decode_i_ETC___d76);
  PORT_decode = 72057594037927935llu & (((((tUInt64)(DEF_IF_decode_insn_BITS_6_TO_0_EQ_0x33_OR_decode_i_ETC___d33)) << 52u) | (((tUInt64)(DEF_IF_decode_insn_BITS_6_TO_0_EQ_0x33_OR_decode_i_ETC___d38)) << 49u)) | DEF_decode_insn_BITS_19_TO_15_9_CONCAT_decode_insn_ETC___d77);
  return PORT_decode;
}

tUInt8 MOD_mkDecoder::METH_RDY_decode()
{
  tUInt8 DEF_CAN_FIRE_decode;
  tUInt8 PORT_RDY_decode;
  DEF_CAN_FIRE_decode = (tUInt8)1u;
  PORT_RDY_decode = DEF_CAN_FIRE_decode;
  return PORT_RDY_decode;
}


/* Reset routines */

void MOD_mkDecoder::reset_RST_N(tUInt8 ARG_rst_in)
{
  PORT_RST_N = ARG_rst_in;
}


/* Static handles to reset routines */


/* Functions for the parent module to register its reset fns */


/* Functions to set the elaborated clock id */

void MOD_mkDecoder::set_clk_0(char const *s)
{
  __clk_handle_0 = bk_get_or_define_clock(sim_hdl, s);
}


/* State dumping routine */
void MOD_mkDecoder::dump_state(unsigned int indent)
{
}


/* VCD dumping routines */

unsigned int MOD_mkDecoder::dump_VCD_defs(unsigned int levels)
{
  vcd_write_scope_start(sim_hdl, inst_name);
  vcd_num = vcd_reserve_ids(sim_hdl, 1u);
  unsigned int num = vcd_num;
  for (unsigned int clk = 0u; clk < bk_num_clocks(sim_hdl); ++clk)
    vcd_add_clock_def(sim_hdl, this, bk_clock_name(sim_hdl, clk), bk_clock_vcd_num(sim_hdl, clk));
  vcd_write_def(sim_hdl, bk_clock_vcd_num(sim_hdl, __clk_handle_0), "CLK", 1u);
  vcd_write_def(sim_hdl, num++, "RST_N", 1u);
  vcd_write_scope_end(sim_hdl);
  return num;
}

void MOD_mkDecoder::dump_VCD(tVCDDumpType dt, unsigned int levels, MOD_mkDecoder &backing)
{
  vcd_defs(dt, backing);
}

void MOD_mkDecoder::vcd_defs(tVCDDumpType dt, MOD_mkDecoder &backing)
{
  unsigned int num = vcd_num;
  if (dt == VCD_DUMP_XS)
  {
    vcd_write_x(sim_hdl, num++, 1u);
  }
  else
    if (dt == VCD_DUMP_CHANGES)
    {
      if ((backing.PORT_RST_N) != PORT_RST_N)
      {
	vcd_write_val(sim_hdl, num, PORT_RST_N, 1u);
	backing.PORT_RST_N = PORT_RST_N;
      }
      ++num;
    }
    else
    {
      vcd_write_val(sim_hdl, num++, PORT_RST_N, 1u);
      backing.PORT_RST_N = PORT_RST_N;
    }
}
