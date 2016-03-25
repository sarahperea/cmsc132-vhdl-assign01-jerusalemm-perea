library IEEE; use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-- Entity Definition
entity t2l_jerusalemm_perea_tb is --constants are defined here
	constant MAX_COMB: integer := 64; -- number of input combinations (6 bits)
	constant DELAY: time := 10 ns; -- delay value in testing
end entity t2l_jerusalemm_perea_tb;

architecture tb of t2l_jerusalemm_perea_tb is
	signal valid: std_logic; --valid data indicator from the UUT
	signal encoded: std_logic; -- the binary encoded data output from the UUT
	signal i: std_logic_vector(5 downto 0); -- inputs to UUT
	
	--Component declaration
	component buzzers is
		port(valid: out std_logic;
		encoded: out std_logic; -- binary encoded output
		i : in std_logic_vector(5 downto 0));
	end component buzzers;
	
	begin -- begin main body of the tb architecture
		-- instantiates the unit under test
		UUT: component buzzers port map(valid, encoded, i);
		
		-- main process: generate test vectors and check results
		main: process is
			variable temp: unsigned(5 downto 0); -- used in calculations
			variable expected_valid: std_logic;
			variable expected_encoded: std_logic;
			variable error_count: integer := 0; --number of simulation errors
			
		begin
			report "Start simulation.";
			
			-- generate all possible input values, since max = 63
			for count in 0 to 63 loop
				temp := TO_UNSIGNED(count, 6);
				i(5) <= std_logic(temp(5)); --6th bit
				i(4) <= std_logic(temp(4)); --5th bit
				i(3) <= std_logic(temp(3)); --4th bit
				i(2) <= std_logic(temp(2)); --3rd bit
				i(1) <= std_logic(temp(1)); --2nd bit
				i(0) <= std_logic(temp(0)); --1st bit
				
				--compute expected values
				if(count=0) then
					expected_valid := '0';
					expected_encoded := '0';
				else
					expected_valid := '1';
					if count=1 or count=2 or count=4 or count=5 or count=8 or count=10 or count=16 or
						count=17 or count=20 or count=21 or count=32 or count=34 or count=40 or count=42 then expected_encoded := '0';
					else expected_encoded := '1';
					end if; -- of check with i > 0
				end if; -- of if (i = 0) .. else
				
				wait for DELAY; -- wait, and then compare with UUT outputs
				
				-- check if output of circuit is the same as the expected value
				assert ((expected_valid = valid) and (expected_encoded = encoded))
					report "ERROR: Expected valid " &
						std_logic'image(expected_valid) & " and encoded " &
						std_logic'image(expected_encoded) & " at time " & time'image(now);
						
				-- increment number of errors
				if((expected_valid/=valid) or (expected_encoded/=encoded)) then
					error_count := error_count + 1;
				end if;
			end loop;
			
			wait for DELAY;
			
			--report errors
			assert(error_count=0)
				report "ERROR: There were " &
					integer'image(error_count) & "errors!";
					
			-- there are no errors
			if(error_count = 0) then
				report "Simulation completed with NO errors.";
			end if;
			
			wait; -- terminate the simulation
		end process;
	end architecture tb;
				
				
				
				
				
				
				
				
				
				
				
				
				
