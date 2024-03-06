import time

from requests_html import HTMLSession
from bs4 import BeautifulSoup
import requests

session = HTMLSession()

market_dictionary = {
    "şok": "Şok",
    "Bim": "Bim",
    "Hakmarekspress": "Hakmar Express",
    "migros": "Migros",
    "carrefour": "Carrefour",
    "a101": "A101",
    "Tarım Kredi Kooperatifi": "Tarım Kredi Kooperatifi",
    "n11": "n11"
}


class Product:
    def __init__(self, name, category1, category2, category3, price, market_products, similar_products,
                 features, image_url):
        self.product_name = name
        self.main_category = category1
        self.sub_category = category2
        self.sub_category2 = category3
        self.product_cheapest_price = price
        self.market_product_array = market_products
        self.similar_product_array = similar_products
        self.features = features
        self.product_image_url = image_url

    def get_product_name(self):
        return self.product_name

    def get_main_category(self):
        return self.main_category

    def get_sub_category(self):
        return self.sub_category

    def get_sub_category2(self):
        return self.sub_category2

    def get_cheapest_price(self):
        return self.product_cheapest_price

    def get_market_products(self):
        return self.market_product_array

    def get_similar_products(self):
        return self.similar_product_array

    def set_similar_products(self, new_similar_products):
        self.similar_product_array = new_similar_products

    def get_features(self):
        return self.features

    def set_features(self, new_features):
        self.features = new_features

    def get_product_image_url(self):
        return self.product_image_url

    def __str__(self):
        # Product details
        product_info = f"Product Name: {self.product_name}\n" \
                       f"Main Category: {self.main_category}\n" \
                       f"Sub-categories: {', '.join([self.sub_category, self.sub_category2])}\n"

        # Cheapest price and market information
        cheapest_price_info = f"Cheapest Price: {self.product_cheapest_price} \n"

        # Market products list
        market_products_info = "\nMarket Products:\n"
        for market_product in self.market_product_array:
            market_products_info += f" - {market_product}\n"

        # Similar products list
        similar_products_info = "\nSimilar Products:\n"
        for similar_product in self.similar_product_array:
            similar_products_info += f" - {similar_product}\n"

        # Features list
        features_info = "\nFeatures:\n"
        for feature, value in self.features.items():
            features_info += f" - {feature}: {value}\n"

        # Image url string
        image_url_str = f"Product Image URL: {str(self.product_image_url)} \n"

        # Combine all information with desired order
        return (product_info + cheapest_price_info + market_products_info + similar_products_info +
                features_info + image_url_str)


class MarketProduct:
    def __init__(self, market_name, product_name, price, unit_price):
        self.market_name = market_name
        self.product_name = product_name
        self.price = price
        self.unit_price = unit_price

    def __str__(self):
        return f"Market: {self.market_name:<20s} Product: {self.product_name:<30s}" \
               f" Price: {self.price:<10s} Unit Price: {self.unit_price}"


class SimilarProduct:
    def __init__(self, product_name, product_price):
        self.product_name = product_name
        self.product_price = product_price

    def get_product_name(self):
        return self.product_name

    def get_product_price(self):
        return self.product_price

    def __str__(self):
        return f"Similar Product: {self.product_name:<50s} Price: {self.product_price:<10s}"


def get_page_data(input_url):
    http_request = requests.get(input_url)
    html = http_request.text
    parsed_html = BeautifulSoup(html, "html.parser")
    return parsed_html


# Gets the product name from the soup
def get_product_name(soup):
    product_name = soup.find("h1", {"class": "ProductDetailComponent_title__2fJtJ"}).text
    return product_name


# Gets the product's cheapest price from the soup
def get_product_cheapest_price(soup):
    product_cheapest_price = soup.find("div", {"class": "MainOfferCard_price_container__22jHp"}).text
    return product_cheapest_price


# Gets the product's market products from the soup. Return a market product list
def get_market_product_array(soup):
    market_product_soup = soup.find("div", {"class": "ProductPage_offersWrapper__2jzUc ProductPage_seeMore__BC-Er"})
    final_market_product_list = []
    for market_product in market_product_soup.find_all("a"):
        name_info_side = market_product.find("div", {"class": "OfferCard_merchantInfo__EF_xU"})
        price_info_side = market_product.find("div", {"OfferCard_moreDetail__3Ne1C"})
        market_product_name = name_info_side.find("span").text
        market_name_img = market_product.find_all("img")
        market_name_raw = market_name_img[1]["alt"]
        if market_name_raw in market_dictionary:
            market_name = market_dictionary[str(market_name_raw)]
        else:
            market_name = market_name_raw
        market_product_price = price_info_side.find("span", {"class": "OfferCard_price__en-Ud"}).text
        market_product_unit_price = "0"
        if None is not price_info_side.find("span", {"class": "OfferCard_unitPrice__L2YHY"}):
            market_product_unit_price = price_info_side.find("span", {"class": "OfferCard_unitPrice__L2YHY"}).text
        new_market_product = MarketProduct(market_name, market_product_name, market_product_price,
                                           market_product_unit_price)
        final_market_product_list.append(new_market_product)
    return final_market_product_list


# Gets the product's similar products from the soup. Return a similar product list
def get_similar_products(soup):
    final_similar_product_list = []
    similar_product_table = soup.find("div", {"class": "ProductPage_similarProductsMobile__KzQs9"})
    if None is not similar_product_table:
        for similar_product in similar_product_table.find_all("li", {"class": "List_container__2J99l"}):
            current_similar_product_name = similar_product.find("span", {"class": "ListItem_title__3UPBc"}).text
            current_similar_product_price = similar_product.find("span", {"class": "ListItem_info__JSKzs"}).text
            new_similar_product = SimilarProduct(current_similar_product_name, current_similar_product_price)
            final_similar_product_list.append(new_similar_product)
    return final_similar_product_list


"""
    similar_product_table = soup.find("div", {"class": "ProductPage_similarProductsMobile__KzQs9"})
    if None is not soup.find("div", {"class": "ProductPage_similarProductsMobile__KzQs9"}):
        similar_product_table = soup.find("div", {"class": "ProductPage_similarProductsMobile__KzQs9"})
        for similar_products_url in similar_product_table.find_all("li", {"class": "List_container__2J99l"}):
            current_similar_product_url = "https://www.cimri.com/" + str(similar_products_url.find("a")["href"])
            current_soup = get_page_data(str(current_similar_product_url))
            if check_offline_market(current_soup):
                time.sleep(3)
                current_similar_product_name = get_product_name(current_soup)
                current_similar_product_price = get_product_cheapest_price(current_soup)
                new_similar_product = SimilarProduct(current_similar_product_name, current_similar_product_price)
                final_similar_product_list.append(new_similar_product)
"""


# Gets the product's features from the soup. Return a dictionary
def get_product_feature(soup):
    general_features = soup.find("div", {"class": "SpecsComponent_table__1dO9S"})
    feature_dict = {}
    if general_features is not None:
        table = general_features.find("table", {"class": "DataTable_table__4UFD4"})
        if table is not None:
            if "Genel Özellikler" in table.text:
                for feature in table.find_all("tr", {"class": "DataTable_withBorders__LH_Sr"}):
                    left_raw, right_raw = feature.find_all("td")
                    feature_dict[left_raw.text] = right_raw.text
    return feature_dict


def get_product_image(product_soup):
    product_image = ""
    image_container = product_soup.find('div', class_='ProductPage_imageWrapper__2S7GW')
    if image_container is not None:
        image_divs = image_container.find_all('img')
        for image_div in image_divs:
            if image_div['alt'] == get_product_name(product_soup):
                product_image = image_div['src']

    return product_image


# Checks whether opened as an offline or online when the page is opened
def check_offline_market(soup):
    """
    if "Online Marketler" in soup.find("div", {"class": "OffersTab_tabItem__3CWpN OffersTab_selectedTab__1ehiU"}).text:
        return False
    else:
        return True
    """
    if soup.find("div", {"class": "OffersTab_tabItem__3CWpN OffersTab_selectedTab__1ehiU"}):
        if "Online Marketler" in soup.find("div",
                                           {"class": "OffersTab_tabItem__3CWpN OffersTab_selectedTab__1ehiU"}).text:
            return False
        else:
            return True
    else:
        print("There is a problem ")
        return False


# Make proper similar product list of a product
def organize_similar_products(product_list):
    for current_product in product_list:
        new_similar_products_list = []
        current_similar_products = current_product.get_similar_products()
        for similar_product in current_similar_products:
            current_similar_product_name = similar_product.get_product_name()
            current_similar_product_price = similar_product.get_product_price()
            for product_from_list in product_list:
                current_product_name = product_from_list.get_product_name()
                current_product_price = product_from_list.get_cheapest_price()
                if current_product_price == current_similar_product_price:
                    if current_similar_product_name[:-3] in current_product_name:
                        new_similar_product = SimilarProduct(current_product_name, current_product_price)
                        new_similar_products_list.append(new_similar_product)
        current_product.set_similar_products(new_similar_products_list)

    return product_list


def scrape_product(product_soup, main_category, sub_category, sub_category2):
    if not check_offline_market(product_soup):
        return
    current_product_name = get_product_name(product_soup)
    current_product_cheapest_price = get_product_cheapest_price(product_soup)
    current_product_market_products = get_market_product_array(product_soup)
    current_product_similar_products = get_similar_products(product_soup)
    current_product_feature_dict = get_product_feature(product_soup)
    current_product_image_url = get_product_image(product_soup)
    new = Product(current_product_name, main_category, sub_category, sub_category2,
                  price=current_product_cheapest_price,
                  market_products=current_product_market_products,
                  similar_products=current_product_similar_products,
                  features=current_product_feature_dict,
                  image_url=current_product_image_url)
    return new



"""
print((get_page_data("https://www.cimri.com/market/peynir/en-ucuz-icim-900-gr-beyaz-peynir-tam-yagli-fiyatlari,887472")), "", "", ""))

a = get_similar_products
(get_page_data("https://www.cimri.com/market/deniz-urunu/en-ucuz-dardanel-190-gr-sushida-tokyo-mix-fiyatlari,1187446"))

for b in a:
    stri = b.get_product_name()
    print(stri[:-3])
"""