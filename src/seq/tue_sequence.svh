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
`ifndef TUE_SEQUENCE_SVH
`define TUE_SEQUENCE_SVH
class tue_sequence #(
  type  CONFIGURATION = tue_configuration_dummy,
  type  STATUS        = tue_status_dummy,
  type  REQ           = uvm_sequence_item,
  type  RSP           = REQ
) extends uvm_sequence_item;
  protected CONFIGURATION configuration;
  protected STATUS        status;

  function void set_sequencer(uvm_sequencer_base sequencer);
    tue_context_if #(CONFIGURATION, STATUS) context_if;
    super.set_sequencer(sequencer);
    if ($cast(context_if, sequencer)) begin
      configuration = context_if.get_configuration();
      status        = context_if.get_status();
    end
  endfunction

  `tue_object_default_constructor(tue_sequence)
endclass
`endif
