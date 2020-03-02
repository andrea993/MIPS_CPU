library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity ProgramCounter is
	port (
		CLK		:	in		std_logic;
		RST		:	in		std_logic;
		nextAddr	:	in		std_logic_vector(31 downto 0);
		currAddr	:	out	std_logic_vector(31 downto 0)
	);
end;

Architecture s of ProgramCounter is
begin
	process(CLK, RST) 
	begin
		if RST = '1' then
			currAddr <= (others => '0');
		elsif rising_edge(CLK) then
			currAddr <= nextAddr;
		end if;
	end process;
end;
