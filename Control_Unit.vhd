library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Control_Unit is
    Port (
        INSTR   : in  STD_LOGIC_VECTOR(11 downto 0);
        ALU_SEL : out STD_LOGIC_VECTOR(1 downto 0);
        ACC_EN  : out STD_LOGIC;
        R_EN    : out STD_LOGIC;
        Z_EN    : out STD_LOGIC;
        PC_JUMP : out STD_LOGIC
    );
end Control_Unit;

architecture Behavioral of Control_Unit is
begin
  process(INSTR)
    begin
        ALU_SEL <= "11";
        ACC_EN  <= '0';
        R_EN    <= '0';
        Z_EN    <= '0';
        PC_JUMP <= '0';

        case INSTR(11 downto 8) is

            when "0001" => -- LDI
                ACC_EN <= '1';
                Z_EN   <= '1';

            when "0010" => -- ADD
                ALU_SEL <= "00";
                ACC_EN  <= '1';
                Z_EN    <= '1';
  when "0011" => -- SUB
                ALU_SEL <= "01";
                ACC_EN  <= '1';
                Z_EN    <= '1';

            when "0100" => -- AND
                ALU_SEL <= "10";
                ACC_EN  <= '1';
                Z_EN    <= '1';

            when "1010" => -- STA
                R_EN <= '1';
   when "1011" => -- LDR
                ACC_EN <= '1';
                Z_EN   <= '1';

            when others =>
                null;

        end case;
    end process;

end Behavioral; 
