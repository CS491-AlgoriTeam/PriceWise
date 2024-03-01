import scrape_cimri_product
import scrape_cimri_url
from requests_html import HTMLSession
from bs4 import BeautifulSoup
import requests
import time

session = HTMLSession()

main_category = "Meyve ve Sebze"
sebze_category_urls = "https://www.cimri.com/market/sebze?onlyOffline=true"
meyve_category_urls = "https://www.cimri.com/market/meyve?onlyOffline=true"


def scrape_product_sebze(sebze_product_soup):
    current_category = "Sebze"
    if not scrape_cimri_product.check_offline_market(sebze_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(sebze_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(sebze_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(sebze_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(sebze_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(sebze_product_soup)
    new_sebze = scrape_cimri_product.Product(current_product_name, main_category, current_category, "",
                                             price=current_product_cheapest_price,
                                             market_products=current_product_market_products,
                                             similar_products=current_product_similar_products,
                                             features=current_product_feature_dict)
    return new_sebze


def scrape_sebze_products():
    sebze_product_urls = scrape_cimri_url.get_category_urls(sebze_category_urls)
    sebze_list = []
    for sebze_product_url in sebze_product_urls:
        sebze_product_soup = scrape_cimri_product.get_page_data(str(sebze_product_url))
        if None is not scrape_product_sebze(sebze_product_soup):
            sebze_list.append(scrape_product_sebze(sebze_product_soup))
        time.sleep(3)
    return sebze_list


############################################################################################

def scrape_product_meyve(meyve_product_soup):
    current_category = "Meyve"
    if not scrape_cimri_product.check_offline_market(meyve_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(meyve_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(meyve_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(meyve_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(meyve_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(meyve_product_soup)
    new_meyve = scrape_cimri_product.Product(current_product_name, main_category, current_category, "",
                                             price=current_product_cheapest_price,
                                             market_products=current_product_market_products,
                                             similar_products=current_product_similar_products,
                                             features=current_product_feature_dict)
    return new_meyve


def scrape_meyve_products():
    meyve_product_urls = scrape_cimri_url.get_category_urls(meyve_category_urls)
    meyve_list = []
    for meyve_product_url in meyve_product_urls:
        meyve_product_soup = scrape_cimri_product.get_page_data(str(meyve_product_url))
        if None is not scrape_product_meyve(meyve_product_soup):
            meyve_list.append(scrape_product_meyve(meyve_product_soup))
        time.sleep(3)
    return meyve_list


def scrape_ms_all_products():
    meyve_sebze_list = []
    meyve_sebze_list.extend(scrape_sebze_products())
    meyve_sebze_list.extend(scrape_meyve_products())
    return meyve_sebze_list


print(len(scrape_sebze_products()))
"""
sebze_product_urls = scrape_cimri_url.get_category_urls(sebze_category_urls)
sebze_product_soup = scrape_cimri_product.get_page_data(str(sebze_product_urls[15]))
print(sebze_product_urls[15])
scrape_product_sebze(sebze_product_soup)
"""