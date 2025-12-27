# FPGA-Sobel-Edge-Detection-Pipeline-with-VHDL-Simulation-Benchmark
A VHDL implementation of the Sobel edge detection algorithm featuring a 3x3 windowing pipeline with line buffers written for xc7a100tcsg324-1. Also includes a simulation benchmark.

# The design consists of three main stages:
1)RGB to Grayscale Converter: Converts 24-bit RGB data into 8-bit luminance values.
2)Line Buffer (3x3 Window Generator): Stores image rows to create the 3x3 pixel matrix required for the Sobel operator.
3)Sobel Core: Computes horizontal ($G_x$) and vertical ($G_y$) gradients using convolution kernels and applies a configurable threshold to detect edges.

# The following results were obtained from the Vivado VHDL simulation for a 1024x1024 (1MP) image:
-Image Resolution	1024 x 1024 pixels
-Total Processed Pixels	1,048,576
-Total Clock Cycles	1,048,781
-Pipeline Latency	205 Cycles
-Efficiency (CPI)	~1.0001 Cycles Per Pixel
-Simulated Frequency	100 MHz

Achieves a throughput of 1 pixel per clock cycle.
Efficient data flow using custom Line Buffers for 3x3 window generation.
Automated simulation testbench that measures total clock cycles, latency, and pixel count.
