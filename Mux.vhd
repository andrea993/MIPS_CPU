library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity Mux is
	generic (
		Nbits : natural := 32
	);
	port (
		input_val_1	:	in		std_logic_vector(Nbits-1 downto 0);
		input_val_2	:	in		std_logic_vector(Nbits-1 downto 0);
		selector		:	in		std_logic;
		output_val	:	out	std_logic_vector(Nbits-1 downto 0)
	);
end Mux;

Architecture s of Mux is
begin
	output_val <= input_val_1 when selector = '0' else input_val_2;
end s;



