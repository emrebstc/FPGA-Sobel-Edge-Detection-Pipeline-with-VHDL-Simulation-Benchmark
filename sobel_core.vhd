library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity sobel_core is
    Port ( 
        clk      : in  std_logic;
        -- 3x3 pencere girisleri
        p11, p12, p13 : in unsigned(7 downto 0);
        p21, p22, p23 : in unsigned(7 downto 0);
        p31, p32, p33 : in unsigned(7 downto 0);
        edge_out : out std_logic -- kenar sonucu
    );
end sobel_core;

architecture Behavioral of sobel_core is
    signal Gx, Gy : signed(10 downto 0) := (others => '0');
    signal G_sum  : unsigned(10 downto 0) := (others => '0');
    constant THRESHOLD : unsigned(7 downto 0) := x"41"; -- esik deger (65 suan)
begin
    process(clk)
    begin
        if rising_edge(clk) then
            -- Gx hesapla: (p13 + 2*p23 + p33) - (p11 + 2*p21 + p31)
            -- p<<1 yaparak 2 ile carpma islemi
            
            Gx <= signed(resize(p13, 11)) + signed(resize(p23 & '0', 11)) + signed(resize(p33, 11)) - 
                  signed(resize(p11, 11)) - signed(resize(p21 & '0', 11)) - signed(resize(p31, 11));

            -- Gy hesapla: (p31 + 2*p32 + p33) - (p11 + 2*p12 + p13)
            Gy <= signed(resize(p31, 11)) + signed(resize(p32 & '0', 11)) + signed(resize(p33, 11)) - 
                  signed(resize(p11, 11)) - signed(resize(p12 & '0', 11)) - signed(resize(p13, 11));

            -- gradyanlarin toplami |Gx| + |Gy|
            G_sum <= unsigned(abs(Gx)) + unsigned(abs(Gy));

            -- esik deger kontrolu
            if G_sum > THRESHOLD then
                edge_out <= '1'; -- kenar tespit edilme bayragi
            else
                edge_out <= '0';
            end if;
        end if;
    end process;
end Behavioral;