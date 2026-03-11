library verilog;
use verilog.vl_types.all;
entity signExtend is
    port(
        Q               : in     vl_logic_vector(15 downto 0);
        Qplus           : out    vl_logic_vector(31 downto 0)
    );
end signExtend;
