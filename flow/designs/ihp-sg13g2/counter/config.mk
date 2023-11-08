export DESIGN_NAME = counter
export PLATFORM    = ihp-sg13g2

export VERILOG_FILES = ./designs/src/$(DESIGN_NICKNAME)/counter.v
export SDC_FILE      = ./designs/$(PLATFORM)/$(DESIGN_NICKNAME)/constraint.sdc

export USE_FILL = 1

export DIE_AREA = 0.0 0.0 100.0 100.0
export CORE_AREA = 10 10 90 90

export PLACE_DENSITY ?= 0.1
#export CORE_UTILIZATION = 20
export TNS_END_PERCENT = 100
