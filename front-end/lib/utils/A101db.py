from requests_html import HTMLSession
from bs4 import BeautifulSoup
import requests
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
from bs4 import BeautifulSoup
import categoryDeecider as cd

# Initialize the Firebase Admin SDK
cred = credentials.Certificate('/Users/tugberkdikmen/Desktop/Fall-23/CS491/PriceWise Frontend/PriceWise/front-end/lib/dbServiceKeys/pricewise-cs-firebase-adminsdk-kc14m-bc36ff519d.json')
firebase_admin.initialize_app(cred)
session = HTMLSession()
url = "https://www.a101.com.tr/market/"


class Product:
    def __init__(self, name, price, category):
        self.name = name
        self.price = price
        self.category = category  # New attribute

    def __str__(self):
        return f"{self.name}({self.price}) - {self.category}"



def getdata(url):
    r = session.get(url)
    soup = BeautifulSoup(r.text, "html.parser")
    return soup


def getnextpage(soup):
    page = soup.find("nav", {'class': 'pagination'})
    if not page.find("li", {'class': "page-link js-pagination-next js-passive hidden"}):
        url = "https://www.a101.com.tr/" + str(page.find())
        return url
    else:
        return

httpRequest = requests.get(url)
html = httpRequest.text
parsedHtml = BeautifulSoup(html, "html.parser")
page = parsedHtml.find("nav", {'class': 'pagination'})

urls = page.find_all('a', {'class': 'page-link js-pagination'})

urls = [url['href'] for url in urls]

final_urls = []
first_page = True
for c_url in urls:
    if first_page:
        current_string = "https://www.a101.com.tr//market/"
        first_page = False
    else:
        current_string = "https://www.a101.com.tr//market/" + str(c_url)
    final_urls.append(current_string)
#print(final_urls)


product_final_list = []

for currentUrl in final_urls:

    httpRequest = requests.get(currentUrl)

    html = httpRequest.text

    parsedHtml = BeautifulSoup(html, "html.parser")

    arrayOfProjectHTML = parsedHtml.find_all("li", {"class": "col-md-4 col-sm-6 col-xs-6 set-product-item"})

    for product in arrayOfProjectHTML:
        current_name = product.find("h3").text
        current_price = product.find("span", {"class": "current"}).text
        current_category = cd.determine_category(current_name)
        current_product = Product(current_name, current_price, current_category)
        product_final_list.append(current_product)

# Function to push data to Firestore
def push_to_firestore(product_list):
    db = firestore.client()
    for product in product_list:
        # Modify the reference path to include the category
        products_ref = db.collection('Markets').document('A101').collection('Categories').document(product.category).collection('Products')
        products_ref.add({
            'name': product.name,
            'price': product.price,
            'category': product.category
        })

# Main script execution
if __name__ == "__main__":
    #product_list = parse_products(url)  # Make sure to replace this with the actual function you use to parse the products
    push_to_firestore(product_final_list)
    print(f'Successfully added {len(product_final_list)} products to Firestore.')
    
    #print(len(product_final_list))
    #for product in product_final_list:
    #    print(product)
