class coverage extends uvm_subscriber#(seq_item);
    `uvm_component_utils(coverage)

    seq_item item;

    covergroup input_cg;
        en_cp : coverpoint item.en;
        addr_cp : coverpoint item.addr;
        data_in_cp : coverpoint item.data_in {
            bins all_ones  = {32'hFFFFFFFF};
            bins all_zeros = {32'h00000000};
        }
        addr_en_cx : cross  addr_cp, en_cp {
            bins addr_0  = binsof(addr_cp) intersect {0}  && binsof(en_cp) intersect {1};
            bins addr_1  = binsof(addr_cp) intersect {1}  && binsof(en_cp) intersect {1};
            bins addr_2  = binsof(addr_cp) intersect {2}  && binsof(en_cp) intersect {1};
            bins addr_3  = binsof(addr_cp) intersect {3}  && binsof(en_cp) intersect {1};
            bins addr_4  = binsof(addr_cp) intersect {4}  && binsof(en_cp) intersect {1};
            bins addr_5  = binsof(addr_cp) intersect {5}  && binsof(en_cp) intersect {1};
            bins addr_6  = binsof(addr_cp) intersect {6}  && binsof(en_cp) intersect {1};
            bins addr_7  = binsof(addr_cp) intersect {7}  && binsof(en_cp) intersect {1};
            bins addr_8  = binsof(addr_cp) intersect {8}  && binsof(en_cp) intersect {1};
            bins addr_9  = binsof(addr_cp) intersect {9}  && binsof(en_cp) intersect {1};
            bins addr_10 = binsof(addr_cp) intersect {10} && binsof(en_cp) intersect {1};
            bins addr_11 = binsof(addr_cp) intersect {11} && binsof(en_cp) intersect {1};
            bins addr_12 = binsof(addr_cp) intersect {12} && binsof(en_cp) intersect {1};
            bins addr_13 = binsof(addr_cp) intersect {13} && binsof(en_cp) intersect {1};
            bins addr_14 = binsof(addr_cp) intersect {14} && binsof(en_cp) intersect {1};
            bins addr_15 = binsof(addr_cp) intersect {15} && binsof(en_cp) intersect {1};

            ignore_bins enable_off = binsof(en_cp) intersect {0};
        }
    endgroup

    function new(string name, uvm_component parent);
        super.new(name, parent);
        input_cg = new();
    endfunction

    function void write(seq_item t);
        item = t;
        input_cg.sample();
    endfunction
endclass