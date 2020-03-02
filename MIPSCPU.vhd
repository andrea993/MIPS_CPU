library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity MIPSCPU is
	port (
			  CLK		:	in std_logic;
			  RST_PC	:	in	std_logic;
			  RST_PL	:	in	std_logic
		  );
end MIPSCPU;

Architecture s of MIPSCPU is
	signal sBranch2Fetch, sJump2Fetch															:	std_logic;
	signal sBranchAddr2Fetch, sJumpAddr2Fetch													:	std_logic_vector(31 downto 0);
	signal sPcToPartition, sInstructionToPartition 														:	std_logic_vector(31 downto 0);
	signal sRegWriteFlagToFetch																	:	std_logic;
	signal sWriteRegToFetch																			:	std_logic_vector(4 downto 0);
	signal sDataWriteToFetch																		:	std_logic_vector(31 downto 0);
	signal sMemToRegToElab, sRegWriteToElab, sJumpToElab, sBranchToElab				:	std_logic;
	signal sMemReadToElab, sMemWriteToElab, sRegDstToElab, sAluSrcToElab				:	std_logic;
	signal sAluOpToElab																				:	std_logic_vector(3 downto 0);
	signal sJumpAddrToElab, sProgramCounterToElab, sReadData1ToElab					:	std_logic_vector(31 downto 0);
	signal sReadData2ToElab, sExtdSignToElab													:	std_logic_vector(31 downto 0);
	signal sRegRtToElab, sRegRdToElab															:	std_logic_vector(4 downto 0);
	signal sMemToRegToMemOp, sRegWriteToMemOp, sJumpToMemOp								:	std_logic; 
	signal sBranchToMemOp, sMemReadToMemOp, sMemWriteToMemOp, sZeroFlagToMemOp		:	std_logic;
	signal sJumpAddrToMemOp, sBranchAdrrToMemOp												:	std_logic_vector(31 downto 0);
	signal sReadData2ToMemOp, sAluResultToMemOp												:	std_logic_vector(31 downto 0);
	signal sWriteRegToMemOp																			:	std_logic_vector(4 downto 0);
	signal sMemToRegToMux																			:	std_logic;
	signal sReadDataMemToMux, sAluResultToMux													:	std_logic_vector(31 downto 0);

begin
	
	FetchBlock0 : entity work.FetchBlock	
	port map (
		CLK					=>	CLK,
		RST_PC				=> RST_PC,
		RST_Pipeline		=> RST_PL,
		muxBranch_CTRL		=> sBranch2Fetch,
		muxBranch_In1		=> sBranchAddr2Fetch,
		muxJump_CTRL		=>	sJump2Fetch,
		muxJump_In1			=>	sJumpAddr2Fetch,
		pc_out				=>	sPcToPartition,
		instruction_out1	=>	sInstructionToPartition
	);


	DecodeBlock0 : entity work.DecodeBlock
	port map (
		CLK					=>	CLK,
		RST_PipelineDecode		=>	RST_PL,
		Reg_WriteEnable	=>	sRegWriteFlagToFetch,
		Reg_Wreg_idx		=>	sWriteRegToFetch,
		Reg_RegWrite		=>	sDataWriteToFetch,
		instruction			=>	sInstructionToPartition,
		PC_In					=>	sPcToPartition,
		CU_mem2reg			=>	sMemToRegToElab,
		CU_regWrite			=>	sRegWriteToElab,
		CU_jump				=>	sJumpToElab,
		CU_branch			=>	sBranchToElab,
		CU_memRead			=>	sMemReadToElab,
		CU_memWrite			=>	sMemWriteToElab,
		CU_reg				=>	sRegDstToElab,
		CU_alu				=>	sAluSrcToElab,
		CU_aluOP				=>	sAluOpToElab,
		jumpAddr				=>	sJumpAddrToElab,
		PC_Out				=>	sProgramCounterToElab,
		readData1			=>	sReadData1ToElab,
		readData2			=>	sReadData2ToElab,
		extendSignal		=>	sExtdSignToElab,
		REG_RT_Out			=>	sRegRtToElab,
		REG_RD_Out			=>	sRegRtToElab
	);

	ExecuteBlock0 : entity work.ExecuteBlock
	port map (
		CLK					=>	CLK,
		RST_Pipeline		=>	RST_PL,
		mem2Reg_in			=>	sMemToRegToElab,
		regWrite_in			=>	sRegWriteToElab,
		jump_in				=>	sJumpToMemOp,
		branch_in			=>	sBranchToElab,
		memRead_in			=>	sMemReadToElab,
		memWrite_in			=> sMemWriteToElab,
		reg_in				=> sRegDstToElab,
		aluSrc_in			=>	sAluSrcToElab,
		aluOp_in				=>	sAluOpToElab,
		jumpAddr_in			=>	sJumpAddrToElab,
		PC_in					=> sProgramCounterToElab,
		readData1_in		=>	sReadData1ToElab,
		readData2_in		=>	sReadData2ToElab,
		extendSignal_in	=>	sExtdSignToElab,
		regRT_in				=>	sRegRtToElab,
		regRD_in				=>	sRegRdToElab,
		mem2Reg_out			=>	sMemToRegToMemOp,
		regWrite_out		=>	sRegWriteToMemOp,
		jump_out				=>	sJumpToMemOp,
		branch_out			=>	sBranchToMemOp,
		memRead_out			=>	sMemReadToMemOp,
		memWrite_out		=>	sMemWriteToMemOp,
		jumpAddr_out		=>	sJumpAddrToMemOp,
		branchAddr_out		=>	sBranchAdrrToMemOp,
		zeroFlag_out		=>	sZeroFlagToMemOp,
		aluRes_out			=>	sAluResultToMemOp,
		readData2_out		=>	sReadData2ToMemOp,
		reg_out				=>	sWriteRegToMemOp
	);

	MemoryBlock0 : entity work.MemoryBlock
	port map (
		CLK					=>	CLK,
		RST_Pipeline		=> RST_PL,
		mem2Reg_in			=>	sMemToRegToMemOp,
		regWrite_in			=>	sRegWriteToMemOp,
		jump_in				=>	sJumpToMemOp,
		branch_in			=>	sBranchToMemOp,
		memRead_in			=>	sMemReadToMemOp,
		memWrite_in			=> sMemWriteToMemOp,
		jumpAddr_in			=>	sJumpAddrToMemOp,
		branchAddr_in		=>	sBranchAdrrToMemOp,
		zeroFlag_in			=>	sZeroFlagToMemOp,
		aluRes_in			=>	sAluResultToMemOp,
		readData2_in		=>	sReadData2ToMemOp,
		reg_in				=>	sWriteRegToMemOp,
		mem2Reg_out			=>	sMemToRegToMux,
		regWrite_out		=>	sRegWriteFlagToFetch,
		jump_out				=>	sJump2Fetch,
		branch_out			=>	sBranch2Fetch,
		jumpAddr_out		=>	sJumpAddr2Fetch,
		branchAddr_out		=>	sBranchAddr2Fetch,
		aluRes_out			=>	sAluResultToMemOp,
		readDataMem_out	=>	sReadDataMemToMux,
		reg_out				=>	sWriteRegToFetch
	);


	Mux0 : entity work.Mux
	generic map (32)
	port map (
		selector				=> sMemToRegToMux,
		input_val_1			=>	sAluResultToMux,
		input_val_2			=>	sReadDataMemToMux,
		output_val			=>	sDataWriteToFetch
	);
	

end s;

