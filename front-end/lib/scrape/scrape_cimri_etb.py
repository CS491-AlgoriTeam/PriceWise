import scrape_cimri_product
import scrape_cimri_url
from requests_html import HTMLSession
from bs4 import BeautifulSoup
import requests
import time
import firestore_cimri_product as fs

session = HTMLSession()

main_category = "Et, Tavuk ve Balık"

et_category_urls = "https://www.cimri.com/market/kirmizi-et?onlyOffline=true"
sarkuteri_category_urls = "https://www.cimri.com/market/sarkuteri?onlyOffline=true"
tavuk_category_urls = "https://www.cimri.com/market/beyaz-et?onlyOffline=true"
balik_category_urls = "https://www.cimri.com/market/deniz-urunu?onlyOffline=true"


def scrape_product_et(et_product_soup):
    current_category = "Et"
    if not scrape_cimri_product.check_offline_market(et_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(et_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(et_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(et_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(et_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(et_product_soup)
    new_et = scrape_cimri_product.Product(current_product_name, main_category, current_category, "",
                                          price=current_product_cheapest_price,
                                          market_products=current_product_market_products,
                                          similar_products=current_product_similar_products,
                                          features=current_product_feature_dict)
    fs.add_product_to_firestore(new_et)
    return new_et


def scrape_et_products():
    et_product_urls = scrape_cimri_url.get_category_urls(et_category_urls)
    et_list = []
    i = 0
    for et_product_url in et_product_urls:
        et_product_soup = scrape_cimri_product.get_page_data(str(et_product_url))
        current_product_et = scrape_product_et(et_product_soup)
        if None is not current_product_et:
            et_list.append(current_product_et)
            i = i + 1
        print(i)
        print(current_product_et)
        print()
        time.sleep(3)
    return et_list


######################################################################################

def scrape_product_sarkuteri(sarkuteri_product_soup):
    current_category = "Şarküteri"
    if not scrape_cimri_product.check_offline_market(sarkuteri_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(sarkuteri_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(sarkuteri_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(sarkuteri_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(sarkuteri_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(sarkuteri_product_soup)
    new_sarkuteri = scrape_cimri_product.Product(current_product_name, main_category, current_category, "",
                                                 price=current_product_cheapest_price,
                                                 market_products=current_product_market_products,
                                                 similar_products=current_product_similar_products,
                                                 features=current_product_feature_dict)
    return new_sarkuteri


def scrape_sarkuteri_products():
    sarkuteri_product_urls = scrape_cimri_url.get_category_urls(sarkuteri_category_urls)
    sarkuteri_list = []
    for sarkuteri_product_url in sarkuteri_product_urls:
        sarkuteri_product_soup = scrape_cimri_product.get_page_data(str(sarkuteri_product_url))
        if None is not scrape_product_sarkuteri(sarkuteri_product_soup):
            sarkuteri_list.append(scrape_product_sarkuteri(sarkuteri_product_soup))
        time.sleep(3)
    return sarkuteri_list


######################################################################################

def scrape_product_tavuk(tavuk_product_soup):
    current_category = "Tavuk"
    if not scrape_cimri_product.check_offline_market(tavuk_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(tavuk_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(tavuk_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(tavuk_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(tavuk_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(tavuk_product_soup)
    new_tavuk = scrape_cimri_product.Product(current_product_name, main_category, current_category, "",
                                             price=current_product_cheapest_price,
                                             market_products=current_product_market_products,
                                             similar_products=current_product_similar_products,
                                             features=current_product_feature_dict)
    return new_tavuk

def scrape_tavuk_products():
    tavuk_product_urls = scrape_cimri_url.get_category_urls(tavuk_category_urls)
    tavuk_list = []
    for tavuk_product_url in tavuk_product_urls:
        tavuk_product_soup = scrape_cimri_product.get_page_data(str(tavuk_product_url))
        if None is not scrape_product_tavuk(tavuk_product_soup):
            tavuk_list.append(scrape_product_tavuk(tavuk_product_soup))
        time.sleep(3)
    return tavuk_list

######################################################################################

def scrape_product_balik(balik_product_soup):
    current_category = "Balık"
    if not scrape_cimri_product.check_offline_market(balik_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(balik_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(balik_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(balik_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(balik_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(balik_product_soup)
    new_balik = scrape_cimri_product.Product(current_product_name, main_category, current_category, "",
                                             price=current_product_cheapest_price,
                                             market_products=current_product_market_products,
                                             similar_products=current_product_similar_products,
                                             features=current_product_feature_dict)
    return new_balik


def scrape_balik_products():
    balik_product_urls = scrape_cimri_url.get_category_urls(balik_category_urls)
    balik_list = []
    for balik_product_url in balik_product_urls:
        print(balik_product_url)
        balik_product_soup = scrape_cimri_product.get_page_data(str(balik_product_url))
        if None is not scrape_product_balik(balik_product_soup):
            balik_list.append(scrape_product_balik(balik_product_soup))
        time.sleep(3)
    return balik_list


print(len(scrape_et_products()))