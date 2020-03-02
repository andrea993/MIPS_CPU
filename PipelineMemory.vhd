library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity PipelineMemory is
	port (
			  CLK							:	in		std_logic;
			  RST							:	in		std_logic;

			  input_MemToReg			:	in		std_logic;
			  input_RegWrite			:	in		std_logic;
			  input_AluResult			:	in		std_logic_vector(31 downto 0);
			  input_ReadDataMem		:	in		std_logic_vector(31 downto 0);
			  input_WriteReg			:	in		std_logic_vector(4 downto 0);

			  output_MemToReg			:	out	std_logic;
			  output_RegWrite			:	out	std_logic;
			  output_AluResult		:	out	std_logic_vector(31 downto 0);
			  output_ReadDataMem		:	out	std_logic_vector(31 downto 0);
			  output_WriteReg			:	out	std_logic_vector(4 downto 0)
		  );
end PipelineMemory;

Architecture s of PipelineMemory is
	signal	sMemToReg		:	std_logic;
	signal	sRegWrite		:	std_logic;
	signal	sZero				:	std_logic;
	signal	sAluResult		:	std_logic_vector(31 downto 0);
	signal	sReadDataMem	:	std_logic_vector(31 downto 0);
	signal	sWriteReg		:	std_logic_vector(4 downto 0);
begin
	process (CLK, RST)
	begin
		if	RST = '1' then
			sMemToReg		<= '0';
			sRegWrite		<= '0';
			sAluResult		<=	(others => '0');
			sReadDataMem	<=	(others => '0');
			sWriteReg		<=	(others => '0');
		end if;

		if rising_edge(CLK) then
			sMemToReg		<=	input_MemToReg;
			sRegWrite		<=	input_RegWrite;
			sAluResult		<=	input_AluResult;
			sReadDataMem	<=	input_ReadDataMem;
			sWriteReg		<=	input_WriteReg;
		end if;
	end process;

	output_MemToReg		<=	sMemToReg;
	output_RegWrite		<=	sRegWrite;
	output_AluResult		<=	sAluResult;
	output_ReadDataMem	<=	sReadDataMem;
	output_WriteReg		<=	sWriteReg;
end s;

