library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity v_sync_generator is
	port (
		Clk         : in  STD_LOGIC;
		Enable      : in  STD_LOGIC;
		V_sync      : out STD_LOGIC;
		Reset_color : out STD_LOGIC
	);
end v_sync_generator;


architecture Behavioral of v_sync_generator is

signal Reset : STD_LOGIC := '0';

-- In lines, to get these times by clocks multiply them by 800, which is horizontal sync pulse time.
constant v_sync_pulse_time : integer := 521;
constant v_pulse_width     : integer := 2;
constant v_front_porch     : integer := 10;
constant v_back_porch      : integer := 29;

begin

v_process : process(Clk, Enable)

	variable count : integer range 1 to v_sync_pulse_time := 1;
	
	begin
		
		-- Behavioral Clock
		if rising_edge(Clk) then
			if Reset = '1' then
				count := 1;
			elsif Enable = '1' then 
				count := count + 1;
			end if;
		end if;
		
		-- Sync pulse time = 521 lines, so we reset the clock when count = 521 is reached.
		if count = v_sync_pulse_time then
			Reset <= '1';
		else
			Reset <= '0';
		end if;
		
		-- Pulse width + back porch = 2 + 29 = 31, sync pulse time - front porch = 521 - 10 = 511.
		-- This corresponds to T_disp, beside T_disp we have to reset the colors.
		if (v_pulse_width + v_back_porch) < count and count < (v_sync_pulse_time - v_front_porch) then
			Reset_color <= '0';
		else
			Reset_color <= '1';
		end if;
		
		-- Pulse width = 2, so if count > pulse_width then V_sync has to be 1.
		if v_pulse_width < count then
			V_sync <= '1';
		else
			V_sync <= '0';
		end if;
		
	end process v_process;

end Behavioral;