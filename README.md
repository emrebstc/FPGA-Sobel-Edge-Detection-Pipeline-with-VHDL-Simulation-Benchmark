A VHDL implementation of the Sobel edge detection algorithm featuring a 3x3 windowing pipeline with line buffers written for xc7a100tcsg324-1 in Vivado 2025. Also includes a simulation benchmark.

--------------------------------------------------------------------------------------------------------------
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

*Achieves a throughput of 1 pixel per clock cycle.*

--------------------------------------------------------------------------------------------------------------
# Usage:
1. Add all .vhd files to your Vivado project.

2. Run the tb_image_processor testbench for one time, it will generate .sim files in your project foler.
 
3. Add your source image to your python path and rename it as "image_original.png"
 
4. Run png_to_txt.py it will generate input_image_data.txt
  
5. Drag your input_image_data.txt file to folder here "EdgeDetectionProcessor/EdgeDetectionProcessor.sim/sim_1/behav/xsim/"
  
6. Run the tb_image_processor testbench again.
  
7. Your output_image_data.txt will be generated in "EdgeDetectionProcessor/EdgeDetectionProcessor.sim/sim_1/behav/xsim/"

8. Delete last 200 line on your output_image_data.txt
 
9. Copy and paste that .txt file to your python path.
  
10. Run txt_to_rgb.py it will generate "image_processed.jpg" in your python path.
  
11. Done

*Note: Before creating each new image, delete the output_image_data.txt file from the project folder or rename it to something like output_image_dataX.txt in the test bench code. If you want to generate different resolutions like 256x256 or something else edit "line_buffer.vhd" and change 1023 value to 255 for 256x256 resolution. Also edit "txt_to_rgb.py"*

--------------------------------------------------------------------------------------------------------------
# EXAMPLES
1) 1024x1024
<img width="256" height="256" alt="Building_1024x1024" src="https://github.com/user-attachments/assets/35fe23b4-16fb-4f15-b55b-9c818ab1b3cd" />

<img width="256" height="256" alt="Building_out_1024x1024" src="https://github.com/user-attachments/assets/a8074eee-5918-4f65-99df-d546772258dc" />

2) 800x800
<img width="256" height="256" alt="jet-800x800" src="https://github.com/user-attachments/assets/d659867e-2559-4dad-b10f-81cc8d896372" />

<img width="256" height="256" alt="jet-800x800" src="https://github.com/user-attachments/assets/07026f91-408a-41e6-9a22-edfa58b25cb5" />

3) 512x512
<img width="256" height="256" alt="car" src="https://github.com/user-attachments/assets/86c15f96-e707-4342-b1a8-82b62f6c5db8" />

<img width="256" height="256" alt="car" src="https://github.com/user-attachments/assets/d33910e8-87b3-4047-ae06-5bb8ae790650" />

4) 128x128
<img width="256" height="256" alt="CoffeeCup_Original" src="https://github.com/user-attachments/assets/a4c94a83-80ce-411b-a5f2-d2bc61cc0310" />

<img width="256" height="256" alt="CoffeeCup_Original" src="https://github.com/user-attachments/assets/3532c3df-8110-4a94-9820-1f92ad11f72d" />

--------------------------------------------------------------------------------------------------------------
<img width="512" height="512" alt="Ekran görüntüsü 2025-12-27 041840" src="https://github.com/user-attachments/assets/0e4bf373-4833-4aa7-bb25-0e14b6c6bfef" />
<img width="512" height="512" alt="Ekran görüntüsü 2025-12-27 185208" src="https://github.com/user-attachments/assets/2cdc63d6-e03e-4b0a-bcb4-5aa0058d2809" />
<img width="1024" height="1024" alt="Ekran görüntüsü 2025-12-27 043313" src="https://github.com/user-attachments/assets/2be2e0f8-209e-47b1-8cd1-c68d73744115" />
<img width="1024" height="1024" alt="ada" src="https://github.com/user-attachments/assets/8098a6ff-c6ca-4f0e-ae52-aa5a9c8fa7f9" />
