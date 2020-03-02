library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use STD.textio.all;

entity ExecuteBlock is 
	port (
		CLK					:	in		std_logic;
		RST_Pipeline		:	in		std_logic;

		mem2Reg_in			:	in		std_logic;
		regWrite_in			:	in		std_logic;
		jump_in				:	in		std_logic;
		branch_in			:	in		std_logic;
		memRead_in			:	in		std_logic;
		memWrite_in			:	in		std_logic;
		reg_in				:	in		std_logic;
		aluSrc_in			:	in		std_logic;	
		aluOp_in				:	in		std_logic_vector(3 downto 0);
		jumpAddr_in			:	in		std_logic_vector(31 downto 0);
		PC_in					:	in		std_logic_vector(31 downto 0);
		readData1_in		:	in		std_logic_vector(31 downto 0);
		readData2_in		:	in		std_logic_vector(31 downto 0);
		extendSignal_in	:	in		std_logic_vector(31 downto 0);
		regRT_in				:	in		std_logic_vector(4 downto 0);
		regRD_in				:	in		std_logic_vector(4 downto 0);
		
		mem2Reg_out			:	out		std_logic;
		regWrite_out		:	out		std_logic;
		jump_out				:	out		std_logic;
		branch_out			:	out		std_logic;
		memRead_out			:	out		std_logic;
		memWrite_out		:	out		std_logic;
		jumpAddr_out		:	out		std_logic_vector(31 downto 0);
		branchAddr_out		:	out		std_logic_vector(31 downto 0);
		zeroFlag_out		:	out		std_logic;
		aluRes_out			:	out		std_logic_vector(31 downto 0);
		readData2_out		:	out		std_logic_vector(31 downto 0);
		reg_out				:	out		std_logic_vector(4 downto 0)
	);
end ExecuteBlock;

Architecture s of ExecuteBlock is

	signal sZero					:	std_logic;
	signal sSelectedWriteReg	:	std_logic_vector(4 downto 0);
	signal sAluData				:	std_logic_vector(31 downto 0);
	signal sAluRes					:	std_logic_vector(31 downto 0);
	signal sExtendShift		:	std_logic_vector(31 downto 0);
	signal sBranhAddr				:	std_logic_vector(31 downto 0);
	
begin
	selectRegister	:	entity work.Mux 
		generic map (5)
		port map (
			selector			=>	reg_in,
			input_val_1		=>	regRT_in,
			input_val_2		=>	regRD_in,
			output_val		=>	sSelectedWriteReg
		);

	selectData		:	entity work.Mux
		generic map (32)
		port map (
			selector			=>	aluSrc_in,	
			input_val_1		=>	readData2_in,
			input_val_2		=>	extendSignal_in,
			output_val		=>	sAluData
			--output_val => open
		);
		
	shiftLeft0		:	entity work.ShiftLeft
		generic map (32, 32, 2)
		port map ( 
			input_val		=>	extendSignal_in,
			output_val		=>	sExtendShift
		);
	
	alu_execute		:	entity work.ALU
		port map (
			OP_idx			=>	aluOp_in,
			In1				=> readData1_in,
			In2				=> sAluData,
			OutZ				=> sZero,
			OutRes			=> sAluRes 
		);

	branchAdd		:	entity work.Adder
		port map (
			input_val_1		=>	PC_in,
			input_val_2		=>	sExtendShift,
			output_val		=>	sBranhAddr
		);

	pipeline			:	entity work.PipelineExecute
		port map (
			CLK					=> CLK,
			RST					=>	RST_Pipeline,
			input_MemToReg		=>	mem2Reg_in,
			input_RegWrite		=>	regWrite_in,
			input_Jump			=>	jump_in,
			input_Branch		=>	branch_in,
			input_MemRead		=>	memRead_in,
			input_MemWrite		=>	memWrite_in,
			input_Zero			=>	sZero,
			input_JumpAddr		=>	jumpAddr_in,
			input_BranchAddr	=>	sBranhAddr,
			input_AluResult	=>	sAluRes,
			input_ReadData2	=>	readData2_in,
			input_WriteReg		=>	sSelectedWriteReg,
			output_MemToReg	=>	mem2Reg_out, 	
			output_RegWrite	=>	regWrite_out,
			output_Jump			=>	jump_out,
			output_Branch		=>	branch_out,
			output_MemRead		=>	memRead_out,
			output_MemWrite	=>	memWrite_out,
			output_Zero			=>	zeroFlag_out,
			output_JumpAddr	=>	jumpAddr_out,
			output_BranchAddr	=>	branchAddr_out,
			output_AluResult	=>	aluRes_out,
			output_ReadData2	=>	readData2_out,
			output_WriteReg	=> reg_out
		);

end s;

