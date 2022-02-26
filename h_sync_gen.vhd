library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity h_sync_generator is
	port (
		Clk         : in  STD_LOGIC;
		Enable      : in  STD_LOGIC;
		H_sync      : out STD_LOGIC;
		Reset_color : out STD_LOGIC;
		V_enable    : out STD_LOGIC
	);
end h_sync_generator;


architecture Behavioral of h_sync_generator is

signal Reset : STD_LOGIC := '0';

-- In clocks
constant h_sync_pulse_time : integer := 800;
constant h_pulse_width     : integer := 96;
constant h_front_porch     : integer := 16;
constant h_back_porch      : integer := 48;

begin

h_process : process(Clk, Enable)

	variable count : integer range 1 to h_sync_pulse_time := 1;
	
	begin
		
		-- Behavioral Clock
		if rising_edge(Clk) then
			if Reset = '1' then
				count := 1;
			elsif Enable = '1' then 
				count := count + 1;
			end if;
		end if;
		
		-- Sync pulse time = 800 clocks, so we reset the clock when count = 800 is reached.
		-- Also we set V_enable = 1 because we are moving to a new line since horizontal is finished.
		if count = h_sync_pulse_time then
			V_enable <= '1';
			Reset <= '1';
		else
			V_enable <= '0';
			Reset <= '0';
		end if;
		
		-- Pulse width + back porch = 96 + 48 = 144, sync pulse time - front porch = 800 - 16 = 784.
		-- This corresponds to T_disp, beside T_disp we have to reset the colors.
		if (h_pulse_width + h_back_porch) < count and count < (h_sync_pulse_time - h_front_porch) then
			Reset_color <= '0';
		else
			Reset_color <= '1';
		end if;
		
		-- Pulse width = 96, so if count > pulse_width then H_sync has to be 1.
		if h_pulse_width < count then
			H_sync <= '1';
		else
			H_sync <= '0';
		end if;
		
	end process h_process;

end Behavioral;