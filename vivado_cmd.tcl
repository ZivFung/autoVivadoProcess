##########################################
#Date: 2019.10.22
#Author: Created by Jiaxiang Feng.
#Description: Vivado tcl command for generating bitstream
#Version: 2.1
##########################################

#argument: open, synthesis, bitstream


set PROJECT_PATH "path"
#puts "$argc"
puts "$argv"

set RUN_OPTION [lindex $argv 0]

set OUTPUT_DIR [lindex $argv 1]



if {$argc < 1} {
	puts "Please enter run option (open, synthesis, bitstream) and output file directory!"
	exit
} elseif {$argc == 1} {
	if {$RUN_OPTION == "open"} {
#		exit
	} elseif {$RUN_OPTION == "synthesis"} {
		reset_run synth_1
		launch_runs synth_1 -jobs 8
		wait_on_run synth_1
		if {[get_property PROGRESS [get_runs synth_1]] !="100%"} {
			error "ERROR: synthesis failed\n"		
		}
		exit				
	} elseif {$RUN_OPTION == "bitstream"} {
		reset_run synth_1
		launch_runs synth_1 -jobs 8
		wait_on_run synth_1
		if {[get_property PROGRESS [get_runs synth_1]] !="100%"} {
			error "ERROR: synthesis failed\n"		
		}
		launch_run impl_1 -to_step write_bitstream -jobs 8
		wait_on_run impl_1
		if {[get_property PROGRESS [get_runs impl_1]] != "100%"} {
			error "ERROR: implementation failed\n"		
		}
		exit		 	
	} else {
		error "ERROR: error option\n"
	}
} elseif {$argc == 2} {
	set outputDir $OUTPUT_DIR

	if {$RUN_OPTION == "open"} {
#		exit
	} elseif {$RUN_OPTION == "synthesis"} {
		reset_run synth_1
		launch_runs synth_1 -jobs 8
		wait_on_run synth_1
		if {[get_property PROGRESS [get_runs synth_1]] !="100%"} {
			error "ERROR: synthesis failed\n"		
		}
		open_run synth_1
		write_checkpoint -force $outputDir/post_synth	
		report_timing_summary -file $outputDir/post_synth_timing_summary.rpt
		report_power -file $outputDir/post_synth_power.rpt
		exit	
	} elseif {$RUN_OPTION == "bitstream"} {
		reset_run synth_1
		launch_runs synth_1 -jobs 8
		wait_on_run synth_1
		if {[get_property PROGRESS [get_runs synth_1]] !="100%"} {
			error "ERROR: synthesis failed\n"		
		}
		open_run synth_1
		write_checkpoint -force $outputDir/post_synth	
		report_timing_summary -file $outputDir/post_synth_timing_summary.rpt
		report_power -file $outputDir/post_synth_power.rpt
	
		launch_run impl_1 -jobs 8
		wait_on_run impl_1
		if {[get_property PROGRESS [get_runs impl_1]] != "100%"} {
			error "ERROR: implementation failed\n"		
		}
		open_run impl_1
		report_timing_summary -file $outputDir/post_impl_timing_summary.rpt
		report_timing -sort_by group -max_paths 200 -path_type summary -file $outputDir/post_impl_timing.rpt
		report_utilization -file $outputDir/post_impl_util.rpt
		report_power -file $outputDir/post_impl_power.rpt
		report_drc -file $outputDir/post_impl_drc.rpt
		write_bitstream -force $outputDir/top.bit
		exit	 	
	} else {
		error "ERROR: error option\n"
	}
} else {
	puts "Too many options!"
	exit
}


#update_compile_order -fileset sources_1
#write_project_tcl {/home/videofpga/Project/Test_Project/test_recreate_project_tcl.tcl}
