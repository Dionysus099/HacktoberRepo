#rm designs/*

# reading the verilog file mux_comparator.v
read_hdl /home/cad5/HW4/counter.v

# reading the required .lib file in Nangate 15nm OCL 
set_attr library /home/cad5/PDK/Nangate_OCL/lib/NangateOpenCellLibrary_slow.lib

# Enabling ICGs in design
set_attr lp_insert_clock_gating true


elaborate

# SDC timing constraints
create_clock -name clk -period 1.4 -waveform {0 0.7} [get_ports "clk"]
set_clock_transition -rise 0.05 [get_clocks "clk"]
set_clock_transition -fall 0.05 [get_clocks "clk"]
#set_clock_uncertainty 0.01 [get_ports "clk"]
set_input_delay -max 0.05 [get_ports "rst"] -clock [get_clocks "clk"] 
set_output_delay -max 0.05 [get_ports "count"] -clock [get_clocks "clk"]

# Define cost groups (clock-clock only. We can also define clock-output, input-clock, input-output)
define_cost_group -name I2C -design  counter
define_cost_group -name C2O -design counter
define_cost_group -name C2C -design counter
define_cost_group -name I2O -design counter
path_group -from [all::all_seqs] -to [all::all_seqs] -group C2C -name C2C 
path_group -from [all::all_seqs] -to [all::all_outs] -group C2O -name C2O
path_group -from [all::all_inps]  -to [all::all_seqs] -group I2C -name I2C
path_group -from [all::all_inps]  -to [all::all_outs] -group I2O -name I2O

# Synthesise the  design to generic gates and set the effort level
set_attr syn_generic_effort high
syn_generic


syn_map



set_attr syn_opt_effort high
syn_opt -incr

# This command prints out all paths 
write_snapshot -outdir /home/cad5/HW4/area_opt -tag syn_opt_no_incr
report_summary -outdir /home/cad5/HW4/area_opt/report_opt

foreach cg [find / -cost_group *] {
  report timing -cost_group [list $cg] >> /home/cad5/HW4/counter/counter_timing_report.rpt
}

# Write out synthesised netlist and constraints
write_hdl > /home/cad5/HW4/counter/hdl_synthesis.v
write_sdc > /home/cad5/HW4/counter/counter_sdc.sdc  

report_timing -gtd -num_paths 100 > /home/cad5/HW4/counter/timing.gtd
report_timing > /home/cad5/HW4/counter/timing.txt 
report_gates > /home/cad5/HW4/counter/gates.txt





