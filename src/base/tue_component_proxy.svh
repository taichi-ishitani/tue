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
`ifndef TUE_COMPONENT_PROXY_SVH
`define TUE_COMPONENT_PROXY_SVH
virtual class tue_component_proxy_base #(
  type  CONFIGURATION = tue_configuration_dummy,
  type  STATUS        = tue_status_dummy
) extends uvm_component;
  pure virtual function void set_configuration(tue_configuration configuration);
  pure virtual function CONFIGURATION get_configuration();
  pure virtual function void set_status(tue_status status);
  pure virtual function STATUS get_status();
  pure virtual function void set_context(tue_configuration configuration, tue_status status);
  `tue_component_default_constructor(tue_component_proxy_base)
endclass

class tue_component_proxy #(
  type  CONFIGURATION = tue_configuration_dummy,
  type  STATUS        = tue_status_dummy,
  type  COMPONENT     = tue_component_base #(uvm_component, CONFIGURATION, STATUS)
) extends tue_component_proxy_base #(CONFIGURATION, STATUS);
  local COMPONENT component;

  function new(string name = "tue_component_proxy", uvm_component parent = null);
    super.new(name, parent);
    $cast(component, parent);
  endfunction

  function void set_configuration(tue_configuration configuration);
    component.set_configuration(configuration);
  endfunction

  function CONFIGURATION get_configuration();
    return component.get_configuration();
  endfunction

  function void set_status(tue_status status);
    component.set_status(status);
  endfunction

  function STATUS get_status();
    return component.get_status();
  endfunction

  function void set_context(tue_configuration configuration, tue_status status);
    component.set_context(configuration, status);
  endfunction
endclass
`endif
