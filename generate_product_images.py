#!/usr/bin/env python3
"""
Generate professional product mockup images locally
Creates clean product cards with product names and colors
"""

from PIL import Image, ImageDraw, ImageFont
from pathlib import Path
import colorsys
import random

IMAGES_DIR = Path('assets/images')
IMAGES_DIR.mkdir(parents=True, exist_ok=True)

# Product definitions with colors and categories
PRODUCTS = [
    # Clothing - Blues and blacks
    ('cap.png', 'Cap', (100, 150, 200)),
    ('t_shirt.png', 'T-Shirt', (200, 100, 100)),
    ('jeans.png', 'Blue Jeans', (50, 100, 180)),
    ('dress.png', 'Summer Dress', (255, 150, 100)),
    ('formal_shirt.png', 'Formal Shirt', (100, 100, 150)),
    
    # Footwear
    ('sneakers.png', 'Sport Shoes', (150, 150, 150)),
    ('running_shoes.png', 'Running Shoes', (200, 100, 50)),
    ('casual_shoes.png', 'Casual Sneakers', (200, 200, 100)),
    ('formal_shoes.png', 'Formal Shoes', (50, 50, 50)),
    ('sandals.png', 'Sandals', (200, 150, 100)),
    
    # Accessories
    ('smart_watch.png', 'Smart Watch', (100, 100, 100)),
    ('handbag.png', 'Hand Bag', (180, 100, 100)),
    ('backpack.png', 'Backpack', (100, 100, 150)),
    ('wallet.png', 'Designer Wallet', (139, 69, 19)),
    ('sunglasses.png', 'Sunglasses', (50, 50, 50)),
    ('sports_watch.png', 'Sports Watch', (100, 150, 150)),
    
    # Electronics
    ('earbuds.png', 'Wireless Earbuds', (100, 100, 100)),
    ('phone_stand.png', 'Phone Stand', (150, 150, 150)),
    ('usb_cable.png', 'USB-C Cable', (255, 100, 50)),
    ('power_bank.png', 'Power Bank', (255, 200, 50)),
    ('speaker.png', 'Bluetooth Speaker', (50, 50, 100)),
    
    # Home & Garden
    ('coffee_maker.png', 'Coffee Maker', (100, 50, 50)),
    ('desk_lamp.png', 'Desk Lamp', (255, 200, 100)),
    ('bed_sheets.png', 'Bed Sheets', (200, 200, 255)),
    ('pillow.png', 'Throw Pillow', (255, 150, 200)),
    
    # Sports & Outdoors
    ('yoga_mat.png', 'Yoga Mat', (150, 200, 100)),
    ('dumbbells.png', 'Dumbbells Set', (100, 100, 100)),
    ('water_bottle.png', 'Water Bottle', (100, 150, 255)),
    ('tent.png', 'Camping Tent', (150, 100, 50)),
    
    # Kids & Toys
    ('rocking_horse.png', 'Rocking Horse', (200, 100, 150)),
    ('puzzle.png', 'Puzzle', (255, 200, 100)),
    ('blocks.png', 'Building Blocks', (100, 200, 100)),
    ('rc_car.png', 'RC Car', (255, 100, 100)),
]

def create_product_image(filename, product_name, color):
    """Create a professional product mockup image"""
    # Create image with white background
    img = Image.new('RGB', (400, 400), color=(255, 255, 255))
    draw = ImageDraw.Draw(img)
    
    # Draw gradient background (colored rectangle with lighter version)
    light_color = tuple(min(255, c + 100) for c in color)
    for y in range(400):
        blend_factor = y / 400
        r = int(color[0] * (1 - blend_factor) + light_color[0] * blend_factor)
        g = int(color[1] * (1 - blend_factor) + light_color[1] * blend_factor)
        b = int(color[2] * (1 - blend_factor) + light_color[2] * blend_factor)
        draw.rectangle([(0, y), (400, y+1)], fill=(r, g, b))
    
    # Add semi-transparent white box for product name
    box_height = 100
    box_top = (400 - box_height) // 2
    draw.rectangle(
        [(40, box_top), (360, box_top + box_height)],
        fill=(255, 255, 255, 200)
    )
    
    # Add product name text
    try:
        # Try to use a default font
        font = ImageFont.load_default()
    except:
        font = None
    
    # Draw text
    text = product_name
    text_bbox = draw.textbbox((0, 0), text, font=font)
    text_width = text_bbox[2] - text_bbox[0]
    text_height = text_bbox[3] - text_bbox[1]
    
    x = (400 - text_width) // 2
    y = (400 - text_height) // 2
    
    # Draw text with outline for better visibility
    outline_range = 2
    for adj_x in range(-outline_range, outline_range + 1):
        for adj_y in range(-outline_range, outline_range + 1):
            draw.text(
                (x + adj_x, y + adj_y),
                text,
                fill=(150, 150, 150),
                font=font
            )
    
    draw.text((x, y), text, fill=(50, 50, 50), font=font)
    
    # Save image
    filepath = IMAGES_DIR / filename
    img.save(filepath, 'PNG')
    print(f"✓", end=' ', flush=True)

def main():
    """Generate all product images"""
    print("Generating professional product mockup images...")
    print(f"Saving to: {IMAGES_DIR.absolute()}\n")
    
    total = len(PRODUCTS)
    success = 0
    
    for filename, product_name, color in PRODUCTS:
        print(f"{filename}...", end=' ')
        try:
            create_product_image(filename, product_name, color)
            success += 1
        except Exception as e:
            print(f"✗({e})", end=' ')
        print()
    
    print(f"\n{'='*60}")
    print(f"Generated: {success}/{total} product images")
    print(f"{'='*60}\n")
    
    if success > 0:
        print(f"✓ Product images saved to: {IMAGES_DIR.absolute()}")
        print(f"✓ Professional product mockups for all {success} products!")
        print(f"✓ Clean, colorful designs perfect for ShopHub!")

if __name__ == '__main__':
    main()
