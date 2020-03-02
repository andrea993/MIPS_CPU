library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TB is
	end TB;

architecture s of TB is

	signal CLK, RST_PC, RST_PL	:	std_logic;

begin
	DUT: entity work.MIPSCPU
	port map (
					CLK			=>	CLK,
					RST_PC		=>	RST_PC,
					RST_PL		=>	RST_PL
				);

	clock: process
		variable clk_state : std_logic := '0';
	begin
		clk_state := not clk_state;
		CLK <= clk_state;
		wait for 10 ns;
	end process;

	reset: process
	begin
		RST_PC	<= '1';
		RST_PL	<= '1';
		wait for 1 ns;

		RST_PC <= '0';
		RST_PL <= '0';
		wait;

	end process;


	end s;




