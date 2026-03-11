library verilog;
use verilog.vl_types.all;
entity shiftLeft2_vlg_check_tst is
    port(
        Qplus           : in     vl_logic_vector(27 downto 0);
        sampler_rx      : in     vl_logic
    );
end shiftLeft2_vlg_check_tst;
