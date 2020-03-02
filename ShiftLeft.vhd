library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity ShiftLeft is
	generic (
		inputNbits	:	natural := 32;
		outputNbits	:	natural := 32;
		shiftNbits	:	natural	:=	2
	);
	port (
		input_val	:	in		std_logic_vector(inputNbits-1 downto 0);
		output_val	:	out	std_logic_vector(outputNbits-1 downto 0)
	);
end ShiftLeft;


Architecture s of ShiftLeft is
	signal input_tmp : std_logic_vector(outputNbits-1 downto 0);
begin
	input_tmp	<=	std_logic_vector(resize(unsigned(input_val), outputNbits));
	output_val	<= std_logic_vector(unsigned(input_tmp) sll shiftNbits);
	--output_val <= std_logic_vector(shift_left(unsigned(input_val), 2)); 
end s;

