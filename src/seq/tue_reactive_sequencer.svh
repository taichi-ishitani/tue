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
`ifndef TUE_REACTIVE_SEQUENCER_SVH
`define TUE_REACTIVE_SEQUENCER_SVH

`uvm_analysis_imp_decl(_request)

virtual class tue_reactive_sequencer #(
  type  CONFIGURATION = tue_configuration_dummy,
  type  STATUS        = tue_status_dummy,
  type  ITEM          = uvm_sequence_item,
  type  REQUEST       = ITEM,
  type  RSP           = ITEM
) extends tue_sequencer #(
  CONFIGURATION, STATUS, ITEM, RSP
);
  typedef tue_reactive_sequencer #(CONFIGURATION, STATUS, ITEM, REQUEST, RSP) this_type;

  uvm_analysis_imp_request #(REQUEST, this_type)  request_export;

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    request_export  = new("request_export", this);
  endfunction

  pure virtual function void write_request(REQUEST request);
  pure virtual task get_request(ref REQUEST request);

  `tue_component_default_constructor(tue_reactive_sequencer)
endclass

class tue_reactive_fifo_sequencer #(
  type  CONFIGURATION = tue_configuration_dummy,
  type  STATUS        = tue_status_dummy,
  type  ITEM          = uvm_sequence_item,
  type  REQUEST       = ITEM,
  type  RSP           = ITEM
) extends tue_reactive_sequencer #(
  CONFIGURATION, STATUS, ITEM, REQUEST, RSP
);
  protected uvm_tlm_analysis_fifo #(REQUEST)  request_fifo;

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    request_fifo  = new("request_fifo", this);
  endfunction

  function void write_request(REQUEST request);
    request_fifo.write(request);
  endfunction

  task get_request(ref REQUEST request);
    request_fifo.get(request);
  endtask

  `tue_component_default_constructor(tue_reactive_fifo_sequencer)
  `uvm_component_param_utils (tue_reactive_fifo_sequencer #(CONFIGURATION, STATUS, ITEM, REQUEST, RSP))
endclass
`endif
