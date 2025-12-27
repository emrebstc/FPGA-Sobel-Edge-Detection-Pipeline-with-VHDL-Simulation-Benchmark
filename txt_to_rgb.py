from PIL import Image

width = 1024
height = 1024

# Create blank RGB img
img = Image.new("RGB", (width, height))
pixels = img.load()

with open("output_image_data.txt", "r") as f:
    lines = f.readlines()

assert len(lines) == width * height,

idx = 0
for y in range(height):
    for x in range(width):
        r, g, b = map(int, lines[idx].split())
        pixels[x, y] = (r, g, b)
        idx += 1

img.save("image_processed.jpg")
img.show()
