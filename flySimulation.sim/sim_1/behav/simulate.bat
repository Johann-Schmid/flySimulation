@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.2\\bin
call %xv_path%/xsim nexys_hdmi_bench_behav -key {Behavioral:sim_1:Functional:nexys_hdmi_bench} -tclbatch nexys_hdmi_bench.tcl -view C:/Users/LocalAdmin/Documents/brems/project_6/nexys_hdmi_bench_behav.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
