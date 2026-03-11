library verilog;
use verilog.vl_types.all;
entity shiftLeft2 is
    port(
        Q               : in     vl_logic_vector(25 downto 0);
        Qplus           : out    vl_logic_vector(27 downto 0)
    );
end shiftLeft2;
