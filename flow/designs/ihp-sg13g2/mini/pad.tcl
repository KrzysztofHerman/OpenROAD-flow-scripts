set IO_LENGTH 180
set IO_WIDTH 80
set BONDPAD_SIZE 70
set MAX_NUM_PADS 6

proc calc_horizontal_pad_location {index} {
    global IO_LENGTH
    global IO_WIDTH
    global MAX_NUM_PADS

    set DIE_WIDTH [expr {[lindex $::env(DIE_AREA) 2] - [lindex $::env(DIE_AREA) 0]}]
    set PAD_AREA_WIDTH [expr {$DIE_WIDTH - $IO_LENGTH - $IO_LENGTH}]
    set HORIZONTAL_PAD_DISTANCE [expr {$PAD_AREA_WIDTH / ( $MAX_NUM_PADS + 1 )}]

    return [expr {$IO_LENGTH - ( $IO_WIDTH / 2 ) + $HORIZONTAL_PAD_DISTANCE * ( $index + 1 )}]
}

proc calc_vertical_pad_location {index} {
    global IO_LENGTH
    global IO_WIDTH
    global MAX_NUM_PADS

    set DIE_HEIGHT [expr {[lindex $::env(DIE_AREA) 3] - [lindex $::env(DIE_AREA) 1]}]
    set PAD_AREA_HEIGHT [expr {$DIE_HEIGHT - $IO_LENGTH - $IO_LENGTH}]
    set VERTICAL_PAD_DISTANCE [expr {$PAD_AREA_HEIGHT / ( $MAX_NUM_PADS + 1 )}]

    return [expr {$IO_LENGTH - ( $IO_WIDTH / 2 ) + $VERTICAL_PAD_DISTANCE * ( $index + 1 )}]
}

make_fake_io_site -name IOLibSite -width 1 -height $IO_LENGTH
make_fake_io_site -name IOLibCSite -width $IO_LENGTH -height $IO_LENGTH

# Create IO Rows
make_io_sites \
    -horizontal_site IOLibSite \
    -vertical_site IOLibSite \
    -corner_site IOLibCSite \
    -offset $BONDPAD_SIZE

# Place Pads
place_pad -row IO_SOUTH -location [calc_vertical_pad_location  0] {sg13g2_IOPadIOVdd_1} -master sg13g2_IOPadIOVdd
place_pad -row IO_SOUTH -location [calc_vertical_pad_location  1] {sg13g2_IOPadIOVss_1} -master sg13g2_IOPadIOVss
# clk
place_pad -row IO_SOUTH -location [calc_vertical_pad_location  2] {sg13g2_IOPadIn_x1}
# reset
place_pad -row IO_EAST -location [calc_horizontal_pad_location  0] {sg13g2_IOPadIn_x2}
# clock
place_pad -row IO_EAST -location [calc_horizontal_pad_location  1] {sg13g2_IOPadIn_x3}
# reset
place_pad -row IO_EAST -location [calc_horizontal_pad_location  2] {sg13g2_IOPadIn_clk}

place_pad -row IO_NORTH -location [calc_vertical_pad_location  0] {sg13g2_IOPadIn_rst}
place_pad -row IO_NORTH -location [calc_vertical_pad_location  1] {sg13g2_IOPadVss_1} -master sg13g2_IOPadVss
place_pad -row IO_NORTH -location [calc_vertical_pad_location  2] {sg13g2_IOPadVdd_1} -master sg13g2_IOPadVdd
# hyperbus dq0-7
place_pad -row IO_WEST -location [calc_horizontal_pad_location  0] {sg13g2_IOPadOut4mA_y1}
place_pad -row IO_WEST -location [calc_horizontal_pad_location  1] {sg13g2_IOPadOut4mA_y2}
# spi cs0
place_pad -row IO_WEST -location [calc_horizontal_pad_location  2] {sg13g2_IOPadInOut4mA_1}
# spi sck
#place_pad -row IO_WEST -location [calc_horizontal_pad_location  5] {sg13g2_IOPadIn_x3}

# Place Corner Cells and Filler
place_corners sg13g2_Corner

set iofill {
    sg13g2_Filler200
    sg13g2_Filler400
    sg13g2_Filler1000
    sg13g2_Filler2000
    sg13g2_Filler4000
    sg13g2_Filler10000
}

place_io_fill -row IO_NORTH {*}$iofill
place_io_fill -row IO_SOUTH {*}$iofill
place_io_fill -row IO_WEST {*}$iofill
place_io_fill -row IO_EAST {*}$iofill

connect_by_abutment

place_bondpad -bond bondpad_70x70 sg13g2_IOPad* -offset {5.0 -70.0}

remove_io_rows
