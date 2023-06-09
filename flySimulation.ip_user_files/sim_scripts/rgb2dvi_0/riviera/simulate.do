onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+rgb2dvi_0 -L unisims_ver -L unimacro_ver -L secureip -L xil_defaultlib -L xpm -O5 xil_defaultlib.rgb2dvi_0 xil_defaultlib.glbl

do {wave.do}

view wave
view structure
view signals

do {rgb2dvi_0.udo}

run -all

endsim

quit -force
