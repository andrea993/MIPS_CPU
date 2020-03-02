library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity InstructionMemory is 
	port (
		ReadAddress	:	in		std_logic_vector(31 downto 0);
		Instruction	: 	out	std_logic_vector(31 downto 0)
	);
end InstructionMemory;

architecture s of InstructionMemory is
type vector_of_mem is array(0 to 15) of std_logic_vector (31 downto 0);
signal dataMem	:	vector_of_mem := (
		x"01285024", -- 0x0040 0000: and 			$t2, 	$t1, 	$t0
		x"018b6825", -- 0x0040 0004: or 				$t5, 	$t4, 	$t3
		x"01285020", -- 0x0040 0008: add 			$t2, 	$t1, 	$t0
		x"01285022", -- 0x0040 0004: sub 			$t5, 	$t1, 	$t0
		x"0149402a", -- 0x0040 0010: slt 			$t0, 	$t2, 	$t1
		x"1211fffb", -- 0x0040 0014: branchequal 	$s0, 	$s1, 	$L1		(1210fffb for $s1, $s1)
		x"01285024", -- 0x0040 0018: and 			$t2, 	$t1, 	$t0
		x"018b6825", -- 0x0040 001C: or 				$t5, 	$t4, 	$t3
		x"01285020", -- 0x0040 0020: add 			$t2, 	$t1, 	$t0
		x"01285022", -- 0x0040 0004: sub 			$t5, 	$t1, 	$t0
		x"0149402a", -- 0x0040 0010: slt 			$t0, 	$t2, 	$t1
		x"08100000", -- 0x0040 002C: j 0x00400000 => 0000 1000 0001 0000 0000 0000 0000 (jump to address 0x00400000 (begining))
		x"00000000",
		x"00000000",
		x"00000000",
		x"00000000"
	);

begin
	Instruction <= dataMem((to_integer(unsigned(ReadAddress))));
end s;
