library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU_Control is
    port (
        ALUOp      : in  std_logic_vector(1 downto 0);
        Funct      : in  std_logic_vector(5 downto 0);
        ALU_select : out std_logic_vector(3 downto 0) -- Output to ALU
    );
end ALU_Control;

architecture RTL of ALU_Control is
    -- Internal signals for funct field bits for easier readability
    signal f0, f1, f2, f3 : std_logic;
begin

    f0 <= Funct(0);
    f1 <= Funct(1);
    f2 <= Funct(2);
    f3 <= Funct(3);

    -- Combinational Logic for ALU Selection bits (Standard MIPS Mapping)
    -- Bit 3 is usually 0 for basic operations
    ALU_select(3) <= '0';

    -- Bit 2: High for SUBTRACT or SLT (f1 is '1' and f2 is '0')
    ALU_select(2) <= ALUOp(0) or (ALUOp(1) and f1);

    -- Bit 1: High for ADD, SUBTRACT, or SLT (f2 is '0')
    ALU_select(1) <= (not ALUOp(1)) or (not f2);

    -- Bit 0: High for OR or SLT (f0 and f3 are active)
    ALU_select(0) <= (ALUOp(1) and (f0 or f3));

end architecture RTL;