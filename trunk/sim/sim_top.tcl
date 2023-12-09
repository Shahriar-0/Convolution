	alias clc ".main clear"
	
	clc
	exec vlib work
	vmap work work
	
	set TB					"tb"
	set hdl_path			"../src/hdl"
	set inc_path			"../src/inc"
	
	set run_time			"1 us"
	# set run_time			"-all"

#============================   verilog files  ==================================

	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Adder.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Buffer_1_4.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Buffer_4_16.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Circuit.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Controller.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/counetr_2bit.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Counter_4bit.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Datapath.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/FilterBuffer.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/MAC.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Memory.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Multiplier.v		
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/mux_2bit_4_1.v		
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/mux_2_1.v		
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/mux_7bit_3_1.v		
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/PC.v				
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Reg.v		
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/TableBuffer.v		
	vlog 	+acc -incr -source  +incdir+$inc_path +define+SIM 	./tb/$TB.v
	onerror {break}

#================================ simulation ====================================

	vsim	-voptargs=+acc -debugDB $TB

#======================= adding signals to wave window ==========================

	add wave -hex -group 	 	{TB}				sim:/$TB/*
	add wave -hex -group 	 	{top}				sim:/$TB/uut/*	
	add wave -hex -group -r		{all}				sim:/$TB/*

#=========================== Configure wave signals =============================
	
	configure wave -signalnamewidth 2
    
#====================================== run =====================================

	run $run_time 
	