------------------------------------------------------------------
--Authors : Sarah D. Perea, Anne Jerusalemm
--			T-2L
------------------------------------------------------------------
library IEEE; use IEEE.std_logic_1164.all;

-- Entity Definition
entity buzzers is
	port(valid: out std_logic; --true if >= 1 asserted
	encoded: out std_logic; --binary encoded output
	i: in std_logic_vector(5 downto 0));

end entity buzzers;

-- Architecture Definition
architecture priority of buzzers is
begin
	process(i(5), i(4), i(3), i(2), i(1), i(0)) is --activate when any input changes
	begin
		if((i(5)='1') or (i(4)='1') or (i(3)='1') or (i(2)='1') or (i(1)='1') or (i(0)='1'))
			then valid <= '1'; --indicates valid output
		else
			valid <= '0';
		end if;
		 -- check i(5) first, then others
		--if the IN buzzer and OUT buzzer are ON for the same storage:
		if ((i(5)='1') and (i(4)='1')) or ((i(3)='1') and (i(2)='1')) or ((i(1)='1') and (i(0)='1')) then encoded <= '1';
		--if all buzzers are on
		elsif(i(5)='1') and (i(4)='1') and (i(3)='1') and (i(2)='1') and (i(1)='1') and (i(0)='1') then encoded <= '1';
		--if the IN buzzer and the OUT buzzer is ON regardless of the storage
		elsif((i(5)='1') or (i(3)='1') or (i(1)='1')) and ((i(4)='1') or (i(2)='1') or (i(0)='1') ) then encoded <= '1';
		else encoded <= '0';
		end if;
	end process;
end architecture priority;
