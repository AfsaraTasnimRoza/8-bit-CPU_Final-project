library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CPU_Registers is
    Port (
        CLK       : in  STD_LOGIC;
        RESET     : in  STD_LOGIC;
        ACC_EN    : in  STD_LOGIC;
        R_EN      : in  STD_LOGIC;
        Z_EN      : in  STD_LOGIC;
        ACC_DATA  : in  STD_LOGIC_VECTOR(7 downto 0);
        R_DATA_IN : in  STD_LOGIC_VECTOR(7 downto 0);
        ACC_OUT   : out STD_LOGIC_VECTOR(7 downto 0);
        R_OUT     : out STD_LOGIC_VECTOR(7 downto 0);
        Z_OUT     : out STD_LOGIC
		      );
end CPU_Registers;

architecture Behavioral of CPU_Registers is

    signal acc_reg : STD_LOGIC_VECTOR(7 downto 0) := x"00";
    signal r_reg   : STD_LOGIC_VECTOR(7 downto 0) := x"00";
    signal z_reg   : STD_LOGIC := '1';

begin

    process(CLK)
    begin
	   if rising_edge(CLK) then
            if RESET = '1' then
                acc_reg <= x"00";
                r_reg   <= x"00";
                z_reg   <= '1';
            else
                if ACC_EN = '1' then
                    acc_reg <= ACC_DATA;
                end if;

                if R_EN = '1' then
                    r_reg <= R_DATA_IN;
                end if;

                if Z_EN = '1' and ACC_EN = '1' then
                    if ACC_DATA = x"00" then
                        z_reg <= '1';
                    else
                        z_reg <= '0';
                    end if;
                end if;
            end if;
        end if;
    end process;
    ACC_OUT <= acc_reg;
    R_OUT   <= r_reg;
    Z_OUT   <= z_reg;

end Behavioral; 
