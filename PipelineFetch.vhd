library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity PipelineFetch is
	port (
		CLK						:	in		std_logic;
		RST						:	in		std_logic;
		input_PC					:	in		std_logic_vector(31 downto 0);
		input_instruction		:	in		std_logic_vector(31 downto 0);
		output_PC				:	out	std_logic_vector(31 downto 0);
		output_instruction	:	out	std_logic_vector(31 downto 0)
	);
end PipelineFetch;

Architecture s of PipelineFetch is
signal sInstruction, sPC : std_logic_vector(31 downto 0);
begin
	process (CLK, RST)
	begin
		if	RST = '1' then
			sInstruction <= (others => '0');
			sPC <= (others => '0');
		end if;

		if rising_edge(CLK) then
			sInstruction <= input_instruction;
			sPC <= input_PC;
		end if;
	end process;

	output_PC <= sPC;
	output_instruction <= sInstruction;
end s;
	
	
	

