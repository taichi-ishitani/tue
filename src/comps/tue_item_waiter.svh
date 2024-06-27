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
`ifndef TUE_ITEM_WAITER_SVH
`define TUE_ITEM_WAITER_SVH
class tue_item_param_key_waiter #(
  type  KEY = int
);
  KEY       key;
  uvm_event waiter;

  function new(KEY key);
    this.key    = key;
    this.waiter = new();
  endfunction
endclass

virtual class tue_item_waiter #(
  type  CONFIGURATION = uvm_object,
  type  STATUS        = uvm_object,
  type  ITEM          = uvm_sequence_item,
  type  KEY           = int
) extends tue_subscriber #(
  .CONFIGURATION  (CONFIGURATION  ),
  .STATUS         (STATUS         ),
  .T              (ITEM           )
);
  typedef tue_item_param_key_waiter #(
    .KEY  (KEY)
  ) tue_item_key_waiter;

  local uvm_event waiters[$];
  local bit       key_waiters[tue_item_key_waiter];

  function void write(ITEM t);
    tue_item_key_waiter triggered_waiters[$];

    foreach (waiters[i]) begin
      waiters[i].trigger(t);
    end
    waiters.delete();

    foreach (key_waiters[waiter]) begin
      if (match_key(waiter.key, t)) begin
        triggered_waiters.push_back(waiter);
        waiter.waiter.trigger(t);
      end
    end
    foreach (triggered_waiters[i]) begin
      key_waiters.delete(triggered_waiters[i]);
    end
  endfunction

  virtual task get_item(ref ITEM item);
    uvm_event waiter  = get_waiter();
    waiter.wait_on();
    $cast(item, waiter.get_trigger_data());
  endtask

  virtual task get_item_by_key(input KEY key, ref ITEM item);
    uvm_event waiter  = get_key_waiter(key);
    waiter.wait_on();
    $cast(item, waiter.get_trigger_data());
  endtask

  protected virtual function bit match_key(KEY key, ITEM item);
    `uvm_fatal("TUE_ITEM_WAITER", "match_key is not implemented")
    return 0;
  endfunction

  local function uvm_event get_waiter();
    uvm_event waiter  = new();
    waiters.push_back(waiter);
    return waiter;
  endfunction

  local function uvm_event get_key_waiter(KEY key);
    tue_item_key_waiter waiter  = new(key);
    key_waiters[waiter] = 1;
    return waiter.waiter;
  endfunction

  `tue_component_default_constructor(tue_item_waiter)
endclass
`endif
