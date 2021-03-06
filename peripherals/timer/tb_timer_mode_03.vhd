library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-------------------------------------
entity testbench_timer_mode_03 is
end entity testbench_timer_mode_03;
------------------------------

architecture stimulus of testbench_timer_mode_03 is

	constant prescaler_size_for_test : integer := 16;
	constant compare_size_for_test   : integer := 4;

	component Timer
		generic(
			prescaler_size : integer := prescaler_size_for_test;
			compare_size   : integer := compare_size_for_test
		);
		port(
			clock       : in  std_logic;
			reset       : in  std_logic;
			timer_reset : in  std_logic;
			timer_mode  : in  unsigned(1 downto 0);
			prescaler   : in  unsigned(prescaler_size - 1 downto 0);
			top_counter : in  unsigned(prescaler_size - 1 downto 0);
			compare_0A  : in  unsigned(compare_size - 1 downto 0);
			compare_0B  : in  unsigned(compare_size - 1 downto 0);
			compare_1A  : in  unsigned(compare_size - 1 downto 0);
			compare_1B  : in  unsigned(compare_size - 1 downto 0);
			compare_2A  : in  unsigned(compare_size - 1 downto 0);
			compare_2B  : in  unsigned(compare_size - 1 downto 0);
			output_A    : out std_logic_vector(2 downto 0);
			output_B    : out std_logic_vector(2 downto 0)
		);
	end component Timer;
	signal clock       : std_logic;
	signal reset       : std_logic;
	signal timer_reset : std_logic;
	signal timer_mode  : unsigned(1 downto 0);
	signal prescaler   : unsigned(prescaler_size_for_test - 1 downto 0);
	signal top_counter : unsigned(compare_size_for_test - 1 downto 0);
	signal compare_0A  : unsigned(compare_size_for_test - 1 downto 0);
	signal compare_0B  : unsigned(compare_size_for_test - 1 downto 0);
	signal compare_1A  : unsigned(compare_size_for_test - 1 downto 0);
	signal compare_1B  : unsigned(compare_size_for_test - 1 downto 0);
	signal compare_2A  : unsigned(compare_size_for_test - 1 downto 0);
	signal compare_2B  : unsigned(compare_size_for_test - 1 downto 0);
	signal output_A    : std_logic_vector(2 downto 0);
	signal output_B    : std_logic_vector(2 downto 0);

	constant clock_period : time := 20 ns;

begin
	dut : component Timer
		port map(
			clock       => clock,
			reset       => reset,
			timer_reset => timer_reset,
			timer_mode  => timer_mode,
			prescaler   => prescaler,
			top_counter => top_counter,
			compare_0A  => compare_0A,
			compare_0B  => compare_0B,
			compare_1A  => compare_1A,
			compare_1B  => compare_1B,
			compare_2A  => compare_2A,
			compare_2B  => compare_2B,
			output_A    => output_A,
			output_B    => output_B
		);

	test_clock : process
	begin
		clock <= '0';
		wait for clock_period;
		clock <= '1';
		wait for clock_period;
	end process;

	test : process
	begin
		-- reset:
		reset       <= '1';
		timer_reset <= '0';
		prescaler   <= (others => '0');
		timer_mode  <= (others => '0');
		compare_0A  <= (others => '0');
		compare_0B  <= (others => '0');
		compare_1A  <= (others => '0');
		compare_1B  <= (others => '0');
		compare_2A  <= (others => '0');
		compare_2B  <= (others => '0');
		wait for 1 * clock_period;

		-- configure to mode 03:
		timer_mode <= "11";
		prescaler  <= x"0001";
		top_counter <= x"A";
		compare_0A <= x"2";
		compare_0B <= x"4";
		compare_1A <= x"6";
		compare_1B <= x"8";
		compare_2A <= x"A";
		compare_2B <= x"C";
		wait for 1 * clock_period;

		-- run timer:
		reset <= '0';
		wait for 100 * clock_period;

		-- reset timer:
		timer_reset <= '1';
		wait for 1 * clock_period;

		-- run timer again:
		timer_reset <= '0';
		wait for 10 * clock_period;

		wait;
	end process;

end architecture stimulus;
