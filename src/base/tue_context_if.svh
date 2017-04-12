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
`ifndef TUE_CONTEXT_IF_SVH
`define TUE_CONTEXT_IF_SVH
interface class tue_context_if #(
  type  CONFIGURATION = tue_configuration_dummy,
  type  STATUS        = tue_status_dummy
);
  pure virtual function void set_configuration(tue_configuration configuration);
  pure virtual function CONFIGURATION get_configuration();
  pure virtual function void set_status(tue_status status);
  pure virtual function STATUS get_status();
endclass
`endif
