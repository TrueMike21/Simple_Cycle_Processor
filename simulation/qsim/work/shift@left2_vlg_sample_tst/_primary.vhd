library verilog;
use verilog.vl_types.all;
entity shiftLeft2_vlg_sample_tst is
    port(
        Q               : in     vl_logic_vector(25 downto 0);
        sampler_tx      : out    vl_logic
    );
end shiftLeft2_vlg_sample_tst;
