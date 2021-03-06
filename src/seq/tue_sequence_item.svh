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
`ifndef TUE_SEQUENCE_ITEM_SVH
`define TUE_SEQUENCE_ITEM_SVH
class tue_sequence_item #(
  type  CONFIGURATION       = tue_configuration_dummy,
  type  STATUS              = tue_status_dummy,
  type  PROXY_CONFIGURATION = CONFIGURATION,
  type  PROXY_STATUS        = STATUS
) extends tue_sequence_item_base #(
  uvm_sequence_item, CONFIGURATION, STATUS, PROXY_CONFIGURATION, PROXY_STATUS
);
  `tue_object_default_constructor(tue_sequence_item)
endclass
`endif
