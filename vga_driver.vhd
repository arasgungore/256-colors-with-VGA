library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity ee240_vgadriver is
	port (
		board_clk : in  STD_LOGIC;
		vsync     : out STD_LOGIC;
		hsync     : out STD_LOGIC;
		red       : out STD_LOGIC_VECTOR(2 downto 0);
		green     : out STD_LOGIC_VECTOR(2 downto 0);
		blue      : out STD_LOGIC_VECTOR(1 downto 0)
	);
end ee240_vgadriver;


architecture arch_vga_driver of ee240_vgadriver is 


component frequency_divider is
	port (
		Reset   : in  STD_LOGIC;
		Clk_in  : in  STD_LOGIC; 
		Clk_out : out STD_LOGIC
	);
end component;

component color_generator is
	port (
		Enable : in  STD_LOGIC;
		Reset  : in  STD_LOGIC;
		Clk    : in  STD_LOGIC;
		red    : out STD_LOGIC_VECTOR(2 downto 0);
		green  : out STD_LOGIC_VECTOR(2 downto 0);
		blue   : out STD_LOGIC_VECTOR(1 downto 0)
	);
end component;

component h_sync_generator is
	 port (
		 Clk         : in  STD_LOGIC;
		 Enable      : in  STD_LOGIC;
		 H_sync      : out STD_LOGIC;
		 Reset_color : out STD_LOGIC;
		 V_enable    : out STD_LOGIC
	 );
end component;

component v_sync_generator is
	 port (
		 Clk         : in  STD_LOGIC;
		 Enable      : in  STD_LOGIC;
		 V_sync      : out STD_LOGIC;
		 Reset_color : out STD_LOGIC
	 );
end component;


signal clk_div, v_sync_gen_enable, reset, h_reset, v_reset : STD_LOGIC;
signal count : STD_LOGIC_VECTOR(7 downto 0);


begin

	freq_div : frequency_divider		-- 100 MHz to 25 MHz, divide by 4
		port map('0', board_clk, clk_div);
	
	h_sync_gen : h_sync_generator
		port map(board_clk, clk_div, hsync, h_reset, v_sync_gen_enable);
	
	v_sync_gen : v_sync_generator
		port map(board_clk, v_sync_gen_enable, vsync, v_reset);

	reset <= h_reset or v_reset;

	eight_bit_cnt : color_generator
		port map(clk_div, reset, board_clk, red, green, blue);

end arch_vga_driver;