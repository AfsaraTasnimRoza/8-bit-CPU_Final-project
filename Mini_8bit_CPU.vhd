library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Mini_8bit_CPU is
    Port (
        CLK   : in  STD_LOGIC;
        RESET : in  STD_LOGIC;
        Q     : out STD_LOGIC_VECTOR(7 downto 0);
        Z     : out STD_LOGIC;
        PC    : out STD_LOGIC_VECTOR(3 downto 0)
    );
end Mini_8bit_CPU;
architecture Structural of Mini_8bit_CPU is

    signal pc_out   : STD_LOGIC_VECTOR(3 downto 0);
    signal pc_next  : STD_LOGIC_VECTOR(3 downto 0);
    signal instr    : STD_LOGIC_VECTOR(11 downto 0);
    signal opcode   : STD_LOGIC_VECTOR(3 downto 0);

    signal alu_sel  : STD_LOGIC_VECTOR(1 downto 0);
    signal alu_out  : STD_LOGIC_VECTOR(7 downto 0);

    signal acc_en   : STD_LOGIC;
    signal r_en     : STD_LOGIC;
    signal z_en     : STD_LOGIC;
    signal pc_jump  : STD_LOGIC;
	   signal acc_out  : STD_LOGIC_VECTOR(7 downto 0);
    signal r_out    : STD_LOGIC_VECTOR(7 downto 0);
    signal z_out    : STD_LOGIC;
    signal acc_data : STD_LOGIC_VECTOR(7 downto 0);

begin

    -- Program Counter: increment after each instruction
    pc_next <= std_logic_vector(unsigned(pc_out) + 1);

    U_PC : entity work.PC
        port map (
		CLK     => CLK,
            RESET   => RESET,
            PC_NEXT => pc_next,
            PC_OUT  => pc_out
        );

    -- Program ROM
    U_ROM : entity work.Program_ROM
        port map (
            PC    => pc_out,
            INSTR => instr
        );
	 opcode <= instr(11 downto 8);

    -- Control Unit
    U_CONTROL : entity work.Control_Unit
        port map (
            INSTR   => instr,
            ALU_SEL => alu_sel,
            ACC_EN  => acc_en,
            R_EN    => r_en,
            Z_EN    => z_en,
            PC_JUMP => pc_jump
        );
	    -- Arithmetic Logic Unit
    U_ALU : entity work.ALU
        port map (
            ACC_IN  => acc_out,
            OPERAND => instr(7 downto 0),
            ALU_SEL => alu_sel,
            ALU_OUT => alu_out
        );
  -- Select data for the accumulator
    process(opcode, instr, r_out, alu_out)
    begin
        case opcode is
            when "0001" =>
                acc_data <= instr(7 downto 0); -- LDI

            when "1011" =>
                acc_data <= r_out;             -- LDR

            when others =>
                acc_data <= alu_out;           -- ADD / SUB
        end case;
    end process;
  -- CPU Registers
    U_REGISTERS : entity work.CPU_Registers
        port map (
            CLK       => CLK,
            RESET     => RESET,
            ACC_EN    => acc_en,
            R_EN      => r_en,
            Z_EN      => z_en,
            ACC_DATA  => acc_data,
            R_DATA_IN => acc_out,
            ACC_OUT   => acc_out,
            R_OUT     => r_out,
            Z_OUT     => z_out
        );
		   -- External outputs
    Q  <= acc_out;
    Z  <= z_out;
    PC <= pc_out;

end Structural;
