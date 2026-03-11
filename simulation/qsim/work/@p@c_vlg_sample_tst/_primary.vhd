library verilog;
use verilog.vl_types.all;
entity PC_vlg_sample_tst is
    port(
        clk             : in     vl_logic;
        load            : in     vl_logic;
        Qin             : in     vl_logic_vector(31 downto 0);
        sampler_tx      : out    vl_logic
    );
end PC_vlg_sample_tst;
