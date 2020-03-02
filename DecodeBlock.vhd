library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity DecodeBlock is
	port (
		CLK						:	in		std_logic;
		RST_PipelineDecode	:	in		std_logic;

		-- Registers
		Reg_WriteEnable		:	in		std_logic;
		Reg_Wreg_idx			:	in		std_logic_vector(4 downto 0);
		Reg_RegWrite			:	in		std_logic_vector(31 downto 0);
	
		instruction				:	in		std_logic_vector(31 downto 0);
		PC_In						:	in		std_logic_vector(31 downto 0);
		
		-- Control unit
	  CU_reg						:	out	std_logic;
	  CU_jump					:	out	std_logic;
	  CU_branch					:	out	std_logic;
	  CU_memRead				:	out	std_logic;
	  CU_memWrite				:	out	std_logic;
	  CU_mem2reg				:	out	std_logic;
	  CU_alu						:	out	std_logic;
	  CU_regWrite				:	out	std_logic;
	  CU_aluOP					:	out	std_logic_vector(3 downto 0);

		-- From instrucitons
		jumpAddr						:	out	std_logic_vector(31 downto 0);
		PC_Out						:	out	std_logic_vector(31 downto 0);
		readData1					:	out	std_logic_vector(31 downto 0);
		readData2					:	out	std_logic_vector(31 downto 0);
		extendSignal				:	out	std_logic_vector(31 downto 0);
		REG_RT_Out					:	out	std_logic_vector(4 downto 0);
		REG_RD_Out					:	out	std_logic_vector(4 downto 0)
	);
end DecodeBlock;


Architecture s of DecodeBlock is

	signal sExtendedRes		: std_logic_vector(31 downto 0);
	signal sReadData1			: std_logic_vector(31 downto 0);
	signal sReadData2			: std_logic_vector(31 downto 0);
	signal sShiftInstr		: std_logic_vector(27 downto 0);
	signal sJumpAddr			: std_logic_vector(31 downto 0);
	signal sAluOP				: std_logic_vector(3 downto 0);
	signal sReg, sJump, sBranch, sMemRead, sMemWrite, sMem2reg,sAlu, sRegWrite	:	std_logic	:=	'0';

begin
	SignExtend0	:	entity work.SignExtend
		port map (
			input_val	=>	instruction(15 downto 0),
			output_val	=>	sExtendedRes
		);

	Registers0	:	entity work.Registers
		port map (
			WriteEnable	=>	Reg_WriteEnable,
			RReg1_idx	=>	instruction(25 downto 21),
			RReg2_idx	=>	instruction(20 downto 16),
			WReg_idx		=>	Reg_Wreg_idx,
			RegWrite		=> Reg_RegWrite
		);

	ControlUnit0 : entity work.ControlUnit
		port map (
			OP				=>	instruction(31 downto 26),
			funct			=>	instruction(5 downto 0),
			reg			=>	sReg,
			jump			=> sJump,
			branch		=> sBranch,
			memRead		=> sMemRead,
			memWrite		=> sMemWrite,
			mem2reg		=> sMem2reg,
			alu			=>	sAlu,
			regWrite		=> sMem2reg,
			aluOP			=> sAluOP
		);

	ShiftLeft0 : entity work.ShiftLeft
		generic map (26, 28, 2)
		port map (
			input_val	=>	instruction(25 downto 0),
			output_val	=>	sShiftInstr
		);

	sJumpAddr <= PC_In(31 downto 28) & sShiftInstr;

	PipelineDecode0 : entity work.PipelineDecode
		port map (
			CLK					=>	CLK,
			RST					=> RST_PipelineDecode,
			input_MemToReg		=> sMem2reg,
			input_RegWrite		=>	sRegWrite,
			input_Jump			=>	sJump,
			input_Branch		=>	sBranch,
			input_MemRead		=> sMemRead,
			input_MemWrite		=>	sMemWrite,
			input_RegDst		=>	sReg,
			input_AluSrc		=>	sAlu,
			input_AluOp			=>	sAluOP,	
			input_JumpAddr		=>	sJumpAddr,	
			input_PC				=>	PC_In,
			input_ReadData1	=>	sReadData1,
			input_ReadData2	=>	sReadData2,	
			input_SignExt		=>	sExtendedRes,	
			input_WriteRegRT	=>	instruction(20 downto 16),
			input_WriteRegRD	=>	instruction(15 downto 11),
			output_MemToReg	=>	CU_mem2reg,
			output_RegWrite	=>	CU_regWrite,	
			output_Jump			=>	CU_jump,	
			output_Branch		=>	CU_branch,	
			output_MemRead		=>	CU_memRead,	
			output_MemWrite	=>	CU_memWrite,		
			output_RegDst		=>	CU_reg,
			output_AluSrc		=>	CU_alu,	
			output_AluOp		=>	CU_aluOP,	
			output_JumpAddr	=>	jumpAddr,			
			output_PC			=>	PC_Out,
			output_ReadData1	=>	readData1,
			output_ReadData2	=>	readData2,
			output_SignExt		=>	extendSignal,	
			output_WriteRegRT	=>	REG_RT_Out,
			output_WriteRegRD	=>	REG_RD_Out
		);
			
end s;

