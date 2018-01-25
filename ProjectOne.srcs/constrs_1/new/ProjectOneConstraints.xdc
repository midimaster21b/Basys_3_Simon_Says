# clk (100MHz)
set_property PACKAGE_PIN W5 [get_ports SevenSegmentClk]
set_property IOSTANDARD LVCMOS33 [get_ports SevenSegmentClk]

# Seven segment selection pins
set_property PACKAGE_PIN W4 [get_ports {SevenSegmentSelector[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SevenSegmentSelector[3]}]

set_property PACKAGE_PIN V4 [get_ports {SevenSegmentSelector[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SevenSegmentSelector[2]}]

set_property PACKAGE_PIN U4 [get_ports {SevenSegmentSelector[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SevenSegmentSelector[1]}]

set_property PACKAGE_PIN U2 [get_ports {SevenSegmentSelector[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SevenSegmentSelector[0]}]

# Seven segment cathodes
# A cathode
set_property PACKAGE_PIN W7 [get_ports {SevenSegmentOut[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SevenSegmentOut[0]}]

# B cathode
set_property PACKAGE_PIN W6 [get_ports {SevenSegmentOut[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SevenSegmentOut[1]}]

# C cathode
set_property PACKAGE_PIN U8 [get_ports {SevenSegmentOut[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SevenSegmentOut[2]}]

# D cathode
set_property PACKAGE_PIN V8 [get_ports {SevenSegmentOut[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SevenSegmentOut[3]}]

# E cathode
set_property PACKAGE_PIN U5 [get_ports {SevenSegmentOut[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SevenSegmentOut[4]}]

# F cathode
set_property PACKAGE_PIN V5 [get_ports {SevenSegmentOut[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SevenSegmentOut[5]}]

# G cathode
set_property PACKAGE_PIN U7 [get_ports {SevenSegmentOut[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SevenSegmentOut[6]}]

# Output selection
set_property PACKAGE_PIN R2 [get_ports SevenSegmentState]
set_property IOSTANDARD LVCMOS33 [get_ports SevenSegmentState]
