library verilog;
use verilog.vl_types.all;
entity PC is
    port(
        Qin             : in     vl_logic_vector(31 downto 0);
        load            : in     vl_logic;
        clk             : in     vl_logic;
        Qout            : out    vl_logic_vector(31 downto 0)
    );
end PC;
