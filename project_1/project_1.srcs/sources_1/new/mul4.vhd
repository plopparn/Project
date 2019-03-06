----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.02.2019 15:06:18
-- Design Name: 
-- Module Name: multi - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
entity mul4 is 
Port ( in_1 : in STD_LOGIC_VECTOR (3 downto 0);
in_2 : in STD_LOGIC_VECTOR (3 downto 0); 
m_out : out STD_LOGIC_VECTOR (7 downto 0)); 
end mul4;

architecture Behavioral of mul4 is

begin
m_out <= (in_1*in_2);

end Behavioral;