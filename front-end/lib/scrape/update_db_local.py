import os
import re
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore

# Initialize Firebase Admin SDK
cred = credentials.Certificate('/Users/tugberkdikmen/Desktop/Fall-23/CS491/PriceWise Frontend/PriceWise/front-end/lib/database/pricewise-cs-firebase-adminsdk-kc14m-bc36ff519d.json')
firebase_admin.initialize_app(cred)

db = firestore.client()

# Helper function to convert price string to float
def parse_price(price_str):
    try:
        # Remove the " TL" and any units like "/kg" if present, then normalize numbers
        clean_price = price_str.replace(" TL", "").split('/')[0].strip()
        clean_price = clean_price.replace(".", "").replace(",", ".")
        return float(clean_price)
    except ValueError as e:
        print(f"Error converting price '{price_str}': {e}")
        return None


def parse_market_product_line(line):
    # Remove the leading '- ' from the line if present
    line = line[2:] if line.startswith('- ') else line

    # Split the line into parts based on known labels
    market_part = 'Market:'
    product_part = 'Product:'
    price_part = 'Price:'
    unit_price_part = 'Unit Price:'

    # Find the indices of each part
    market_index = line.find(market_part)
    product_index = line.find(product_part)
    price_index = line.find(price_part)
    unit_price_index = line.find(unit_price_part)

    # Parse out each part based on indices
    market = line[market_index + len(market_part):product_index].strip()
    product = line[product_index + len(product_part):price_index].strip()
    price = parse_price(line[price_index + len(price_part):unit_price_index].strip())
    unit_price = parse_price(line[unit_price_index + len(unit_price_part):].strip())

    return {
        'market': market,
        'product': product,
        'price': price,
        'unit_price': unit_price
    }

def parse_txt_data(file_path):
    with open(file_path, 'r', encoding='utf-8') as file:
        all_products = []
        product_data = None

        for line in file:
            line = line.strip()
            if line.isdigit():  # New product block starts
                if product_data:  # Save the last product block before starting a new one
                    all_products.append(product_data)
                product_data = {
                    'market_product_array': [],
                    'similar_product_array': [],
                    'features': {},
                    'product_image_url': None
                }
            elif line.startswith('Product Name:'):
                product_data['product_name'] = line.split(':', 1)[1].strip()
            elif line.startswith('Main Category:'):
                product_data['main_category'] = line.split(':', 1)[1].strip()
            elif line.startswith('Sub-categories:'):
                sub_categories = [sub.strip() for sub in line.split(':', 1)[1].split(',')]
                product_data['sub_category'] = sub_categories[0].strip()  # Always set the first sub-category
                
                # Set the second sub-category, default to "SubCategory" if it is empty
                if len(sub_categories) > 1 and sub_categories[1]:
                    product_data['sub_category2'] = sub_categories[1].strip()
                else:
                    product_data['sub_category2'] = "SubCategory"
            elif line.startswith('Cheapest Price:'):
                product_data['product_cheapest_price'] = parse_price(line.split(':', 1)[1].strip())
            elif line.startswith('Market Products:'):
                product_data['reading_section'] = 'market_products'
            elif line.startswith('Similar Products:'):
                product_data['reading_section'] = 'similar_products'
            elif line.startswith('Features:'):
                product_data['reading_section'] = 'features'
            elif line.startswith('-') and product_data and 'reading_section' in product_data:
                if product_data['reading_section'] == 'market_products':
                    product_data['market_product_array'].append(parse_market_product_line(line))
                elif product_data['reading_section'] == 'similar_products':
                    parts = line[1:].strip().split(' Price: ')
                    if len(parts) == 2:
                        product_data['similar_product_array'].append({
                            'product_name': parts[0].strip(),
                            'price': parse_price(parts[1].strip())
                        })
                elif product_data['reading_section'] == 'features':
                    key, value = line[1:].split(':', 1)
                    product_data['features'][key.strip()] = value.strip()
            elif line.startswith('Product Image URL:'):
                product_data['product_image_url'] = line.split(':', 1)[1].strip() or None  # Set to None if empty

        if product_data:  # Add the last product block
            all_products.append(product_data)

        return all_products

def sanitize_document_id(document_id):
    # Remove any characters that are not allowed in Firestore document paths
    return re.sub(r'[^\w\s-]', '', document_id).strip()

'''
def sanitize_document_id(document_id):
    # Remove any characters that are not allowed in Firestore document paths
    if not document_id:
        return None
    return re.sub(r'[^\w\s-]', '', document_id).strip()
'''
def add_product_to_firestore(product_data):
    for product in product_data:
        sanitized_product_name = sanitize_document_id(product['product_name'])
        if not sanitized_product_name:
            print(f"Skipping product with invalid name: {product['product_name']}")
            continue

        try:
            doc_ref = db.collection('saleProducts') \
                        .document(sanitized_product_name)
                        #.document(product['main_category']) \
                        #.collection(product['sub_category']) \
                        #.document(product['sub_category2']) \
                        #.collection('Products') \
                        
            product_to_set = {
                'product_name': sanitized_product_name,
                'main_category': product['main_category'],
                'sub_category': product['sub_category'],
                'sub_category2': product['sub_category2'],
                'product_cheapest_price': product.get('product_cheapest_price', None),
                'market_product_array': product.get('market_product_array', []),
                'similar_product_array': product.get('similar_product_array', []),
                'features': product.get('features', {}),
                'product_image_url': product.get('product_image_url', None)
            }
            doc_ref.set(product_to_set, merge=True)
            #print(f"Added product {sanitized_product_name} to the database.")
        except Exception as e:
            print(f"Failed to add product {sanitized_product_name} due to {e}")

def process_directory(directory_path):
    for filename in os.listdir(directory_path):
        if filename.endswith('.txt'):
            try:
                items_processed = 0
                file_path = os.path.join(directory_path, filename)
                product_data = parse_txt_data(file_path)
                add_product_to_firestore(product_data)
                for products in product_data:
                    items_processed += 1
                print(f"For {filename} {items_processed} items pushed to the database.")
            except Exception as e:
                print(f"Failed to add product {filename} due to {e}")

def process_file(file_path):
    items_processed = 0
    product_data = parse_txt_data(file_path)
    add_product_to_firestore(product_data)
    for products in product_data:
        items_processed += 1
    print(f"{items_processed} items pushed to the database.")

dir_path = os.path.abspath('/Users/tugberkdikmen/Desktop/Fall-23/CS491/PriceWise Frontend/PriceWise/front-end/lib/scrape/products_local/d7')
file_path = os.path.abspath('/Users/tugberkdikmen/Desktop/Fall-23/CS491/PriceWise Frontend/PriceWise/front-end/lib/scrape/products_local/sale.txt')

process_file(file_path)
#process_directory(dir_path)
print("Done")