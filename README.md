# autoVivadoProcess
This tool can run the Vivado systhesis&implementation automatically in Linux system terminal without open Vivado GUI.

# Usage
1. Put two file in the same directory, open terminal at this directory.
2. run auto_vivado_process.sh 
usage: sh auto_vivado_process.sh [Project Path] <[Output File Directory]> [Run Option] [Vivado Version]
  
[Run option] includes open(Open project in tcl mode), synthesis(Open and synthesis), bitstream(Generate bitstream and open implement result)
  
[Output File Directory] is optional.
