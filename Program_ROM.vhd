library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Program_ROM is
    Port (
        PC      : in  STD_LOGIC_VECTOR(3 downto 0);
        INSTR   : out STD_LOGIC_VECTOR(11 downto 0)
    );
end Program_ROM;

architecture Behavioral of Program_ROM is
  type rom_type is array (0 to 15) of
        STD_LOGIC_VECTOR(11 downto 0);

    constant ROM : rom_type := (
        0  => x"164", -- LDI 0x64
        1  => x"A00", -- STA
        2  => x"314", -- SUB 0x14
        3  => x"20A", -- ADD 0x0A
        4  => x"A00", -- STA
        5  => x"35A", -- SUB 0x5A
        6  => x"B00", -- LDR
        7  => x"360", -- SUB 0x60
        others => x"000"
    );

begin

    INSTR <= ROM(to_integer(unsigned(PC)));

end Behavioral; 
