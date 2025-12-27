library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity line_buffer is
    Port ( 
        clk      : in  std_logic;
        pixel_in : in  unsigned(7 downto 0); -- gri piksel girisi
        -- sobelin 3x3 penceresi icin cikislar P: pixel R: row C: column
        p11, p12, p13 : out unsigned(7 downto 0); -- ust satir
        p21, p22, p23 : out unsigned(7 downto 0); -- orta satir
        p31, p32, p33 : out unsigned(7 downto 0)  -- alt satir (giristen geliyor)
    );
end line_buffer;

-- 1024x1024 resim icin line buffer

architecture Behavioral of line_buffer is 
    type line_array is array (0 to 1023) of unsigned(7 downto 0);
    signal line_1 : line_array := (others => (others => '0'));
    signal line_2 : line_array := (others => (others => '0'));
    signal ptr : integer range 0 to 1023 := 0;

    -- Hata icin ara sinyaller
    signal s_p11, s_p12, s_p13 : unsigned(7 downto 0) := (others => '0');
    signal s_p21, s_p22, s_p23 : unsigned(7 downto 0) := (others => '0');
    signal s_p31, s_p32, s_p33 : unsigned(7 downto 0) := (others => '0');

begin
    -- Ara sinyalleri gercek cikislara bagla
    p11 <= s_p11; p12 <= s_p12; p13 <= s_p13;
    p21 <= s_p21; p22 <= s_p22; p23 <= s_p23;
    p31 <= s_p31; p32 <= s_p32; p33 <= s_p33;

    process(clk)
    begin
        if rising_edge(clk) then
            -- sinyalleri okuyup yaz
            s_p13 <= line_1(ptr);
            s_p12 <= s_p13;
            s_p11 <= s_p12;

            s_p23 <= line_2(ptr);
            s_p22 <= s_p23;
            s_p21 <= s_p22;

            s_p33 <= pixel_in;
            s_p32 <= s_p33;
            s_p31 <= s_p32;

            line_1(ptr) <= line_2(ptr);
            line_2(ptr) <= pixel_in;

            if ptr = 1023 then
                ptr <= 0;
            else
                ptr <= ptr + 1;
            end if;
        end if;
    end process;
end Behavioral;