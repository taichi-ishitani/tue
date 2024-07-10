//------------------------------------------------------------------------------
//  Copyright 2024 Taichi Ishitani
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
`ifndef TUE_ID_MANAGER_SVH
`define TUE_ID_MANAGER_SVH
class tue_id_manager #(
  type  ID  = int
) extends uvm_object;
  protected semaphore id_semaphore;
  protected ID        id_queue[$];

  function void init(int n_id = 0);
    int n;

    if (n_id > 0) begin
      n = n_id;
    end
    else begin
      n = 2**$bits(ID);
    end

    id_semaphore  = new(n);
    for (int i = 0;i < n;++i) begin
      id_queue.push_back(i);
    end
  endfunction

  task get_id(ref ID id);
    id_semaphore.get(1);
    id  = id_queue.pop_front();
  endtask

  function void release_id(ID id);
    id_queue.push_back(id);
    id_semaphore.put(1);
  endfunction

  `tue_object_default_constructor(tue_id_manager)
endclass
`endif
