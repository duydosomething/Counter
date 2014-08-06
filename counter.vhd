----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:44:06 07/16/2014 
-- Design Name: 
-- Module Name:    counter - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all; 

entity counter is
generic(n: integer := 4);
port( clock:      in std_logic;
      reset:      in std_logic;
      UpDownCount: in std_logic;
      a, b, c, d, e, f, g : out std_logic
	  );
end counter;

ARCHITECTURE behavior of counter is
signal Q:     std_logic_vector(n-1 downto 0);

signal SlowClock:std_logic := '0';

begin
process (clock)
variable counter: integer := 0;
begin
        if(clock'event and clock = '1') then
               if(counter >= 0 and counter < 25000000) then
                       counter := counter +1;
                       SlowClock <= '0';
               elsif (counter < 50000000) then
                       counter := counter +1;
                       SlowClock <= '1';
               else
                       counter := 0;
               end if;
        end if;
end process;

process(SlowClock, reset, Q)
begin
	if reset = '1' then
		Q <= "0000";
	elsif(SlowClock'event and SlowClock ='1') then
	 	if UpDownCount = '1' then
			Q <= std_logic_vector(unsigned(Q) + 1);
		else
			Q <= std_logic_vector(unsigned(Q) - 1);
		end if;
	end if;
			
end process;
	process(Q)
		begin
		 a <= (not(Q(3)) and not(Q(2)) and not(Q(1)) and Q(0)) or 
		      (not(Q(3)) and Q(2) and not(Q(1)) and not(Q(0))) or 
		      (Q(3) and Q(2) and not(Q(1)) and Q(0)) or 
		      (Q(3) and not(Q(2)) and Q(1) and Q(0)); 
		b <= (not(Q(3)) and Q(2) and not(Q(1)) and Q(0)) or
		     (Q(2) and Q(1) and not(Q(0))) or
		     (Q(3) and Q(1) and Q(0)) or 
		     (Q(3) and Q(2) and not(Q(1)) and not(Q(0))); 
		c <= (not(Q(3)) and not(Q(2)) and Q(1) and not(Q(0))) or
		     (Q(3) and Q(2) and not(Q(1)) and not(Q(0))) or 
		     (Q(3) and Q(2) and Q(1)); 
		d <= (not(Q(3)) and Q(2) and not(Q(1)) and not(Q(0))) or 
		     (not(Q(3)) and not(Q(2)) and not(Q(1)) and Q(0)) or
		     (Q(2) and Q(1) and Q(0)) or
		     (Q(3) and not(Q(2)) and Q(1) and not(Q(0))); 
		e <= (not(Q(3)) and Q(2) and not(Q(1)) and not(Q(0))) or 
			  (not(Q(3)) and Q(0)) or
			  (Q(3) and not(Q(2)) and not(Q(1)) and Q(0)); 
		f <= (not(Q(3)) and not(Q(2)) and not(Q(1)) and Q(0)) or
		     (not(Q(3)) and not(Q(2)) and Q(1) and not(Q(0))) or
		     (not(Q(3)) and Q(1) and Q(0)) or 
		     (Q(3) and Q(2) and not(Q(1)) and Q(0)); 
		g <= (not(Q(3) or Q(2) or Q(1))) or
		     (not(Q(3)) and Q(2) and Q(1) and Q(0)) or
		    (Q(3) and Q(2) and not(Q(1)) and not(Q(0)));
	end process;
 
end behavior;