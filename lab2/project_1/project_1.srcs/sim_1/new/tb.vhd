library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_two_counter is
end tb_two_counter;

architecture Behavioral of tb_two_counter is
    COMPONENT two_counter
     Port(i_clk:in std_logic;  
          i_rst:in std_logic; 
          o_count1 : out std_logic_vector(3 downto 0);
          o_count2 : out std_logic_vector(3 downto 0)
          );
    END COMPONENT;
    signal i_clk : std_logic := '0'; 
    signal i_rst : std_logic := '0'; 
    signal o_count1:std_logic_vector(3 downto 0);
    signal o_count2:std_logic_vector(3 downto 0);
    
    constant i_clk_period: time :=10ns;
    
begin
     uut: two_counter PORT MAP (
     i_clk =>I_clk,
     i_rst =>I_rst,
     o_count1 => o_count1,
     o_count2 => o_count2
    );
    
   i_clk_process:process
   begin
       i_clk <= '0';
       wait for i_clk_period/2;
       i_clk <= '1';
       wait for i_clk_period/2;
   end process;
   
   stim_proc: process
   begin
   i_rst  <= '0';
   wait for 100ns;
   i_rst  <= '1';
   wait for i_clk_period*20;
   
   wait;
   end process;
END;    
