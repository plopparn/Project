library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity cpu is
    Port (
        clk : in STD_LOGIC;
        update : in STD_LOGIC;
        ax : in STD_LOGIC_VECTOR(3 downto 0);
        opcode : in STD_LOGIC_VECTOR(3 downto 0);
        result_add : in STD_LOGIC_VECTOR(4 downto 0);
        result_mult : in STD_LOGIC_VECTOR(7 downto 0);
        result_not : in STD_LOGIC_VECTOR(3 downto 0);
        result_and : in STD_LOGIC_VECTOR(3 downto 0);
        result_or : in STD_LOGIC_VECTOR(3 downto 0);
        A : out STD_LOGIC_VECTOR(3 downto 0);
        B : out STD_LOGIC_VECTOR(3 downto 0);
        C : out STD_LOGIC_VECTOR(3 downto 0);
        D : out STD_LOGIC_VECTOR(3 downto 0);
        input1 : inout STD_LOGIC_VECTOR(3 downto 0);
        input2 : inout STD_LOGIC_VECTOR(3 downto 0);
        execute: in STD_LOGIC
        );
end cpu;

architecture Behavioral of CPU is

signal bx, cx, dx: STD_LOGIC_VECTOR(3 downto 0);

begin

    U1: process(clk)
    begin
        -- only execute when execute trigger (button) is pressed
        if rising_edge(clk) AND (execute = '1') then
        
            input1 <= "0000"; -- clear the inputs
            input2 <= "0000"; -- clear the inputs
        
            case opcode is
                when "0000" => bx <= ax; -- assign b
                when "0001" => cx <= ax; -- assign c
                when "0010" => dx <= ax; -- assign d
                when "0011" => bx <= "0000"; -- clear b
                when "0100" => cx <= "0000"; -- clear c
                when "0101" => dx <= "0000"; -- clear d
                when "0110" => -- Test add
                    input1 <= "0010";
                    input2 <= "0011";
                    cx <= result_add(3 downto 0);
                    dx <= "000"&result_add(4); -- carry out
                when "0111" => -- test mult
                    input1 <= "0010";
                    input2 <= "0011";
                    cx <= result_mult(3 downto 0);
                    dx <= result_mult(7 downto 4);
                when "1000" => -- test invert
                    input1 <= "0010";
                    cx <= result_not;
                    dx <= "1101";
                when "1001" => -- test and
                    input1 <= "0010";
                    input2 <= "0011";
                    cx <= result_and;
                    dx <= "0010";
                when "1010" => -- test or
                    input1 <= "0010";
                    input2 <= "0011";
                    cx <= result_or;
                    dx <= "0011";
                when "1011" => -- AX + BX
                    input1 <= ax;
                    input2 <= bx;
                    cx <= result_add(3 downto 0);
                    dx <= "000"&result_add(4);
                when "1100" => -- AX * BX
                    input1 <= ax;
                    input2 <= bx;
                    cx <= result_mult(3 downto 0);
                    dx <= result_mult(7 downto 4);
                when "1101" =>
                    input1 <= ax;
                    input2 <= bx;
                    cx <= result_not;
                    dx <= "0000";
                when "1110" =>
                    input1 <= ax;
                    input2 <= bx;
                    cx <= result_and;
                    dx <= "0000";
                when "1111" =>
                    input1 <= ax;
                    input2 <= bx;
                    cx <= result_or;
                    dx <= "0000";
                when others =>
                    cx <= (others => '0');
            end case;
        end if;
    end process;
    
    -- connect results
    a <= ax; -- to always show the value of ax
    b <= bx;
    c <= cx;
    d <= dx;
    
end Behavioral;
