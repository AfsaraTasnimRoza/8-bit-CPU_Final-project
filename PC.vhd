library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PC is
    Port (
        CLK     : in  STD_LOGIC;
        RESET   : in  STD_LOGIC;
        PC_NEXT : in  STD_LOGIC_VECTOR(3 downto 0);
        PC_OUT  : out STD_LOGIC_VECTOR(3 downto 0)
    );
end PC;

architecture Behavioral of PC is
    signal pc_reg : unsigned(3 downto 0) := (others => '0');
begin
 process(CLK)
    begin
        if rising_edge(CLK) then
            if RESET = '1' then
                pc_reg <= (others => '0');
            else
                pc_reg <= unsigned(PC_NEXT);
            end if;
        end if;
    end process;

    PC_OUT <= std_logic_vector(pc_reg);

end Behavioral;
