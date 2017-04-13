//------------------------------------------------------------------------------
//  Copyright 2017 Taichi Ishitani
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
`ifndef TUE_SEQUENCER_SVH
`define TUE_SEQUENCER_SVH
class tue_sequencer #(
  type  CONFIGURATION = tue_configuration_dummy,
  type  STATUS        = tue_status_dummy,
  type  REQ           = uvm_sequence_item,
  type  RSP           = REQ
) extends tue_component_base #(
  uvm_sequencer #(REQ, RSP), CONFIGURATION, STATUS
);
  typedef tue_sequencer #(CONFIGURATION, STATUS, REQ, RSP)        this_type;
  typedef tue_component_proxy #(this_type, CONFIGURATION, STATUS) t_component_proxy;

  function new(string name = "tue_sequencer", uvm_component parent = null);
    super.new(name, parent);
    void'(t_component_proxy::create_component_proxy(this));
  endfunction

  `uvm_component_param_utils(tue_sequencer #(CONFIGURATION, STATUS, REQ, RSP))
endclass
`endif
