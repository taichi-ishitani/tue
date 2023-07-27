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
class tue_sequencer_base #(
  type  BASE                = uvm_sequencer,
  type  CONFIGURATION       = tue_configuration_dummy,
  type  STATUS              = tue_status_dummy,
  type  PROXY_CONFIGURATION = CONFIGURATION,
  type  PROXY_STATUS        = STATUS
) extends tue_component_base #(
  .BASE           (BASE           ),
  .CONFIGURATION  (CONFIGURATION  ),
  .STATUS         (STATUS         )
);
  typedef tue_sequencer_base #(
    BASE, CONFIGURATION, STATUS, PROXY_CONFIGURATION, PROXY_STATUS
  ) this_type;

  typedef tue_component_proxy #(
    this_type, PROXY_CONFIGURATION, PROXY_STATUS
  ) this_proxy;

  protected bit enable_default_sequence = 1;

  function new(string name = "tue_sequencer", uvm_component parent = null);
    super.new(name, parent);
    void'(this_proxy::create_component_proxy(this));
  endfunction

  function void set_enable_default_sequence(bit value);
    enable_default_sequence = value;
  endfunction

  function bit get_enable_default_sequence();
    return enable_default_sequence;
  endfunction

  function void start_phase_sequence(uvm_phase phase);
    if (enable_default_sequence) begin
      super.start_phase_sequence(phase);
    end
  endfunction

  function bit has_default_sequence(string phase);
    return uvm_config_db #(uvm_object_wrapper)::exists(this, phase, "default_sequence");
  endfunction

  function void set_default_sequence(
    string              phase,
    uvm_object_wrapper  default_sequence,
    bit                 override  = 0
  );
    if ((!override) && has_default_sequence(phase)) begin
      return;
    end

    uvm_config_db #(uvm_object_wrapper)::set(this, phase, "default_sequence", default_sequence);
  endfunction
endclass

class tue_sequencer #(
  type  CONFIGURATION       = tue_configuration_dummy,
  type  STATUS              = tue_status_dummy,
  type  REQ                 = uvm_sequence_item,
  type  RSP                 = REQ,
  type  PROXY_CONFIGURATION = CONFIGURATION,
  type  PROXY_STATUS        = STATUS
) extends tue_sequencer_base #(
  .BASE                 (uvm_sequencer #(REQ, RSP)  ),
  .CONFIGURATION        (CONFIGURATION              ),
  .STATUS               (STATUS                     ),
  .PROXY_CONFIGURATION  (PROXY_CONFIGURATION        ),
  .PROXY_STATUS         (PROXY_STATUS               )
);
  `tue_component_default_constructor(tue_sequencer)
  `uvm_component_param_utils(tue_sequencer #(
    CONFIGURATION, STATUS, REQ, RSP, PROXY_CONFIGURATION, PROXY_STATUS
  ))
endclass
`endif
