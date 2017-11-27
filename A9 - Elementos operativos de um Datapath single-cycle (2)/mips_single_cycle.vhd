library ieee;
use ieee.std_logic_1164.all;

library work;
use work.MIPS_pkg.all;
use work.DisplayUnit_pkg.all;

entity mips_single_cycle is
	port(CLOCK_50 :  in std_logic;
		  SW		  :  in std_logic_vector(7 downto 0);
		  KEY		  :  in std_logic_vector(3 downto 0);
		  HEX0	  : out std_logic_vector(6 downto 0);
		  HEX1	  : out std_logic_vector(6 downto 0);
		  HEX2	  : out std_logic_vector(6 downto 0);
		  HEX3	  : out std_logic_vector(6 downto 0);
		  HEX4	  : out std_logic_vector(6 downto 0);
		  HEX5	  : out std_logic_vector(6 downto 0);
		  HEX6	  : out std_logic_vector(6 downto 0);
		  HEX7	  : out std_logic_vector(6 downto 0));
end mips_single_cycle;

architecture Structural of mips_single_cycle is
	-- secondary clock
	signal s_clk : std_logic;
	
	-- jump address
	signal s_jaddr : std_logic_vector(25 downto 0);
	
	-- instructions and offsets
	signal s_instruct_addr, s_instruct, s_offset : std_logic_vector(31 downto 0);
	
	--	signals for registers in register file
	signal regs1, regs2, wReg, regd : std_logic_vector(4 downto 0);
	
	-- signals for data in register file
	signal r_data1, r_data2, w_data : std_logic_vector(31 downto 0);
	
	-- signals for ALU
	signal alu_e2, result	: std_logic_vector(31 downto 0);
	signal alu_funct	: std_logic_vector(5 downto 0);
	signal alu_control	: std_logic_vector(2 downto 0);
	signal zero : std_logic;
	
begin

	debnc : 
		entity work.DebounceUnit(Behavioral)
			generic map(mSecMinInWidth => 200,
							inPolarity		=> '0',
							outPolarity		=> '1')
			port map(refClk		=> CLOCK_50,
						dirtyIn		=> KEY(0),
						pulsedOut	=> s_clk);
							
	display : 
		entity work.DisplayUnit(Behavioral)
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
									
	pcu : 
		entity work.PCupdate(Behavioral)
			port map(clk		=>	s_clk,
						zero		=> '0',
						branch	=> '0',
						jump		=> '0',
						reset 	=> KEY(0),
						pc			=> s_instruct_addr,
						offSet	=> s_offSet,
						jaddr		=> s_jaddr);
						
	inst_mem : 
		entity work.InstructionMemory(Behavioral)
			port map(address => s_instruct_addr(5 downto 0),
						instruction => s_instruct);
						
	spliter : 
		entity work.InstrSplitter(Behavioral)
			port map(instruction => s_instruct,
						imm			=> s_offset(15 downto 0),
						jaddr			=> s_jaddr,
						reg1			=> regd,
						reg2			=> regs1,
						reg3			=> regs2,
						funct			=> alu_funct);
						
	extender : 
		entity work.SignExtend(Behavioral)
			port map(dataIn 		=> s_offset(15 downto 0),
						dataOut 		=> s_offset);
						
	m1 :
		entity work.Mux2N(Behavioral)
			generic map(BITS 		=> 5)
			port map(entry1		=> regs1,
						entry2		=> regs2,
						selector		=> SW(6),
						outData		=> wReg);
	register_file :
		entity work.RegFile(Behavioral)
			port map(clk			=> s_clk,
						writeEnable => SW(7),
						readReg1		=> regs1,
						readReg2		=> regs2,
						readData1	=> r_data1,
						readData2	=> r_data2,
						writeData	=> w_data,
						writeReg		=> wReg);
						
	m2	:
		entity work.Mux2N(Behavioral)
			generic map(BITS		=> 32)
			port map(entry1		=> r_data2,
						entry2		=> s_offset,
						selector		=> SW(5),
						outData		=> alu_e2);
						
	alu_32:
		entity work.ALU32(Behavioral)
			port map(data1			=> r_data1,
						data2			=> alu_e2,
						aluControl 	=> alu_control,
						zero			=> zero,
						result		=> DU_DMdata);
						
	alu_control_unit:
		entity work.ALUControlUnit(Behavioral)
			port map(ALUop			=> SW(4 downto 3),
						funct			=> alu_funct,
						ALUControl	=> alu_control);
end Structural;