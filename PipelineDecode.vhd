library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity PipelineDecode is
port (
	CLK						:	in		std_logic;
	RST						:	in		std_logic;

	input_MemToReg			:	in		std_logic;
	input_RegWrite			:	in		std_logic;
	input_Jump				:	in		std_logic;
	input_Branch			:	in		std_logic;
	input_MemRead			:	in		std_logic;
	input_MemWrite			:	in		std_logic;
	input_RegDst			:	in		std_logic;
	input_AluSrc			:	in		std_logic;
	input_AluOp				:	in		std_logic_vector(3 downto 0);
	input_JumpAddr			:	in		std_logic_vector(31 downto 0);
	input_PC					:	in		std_logic_vector(31 downto 0);
	input_ReadData1		:	in		std_logic_vector(31 downto 0);
	input_ReadData2		:	in		std_logic_vector(31 downto 0);
	input_SignExt			:	in		std_logic_vector(31 downto 0);
	input_WriteRegRT		:	in		std_logic_vector(4 downto 0);
	input_WriteRegRD		:	in 	std_logic_vector(4 downto 0);

	output_MemToReg		:	out	std_logic;
	output_RegWrite		:	out	std_logic;
	output_Jump				:	out	std_logic;
	output_Branch			:	out	std_logic;
	output_MemRead			:	out	std_logic;
	output_MemWrite		:	out	std_logic;
	output_RegDst			:	out	std_logic;
	output_AluSrc			:	out	std_logic;
	output_AluOp			:	out	std_logic_vector(3 downto 0);
	output_JumpAddr		:	out	std_logic_vector(31 downto 0);
	output_PC				:	out	std_logic_vector(31 downto 0);
	output_ReadData1		:	out	std_logic_vector(31 downto 0);
	output_ReadData2		:	out	std_logic_vector(31 downto 0);
	output_SignExt			:	out	std_logic_vector(31 downto 0);
	output_WriteRegRT		:	out	std_logic_vector(4 downto 0);
	output_WriteRegRD		:	out 	std_logic_vector(4 downto 0)

);
end PipelineDecode;

Architecture s of PipelineDecode is
signal	sMemToReg	:	std_logic;
signal	sRegWrite	:	std_logic;
signal	sJump			:	std_logic;
signal	sBranch		:	std_logic;
signal	sMemRead		:	std_logic;
signal	sMemWrite	:	std_logic;
signal	sRegDst		:	std_logic;
signal	sAluSrc		:	std_logic;
signal	sAluOp		:	std_logic_vector(3 downto 0);
signal	sJumpAddr	:	std_logic_vector(31 downto 0);
signal	sPC			:	std_logic_vector(31 downto 0);
signal	sReadData1	:	std_logic_vector(31 downto 0);
signal	sReadData2	:	std_logic_vector(31 downto 0);
signal	sSignExt		:	std_logic_vector(31 downto 0);
signal	sWriteRegRT	:	std_logic_vector(4 downto 0);
signal	sWriteRegRD	:	std_logic_vector(4 downto 0);
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
			sRegDst	 	<= '0';
			sAluSrc	 	<= '0';
			sAluOp		<=	(others => '0');
			sJumpAddr	<=	(others => '0');
			sPC			<=	(others => '0');
			sReadData1	<=	(others => '0');
			sReadData2	<=	(others => '0');
			sSignExt		<=	(others => '0');
			sWriteRegRT	<=	(others => '0');
			sWriteRegRD	<=	(others => '0');
		end if;

		if rising_edge(CLK) then
			sMemToReg			<=	input_MemToReg;
			sRegWrite			<=	input_RegWrite;
			sJump					<=	input_Jump;
			sBranch				<=	input_Branch;
			sMemRead				<=	input_MemRead;
			sMemWrite			<=	input_MemWrite;
			sRegDst				<=	input_RegDst;
			sAluSrc				<=	input_AluSrc;
			sAluOp				<=	input_AluOp;
			sJumpAddr			<=	input_JumpAddr;
			sPC					<=	input_PC;
			sReadData1			<=	input_ReadData1;
			sReadData2			<=	input_ReadData2;
			sSignExt				<=	input_SignExt;
			sWriteRegRT			<=	input_WriteRegRT;
			sWriteRegRD			<=	input_WriteRegRD;
		end if;
	end process;

	output_MemToReg	<=	sMemToReg;
	output_RegWrite	<=	sRegWrite;
	output_Jump			<=	sJump;
	output_Branch		<=	sBranch;
	output_MemRead		<=	sMemRead;
	output_MemWrite	<=	sMemWrite;
	output_RegDst		<=	sRegDst;
	output_AluSrc		<=	sAluSrc;
	output_AluOp		<=	sAluOp;
	output_JumpAddr	<=	sJumpAddr;
	output_PC			<=	sPC;
	output_ReadData1	<=	sReadData1;
	output_ReadData2	<=	sReadData2;
	output_SignExt		<=	sSignExt;
	output_WriteRegRT	<=	sWriteRegRT;
	output_WriteRegRD	<=	sWriteRegRD;
end s;
	
	
	

