import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore

# Initialize Firebase Admin SDK
cred = credentials.Certificate('/Users/tugberkdikmen/Desktop/Fall-23/CS491/PriceWise Frontend/PriceWise/front-end/lib/database/pricewise-cs-firebase-adminsdk-kc14m-bc36ff519d.json')
firebase_admin.initialize_app(cred)

db = firestore.client()
####################### FIRESTORE PUSH #############################

def add_product_to_firestore(product):
    # Convert market_product_array to a list of dictionaries
    market_products_as_dicts = [
    {
        'market': mp.market_name,  # Updated to the correct attribute name
        'product': mp.product_name,
        'price': mp.price,
        'unit_price': mp.unit_price,
    }
    for mp in product.market_product_array
    ]

    similar_products_as_dicts = [
    {
        'product_name': sp.product_name,
        'price': sp.product_price,
    }
    for sp in product.similar_product_array
    ]
    
    # Ensure similar conversion for other attributes if necessary

    doc_ref = db.collection('Products')\
                .document(product.main_category)\
                .collection('Sub Category')\
                .document(product.sub_category)\
                .collection('Sub Category 2')\
                .document(product.sub_category2)\
                .collection('Product Name')\
                .document(product.product_name)
    doc_ref.set({
        'product_name': product.product_name,
        'main_category': product.main_category,
        'sub_category': product.sub_category,
        'sub_category2': product.sub_category2,
        'product_cheapest_price': product.product_cheapest_price,
        'market_product_array': market_products_as_dicts,  # Assuming this is already converted
        'similar_product_array': similar_products_as_dicts,  # Use the converted list here
        'features': product.features,  # Ensure this is also in a compatible format
        'product_image_url': product.product_image_url
    }, merge =True)
