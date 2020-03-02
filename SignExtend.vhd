library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity SignExtend is
	port (
	  input_val		:	in		std_logic_vector(15 downto 0);
	  output_val	:	out	std_logic_vector(31 downto 0)
  );
end SignExtend;

architecture s of SignExtend is
begin
	output_val <= std_logic_vector(resize(signed(input_val), output_val'length));
end s;
