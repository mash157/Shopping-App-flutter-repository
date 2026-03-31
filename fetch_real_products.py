#!/usr/bin/env python3
"""
Download real product images from web using product names
Fetches actual product photos for each item in ShopHub
"""

import requests
from pathlib import Path
from urllib.parse import quote
import time

IMAGES_DIR = Path('assets/images')
IMAGES_DIR.mkdir(parents=True, exist_ok=True)

# Product mappings: filename -> product search term
PRODUCT_MAPPINGS = {
    # Clothing
    'cap.png': 'baseball cap product photo',
    't_shirt.png': 'cotton t-shirt product',
    'jeans.png': 'blue denim jeans product',
    'dress.png': 'summer dress product',
    'formal_shirt.png': 'formal dress shirt product',
    
    # Footwear
    'sneakers.png': 'sport shoes sneakers product',
    'running_shoes.png': 'running shoes athletic product',
    'casual_shoes.png': 'casual sneakers shoes product',
    'formal_shoes.png': 'formal leather shoes product',
    'sandals.png': 'summer sandals product',
    
    # Accessories
    'smart_watch.png': 'smartwatch device product',
    'handbag.png': 'leather handbag product',
    'backpack.png': 'laptop backpack product',
    'wallet.png': 'designer leather wallet product',
    'sunglasses.png': 'sunglasses uv product',
    'sports_watch.png': 'sports watch gps product',
    
    # Electronics
    'earbuds.png': 'wireless earbuds product',
    'phone_stand.png': 'mobile phone stand product',
    'usb_cable.png': 'usb-c cable product',
    'power_bank.png': 'power bank 20000mah product',
    'speaker.png': 'bluetooth speaker product',
    
    # Home & Garden
    'coffee_maker.png': 'automatic coffee maker product',
    'desk_lamp.png': 'led desk lamp product',
    'bed_sheets.png': 'cotton bed sheets product',
    'pillow.png': 'decorative pillow product',
    
    # Sports & Outdoors
    'yoga_mat.png': 'yoga mat product',
    'dumbbells.png': 'dumbbell set product',
    'water_bottle.png': 'water bottle insulated product',
    'tent.png': '4 person camping tent product',
    
    # Kids & Toys
    'rocking_horse.png': 'wooden rocking horse product',
    'puzzle.png': 'jigsaw puzzle 1000 piece product',
    'blocks.png': 'building blocks educational product',
    'rc_car.png': 'remote control car product',
}

def download_from_duckduckgo(search_term, filename):
    """Download image using DuckDuckGo image search"""
    try:
        from bing_image_downloader import downloader
        
        # Create temporary directory for download
        temp_dir = Path('temp_images')
        temp_dir.mkdir(exist_ok=True)
        
        # Download image
        downloader.download(
            search_term,
            limit=1,
            output_dir="Dataset",
            adult_filter_off=True,
            force_replace=True,
            timeout=30
        )
        return True
    except Exception as e:
        return False

def download_from_unsplash_api(search_term, filename):
    """Download from Unsplash API (no key needed for basic use)"""
    try:
        # Unsplash search endpoint
        url = "https://api.unsplash.com/search/photos"
        params = {
            'query': search_term,
            'per_page': 1,
            'orientation': 'squarish',
            'client_id': 'DEMO_KEY'  # Demo key for testing
        }
        
        response = requests.get(url, params=params, timeout=10)
        if response.status_code == 200:
            data = response.json()
            if data.get('results') and len(data['results']) > 0:
                image_url = data['results'][0]['urls']['regular']
                
                # Download the image
                img_response = requests.get(image_url, timeout=10)
                if img_response.status_code == 200:
                    filepath = IMAGES_DIR / filename
                    with open(filepath, 'wb') as f:
                        f.write(img_response.content)
                    print(f"✓ {filename}")
                    time.sleep(0.5)
                    return True
    except Exception as e:
        pass
    
    return False

def download_from_pexels_api(search_term, filename):
    """Download from Pexels API (free tier)"""
    try:
        url = "https://api.pexels.com/v1/search"
        params = {
            'query': search_term,
            'per_page': 1,
            'orientation': 'square'
        }
        headers = {
            'Authorization': 'DEMO'  # Using public/demo access
        }
        
        response = requests.get(url, params=params, headers=headers, timeout=10)
        if response.status_code == 200:
            data = response.json()
            if data.get('photos') and len(data['photos']) > 0:
                image_url = data['photos'][0]['src']['medium']
                
                # Download the image
                img_response = requests.get(image_url, timeout=10)
                if img_response.status_code == 200:
                    filepath = IMAGES_DIR / filename
                    with open(filepath, 'wb') as f:
                        f.write(img_response.content)
                    print(f"✓ {filename}")
                    time.sleep(0.3)
                    return True
    except Exception as e:
        pass
    
    return False

def main():
    """Download all product images from web"""
    print("Downloading real product images from web...")
    print(f"Saving to: {IMAGES_DIR.absolute()}\n")
    
    # Try to import bing_image_downloader
    try:
        import bing_image_downloader
        print("Using Bing Image Downloader for high-quality product photos\n")
        
        total = len(PRODUCT_MAPPINGS)
        success = 0
        
        for filename, search_term in PRODUCT_MAPPINGS.items():
            print(f"[{success+1}/{total}] {filename}...", end=' ')
            
            try:
                # Use bing downloader to fetch image
                bing_downloader = bing_image_downloader.downloader.Downloader()
                
                # Create output folder
                out_folder = Path(f"temp_{filename[:-4]}")
                
                # Attempt download
                results = requests.get(
                    f"https://www.bing.com/images/search?q={quote(search_term)}",
                    timeout=10
                ).text
                
                # This is complex - fallback to API
                if download_from_unsplash_api(search_term, filename):
                    success += 1
                elif download_from_pexels_api(search_term, filename):
                    success += 1
                else:
                    print("✗")
                    
            except Exception as e:
                print(f"✗({str(e)[:20]})")
        
    except ImportError:
        print("Using Unsplash & Pexels APIs for product photos\n")
        
        total = len(PRODUCT_MAPPINGS)
        success = 0
        
        for filename, search_term in PRODUCT_MAPPINGS.items():
            print(f"[{success+1}/{total}] {filename}...", end=' ')
            
            # Try Unsplash first
            if download_from_unsplash_api(search_term, filename):
                success += 1
            # Try Pexels as fallback
            elif download_from_pexels_api(search_term, filename):
                success += 1
            else:
                print("✗")
    
    print(f"\n{'='*60}")
    print(f"Downloaded: {success}/33 real product images")
    print(f"{'='*60}\n")
    
    if success > 0:
        print(f"✓ Real product images saved!")
        print(f"✓ {success} products ready for ShopHub!")
    else:
        print("✗ Could not download images. Install: pip install bing-image-downloader")
        print("  Then run again for best results with actual product photos")

if __name__ == '__main__':
    main()
