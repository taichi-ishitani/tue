package sample_pkg;
  import  uvm_pkg::*;
  import  tue_pkg::*;
  `include  "tue_macros.svh"

  class sample_configuration #(type T = bit) extends tue_configuration;
    T v;
    `tue_object_default_constructor(sample_configuration)
    `uvm_object_param_utils(sample_configuration)
  endclass

  class sample_status #(type T = bit) extends tue_status;
    T v;
    `tue_object_default_constructor(sample_status)
    `uvm_object_param_utils(sample_status)
  endclass

  class sample_item extends tue_sequence_item #(sample_configuration, sample_status);
    rand  bit [1:0] v;

    constraint c {
      v == {status.v, configuration.v};
    };

      `tue_object_default_constructor(sample_item)
  endclass

  typedef tue_sequencer #(sample_configuration, sample_status, sample_item) sample_sequencer;

  class sample_test extends tue_test #(sample_configuration, sample_status);
    sample_sequencer      sequencer;

    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      sequencer     = sample_sequencer::type_id::create("sequencer", this);
      sequencer.set_configuration(configuration);
      sequencer.set_status(status);
    endfunction

    task run_phase(uvm_phase phase);
      for (int i = 0;i < 4;i++) begin
        sample_item item;
        item  = new();
        item.set_item_context(null, sequencer);
        configuration.v = i[0];
        status.v        = i[1];
        if (item.randomize()) begin
          if (item.v != i) begin
            `uvm_fatal(get_name(), "Error!")
          end
        end
        else begin
          `uvm_fatal(get_name(), "randomize failed")
        end
      end
    endtask

    `tue_component_default_constructor(sample_test)
    `uvm_component_utils(sample_test)
  endclass
endpackage

module test();
  import uvm_pkg::*;
  import sample_pkg::*;

  initial begin
    run_test("sample_test");
  end
endmodule
