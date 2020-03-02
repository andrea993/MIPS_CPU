library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity Adder is
	port (
		input_val_1	:	in		std_logic_vector(31 downto 0);
		input_val_2	:	in		std_logic_vector(31 downto 0);
		output_val	:	out	std_logic_vector(31 downto 0)
	);
end Adder;

Architecture s of Adder is
begin
	output_val <= input_val_1 + input_val_2;
end s;
