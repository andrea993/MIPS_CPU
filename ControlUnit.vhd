library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity ControlUnit is
	port (
			  OP			:	in		std_logic_vector(5 downto 0);
			  funct		:	in		std_logic_vector(5 downto 0);

			  reg			:	out	std_logic;
			  jump		:	out	std_logic;
			  branch		:	out	std_logic;
			  memRead	:	out	std_logic;
			  memWrite	:	out	std_logic;
			  mem2reg	:	out	std_logic;
			  alu			:	out	std_logic;
			  regWrite	:	out	std_logic;
			  aluOP		:	out	std_logic_vector(3 downto 0)
		  );
end ControlUnit;

Architecture s of ControlUnit is
begin
	process(OP, funct)
	begin
		case OP is
			-- R-type
			when "000000" =>
				reg		<= '1';
				jump		<= '0';
				branch	<= '0';
				memRead	<= '0';
				memWrite <= '0';
				mem2reg	<= '0';
				regWrite	<= '1';

				case unsigned(funct) is
					when "110000" => -- add
						alu	<= '0';
						aluOP	<= "0000"; 
					when "110001" => -- sub
						alu	<= '0';
						aluOP	<= "0001"; 
					when "110010" => -- and
						alu	<= '0';
						aluOP	<= "0010"; 
					when "110011" => -- or
						alu	<= '0';
						aluOP	<= "0011"; 
					when "110100" => -- shift left 
						alu	<= '1';
						aluOP	<= "0100";
					when "110101" =>	-- shift right 
						alu	<= '1';
						aluOP	<= "0101"; 
					when others => -- reset pipeline
						alu	<= '0';
						aluOP	<= "1111";
				end case;

			-- Data transfer
			when "010000" => --load
				reg		<= '0';
				jump		<= '0';
				branch	<= '0';
				memRead	<= '1';
				memWrite <= '0';
				mem2reg	<= '1';
				regWrite	<= '1';
				alu		<= '1';
				aluOP		<= "0000";

			when "010001" => --store
				reg		<= '0';
				jump		<= '0';
				branch	<= '0';
				memRead	<= '0';
				memWrite <= '1';
				mem2reg	<= '1';
				regWrite	<= '0';
				alu		<= '1';
				aluOP		<= "0000";

			when "001000" => --add immediate
				reg		<= '0';
				jump		<= '0';
				branch	<= '0';
				memRead	<= '0';
				memWrite <= '0';
				mem2reg	<= '0';
				regWrite	<= '1';
				alu		<= '1';
				aluOP		<= "0000";

			when "001001" => --and immediate
				reg		<= '0';
				jump		<= '0';
				branch	<= '0';
				memRead	<= '0';
				memWrite <= '0';
				mem2reg	<= '0';
				regWrite	<= '1';
				alu		<= '1';
				aluOP		<= "0000";

			when "001010" => --or immediate
				reg		<= '0';
				jump		<= '0';
				branch	<= '0';
				memRead	<= '0';
				memWrite <= '0';
				mem2reg	<= '0';
				regWrite	<= '1';
				alu		<= '1';
				aluOP		<= "0011";

			--	Conditional branch "0001XX"
			when "000100" => --BEQ
				reg		<= '0';
				jump		<= '0';
				branch	<= '1';
				memRead	<= '0';
				memWrite <= '0';
				mem2reg	<= '1';
				regWrite	<= '0';
				alu		<= '0';
				aluOP		<= "0001";

			-- Unconditional jum "00001X"
			when "000010" => 
				reg		<= '0';
				jump		<= '1';
				branch	<= '0';
				memRead	<= '0';
				memWrite <= '0';
				mem2reg	<= '1';
				regWrite	<= '0';
				alu		<= '0';
				aluOP		<= "XXXX";

			when others => null;

		end case;
	end process;

end s;
				
				



