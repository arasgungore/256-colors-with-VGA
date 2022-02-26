library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;


entity frequency_divider is
	port (
		Reset   : in  STD_LOGIC;
		Clk_in  : in  STD_LOGIC; 
		Clk_out : out STD_LOGIC
	);
end frequency_divider;


architecture Behavioral of frequency_divider is

signal count : STD_LOGIC_VECTOR(1 downto 0) := (others => '0');

begin

	my_freq_div : process(Clk_in)
	begin

		if rising_edge(Clk_in) then
			if Reset = '1' then
				count <= (others => '0');
			else 
				count <= count + 1;
				if count = "11" then
					Clk_out <= '1';
				else
					Clk_out <= '0';
				end if;
			end if;
		end if;

	end process my_freq_div;

end Behavioral;