export DESIGN_NAME = ttsimon
export PLATFORM    = ihp-sg13g2

export VERILOG_FILES = ./designs/src/$(DESIGN_NICKNAME)/ttsimon.v
export SDC_FILE      = ./designs/$(PLATFORM)/$(DESIGN_NICKNAME)/constraint.sdc

export USE_FILL = 1
export PLACE_DENSITY ?= 0.9
export CORE_UTILIZATION = 60
export TNS_END_PERCENT = 100
