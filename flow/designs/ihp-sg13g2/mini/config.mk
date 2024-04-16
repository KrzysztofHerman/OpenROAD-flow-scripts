export DESIGN_NAME = mini
export PLATFORM    = ihp-sg13g2

export VERILOG_FILES = ./designs/src/$(DESIGN_NICKNAME)/mini.v
export SDC_FILE      = ./designs/$(PLATFORM)/$(DESIGN_NICKNAME)/constraint.sdc

export USE_FILL = 0

export DIE_AREA = 0 0 100 100
export CORE_AREA = 10 10 90 90

export PLACE_DENSITY ?= 0.88
#export CORE_UTILIZATION = 20
export TNS_END_PERCENT = 100
