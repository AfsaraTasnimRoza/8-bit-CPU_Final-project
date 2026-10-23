LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Mini_8bit_CPU_tb IS
END Mini_8bit_CPU_tb;

ARCHITECTURE behavior OF Mini_8bit_CPU_tb IS

    COMPONENT Mini_8bit_CPU
    PORT(
        CLK   : IN  std_logic;
        RESET : IN  std_logic;
        Q     : OUT std_logic_vector(7 downto 0);
        Z     : OUT std_logic;
        PC    : OUT std_logic_vector(3 downto 0)
    );
    END COMPONENT;
	  signal CLK   : std_logic := '0';
    signal RESET : std_logic := '1';

    signal Q  : std_logic_vector(7 downto 0);
    signal Z  : std_logic;
    signal PC : std_logic_vector(3 downto 0);

    constant CLK_period : time := 10 ns;

BEGIN
 uut: Mini_8bit_CPU PORT MAP (
        CLK   => CLK,
        RESET => RESET,
        Q     => Q,
        Z     => Z,
        PC    => PC
    );

    CLK_process: process
    begin
        CLK <= '0';
        wait for CLK_period/2;
        CLK <= '1';
        wait for CLK_period/2;
    end process;
	  stim_proc: process
    begin
        RESET <= '1';
        wait for 25 ns;

        RESET <= '0';
        wait for 300 ns;

        wait;
    end process;

END behavior; 
