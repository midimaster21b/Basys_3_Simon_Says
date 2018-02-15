# clk (100MHz)
set_property PACKAGE_PIN W5 [get_ports InputClock]
set_property IOSTANDARD LVCMOS33 [get_ports InputClock]

# Seven segment selection pins
set_property PACKAGE_PIN W4 [get_ports {SevenSegmentDisplaySelect[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SevenSegmentDisplaySelect[3]}]

set_property PACKAGE_PIN V4 [get_ports {SevenSegmentDisplaySelect[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SevenSegmentDisplaySelect[2]}]

set_property PACKAGE_PIN U4 [get_ports {SevenSegmentDisplaySelect[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SevenSegmentDisplaySelect[1]}]

set_property PACKAGE_PIN U2 [get_ports {SevenSegmentDisplaySelect[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SevenSegmentDisplaySelect[0]}]

# Seven segment cathodes
# A cathode
set_property PACKAGE_PIN W7 [get_ports {SevenSegmentCharacter[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SevenSegmentCharacter[0]}]

# B cathode
set_property PACKAGE_PIN W6 [get_ports {SevenSegmentCharacter[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SevenSegmentCharacter[1]}]

# C cathode
set_property PACKAGE_PIN U8 [get_ports {SevenSegmentCharacter[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SevenSegmentCharacter[2]}]

# D cathode
set_property PACKAGE_PIN V8 [get_ports {SevenSegmentCharacter[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SevenSegmentCharacter[3]}]

# E cathode
set_property PACKAGE_PIN U5 [get_ports {SevenSegmentCharacter[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SevenSegmentCharacter[4]}]

# F cathode
set_property PACKAGE_PIN V5 [get_ports {SevenSegmentCharacter[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SevenSegmentCharacter[5]}]

# G cathode
set_property PACKAGE_PIN U7 [get_ports {SevenSegmentCharacter[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SevenSegmentCharacter[6]}]

# Output selection
set_property PACKAGE_PIN R2 [get_ports rst_switch]
set_property IOSTANDARD LVCMOS33 [get_ports rst_switch]

# Led One
set_property PACKAGE_PIN U16 [get_ports LedOne]
set_property IOSTANDARD LVCMOS33 [get_ports LedOne]

# Led Two
set_property PACKAGE_PIN E19 [get_ports LedTwo]
set_property IOSTANDARD LVCMOS33 [get_ports LedTwo]

# Led Three
set_property PACKAGE_PIN U19 [get_ports LedThree]
set_property IOSTANDARD LVCMOS33 [get_ports LedThree]

