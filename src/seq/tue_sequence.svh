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
) extends tue_object_base #(uvm_sequence #(REQ, RSP), CONFIGURATION, STATUS);
  function void set_sequencer(uvm_sequencer_base sequencer);
    tue_component_proxy_base #(CONFIGURATION, STATUS) component_proxy;
    super.set_sequencer(sequencer);
    component_proxy = tue_component_proxy_base #(CONFIGURATION, STATUS)::get(sequencer);
    if (component_proxy != null) begin
      set_context(component_proxy.get_configuration(), component_proxy.get_status());
    end
  endfunction

`ifndef UVM_POST_VERSION_1_1
    protected bit enable_automatic_phase_objection  = 0;

    protected function void set_automatic_phase_objection(bit value);
      enable_automatic_phase_objection  = value;
    endfunction

    task pre_body();
      if ((starting_phase != null) && enable_automatic_phase_objection) begin
        starting_phase.raise_objection(this);
      end
    endtask

    task post_body();
      if ((starting_phase != null) && enable_automatic_phase_objection) begin
        starting_phase.drop_objection(this);
      end
    endtask
`endif

  `tue_object_default_constructor(tue_sequence)
endclass
`endif
