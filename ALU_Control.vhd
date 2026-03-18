library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU_Control is
    port (
        ALUOp      : in  std_logic_vector(1 downto 0);
        Funct      : in  std_logic_vector(3 downto 0);
        ALU_select : out std_logic_vector(3 downto 0) -- Output to ALU
    );
end ALU_Control;

architecture RTL of ALU_Control is
    
begin
    -- Combinational Logic for ALU Selection bits (Standard MIPS Mapping)
    -- Bit 3 is usually 0 for basic operations
    ALU_select(3) <= '0';

    -- Bit 2: High for SUBTRACT or SLT (Funct(1) is '1' and Funct(2) is '0')
    ALU_select(2) <= ALUOp(0) or (ALUOp(1) and Funct(1));

    -- Bit 1: High for ADD, SUBTRACT, or SLT (Funct(2) is '0')
    ALU_select(1) <= (not ALUOp(1)) or (not Funct(2));

    -- Bit 0: High for OR or SLT (Funct(0) and Funct(3) are active)
    ALU_select(0) <= (ALUOp(1) and (Funct(0) or Funct(3)));

end architecture RTL;