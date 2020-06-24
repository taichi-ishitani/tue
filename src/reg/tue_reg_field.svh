//------------------------------------------------------------------------------
//  Copyright 2020 Taichi Ishitani
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
`ifndef TUE_REG_FIELD_SVH
`define TUE_REG_FIELD_SVH
class tue_reg_field extends uvm_reg_field;
`ifdef TUE_UVM_PRE_IEEE
  virtual function string get_access(uvm_reg_map map = null);
    string  access;
    uvm_reg parent;

    access  = super.get_access(uvm_reg_map::backdoor());
    if (map == uvm_reg_map::backdoor()) begin
      return access;
    end

    parent  = get_parent();
    if (parent.get_rights(map) == "WO") begin
      case (access)
        "RW":     return "WO";
        "WRC":    return "WO";
        "WRS":    return "WO";
        "W1SRC":  return "W1S";
        "W0SRC":  return "W0S";
        "W1CRS":  return "W1C";
        "W0CRS":  return "W0C";
        "WCRS":   return "WC";
        "WSRC":   return "WS";
        "WO":     return access;
        "WC":     return access;
        "WS":     return access;
        "W1C":    return access;
        "W1S":    return access;
        "W0C":    return access;
        "W0S":    return access;
        "W0T":    return access;
        "W1":     return access;
        "WO1":    return access;
      endcase
    end

    return super.get_access(map);
  endfunction
`endif

  virtual function bit is_writable(uvm_reg_map map = null);
    string  access  = get_access(map);
    return !(access inside {"NOACCESS", "RO", "RC", "RS"});
  endfunction

  virtual function bit is_readable(uvm_reg_map map = null);
    string  access  = get_access(map);
    return !(access inside {"NOACCESS", "WO", "WOC", "WOS", "WO1"});
  endfunction

  `tue_object_default_constructor(tue_reg_field)
endclass
`endif
