----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2024/09/21 15:17:45
-- Design Name: 
-- Module Name: counter - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity two_counter is
    Port ( i_clk : in STD_LOGIC;
           i_rst : in STD_LOGIC;
           o_count1 : out STD_LOGIC_VECTOR (3 downto 0);
           o_count2 : out STD_LOGIC_VECTOR (3 downto 0)
         );
end two_counter;

architecture Behavioral of two_counter is

signal count1:STD_LOGIC_VECTOR (3 downto 0);
signal count2:STD_LOGIC_VECTOR (3 downto 0);
signal state:STD_LOGIC;

signal count1_up:STD_LOGIC_VECTOR (3 downto 0);
signal count2_up:STD_LOGIC_VECTOR (3 downto 0);
signal count1_down:STD_LOGIC_VECTOR (3 downto 0);
signal count2_down:STD_LOGIC_VECTOR (3 downto 0);
begin

count1_up <= "0110";  -- 结4じ秈
count2_up <= "1001";  -- 结4じ秈
count1_down <= "0001";  -- 结4じ秈
count2_down <= "0010";  -- 结4じ秈

o_count1 <= count1;
o_count2 <= count2;

FSM: process(i_clk,i_rst)
begin
    if i_rst= '0' then
       state <= '0';
    elsif i_clk'event and i_clk = '1' then
       case state is
           when '0' =>
               if count1= count1_up then
                   state <= '1';
               end if;
           when '1' =>
               if count2=count2_down then 
                   state <= '0';
               end if;
           when others =>
               null;
       end case;
    end if;
end process;

counter1p: process(i_clk,i_rst,state,count1_down)
begin
    if i_rst = '0' then
       count1 <=count1_down;
    elsif i_clk'event and i_clk='1' then
       case state is
           when '0' =>
              count1 <= count1 + '1';
           when '1' =>
               count1 <=count1_down;
           when others =>
               null;
       end case;
    end if;
end process;

counter2p:process(i_clk,i_rst,state,count2_up)
begin
    if i_rst = '0' then
       count2 <=count2_up;
    elsif i_clk'event and i_clk='1' then
       case state is
           when '0' =>
               count2 <=count2_up;
           when '1' =>
           count2<=count2 - '1';
           when others =>
               null;
       end case;
    end if;
end process;

end Behavioral;
