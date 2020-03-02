library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity PipelineExecute is
port (
	CLK						:	in		std_logic;
	RST						:	in		std_logic;

	input_MemToReg			:	in		std_logic;
	input_RegWrite			:	in		std_logic;
	input_Jump				:	in		std_logic;
	input_Branch			:	in		std_logic;
	input_MemRead			:	in		std_logic;
	input_MemWrite			:	in		std_logic;
	input_Zero				:	in		std_logic;
	input_JumpAddr			:	in		std_logic_vector(31 downto 0);
	input_BranchAddr		:	in		std_logic_vector(31 downto 0);
	input_AluResult		:	in		std_logic_vector(31 downto 0);
	input_ReadData2		:	in		std_logic_vector(31 downto 0);
	input_WriteReg			:	in		std_logic_vector(4 downto 0);

	output_MemToReg		:	out	std_logic;
	output_RegWrite		:	out	std_logic;
	output_Jump				:	out	std_logic;
	output_Branch			:	out	std_logic;
	output_MemRead			:	out	std_logic;
	output_MemWrite		:	out	std_logic;
	output_Zero				:	out	std_logic;
	output_JumpAddr		:	out	std_logic_vector(31 downto 0);
	output_BranchAddr		:	out	std_logic_vector(31 downto 0);
	output_AluResult		:	out	std_logic_vector(31 downto 0);
	output_ReadData2		:	out	std_logic_vector(31 downto 0);
	output_WriteReg		:	out	std_logic_vector(4 downto 0)

);
end PipelineExecute;

Architecture s of PipelineExecute is
signal	sMemToReg	:	std_logic;
signal	sRegWrite	:	std_logic;
signal	sJump			:	std_logic;
signal	sBranch		:	std_logic;
signal	sMemRead		:	std_logic;
signal	sMemWrite	:	std_logic;
signal	sZero			:	std_logic;
signal	sJumpAddr	:	std_logic_vector(31 downto 0);
signal	sBranchAddr	:	std_logic_vector(31 downto 0);
signal	sAluResult	:	std_logic_vector(31 downto 0);
signal	sReadData2	:	std_logic_vector(31 downto 0);
signal	sWriteReg	:	std_logic_vector(4 downto 0);
signal	sWriteRegRD	: 	std_logic_vector(4 downto 0);
begin
	process (CLK, RST)
	begin
		if	RST = '1' then
			sMemToReg 	<= '0';
			sRegWrite 	<= '0';
			sJump			<= '0';
			sBranch	 	<= '0';
			sMemRead		<= '0';
			sMemWrite 	<= '0';
			sZero	 		<= '0';
			sJumpAddr	<=	(others => '0');
			sBranchAddr	<=	(others => '0');
			sAluResult	<=	(others => '0');
			sReadData2	<=	(others => '0');
			sWriteReg	<=	(others => '0');
			sWriteRegRD <= (others => '0');
		end if;

		if rising_edge(CLK) then
			sMemToReg	<=	input_MemToReg;
			sRegWrite	<=	input_RegWrite;
			sJump			<=	input_Jump;
			sBranch		<=	input_Branch;
			sMemRead		<=	input_MemRead;
			sMemWrite	<=	input_MemWrite;
			sZero			<=	input_Zero;
			sJumpAddr	<=	input_JumpAddr;
			sBranchAddr	<=	input_BranchAddr;
			sAluResult	<=	input_AluResult;
			sReadData2	<=	input_ReadData2;
			sWriteReg	<=	input_WriteReg;
		end if;
	end process;

	output_MemToReg	<=	sMemToReg;
	output_RegWrite	<=	sRegWrite;
	output_Jump			<=	sJump;
	output_Branch		<=	sBranch;
	output_MemRead		<=	sMemRead;
	output_MemWrite	<=	sMemWrite;
	output_Zero			<=	sZero;
	output_JumpAddr	<=	sJumpAddr;
	output_BranchAddr	<=	sBranchAddr;
	output_AluResult	<=	sAluResult;
	output_ReadData2	<=	sReadData2;
	output_WriteReg	<=	sWriteReg;
end s;
	
