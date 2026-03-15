library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU is
    port (
        SrcA       : in  std_logic_vector(31 downto 0);
        SrcB       : in  std_logic_vector(31 downto 0);
        ALUControl : in  std_logic_vector(3 downto 0);
        ALUResult  : out std_logic_vector(31 downto 0);
        Zero       : out std_logic
    );
end ALU;

architecture Structural of ALU is
    -- Internal signals for each operation's result
    signal sum, diff, and_res, or_res, slt_res : std_logic_vector(31 downto 0);
    signal final_result : std_logic_vector(31 downto 0);
begin

    -- 1. PRE-CALCULATE ALL OPERATIONS (The "Functional Units")
    
    -- Bitwise Logic
    and_res <= SrcA and SrcB;
    or_res  <= SrcA or SrcB;

    -- Arithmetic (Addition and Subtraction)
    sum  <= std_logic_vector(unsigned(SrcA) + unsigned(SrcB));
    diff <= std_logic_vector(unsigned(SrcA) - unsigned(SrcB));

    -- Comparison (Set on Less Than)
    -- If SrcA < SrcB, result is 1, else 0.
    slt_res <= x"00000001" when (signed(SrcA) < signed(SrcB)) else x"00000000";

    -- 2. THE BIG MULTIPLEXER (Operation Selection)
    -- This selects which pre-calculated result goes to the output
    final_result <= and_res when (ALUControl = "0000") else  -- AND
                    or_res  when (ALUControl = "0001") else  -- OR
                    sum     when (ALUControl = "0010") else  -- ADD
                    diff    when (ALUControl = "0110") else  -- SUB
                    slt_res when (ALUControl = "0111") else  -- SLT
                    x"00000000";                             -- Default

    -- 3. ZERO FLAG LOGIC
    -- The Zero flag is '1' if the result is exactly zero (used for BEQ)
    Zero <= '1' when (final_result = x"00000000") else '0';

    -- Drive the output port
    ALUResult <= final_result;

end architecture Structural;