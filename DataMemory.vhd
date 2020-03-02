library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity DataMemory is 
	port (
		WriteData	:	in		std_logic_vector(31 downto 0);
		ReadData		: 	out	std_logic_vector(31 downto 0);
		Address		:	in		std_logic_vector(31 downto 0);
		MemWrite		:	in		std_logic;
		MemRead		:	in		std_logic
	);
end DataMemory;

architecture s of DataMemory is
type vector_of_mem is array(0 to 15) of std_logic_vector (31 downto 0);
signal dataMem	:	vector_of_mem;

begin
	process(MemRead, MemWrite)
	begin
		if MemRead = '1' then
			ReadData <= dataMem(to_integer(unsigned(Address)));
		end if;
		
		if MemWrite = '1' then
			dataMem(to_integer(unsigned(Address))) <= WriteData;
		end if;
	end process;
end s;
