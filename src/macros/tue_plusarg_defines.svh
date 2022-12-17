//------------------------------------------------------------------------------
//  Copyright 2022 Taichi Ishitani
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//------------------------------------------------------------------------------
`ifndef TUE_PLUSARG_DEFINES_SVH
`define TUE_PLUSARG_DEFINES_SVH

`define tue_define_plusarg(ARG, BLOCK) \
begin \
  uvm_cmdline_processor __clp; \
  string                __arg; \
  string                __values[$]; \
  __clp = uvm_cmdline_processor::get_inst(); \
  __arg = `"ARG`"; \
  if (__clp.get_arg_matches(__arg, __values)) begin \
    BLOCK; \
  end \
end

`define tue_define_plusarg_value(ARG, BLOCK) \
begin \
  uvm_cmdline_processor __clp; \
  string                __arg; \
  string                __value; \
  __clp = uvm_cmdline_processor::get_inst(); \
  __arg = {`"ARG`", "="}; \
  if (__clp.get_arg_value(__arg, __value)) begin \
    BLOCK; \
  end \
end

`define tue_define_plusarg_flag(ARG, VARIABLE) \
`tue_define_plusarg(ARG, begin VARIABLE = 1; end)

`define tue_define_plusarg_bin(ARG, VARIABLE) \
`tue_define_plusarg_value(ARG, begin VARIABLE = __value.atobin(); end)

`define tue_define_plusarg_dec(ARG, VARIABLE) \
`tue_define_plusarg_value(ARG, begin VARIABLE = __value.atoi(); end)

`define tue_define_plusarg_hex(ARG, VARIABLE) \
`tue_define_plusarg_value(ARG, begin VARIABLE = __value.atohex(); end)

`define tue_define_plusarg_string(ARG, VARIABLE) \
`tue_define_plusarg_value(ARG, begin VARIABLE = __value; end)


`endif
