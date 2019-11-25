############################################
#Date: 2019.10.22
#Author: Created by Jiaxiang Feng
#Description: This script fnuction as automatic generating bitstream for vivado projects.
#Version: 2.0
############################################

#!/bin/bash

#for args in $@
#do
#	echo $args
#done

if [[ $# < 3 || $# > 4 ]]
	then
	echo " "
	echo "Error arguments." 
	echo " "
	echo "Usage:[Project Path] <[Output File Directory]> [Run Option] [Vivado Version]."
	echo " "
	echo "Run option includes open(Open project in tcl mode), synthesis(Open and synthesis), bitstream(Generate bitstream and open implement result) "
	echo " "
	echo "Vivado Version includes 2018.2 and 2017.3"
	echo " "
exit 1;
fi


if [[ $# == 4 ]]
	then

if [[ ! -f $1 || ! -e $1 ]]
	then

		echo "Please enter target project file (.xpr)"

		exit 1;

fi

if [[ ! -d $2 || ! -e $2 ]]
        then
		echo "No output directory, building"
		mkdir $2		
#                echo "Please enter output file directory."

#                exit 1;
fi

if [[ ! -d $2 ]]
	then 
                echo "Building failed, please enter right output directory."
#	mkdir $2
		exit 1;
else 
	echo "output directory: $2"

fi


if [ $3 != "open" || $3 != "synthesis" || $3 != "bitstream" ]
	then 
		ehco "Error run option.(open, synthesis, bitstream)"
		exit 1
fi

if [ $4 != "2017.3" || $4 != "2018.2" ]
	then
		echo "Error vivado version. (2018.2 or 2017.3)"
		exit 1
fi

PROJECT_PATH=$1

OUTPUT_DIR=$2

RUN_OPTION=$3

VIVADO_VERSION=$4

echo "Project path:$PROJECT_PATH"
echo "Output file path:$OUTPUT_DIR" 
echo "Run option: $RUN_OPTION"

else 


	if [[ ! -f $1 || ! -e $1 ]]
		then

			echo "Please enter target project file (.xpr)"

			exit 1;

	fi

	if [ $2 != "open" || $2 != "synthesis" || $2 != "bitstream" ]
		then 
			ehco "Error run option.(open, synthesis, bitstream)"
			exit 1
	fi

	if [ $3 != "2017.3" || $3 != "2018.2" ]
		then
			echo "Error vivado version. (2018.2 or 2017.3)"
			exit 1
	fi

	PROJECT_PATH=$1

	RUN_OPTION=$2

	VIVADO_VERSION=$3

	echo "Project path:$PROJECT_PATH" 
	echo "Run option: $RUN_OPTION"

fi



source /home/Xilinx/Vivado/$VIVADO_VERSION/settings64.sh
source /home/Xilinx/SDK/$VIVADO_VERSION/settings64.sh

#source /home/Xilinx/Vivado/$VIVADO_VERSION/settings64.csh

#export XILINXD_LICENSE_FILE = "$PATH:/home/Xilinx_2018.2/lic"


vivado -mode tcl $PROJECT_PATH -nojournal -source vivado_cmd.tcl -tclargs $RUN_OPTION $OUTPUT_DIR
