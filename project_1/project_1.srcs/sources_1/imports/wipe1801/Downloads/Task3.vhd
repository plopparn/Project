library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cpu_top_module is
    Port (
       execute: in STD_LOGIC;
       ax   : in STD_LOGIC_VECTOR (3 downto 0);
       opcode : in STD_LOGIC_VECTOR (3 downto 0);
       clk : in  STD_LOGIC;
       btnc : in STD_LOGIC;
       topselDispA : out  STD_LOGIC;
       topselDispB : out  STD_LOGIC;
       topselDispC : out  STD_LOGIC;
       topselDispD : out  STD_LOGIC;
       topsegA : out  STD_LOGIC;
       topsegB : out  STD_LOGIC;
       topsegC : out  STD_LOGIC;
       topsegD : out  STD_LOGIC;
       topsegE : out  STD_LOGIC;
       topsegF : out  STD_LOGIC;
       topsegG : out  STD_LOGIC);
end cpu_top_module;

architecture rtl of cpu_top_module is

component segmentdriver 
	Port( 
			display_A : in STD_LOGIC_VECTOR  (3 downto 0);
			display_B : in STD_LOGIC_VECTOR  (3 downto 0);
			display_C : in STD_LOGIC_VECTOR  (3 downto 0);
			display_D : in STD_LOGIC_VECTOR  (3 downto 0);
			segA : out STD_LOGIC;
			segB : out STD_LOGIC;
			segC : out STD_LOGIC;
			segD : out STD_LOGIC;
			segE : out STD_LOGIC;
			segF : out STD_LOGIC;
			segG : out STD_LOGIC;
			select_Display_A : out STD_LOGIC; 
			select_Display_B : out STD_LOGIC; 
			select_Display_C : out STD_LOGIC; 
			select_Display_D : out STD_LOGIC;
			clk : in STD_LOGIC
		);
end component;

component add4 is
    port (in_1, in_2 : in std_logic_vector(3 downto 0);
        s_out : out std_logic_vector(4 downto 0));
end component;

component mul4 is
    port (in_1, in_2 : in std_logic_vector(3 downto 0);
        m_out : out std_logic_vector(7 downto 0));
end component;

component invrt4 is
    port (in_1 : in std_logic_vector(3 downto 0);
        i_out : out std_logic_vector(3 downto 0));
end component;

component bit_and4 is
    port (in_1 : in std_logic_vector(3 downto 0);
        in_2 : in std_logic_vector(3 downto 0);
        a_out : out std_logic_vector(3 downto 0));
end component;        

component bit_or4 is
    port (in_1 : in std_logic_vector(3 downto 0);
        in_2 : in std_logic_vector(3 downto 0);
        o_out : out std_logic_vector(3 downto 0));
end component;

component cpu 
    Port (
       clk          : in STD_LOGIC;
       update       : in  STD_LOGIC;
       ax           : in STD_LOGIC_VECTOR (3 downto 0);
       opcode       : in STD_LOGIC_VECTOR (3 downto 0);
       result_add   : in STD_LOGIC_VECTOR (4 downto 0);
       result_mult  : in STD_LOGIC_VECTOR (7 downto 0);
       result_not   : in STD_LOGIC_VECTOR (3 downto 0);
       result_and   : in STD_LOGIC_VECTOR (3 downto 0);
       result_or    : in STD_LOGIC_VECTOR (3 downto 0);
       A            : out  STD_LOGIC_VECTOR (3 downto 0);
       B            : out  STD_LOGIC_VECTOR (3 downto 0);
       C            : out  STD_LOGIC_VECTOR (3 downto 0);
       D            : out  STD_LOGIC_VECTOR (3 downto 0);
       input1       : inout  STD_LOGIC_VECTOR (3 downto 0);
       input2       : inout  STD_LOGIC_VECTOR (3 downto 0);
       execute       : in STD_LOGIC
       );
end component;

    signal input1 : STD_LOGIC_VECTOR  (3 downto 0);
    signal input2 : STD_LOGIC_VECTOR (3 downto 0);
    signal add_res: STD_LOGIC_VECTOR (4 downto 0);
    signal mul_res: STD_LOGIC_VECTOR (7 downto 0);
    signal inv_res: STD_LOGIC_VECTOR (3 downto 0);
    signal and_res: STD_LOGIC_VECTOR (3 downto 0);
    signal or_res: STD_LOGIC_VECTOR (3 downto 0);
    signal ax_temp: STD_LOGIC_VECTOR (3 downto 0):="0000";
    signal bx: STD_LOGIC_VECTOR (3 downto 0):="0000";
    signal cx: STD_LOGIC_VECTOR (3 downto 0):="0000";
    signal dx: STD_LOGIC_VECTOR (3 downto 0):="0000";

begin

    U0 : segmentDriver PORT MAP(
            display_A => ax_temp,
            display_B => bx,
            display_C => cx,
            display_D => dx,
            segA => topsegA,
            segB => topsegB,
            segC => topsegC,
            segD => topsegD,
            segE => topsegE,
            segF => topsegF,
            segG => topsegG,
            select_Display_A => topselDispA,
            select_Display_B => topselDispB,
            select_Display_C => topselDispC,
            select_Display_D => topselDispD,
            clk => clk
        );    
        
    U1 : add4 port map (
            in_1 => input1, 
            in_2 => input2, 
            s_out => add_res
            );
            
    U2 : mul4 port map (
            in_1 => input1, 
            in_2 => input2, 
            m_out => mul_res
            );
            
    U3 : invrt4 port map (
            in_1 => input1, 
            i_out => inv_res
            );
            
    U4 : bit_and4 port map (
            in_1 => input1, 
            in_2 => input2, 
            a_out => and_res
            );

    U5 : bit_or4 port map (
            in_1 => input1, 
            in_2 => input2, 
            o_out => or_res
            );
            
    U6 : cpu Port Map(
            clk           => clk,
            update       => btnc,
            ax           => ax,
            opcode       => opcode,
            result_add   => add_res,
            result_mult  => mul_res,
            result_not   => inv_res,
            result_and   => and_res,
            result_or    => or_res,
            A             => ax_temp,
            B             => bx,
            C             => cx,
            D             => dx,
            input1       => input1,
            input2       => input2,
            execute      => execute
            );
    
end rtl;
