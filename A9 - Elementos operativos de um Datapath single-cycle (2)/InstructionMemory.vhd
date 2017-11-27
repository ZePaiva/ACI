library ieee;
library work;
use work.DisplayUnit_pkg.all;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity InstructionMemory is
	port(address     :  in std_logic_vector(5 downto 0);
		  instruction : out std_logic_vector(31 downto 0));
end InstructionMemory;

architecture Behavioral of InstructionMemory is

	constant NUM_WORDS : positive := (2 ** 5);
	subtype T_DATA    is std_logic_vector(31 downto 0);
	type T_MEM        is array(0 to NUM_WORDS -1) of T_DATA;
	constant s_memory  : T_MEM := (x"2002001a",		-- addi $2, $0, 0x1a
											 x"2003fff9",		--	addi $3, $0, 7
											 x"00432020",		--	add  $4, $2, $3
											 x"00432822",		-- sub  $5, $2, $3
											 x"00433024",		-- and  $6, $2, $3
											 x"00433825",		-- or   $7, $2, $3
											 x"00434027",		-- nor  $8, $2, $3
											 x"00434826",		-- xor  $9, $2, $3
											 x"0043502a",		-- slt  $10, $2, $3
											 x"28ebfff9",		-- slti $11, $7, -7
											 x"292cffe7",		-- slti $12, $9, -25
											 others => x"00000000");

begin
	instruction  <= s_memory(to_integer(unsigned(address(5 downto 2))));
	DU_IMdata    <= s_memory(to_integer(unsigned(DU_IMaddr)));
end Behavioral;