from PIL import Image

# Resmi aç
img = Image.open("image_original.png").convert("RGB")

width, height = img.size
print(width, height)

pixels = img.load()

with open("input_image_data.txt", "w") as f:
    for y in range(height):
        for x in range(width):
            r, g, b = pixels[x, y]
            f.write(f"{r} {g} {b}\n")
