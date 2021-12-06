library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- entity declaration for your testbench.Dont declare any ports here
ENTITY enocoro_4bits_tb IS
END ;

ARCHITECTURE arc OF enocoro_4bits_tb IS
	-- Component Declaration for the Unit Under Test (UUT)
	COMPONENT enocoro_4bits is
port(	
clk: in std_logic;
reset_n: in std_logic;
Data_in : in std_logic_vector(3 downto 0);   
Data_out : out std_logic_vector(3 downto 0);   
valid : out std_logic   

);
	END COMPONENT;
	
	signal clk : std_logic := '0';
	signal reset_n : std_logic := '0';
	signal Data_in : std_logic_vector(3 downto 0):= x"9";    	    
    signal Data_out  : std_logic_vector(3 downto 0);   
    signal valid : std_logic;
  	    
---00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 00 10 20 30 40 50 60 70	
-- LSB FIRST


	-- Clock period definitions
	constant clk_period : time := 20 ns;
BEGIN
	-- Instantiate the Unit Under Test (UUT)
	uut : enocoro_4bits PORT MAP (
		clk => clk,
		reset_n => reset_n,
		Data_in=> Data_in,
		Data_out=> Data_out,
		valid=> valid
		);      
	
	-- Clock process definitions( clock with 50% duty cycle is generated here.
	clk_process :process
	begin
		clk <= '0';
		wait for clk_period/2;  
		clk <= '1';
		wait for clk_period/2;  
	end process;
	-- Stimulus process
	stim_proc: process
	begin 
	   Data_in<=x"9";                     
 	    WAIT FOR clk_period;
        WAIT FOR clk_period;      
		WAIT FOR clk_period;
		
		
        reset_n <= '1';
        
        
        Data_in <= x"9";         
        WAIT FOR clk_period;
        
        Data_in <= x"c";         
        WAIT FOR clk_period;
        
        Data_in <= x"8";         
        WAIT FOR clk_period;

        Data_in <= x"b";         
        WAIT FOR clk_period;
        
        Data_in <= x"7";         
        WAIT FOR clk_period;

        Data_in <= x"a";         
        WAIT FOR clk_period;
        
        Data_in <= x"6";         
        WAIT FOR clk_period;

        Data_in <= x"9";         
        WAIT FOR clk_period;
        
        Data_in <= x"5";         
        WAIT FOR clk_period;

        Data_in <= x"8";         
        WAIT FOR clk_period;
        
        Data_in <= x"4";         
        WAIT FOR clk_period;

        Data_in <= x"7";         
        WAIT FOR clk_period;
        
        Data_in <= x"3";         
        WAIT FOR clk_period;

        Data_in <= x"8";         
        WAIT FOR clk_period;
        
        Data_in <= x"2";         
        WAIT FOR clk_period;

        Data_in <= x"9";         
        WAIT FOR clk_period;
        
        Data_in <= x"c";         
        WAIT FOR clk_period;

        Data_in <= x"4";         
        WAIT FOR clk_period;
        
        Data_in <= x"b";         
        WAIT FOR clk_period;

        Data_in <= x"3";         
        WAIT FOR clk_period;
        
        Data_in <= x"a";         
        WAIT FOR clk_period;

        Data_in <= x"2";         
        WAIT FOR clk_period;
        
        Data_in <= x"9";         
        WAIT FOR clk_period;

        Data_in <= x"1";         
        WAIT FOR clk_period;
        
        Data_in <= x"8";         
        WAIT FOR clk_period;

        Data_in <= x"0";         
        WAIT FOR clk_period;
        
        Data_in <= x"7";         
        WAIT FOR clk_period;

        Data_in <= x"f";         
        WAIT FOR clk_period;
        
        Data_in <= x"6";         
        WAIT FOR clk_period;

        Data_in <= x"e";         
        WAIT FOR clk_period;
        
        Data_in <= x"5";         
        WAIT FOR clk_period;

        Data_in <= x"d";         
        WAIT FOR clk_period;
        
        Data_in <= x"4";         
        WAIT FOR clk_period;

        Data_in <= x"c";         
        WAIT FOR clk_period;
        
        Data_in <= x"3";         
        WAIT FOR clk_period;

        Data_in <= x"b";         
        WAIT FOR clk_period;
        
        Data_in <= x"2";         
        WAIT FOR clk_period;

        Data_in <= x"a";         
        WAIT FOR clk_period;
        
        Data_in <= x"1";         
        WAIT FOR clk_period;

        Data_in <= x"9";         
        WAIT FOR clk_period;
        
        Data_in <= x"0";         
        WAIT FOR clk_period;

        Data_in <= x"8";         
        WAIT FOR clk_period;
        
        Data_in <= x"f";         
        WAIT FOR clk_period;

        Data_in <= x"7";         
        WAIT FOR clk_period;
        
        Data_in <= x"e";         
        WAIT FOR clk_period;

        Data_in <= x"6";         
        WAIT FOR clk_period;
        
        Data_in <= x"d";         
        WAIT FOR clk_period;

        Data_in <= x"5";         
        WAIT FOR clk_period;
                 	
	end process;
	
END;