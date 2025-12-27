library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity image_processor_top is
    Port (   --girisler ve clock
        clk        : in  std_logic;
        r_in       : in  unsigned(7 downto 0);
        g_in       : in  unsigned(7 downto 0);
        b_in       : in  unsigned(7 downto 0);
        -- cikislar
        pixel_out_r : out unsigned(7 downto 0);
        pixel_out_g : out unsigned(7 downto 0);
        pixel_out_b : out unsigned(7 downto 0)
    );
end image_processor_top;

architecture Behavioral of image_processor_top is

    -- Baglanti sinyalleri
    signal s_gray       : unsigned(7 downto 0);
    signal s_p11, s_p12, s_p13 : unsigned(7 downto 0);
    signal s_p21, s_p22, s_p23 : unsigned(7 downto 0);
    signal s_p31, s_p32, s_p33 : unsigned(7 downto 0);
    signal s_is_edge    : std_logic;

begin

    -- 1. modul rgb den gri ye donustur
    U1: entity work.rgb_to_gray
    port map (
        clk      => clk,
        r_in     => r_in,
        g_in     => g_in,
        b_in     => b_in,
        gray_out => s_gray
    );

    -- 2. modul line buffer 3x3 olustur
    U2: entity work.line_buffer
    port map (
        clk      => clk,
        pixel_in => s_gray,
        p11 => s_p11, p12 => s_p12, p13 => s_p13,
        p21 => s_p21, p22 => s_p22, p23 => s_p23,
        p31 => s_p31, p32 => s_p32, p33 => s_p33
    );

    -- 3. modul  sobel algoritmasi mapping
    U3: entity work.sobel_core
    port map (
        clk      => clk,
        p11 => s_p11, p12 => s_p12, p13 => s_p13,
        p21 => s_p21, p22 => s_p22, p23 => s_p23,
        p31 => s_p31, p32 => s_p32, p33 => s_p33,
        edge_out => s_is_edge
    );

    -- cikis mantigini kurma kenar tespiti varsa yesil yoksa gri
    process(clk)
    begin
        if rising_edge(clk) then
            if s_is_edge = '1' then
                pixel_out_r <= x"00"; 
                pixel_out_g <= x"FF"; -- kenarlar yesil
                pixel_out_b <= x"00"; 
            else
                -- kenar olmayan yerleri griye cevir
                pixel_out_r <= s_gray;
                pixel_out_g <= s_gray;
                pixel_out_b <= s_gray;
            end if;
        end if;
    end process;

end Behavioral;