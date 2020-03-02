library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity FetchBlock is
	port (
		CLK					:	in		std_logic;
		RST_PC				:	in		std_logic;
		RST_Pipeline		:	in 	std_logic;
		muxBranch_CTRL		:	in		std_logic;
		muxBranch_In1		:	in 	std_logic_vector(31 downto 0);
		muxJump_CTRL		:	in		std_logic;
		muxJump_In1			:	in		std_logic_vector(31 downto 0);
		pc_out				:	out	std_logic_vector(31 downto 0);
		instruction_out1	:	out	std_logic_vector(31 downto 0)
	);
end FetchBlock;

architecture s of FetchBlock is

	signal sPc_In			:	std_logic_vector(31 downto 0);
	signal sPc_Out			:	std_logic_vector(31 downto 0);
	signal sPlus4			:	std_logic_vector(31 downto 0);
	signal sAddRes			:	std_logic_vector(31 downto 0);
	signal sStoreInstr	:	std_logic_vector(31 downto 0);
	signal sMux_Out		:	std_logic_vector(31 downto 0);


begin
	sPlus4 <= (2 => '1', others => '0');

	--PC+4 vs branch address
	BranchMux : entity work.Mux
		generic map (32)
		port map (
			selector => muxBranch_CTRL,
			input_val_1 => sAddRes,
			input_val_2 => muxBranch_In1,
			output_val => sMux_Out
		);
	
	-- Previous mux ouput vs jump address
	JumpMux : entity work.Mux
		generic map (32)
		port map (
			selector => muxJump_CTRL,
			input_val_1 => sMux_Out,
			input_val_2 => muxJump_In1,
			output_val => sPc_In
		);
	
	NextAddress : entity work.ProgramCounter
		port map (
			CLK => CLK,
			RST => RST_PC,
			nextAddr => sPc_In,
			currAddr => sPc_Out
		);

	Sum : entity work.Adder
		port map (
			input_val_1 => sPc_Out,
			input_val_2 => sPlus4,
			output_val => sAddRes
		);

	Pipeline : entity work.PipelineFetch
		port map (
			CLK => CLK,
			RST => RST_Pipeline,
			input_PC => sAddRes,
			input_instruction => sStoreInstr,
			output_PC => pc_out,
			output_instruction => instruction_out1
		);

end s;

