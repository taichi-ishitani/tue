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
`ifndef TUE_REG_SVH
`define TUE_REG_SVH
class tue_reg extends uvm_reg;
  function new(string name = "", int unsigned n_bits, int has_coverage);
    super.new(name, n_bits, has_coverage);
  endfunction

`ifdef XILINX_SIMULATOR
  function void do_predict(
    uvm_reg_item      rw,
    uvm_predict_e     kind  = UVM_PREDICT_DIRECT,
    uvm_reg_byte_en_t be    = -1
  );
    uvm_reg_data_t  value;
    uvm_reg_field   fields[$];
    tue_reg_field   field;
    int             width;
    int             bit_pos;

    if (is_busy() && (kind == UVM_PREDICT_DIRECT)) begin
      `uvm_warning(
        "RegModel",
        $sformatf(
          "Trying to predict value of register '%s' while it is being accessed",
          get_full_name()
        )
      )
      rw.status = UVM_NOT_OK;
      return;
    end

    value = rw.value[0];
    get_fields(fields);
    foreach (fields[i]) begin
      if ($cast(field, fields[i])) begin
        width       = field.get_n_bits();
        bit_pos     = field.get_lsb_pos();
        rw.value[0] = (value >> bit_pos) & ((1 << width) - 1);
        field.do_predict(rw, kind, be >> (bit_pos / 8));
      end
      else begin
        width       = fields[i].get_n_bits();
        bit_pos     = fields[i].get_lsb_pos();
        rw.value[0] = (value >> bit_pos) & ((1 << width) - 1);
        fields[i].do_predict(rw, kind, be >> (bit_pos / 8));
      end
    end

    rw.value[0] = value;
  endfunction
`endif

  virtual function bit is_writable(uvm_reg_map map = null);
    foreach (m_fields[i]) begin
      if (is_field_writable(m_fields[i], map)) begin
        return 1;
      end
    end
    return 0;
  endfunction

  virtual function bit is_readable(uvm_reg_map map = null);
    foreach (m_fields[i]) begin
      if (is_field_readable(m_fields[i], map)) begin
        return 1;
      end
    end
    return 0;
  endfunction

  virtual function uvm_reg_frontdoor create_frontdoor();
    return null;
  endfunction

  protected virtual function bit is_field_writable(uvm_reg_field field, uvm_reg_map map);
    tue_reg_field temp;
    if ($cast(temp, field)) begin
      return temp.is_writable(map);
    end
    else begin
      string  access  = field.get_access(map);
      if (access == "NOACCESS") begin
        return 0;
      end
      else begin
        return !(access inside {"RO","RC","RS"});
      end
    end
  endfunction

  protected virtual function bit is_field_readable(uvm_reg_field field, uvm_reg_map map);
    tue_reg_field temp;
    if ($cast(temp, field)) begin
      return temp.is_readable(map);
    end
    else begin
      string  access  = field.get_access(map);
      if (access == "NOACCESS") begin
        return 0;
      end
      else begin
        return !(access inside {"WO", "WOC", "WOS", "WO1"});
      end
    end
  endfunction
endclass
`endif
