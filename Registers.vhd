library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity Registers is 
	port (
		RReg1_idx	: in std_logic_vector(4 downto 0);
		RReg2_idx	: in std_logic_vector(4 downto 0);

		RegWrite		: in std_logic_vector(31 downto 0);
		WriteEnable	: in std_logic;
		WReg_idx		: in std_logic_vector(4 downto 0);

		Reg1Read		: out std_logic_vector(31 downto 0);
		Reg2Read		: out std_logic_vector(31 downto 0)
	);
end Registers;


architecture s of Registers is
	type vector_of_mem is array(0 to 31) of std_logic_vector (31 downto 0);
	signal registersMem: vector_of_mem := (                                
        "00000000000000000000000000000010", --0 
        "00000000000000000000000000000001", 
        "00000000000000000000000000000000", 
        "00000000000000000000000000000011", 
        "00000000000000000000000000000000", 
        "00000000000000000000000000011111", --5
        "00000000000000000000000000001010",
        "00000000000000000000000000000000",
        "00000000000000000000000000011010",
        "00000000000000000000000000001101",
        "00000000000000000000000000000000", --10
        "00000000000000000000000000001101",
        "00000000000000000000000000011100",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000", --15
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000", --20
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000", --25
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000", --30
        "00000000000000000000000000000000"
    );

	begin
		Reg1Read <= registersMem(to_integer(unsigned(RReg1_idx)));
		Reg2Read <= registersMem(to_integer(unsigned(RReg2_idx)));

		RegUpdate : process(RegWrite, WriteEnable)
			begin
				if (WriteEnable = '1') then
					registersMem(to_integer(unsigned(WReg_idx))) <= RegWrite;
				end if;
		end process RegUpdate;
		
end s;


				
