library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU32 is
	port(data1		 :  in std_logic_vector(31 downto 0);
		  data2		 :  in std_logic_vector(31 downto 0);
		  aluControl :  in std_logic_vector(2 downto 0);
		  zero		 : out std_logic;
		  result		 : out std_logic_vector(31 downto 0));
end ALU32;

architecture Behavioral of ALU32 is
	signal s_extra : unsigned(31 downto 0);
begin
	s_extra <= not(unsigned(data2)) + 1 when aluControl = "110" else unsigned(data2);
	zero	  <= '1' when result = x"00000000" else '0';
	
	process(aluControl, data1, data2, s_extra)
	begin
		case aluControl is
			when "000" =>
				result <= data1 and data2;
			when "001" =>
				result <= data1 or data2;
			when "010" => 
				result <= std_logic_vector(unsigned(data1) + s_extra);
			when "011" =>
				result <= data1 xor data2;
			when "100" =>
				result <= data1 nor data2;
			when "110" => 
				result <= std_logic_vector(unsigned(data1) + s_extra);
			when "111" =>
				if (signed(data1) < signed(data2)) then
					result <= x"00000001";
				else
					result <= (others => '0');
				end if;
			when others =>
				result <= (others => '-');
		end case;
	end process;
end Behavioral;