library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- entity declaration for your testbench.Dont declare any ports here
ENTITY enocoro_tb IS
END ;

ARCHITECTURE arc OF enocoro_tb IS
	-- Component Declaration for the Unit Under Test (UUT)
	COMPONENT enocoro is
port(	
clk: in std_logic;
reset_n: in std_logic;
Data_in : in std_logic_vector(7 downto 0);   
Data_out : out std_logic_vector(7 downto 0);   
valid : out std_logic   

);
	END COMPONENT;
	
	signal clk : std_logic := '0';
	signal reset_n : std_logic := '0';
	signal Data_in : std_logic_vector(7 downto 0):= x"c9";    	    
    signal Data_out  : std_logic_vector(7 downto 0);   
    signal valid : std_logic;
  	    
---00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 00 10 20 30 40 50 60 70	
-- LSB FIRST


	-- Clock period definitions
	constant clk_period : time := 20 ns;
BEGIN
	-- Instantiate the Unit Under Test (UUT)
	uut : enocoro PORT MAP (
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
	   Data_in<=x"c9";                     
 	    WAIT FOR clk_period;
        WAIT FOR clk_period;      
		WAIT FOR clk_period;
		
		
        reset_n <= '1';
        
        
        Data_in <= x"c9";         
        WAIT FOR clk_period;
        
        Data_in <= x"b8";         
        WAIT FOR clk_period;

        Data_in <= x"a7";         
        WAIT FOR clk_period;
        
         Data_in <= x"96";         
        WAIT FOR clk_period;
        
         Data_in <= x"85";         
        WAIT FOR clk_period;
        
         Data_in <= x"74";         
        WAIT FOR clk_period;
        
         Data_in <= x"83";         
        WAIT FOR clk_period;
        
         Data_in <= x"92";         
        WAIT FOR clk_period;
        
        
        
         Data_in <= x"4c";         
        WAIT FOR clk_period;
        
         Data_in <= x"3b";         
        WAIT FOR clk_period;

         Data_in <= x"2a";         
        WAIT FOR clk_period;    
        
         Data_in <= x"19";         
        WAIT FOR clk_period;       
        
         Data_in <= x"08";         
        WAIT FOR clk_period;        
        
         Data_in <= x"f7";         
       WAIT FOR clk_period;         
        
         Data_in <= x"e6";         
       WAIT FOR clk_period;         
        
         Data_in <= x"d5";         
       WAIT FOR clk_period; 
     
     
         Data_in <= x"c4";         
      WAIT FOR clk_period;
      
       Data_in <= x"b3";         
      WAIT FOR clk_period;

       Data_in <= x"a2";         
      WAIT FOR clk_period;    
      
       Data_in <= x"91";         
      WAIT FOR clk_period;       
      
       Data_in <= x"80";         
      WAIT FOR clk_period;        
      
       Data_in <= x"7f";         
     WAIT FOR clk_period;         
      
       Data_in <= x"6e";         
     WAIT FOR clk_period;         
      
       Data_in <= x"5d";         
     WAIT FOR clk_period; 
                       	
	end process;
	
END;