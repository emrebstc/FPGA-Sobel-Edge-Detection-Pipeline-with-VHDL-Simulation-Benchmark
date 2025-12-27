library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use STD.TEXTIO.ALL; -- dosya okuma yazma icin kutuphane

entity tb_image_processor is
end tb_image_processor;
-- ****************************************************************************
architecture Behavioral of tb_image_processor is
    -- sinyaller
    signal clk : std_logic := '0';
    signal r_in, g_in, b_in : unsigned(7 downto 0) := (others => '0');
    signal r_out, g_out, b_out : unsigned(7 downto 0);
    signal total_clock_cycles : integer := 0;
    
    -- saat periyodu 10 ns (100MHz)
    constant clk_period : time := 10 ns;
     
-- ****************************************************************************
begin

    clk <= not clk after clk_period/2;

    -- top module bagla
    uut: entity work.image_processor_top
    port map (
        clk => clk,
        r_in => r_in, g_in => g_in, b_in => b_in,
        pixel_out_r => r_out, pixel_out_g => g_out, pixel_out_b => b_out
    );

   -- dosya okuma ve yazma isllemi
    process
        file file_in  : text open read_mode  is "input_image_data.txt";
        file file_out : text open write_mode is "output_image_data.txt";
        variable line_in, line_out : line;
        variable r_v, g_v, b_v : integer;
        variable count : integer := 0;
        
        variable start_time : time;
        variable end_time : time;
        variable total_cycles : integer;
    begin
    
        start_time := now;
        -- sistemi baslat
        wait for clk_period * 5;    

        -- verileri al
        while not endfile(file_in) loop
            readline(file_in, line_in);
            read(line_in, r_v); read(line_in, g_v); read(line_in, b_v);
            
            r_in <= to_unsigned(r_v, 8);
            g_in <= to_unsigned(g_v, 8);
            b_in <= to_unsigned(b_v, 8);
            
            wait for clk_period;
            
            write(line_out, to_integer(r_out)); 
            write(line_out, string'(" "));
            write(line_out, to_integer(g_out));
            write(line_out, string'(" "));
            write(line_out, to_integer(b_out));
            writeline(file_out, line_out);
            
            count := count + 1;
        end loop;

        -- pikselleri bosalt
        for i in 1 to 200 loop
            wait for clk_period;
            write(line_out, to_integer(r_out)); 
            write(line_out, string'(" "));
            write(line_out, to_integer(g_out));
            write(line_out, string'(" "));
            write(line_out, to_integer(b_out));
            writeline(file_out, line_out);
        end loop;
        
        end_time := now;
        total_cycles := integer((end_time - start_time) / clk_period);
        
-- ****************************************************************************
        report "### BENCHMARK RESULTS ###";
        report "Total Processed Pixels: " & integer'image(count);
        report "Total Clock Cycles: " & integer'image(total_cycles);
        report "Latency: " & integer'image(total_cycles - count);
        report "########################";
 -- ****************************************************************************       
        -- simulasyonu durdur
        assert false report "Simulation Completed Successfully" severity note;
        assert false report "STOP" severity failure;
        wait;
    end process;
end Behavioral;