class my_sequence extends uvm_sequence;
    `uvm_object_utils(my_sequence)

    seq_item item;

    function new(string name = "my_sequence");
        super.new(name);
    endfunction

    task body();
        `uvm_info(get_type_name(), "Body of Sequence", UVM_FULL)
        item = seq_item::type_id::create("item");
        start_item(item);
        randomize_item : assert(item.randomize() 
                        with { data_in dist {32'd0 := 33, 
                                             [32'd1:32'd4294967294] :/ 34, 
                                             32'd4294967295 := 33}; });
        finish_item(item);
    endtask
endclass