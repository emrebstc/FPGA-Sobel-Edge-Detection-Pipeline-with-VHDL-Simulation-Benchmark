A VHDL implementation of the Sobel edge detection algorithm featuring a 3x3 windowing pipeline with line buffers written for xc7a100tcsg324-1. Also includes a simulation benchmark.

#Usage:
1. Add all .vhd files to your Vivado project.

2. Run the tb_image_processor testbench for one time, it will generate .sim files in your project foler.
 
3. Add your source image to your python path and rename it as "image_original.png"
 
4. Run png_to_txt.py it will generate input_image_data.txt
  
5. Drag your input_image_data.txt file to folder here "EdgeDetectionProcessor/EdgeDetectionProcessor.sim/sim_1/behav/xsim/"
  
6. Run the tb_image_processor testbench again.
  
7. Your output_image_data.txt will be generated in "EdgeDetectionProcessor/EdgeDetectionProcessor.sim/sim_1/behav/xsim/"
 
8. Copy and paste that .txt file to your python path.
  
9. Run txt_to_rgb.py it will generate "image_processed.jpg" in your python path.
  
10. Done

# The design consists of three main stages:
1)RGB to Grayscale Converter: Converts 24-bit RGB data into 8-bit luminance values.

2)Line Buffer (3x3 Window Generator): Stores image rows to create the 3x3 pixel matrix required for the Sobel operator.

3)Sobel Core: Computes horizontal Gx and vertical Gy gradients using convolution kernels and applies a configurable threshold to detect edges.

------------------------------------------------------------------------------------------------------------
# The following results were obtained from the Vivado VHDL simulation for a 1024x1024 (1MP) image:
-Image Resolution	1024 x 1024 pixels

-Total Processed Pixels	1,048,576

-Total Clock Cycles	1,048,781

-Pipeline Latency	205 Cycles

-Efficiency (CPI)	~1.0001 Cycles Per Pixel

-Simulated Frequency	100 MHz

----------------------------------------------------------
*Achieves a throughput of 1 pixel per clock cycle.*

*Efficient data flow using custom Line Buffers for 3x3 window generation.*

*Automated simulation testbench that measures total clock cycles, latency, and pixel count.*
