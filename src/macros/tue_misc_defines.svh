//------------------------------------------------------------------------------
//  Copyright 2022 Taichi Ishitani
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
`ifndef TUE_MISC_DEFINES_SVH
`define TUE_MISC_DEFINES_SVH

`define tue_current_time $rtoi($realtime)

`define tue_randomize_with(HANDLE, CONSTRAINT) \
begin \
  if (!HANDLE.randomize() with CONSTRAINT) begin \
    `uvm_fatal("RNDFLD", "Randomization failed in tue_randomize_with action") \
  end \
end

`define tue_allocate_address(ADDRESS, ALLOCATOR, CONSTRAINT) \
begin \
  if (!ALLOCATOR.randomize() with CONSTRAINT) begin \
    `uvm_fatal("ALLOCFLD", "Address allocation failed") \
  end \
  ADDRESS = ALLOCATOR.address; \
end

`endif
