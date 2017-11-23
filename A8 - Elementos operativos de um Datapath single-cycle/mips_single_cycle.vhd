library ieee;
use ieee.std_logic_1164.all;

library work;
use work.MIPS_pkg.all;
use work.DisplayUnit_pkg.all;

entity mips_single_cycle is
	port(
		CLOCK_50 :  in std_logic;
		SW			:	in std_logic_vector(2 downto 0);
		KEY		:	in std_logic_vector(3 downto 0);
		HEX0		: out std_logic_vector(6 downto 0);
		HEX1		: out std_logic_vector(6 downto 0);
		HEX2		: out std_logic_vector(6 downto 0);
		HEX3		: out std_logic_vector(6 downto 0);
		HEX4		: out std_logic_vector(6 downto 0);
		HEX5		: out std_logic_vector(6 downto 0);
		HEX6		: out std_logic_vector(6 downto 0);
		HEX7		: out std_logic_vector(6 downto 0)
	);
end mips_single_cycle;

architecture Structural of mips_single_cycle is
	
	signal s_clk : std_logic;
	signal s_jaddr : std_logic_vector(25 downto 0);
	signal s_instruct_addr, s_instruct, s_offset : std_logic_vector(31 downto 0);
	
begin

	debnc : entity work.DebounceUnit(Behavioral)
					generic map(mSecMinInWidth => 200,
									inPolarity		=> '0',
									outPolarity		=> '1')
					port map(refClk		=> CLOCK_50,
								dirtyIn		=> KEY(0),
								pulsedOut	=> s_clk);
								
	display : entity work.DisplayUnit(Behavioral)
						generic map(dataPathType	=> SINGLE_CYCLE_DP,
										IM_ADDR_SIZE	=> ROM_ADDR_SIZE,
										DM_ADDR_SIZE	=>	RAM_ADDR_SIZE)
						port map(RefClk	=> CLOCK_50,
									InputSel	=> SW(1 downto 0),
									DispMode	=> SW(2),
									NextAddr	=> KEY(3),
									Dir		=> KEY(2),
									disp0		=> HEX0,
									disp1		=> HEX1,
									disp2		=> HEX2,
									disp3		=> HEX3,
									disp4		=> HEX4,
									disp5		=> HEX5,
									disp6		=> HEX6,
									disp7		=> HEX7);
									
	pcu : entity work.PCupdate(Behavioral)
					port map(
						clk		=>	s_clk,
						zero		=> '0',
						branch	=> '0',
						jump		=> '0',
						reset 	=> KEY(0),
						pc			=> s_instruct_addr,
						offSet	=> s_offSet,
						jaddr		=> s_jaddr);
						
	inst_mem : entity work.InstructionMemory(Behavioral)
					port map(
						address => s_instruct_addr(5 downto 0),
						instruction => s_instruct);
						
	spliter : entity work.InstrSplitter(Behavioral)
					port map(
						instruction => s_instruct,
						imm			=> s_offset(15 downto 0),
						jaddr			=> s_jaddr);
						
	extender : entity work.SignExtend(Behavioral)
					port map(
						dataIn 		=> s_offset(15 downto 0),
						dataOut 		=> s_offset);
	
	
	
end Structural;