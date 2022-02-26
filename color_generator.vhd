library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity color_generator is
	port (
		Enable : in  STD_LOGIC;
		Reset  : in  STD_LOGIC;
		Clk    : in  STD_LOGIC;
		red    : out STD_LOGIC_VECTOR(2 downto 0);
		green  : out STD_LOGIC_VECTOR(2 downto 0);
		blue   : out STD_LOGIC_VECTOR(1 downto 0)
	);
end color_generator;


architecture Behavioral of color_generator is

signal count : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');

begin

	my_counter : process(Clk)
	begin

		if rising_edge(Clk) then
			if Reset = '1' then
				count <= (others => '0');
			elsif Enable = '1' then 
				count <= count + 1;
			end if;
		end if;
		
	end process my_counter;

	red <= count(7 downto 5);
	green <= count(4 downto 2);
	blue <= count(1 downto 0);

end Behavioral;