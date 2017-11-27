library ieee;
use ieee.std_logic_1164.all;

entity Mux2N is
	generic(BITS	: integer range 5 to 32 := 10);
	port(entry1	  :  in std_logic_vector(BITS-1 downto 0);
		  entry2   :  in std_logic_vector(BITS-1 downto 0);
		  selector :  in std_logic;	
		  outData  : out std_logic_vector(BITS-1 downto 0));
end Mux2N;

architecture Behavioral of Mux2N is
begin
	outData <= entry1 when (selector = '1') else entry2;
end Behavioral;