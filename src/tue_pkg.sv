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
`ifndef TUE_PKG_SV
`define TUE_PKG_SV

`include  "tue_macros.svh"

package tue_pkg;
  import  uvm_pkg::*;

  `tue_include_file(base, tue_version.svh        )
  `tue_include_file(base, tue_configuration.svh  )
  `tue_include_file(base, tue_status.svh         )
  `tue_include_file(base, tue_check_type.svh     )
  `tue_include_file(base, tue_object_base.svh    )
  `tue_include_file(base, tue_component_base.svh )
  `tue_include_file(base, tue_component_proxy.svh)
  `tue_include_file(base, tue_component.svh      )

  `tue_include_file(comps, tue_subscriber.svh )
  `tue_include_file(comps, tue_monitor.svh    )
  `tue_include_file(comps, tue_driver.svh     )
  `tue_include_file(comps, tue_scoreboard.svh )
  `tue_include_file(comps, tue_agent.svh      )
  `tue_include_file(comps, tue_env.svh        )
  `tue_include_file(comps, tue_test.svh       )

  `tue_include_file(seq, tue_sequence_item.svh)
  `tue_include_file(seq, tue_sequence.svh     )
  `tue_include_file(seq, tue_sequencer.svh    )

  `tue_include_file(comps, tue_param_monitor.svh)
  `tue_include_file(comps, tue_param_agent.svh  )

  `tue_include_file(seq  , tue_reactive_sequencer.svh)
  `tue_include_file(seq  , tue_reactive_sequence.svh )
  `tue_include_file(comps, tue_reactive_monitor.svh  )
  `tue_include_file(comps, tue_reactive_agent.svh    )
endpackage
`endif
