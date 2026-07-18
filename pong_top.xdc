
set_property CFGBVS VCCO        [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]

#######################################
##   on-board 100 MHz clock signal   ##
#######################################

set_property -dict {PACKAGE_PIN E3 IOSTANDARD LVCMOS33} [get_ports {clk_100MHz}] ; #IO_L12P_T1_MRCC_35 Sch=gclk[100]
create_clock -period 10.000 -name clk -waveform {0.000 5.000} -add [get_ports {clk_100MHz}]


########################
##   slide switches   ##
########################


set_property -dict { PACKAGE_PIN A8   IOSTANDARD LVCMOS33 } [get_ports { sw[0] }]   ; #IO_L12N_T1_MRCC_16 Sch=sw[0]
set_property -dict { PACKAGE_PIN C11  IOSTANDARD LVCMOS33 } [get_ports { sw[1] }]   ; #IO_L13P_T2_MRCC_16 Sch=sw[1]
#set_property -dict { PACKAGE_PIN C10  IOSTANDARD LVCMOS33 } [get_ports { sw[2] }]   ; #IO_L13N_T2_MRCC_16 Sch=sw[2]
#set_property -dict { PACKAGE_PIN A10  IOSTANDARD LVCMOS33 } [get_ports { sw[3] }]   ; #IO_L14P_T2_SRCC_16 Sch=sw[3]

######################
##   push-buttons   ##
######################

set_property -dict { PACKAGE_PIN D9  IOSTANDARD LVCMOS33 } [get_ports { btn[0] }]   ; #IO_L6N_T0_VREF_16 Sch=btn[0]
set_property -dict { PACKAGE_PIN C9  IOSTANDARD LVCMOS33 } [get_ports { btn[1] }]   ; #IO_L11P_T1_SRCC_16 Sch=btn[1]
set_property -dict { PACKAGE_PIN B9  IOSTANDARD LVCMOS33 } [get_ports { btn[2] }]   ; #IO_L11N_T1_SRCC_16 Sch=btn[2]
set_property -dict { PACKAGE_PIN B8  IOSTANDARD LVCMOS33 } [get_ports { btn[3] }]   ; #IO_L12P_T1_MRCC_16 Sch=btn[3]

## Pmod Header JA - Usato per il RESET
set_property -dict { PACKAGE_PIN G13  IOSTANDARD LVCMOS33 } [get_ports { reset }]   ; #IO_0_15 Sch=ja[1]

## Pmod Header JB - Usato per Rosso (R) e Blu (B)
set_property -dict { PACKAGE_PIN E16   IOSTANDARD LVCMOS33 } [get_ports { vga_r[0] }];  
set_property -dict { PACKAGE_PIN E15   IOSTANDARD LVCMOS33 } [get_ports { vga_r[1] }];  
set_property -dict { PACKAGE_PIN D15   IOSTANDARD LVCMOS33 } [get_ports { vga_r[2] }]; 
set_property -dict { PACKAGE_PIN C15   IOSTANDARD LVCMOS33 } [get_ports { vga_r[3] }]; 
set_property -dict { PACKAGE_PIN J17   IOSTANDARD LVCMOS33 } [get_ports { vga_b[0] }];  
set_property -dict { PACKAGE_PIN J18   IOSTANDARD LVCMOS33 } [get_ports { vga_b[1] }];  
set_property -dict { PACKAGE_PIN K15   IOSTANDARD LVCMOS33 } [get_ports { vga_b[2] }];  
set_property -dict { PACKAGE_PIN J15   IOSTANDARD LVCMOS33 } [get_ports { vga_b[3] }];

## Pmod Header JC - Usato per Verde (G) e Sync
set_property -dict { PACKAGE_PIN U12   IOSTANDARD LVCMOS33 } [get_ports { vga_g[0] }];  
set_property -dict { PACKAGE_PIN V12   IOSTANDARD LVCMOS33 } [get_ports { vga_g[1] }];  
set_property -dict { PACKAGE_PIN V10   IOSTANDARD LVCMOS33 } [get_ports { vga_g[2] }];  
set_property -dict { PACKAGE_PIN V11   IOSTANDARD LVCMOS33 } [get_ports { vga_g[3] }];  



set_property -dict { PACKAGE_PIN U14   IOSTANDARD LVCMOS33 } [get_ports { hsync }];
set_property -dict { PACKAGE_PIN V14   IOSTANDARD LVCMOS33 } [get_ports { vsync }];

#######################################
##          Timing Constraints       ##
#######################################

# Specifichiamo che i segnali in uscita devono essere stabili 
# (assumiamo un ritardo massimo generico per porte 3.3V)
#set_output_delay -clock [get_clocks clk] 2.000 [get_ports {hsync vsync rgb[*]}]
#set_input_delay -clock [get_clocks clk] 2.000 [get_ports {sw[*] reset}]
