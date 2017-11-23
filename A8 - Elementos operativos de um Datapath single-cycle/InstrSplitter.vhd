library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity InstrSplitter is
	port(
		instruction :  in std_logic_vector(31 downto 0);
		opcode      : out std_logic_vector(5 downto 0);
		reg1			: out std_logic_vector(4 downto 0);
		reg2			: out std_logic_vector(4 downto 0);
		reg3			: out std_logic_vector(4 downto 0);
		funct			: out std_logic_vector(5 downto 0);
		shamt			: out std_logic_vector(4 downto 0);
		imm			: out std_logic_vector(15 downto 0);
		jaddr			: out std_logic_vector(25 downto 0)
	);
end InstrSplitter;

architecture Behavioral of InstrSplitter is
begin
	opcode <= instruction(31 downto 26);
	reg1	 <= instruction(25 downto 21);
	reg2	 <= instruction(20 downto 16);
	reg3	 <= instruction(15 downto 11);
	shamt	 <= instruction(10 downto 6);
	funct	 <= instruction(5 downto 0);
	imm	 <= instruction(15 downto 0);
	jaddr	 <= instruction(25 downto 0);
end Behavioral;