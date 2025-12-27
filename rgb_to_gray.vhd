library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity rgb_to_gray is
    Port ( 
        clk   : in  STD_LOGIC;
        r_in  : in  unsigned(7 downto 0);
        g_in  : in  unsigned(7 downto 0);
        b_in  : in  unsigned(7 downto 0);
        gray_out : out unsigned(7 downto 0)
    );
end rgb_to_gray;

architecture Behavioral of rgb_to_gray is
begin
    process(clk)
    begin
        if rising_edge(clk) then
            -- yaklasik griye cevirmek icin formul 0.25*R + 0.5*G + 0.25*B
            -- 4 e bolmek icin 2 bit saga kaydirdim 
            gray_out <= shift_right(r_in, 2) + shift_right(g_in, 1) + shift_right(b_in, 2);
        end if;
    end process;
end Behavioral;