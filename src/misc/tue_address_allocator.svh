//------------------------------------------------------------------------------
//  Copyright 2023 Taichi Ishitani
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
`ifndef TUE_ADDRESS_ALLOCATOR_SVH
`define TUE_ADDRESS_ALLOCATOR_SVH
class tue_address_allocator #(
  int ADDRESS_WIDTH = 64
) extends uvm_object;
  typedef bit [ADDRESS_WIDTH-1:0] tue_address;

  typedef struct {
    tue_address       address;
    longint unsigned  size;
  } tue_address_range;

  rand      tue_address       address;
  rand      longint unsigned  size;
  protected tue_address_range allocated_address[$];

  constraint c_valid_range {
    (address + size - 1) <= {ADDRESS_WIDTH{1'b1}};
  }

  constraint c_unique_address_range {
    foreach (allocated_address[i]) {
      !(address inside {[
        allocated_address[i].address:
        allocated_address[i].address+allocated_address[i].size-1
      ]});
      !(allocated_address[i].address inside {[
        address:
        address+size-1
      ]});
    }
  }

  function void post_randomize();
    add_allocated_address(address, size);
  endfunction

  function void clear();
    allocated_address.delete();
  endfunction

  function void add_allocated_address(tue_address address, longint unsigned size);
    tue_address_range range;
    range.address = address;
    range.size    = size;
    allocated_address.push_back(range);
  endfunction

  `tue_object_default_constructor(tue_address_allocator)
endclass
`endif
