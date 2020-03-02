library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity MemoryBlock is 
	port (
		CLK					:	in		std_logic;
		RST_Pipeline		:	in		std_logic;
		mem2Reg_in			:	in		std_logic;
		regWrite_in			:	in		std_logic;
		jump_in				:	in		std_logic;
		branch_in			:	in		std_logic;
		memRead_in			:	in		std_logic;
		memWrite_in			:	in		std_logic;
		jumpAddr_in			:	in		std_logic_vector(31 downto 0);
		branchAddr_in		:	in		std_logic_vector(31 downto 0);
		zeroFlag_in			:	in		std_logic;
		aluRes_in			:	in		std_logic_vector(31 downto 0);
		readData2_in		:	in		std_logic_vector(31 downto 0);
		reg_in				:	in		std_logic_vector(4 downto 0);

		mem2Reg_out			:	out	std_logic;
		regWrite_out		:	out	std_logic;
		jump_out				:	out	std_logic;
		branch_out			:	out	std_logic;
		jumpAddr_out		:	out	std_logic_vector(31 downto 0);
		branchAddr_out		:	out	std_logic_vector(31 downto 0);
		aluRes_out			:	out	std_logic_vector(31 downto 0);
		readDataMem_out	:	out 	std_logic_vector(31 downto 0);
		reg_out				:	out	std_logic_vector(4 downto 0)
	);
end MemoryBlock;

Architecture s of MemoryBlock is

	signal sDataFromMem	:	std_logic_vector(31 downto 0);

begin
	jump_out			<=	jump_in;
	jumpAddr_out	<=	jumpAddr_in;
	branch_out		<=	branch_in and zeroFlag_in;
	branchAddr_out	<=	branchAddr_in;
	
	datamemory_op	:	entity work.DataMemory
		port map (
			WriteData	=>	readData2_in,
			ReadData		=>	sDataFromMem,			
			Address		=>	aluRes_in,
			MemWrite		=>	memWrite_in,	
			MemRead		=>	memRead_in
		);

	pipline		:	entity work.PipelineMemory
		port map (
		  CLK							=>	CLK,
		  RST							=>	RST_Pipeline,

		  input_MemToReg	 		=> mem2Reg_in,
		  input_RegWrite	 		=> regWrite_in,
		  input_AluResult			=>	aluRes_in, 
		  input_ReadDataMem		=> sDataFromMem,
		  input_WriteReg	 		=> reg_in,

		  output_MemToReg			=>	mem2Reg_out,
		  output_RegWrite			=> regWrite_out, 
		  output_AluResult		=> aluRes_out, 
		  output_ReadDataMem		=>	readDataMem_out,
		  output_WriteReg			=>	reg_out
	  );

end s;
	
