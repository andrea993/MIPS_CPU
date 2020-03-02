library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity ALU is 
	port (
		OP_idx		: in std_logic_vector(3 downto 0);
		In1			: in std_logic_vector(31 downto 0);
		In2			: in std_logic_vector(31 downto 0);
		OutZ			: out std_logic;
		OutRes		: out std_logic_vector(31 downto 0)
	);
end ALU;

architecture s of ALU is
	signal res : std_logic_vector(31 downto 0);
	begin
		process(OP_idx, In1 ,In2)
		begin
			case OP_idx is
				when "0000" =>
					res <= std_logic_vector(signed(In1) + signed(In2)); 
				when "0001" => 
					res <= std_logic_vector(signed(In1) - signed(In2));
				when "0010" =>
					res <= std_logic_vector(signed(In1) AND signed(In2));
				when "0011" =>
					res <= std_logic_vector(signed(In1) OR signed(In2));
				when "0100" =>
					res <= std_logic_vector(shift_left(unsigned(In1), to_integer(unsigned(In2)))); 
 
				when "0101" =>
					res <= std_logic_vector(shift_right(unsigned(In1), to_integer(unsigned(In2))));
				when others => 
					res <= (others => '0');
			end case;
		end process;
		OutZ <= '1' when res=x"00000000" else '0';
		OutRes <= res;
end s;


				
