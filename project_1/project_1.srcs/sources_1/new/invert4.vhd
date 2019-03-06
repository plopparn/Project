library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity invrt4 is

Port ( in_1 : in STD_LOGIC_VECTOR (3 downto 0);
i_out : out STD_LOGIC_VECTOR (3 downto 0));

end invrt4;

architecture Behavioral of invrt4 is

begin
i_out <= NOT ( in_1 );

end Behavioral;