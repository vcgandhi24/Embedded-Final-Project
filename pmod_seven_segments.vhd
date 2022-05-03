--------------------------------------------------------------------------------
--
--   FileName:         pmod_seven_segments.vhd
--   Dependencies:     seven_segments.vhd, binary_to_bcd.vhd,
--                     binary_to_bcd_digit.vhd, bcd_to_7seg_display.vhd
--   Design Software:  Vivado 2017.2
--
--   HDL CODE IS PROVIDED "AS IS."  DIGI-KEY EXPRESSLY DISCLAIMS ANY
--   WARRANTY OF ANY KIND, WHETHER EXPRESS OR IMPLIED, INCLUDING BUT NOT
--   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
--   PARTICULAR PURPOSE, OR NON-INFRINGEMENT. IN NO EVENT SHALL DIGI-KEY
--   BE LIABLE FOR ANY INCIDENTAL, SPECIAL, INDIRECT OR CONSEQUENTIAL
--   DAMAGES, LOST PROFITS OR LOST DATA, HARM TO YOUR EQUIPMENT, COST OF
--   PROCUREMENT OF SUBSTITUTE GOODS, TECHNOLOGY OR SERVICES, ANY CLAIMS
--   BY THIRD PARTIES (INCLUDING BUT NOT LIMITED TO ANY DEFENSE THEREOF),
--   ANY CLAIMS FOR INDEMNITY OR CONTRIBUTION, OR OTHER SIMILAR COSTS.
--
--   Version History
--   Version 1.0 02/13/2019 Scott Larson
--     Initial Public Release
--    
--------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY pmod_seven_segments IS
  GENERIC(
    clk_freq : INTEGER := 100);  --the provided system clock frequency in MHz
  PORT(
    clk          : IN      STD_LOGIC;                      --system clock
    reset_n      : IN      STD_LOGIC;                      --active low reset
    number       : IN      INTEGER;                        --number to display on the 7 segment displays
    digit_select : BUFFER  STD_LOGIC;                      --output to the pmod digit select pin
    segments     : OUT     STD_LOGIC_VECTOR(6 DOWNTO 0));  --outputs to the pmod seven segment displays
END pmod_seven_segments;

ARCHITECTURE behavior OF pmod_seven_segments IS
  SIGNAL both_7seg : STD_LOGIC_VECTOR(13 DOWNTO 0);  --values of both 7-segment digits

  --declare 7-Segment Display Driver for Multiple Digits
  COMPONENT seven_segments IS
    GENERIC(
      bits        : INTEGER := 7;      --allowable size of the input numbers in bits
      digits      : INTEGER := 2;      --number of seven segment displays
      ss_polarity : STD_LOGIC := '1'); --7-seg display connection polarity, '0' = common anode, '1' = common cathode
    PORT(
      clk           : IN  STD_LOGIC;                              --system clock
      reset_n       : IN  STD_LOGIC;                              --active low asynchronus reset        
      number        : IN  INTEGER;                                --number to display on the 7 segment displays
      displays_7seg : OUT STD_LOGIC_VECTOR(digits*7-1 DOWNTO 0)); --outputs to 7 segment displays
  END COMPONENT seven_segments;

BEGIN

  --instantiate and configure the 7-Segment Display Driver for Multiple Digits
  seven_segments_0:  seven_segments
    GENERIC MAP(bits => 7, digits => 2, ss_polarity => '1')
    PORT MAP(clk => clk, reset_n => reset_n, number => number, displays_7seg => both_7seg);

  --muliplex the values for the 2 7-segment displays on the output pins
  PROCESS(clk)
    VARIABLE count : INTEGER RANGE 0 TO 5000*clk_freq-1 := 0; --count clock pulses to time digit multiplexing
  BEGIN
    IF(reset_n = '0') THEN                    --asynchronous reset
      count := 0;                               --clear counter
      digit_select <= '0';                      --clear digit selection output
      segments <= (OTHERS => '0');              --clear outputs to 7-segment displays
    ELSIF(clk'EVENT AND clk = '1') THEN       --system clock rising edge
      IF(count < 5000*clk_freq-1) THEN          --time is less than 5ms
        count := count + 1;                       --continue counting
      ELSE                                      --time is 5ms
        count := 0;                               --reset timer
        IF(digit_select = '0') THEN               --right digit currently lit
          digit_select <= '1';                      --select left digit
          segments <= both_7seg(13 DOWNTO 7);       --output segment values for left digit
        ELSE                                      --left digit currently lit
          digit_select <= '0';                      --select right digit
          segments <= both_7seg(6 DOWNTO 0);        --output segment values for right digit
        END IF;
      END IF;
    END IF;
  END PROCESS; 

END behavior;