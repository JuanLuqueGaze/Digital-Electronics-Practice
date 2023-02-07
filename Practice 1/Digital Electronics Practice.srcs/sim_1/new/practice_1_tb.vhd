
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE STD.ENV.FINISH;

ENTITY practice_1_tb IS
    --  Port ( );
END practice_1_tb;

ARCHITECTURE Behavioral OF practice_1_tb IS
    COMPONENT practice_1
        GENERIC (
            N : INTEGER := 4
        );
        PORT (

            data_input : IN signed((N - 1) DOWNTO 0);
            clk : IN STD_LOGIC;
            clear : IN STD_LOGIC;
            load : IN STD_LOGIC;
            data_output : OUT unsigned((N - 1) DOWNTO 0));
    END COMPONENT;
    CONSTANT bits : INTEGER := 4;
    SIGNAL clk, clear, load : STD_LOGIC := '0';
    SIGNAL data_output : unsigned((bits - 1) DOWNTO 0);
    SIGNAL data_input : signed((bits - 1) DOWNTO 0);
    CONSTANT clk_period : TIME := 10ns;
BEGIN
    DUT : practice_1
    GENERIC MAP(
        N => bits
    )

    PORT MAP(
        clk => clk,
        data_output => data_output,
        data_input => data_input,
        clear => clear,
        load => load
    );

    clk_process : PROCESS
    BEGIN
        clk <= '1';
        WAIT FOR clk_period/2;
        clk <= '0';
        WAIT FOR clk_period/2;
    END PROCESS;

    data_process : PROCESS
    BEGIN
        WAIT FOR 17ns;
        load <= '1';
        data_input <= "0100";
        WAIT FOR 40ns;
        load <= '0';
        WAIT FOR 1800ns;
        clear <= '1';
        WAIT FOR 40ns;
        FINISH;

    END PROCESS;

END Behavioral;