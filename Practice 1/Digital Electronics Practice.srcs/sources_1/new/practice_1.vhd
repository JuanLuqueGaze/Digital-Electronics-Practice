--Descripción de un contador progresivo-regresivo de 8 bits con carga de datos y borrado, sincrono
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
ENTITY practice_1 IS
    GENERIC (
        N : INTEGER := 4
    );
    PORT (
        SIGNAL data_input : IN signed((N - 1) DOWNTO 0);
        SIGNAL clk : IN STD_LOGIC;
        SIGNAL load : IN STD_LOGIC;
        SIGNAL clear : IN STD_LOGIC;
        SIGNAL data_output : OUT unsigned((N - 1) DOWNTO 0)
    );
END practice_1;

ARCHITECTURE Behavioral OF practice_1 IS
    SIGNAL data : signed((N - 1) DOWNTO 0);
    SIGNAL add : signed(1 DOWNTO 0);
BEGIN

    counter : PROCESS (data_input, clk, clear, load)
    BEGIN
        IF load THEN
            data <= data_input;
            add <= "11";
        END IF;
        IF rising_edge(clk) AND load = '0' THEN
            CASE (data) IS
                WHEN "0000" =>
                    CASE(add) IS
                    WHEN "11" =>
                        add <= "01";
                    WHEN "01" =>
                        data <= data + add;
                    WHEN OTHERS =>
                        add <= "00";
                    END CASE;
                WHEN "1111" =>
                    CASE(add) IS
                    WHEN "01" =>
                        add <= "11";
                    WHEN "11" =>
                        data <= data + add;
                    WHEN OTHERS =>
                        add <= "00";
                    END CASE;
                WHEN OTHERS =>
                    data <= data + add;
            END CASE;
        END IF;

        IF clear THEN
            data <= (OTHERS => '0');
        END IF;
    END PROCESS;
    data_output <= unsigned(data);

END Behavioral;