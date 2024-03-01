import scrape_cimri_product
import scrape_cimri_url
from requests_html import HTMLSession
from bs4 import BeautifulSoup
import requests
import time

session = HTMLSession()

main_category = "İçecekler"

cay_category_urls = "https://www.cimri.com/market/cay?onlyOffline=true"
kahve_category_urls = "https://www.cimri.com/market/kahve?onlyOffline=true"
sicak_toz_icecek_category_urls = "https://www.cimri.com/market/sicak-toz-icecek?onlyOffline=true"
limonata_meyve_suyu_category_urls = "https://www.cimri.com/market/limonata-ve-meyve-suyu?onlyOffline=true"
gazli_icecek_category_urls = "https://www.cimri.com/market/gazli-icecek?onlyOffline=true"
soguk_toz_icecekler_category_urls = "https://www.cimri.com/market/soguk-toz-icecekler?onlyOffline=true"
geleneksel_icecekler_category_urls = "https://www.cimri.com/market/geleneksel-icecekler?onlyOffline=true"
su_category_urls = "https://www.cimri.com/market/su?onlyOffline=true"
maden_suyu_category_urls = "https://www.cimri.com/market/maden-suyu-ve-soda?onlyOffline=true"
soguk_kahve_category_urls = "https://www.cimri.com/market/soguk-kahveler?onlyOffline=true"
ayran_category_urls = "https://www.cimri.com/market/ayran?onlyOffline=true"



def scrape_product_cay(cay_product_soup):
    current_category = "Çay"
    if not scrape_cimri_product.check_offline_market(cay_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(cay_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(cay_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(cay_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(cay_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(cay_product_soup)
    new_cay = scrape_cimri_product.Product(current_product_name, main_category, current_category, "",
                                           price=current_product_cheapest_price,
                                           market_products=current_product_market_products,
                                           similar_products=current_product_similar_products,
                                           features=current_product_feature_dict)
    return new_cay


def scrape_cay_products():
    cay_product_urls = scrape_cimri_url.get_category_urls(cay_category_urls)
    cay_list = []
    for cay_product_url in cay_product_urls:
        cay_product_soup = scrape_cimri_product.get_page_data(str(cay_product_url))
        if None is not scrape_product_cay(cay_product_soup):
            cay_list.append(scrape_product_cay(cay_product_soup))
        time.sleep(3)
    return cay_list


############################################################################################


def scrape_product_kahve(kahve_product_soup):
    current_category = "Kahve"
    if not scrape_cimri_product.check_offline_market(kahve_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(kahve_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(kahve_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(kahve_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(kahve_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(kahve_product_soup)
    new_kahve = scrape_cimri_product.Product(current_product_name, main_category, current_category, "",
                                             price=current_product_cheapest_price,
                                             market_products=current_product_market_products,
                                             similar_products=current_product_similar_products,
                                             features=current_product_feature_dict)
    return new_kahve


def scrape_kahve_products():
    kahve_product_urls = scrape_cimri_url.get_category_urls(kahve_category_urls)
    kahve_list = []
    for kahve_product_url in kahve_product_urls:
        kahve_product_soup = scrape_cimri_product.get_page_data(str(kahve_product_url))
        if None is not scrape_product_kahve(kahve_product_soup):
            kahve_list.append(scrape_product_kahve(kahve_product_soup))
        time.sleep(3)
    return kahve_list


############################################################################################


def scrape_product_sicak_toz_icecek(sicak_toz_icecek_product_soup):
    current_category = "Sıcak Toz İçecek"
    if not scrape_cimri_product.check_offline_market(sicak_toz_icecek_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(sicak_toz_icecek_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(sicak_toz_icecek_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(sicak_toz_icecek_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(sicak_toz_icecek_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(sicak_toz_icecek_product_soup)
    new_sicak_toz_icecek = scrape_cimri_product.Product(current_product_name, main_category, current_category, "",
                                                        price=current_product_cheapest_price,
                                                        market_products=current_product_market_products,
                                                        similar_products=current_product_similar_products,
                                                        features=current_product_feature_dict)
    return new_sicak_toz_icecek


def scrape_sicak_toz_icecek_products():
    sicak_toz_icecek_product_urls = scrape_cimri_url.get_category_urls(sicak_toz_icecek_category_urls)
    sicak_toz_icecek_list = []
    for sicak_toz_icecek_product_url in sicak_toz_icecek_product_urls:
        sicak_toz_icecek_product_soup = scrape_cimri_product.get_page_data(str(sicak_toz_icecek_product_url))
        if None is not scrape_product_sicak_toz_icecek(sicak_toz_icecek_product_soup):
            sicak_toz_icecek_list.append(scrape_product_sicak_toz_icecek(sicak_toz_icecek_product_soup))
        time.sleep(3)
    return sicak_toz_icecek_list


############################################################################################


def scrape_product_limonata_meyve_suyu(limonata_meyve_suyu_product_soup):
    current_category = "Limonata Meyve Suyu"
    if not scrape_cimri_product.check_offline_market(limonata_meyve_suyu_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(limonata_meyve_suyu_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(limonata_meyve_suyu_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(limonata_meyve_suyu_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(limonata_meyve_suyu_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(limonata_meyve_suyu_product_soup)
    new_limonata_meyve_suyu = scrape_cimri_product.Product(current_product_name, main_category, current_category, "",
                                                           price=current_product_cheapest_price,
                                                           market_products=current_product_market_products,
                                                           similar_products=current_product_similar_products,
                                                           features=current_product_feature_dict)
    return new_limonata_meyve_suyu


def scrape_limonata_meyve_suyu_products():
    limonata_meyve_suyu_product_urls = scrape_cimri_url.get_category_urls(limonata_meyve_suyu_category_urls)
    limonata_meyve_suyu_list = []
    for limonata_meyve_suyu_product_url in limonata_meyve_suyu_product_urls:
        limonata_meyve_suyu_product_soup = scrape_cimri_product.get_page_data(str(limonata_meyve_suyu_product_url))
        if None is not scrape_product_limonata_meyve_suyu(limonata_meyve_suyu_product_soup):
            limonata_meyve_suyu_list.append(scrape_product_limonata_meyve_suyu(limonata_meyve_suyu_product_soup))
        time.sleep(3)
    return limonata_meyve_suyu_list


############################################################################################


def scrape_product_gazli_icecek(gazli_icecek_product_soup):
    current_category = "Gazli İcecek"
    if not scrape_cimri_product.check_offline_market(gazli_icecek_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(gazli_icecek_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(gazli_icecek_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(gazli_icecek_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(gazli_icecek_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(gazli_icecek_product_soup)
    new_gazli_icecek = scrape_cimri_product.Product(current_product_name, main_category, current_category, "",
                                                    price=current_product_cheapest_price,
                                                    market_products=current_product_market_products,
                                                    similar_products=current_product_similar_products,
                                                    features=current_product_feature_dict)
    return new_gazli_icecek


def scrape_gazli_icecek_products():
    gazli_icecek_product_urls = scrape_cimri_url.get_category_urls(gazli_icecek_category_urls)
    gazli_icecek_list = []
    for gazli_icecek_product_url in gazli_icecek_product_urls:
        gazli_icecek_product_soup = scrape_cimri_product.get_page_data(str(gazli_icecek_product_url))
        if None is not scrape_product_gazli_icecek(gazli_icecek_product_soup):
            gazli_icecek_list.append(scrape_product_gazli_icecek(gazli_icecek_product_soup))
        time.sleep(3)
    return gazli_icecek_list


############################################################################################


def scrape_product_soguk_toz_icecekler(soguk_toz_icecekler_product_soup):
    current_category = "SoĞuk Toz İçecekler"
    if not scrape_cimri_product.check_offline_market(soguk_toz_icecekler_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(soguk_toz_icecekler_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(soguk_toz_icecekler_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(soguk_toz_icecekler_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(soguk_toz_icecekler_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(soguk_toz_icecekler_product_soup)
    new_soguk_toz_icecekler = scrape_cimri_product.Product(current_product_name, main_category, current_category, "",
                                                           price=current_product_cheapest_price,
                                                           market_products=current_product_market_products,
                                                           similar_products=current_product_similar_products,
                                                           features=current_product_feature_dict)
    return new_soguk_toz_icecekler


def scrape_soguk_toz_icecekler_products():
    soguk_toz_icecekler_product_urls = scrape_cimri_url.get_category_urls(soguk_toz_icecekler_category_urls)
    soguk_toz_icecekler_list = []
    for soguk_toz_icecekler_product_url in soguk_toz_icecekler_product_urls:
        soguk_toz_icecekler_product_soup = scrape_cimri_product.get_page_data(str(soguk_toz_icecekler_product_url))
        if None is not scrape_product_soguk_toz_icecekler(soguk_toz_icecekler_product_soup):
            soguk_toz_icecekler_list.append(scrape_product_soguk_toz_icecekler(soguk_toz_icecekler_product_soup))
        time.sleep(3)
    return soguk_toz_icecekler_list


############################################################################################


def scrape_product_geleneksel_icecekler(geleneksel_icecekler_product_soup):
    current_category = "Geleneksel İçecekler"
    if not scrape_cimri_product.check_offline_market(geleneksel_icecekler_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(geleneksel_icecekler_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(geleneksel_icecekler_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(geleneksel_icecekler_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(geleneksel_icecekler_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(geleneksel_icecekler_product_soup)
    new_geleneksel_icecekler = scrape_cimri_product.Product(current_product_name, main_category, current_category, "",
                                             price=current_product_cheapest_price,
                                             market_products=current_product_market_products,
                                             similar_products=current_product_similar_products,
                                             features=current_product_feature_dict)
    return new_geleneksel_icecekler


def scrape_geleneksel_icecekler_products():
    geleneksel_icecekler_product_urls = scrape_cimri_url.get_category_urls(geleneksel_icecekler_category_urls)
    geleneksel_icecekler_list = []
    for geleneksel_icecekler_product_url in geleneksel_icecekler_product_urls:
        geleneksel_icecekler_product_soup = scrape_cimri_product.get_page_data(str(geleneksel_icecekler_product_url))
        if None is not scrape_product_geleneksel_icecekler(geleneksel_icecekler_product_soup):
            geleneksel_icecekler_list.append(scrape_product_geleneksel_icecekler(geleneksel_icecekler_product_soup))
        time.sleep(3)
    return geleneksel_icecekler_list


############################################################################################


def scrape_product_su(su_product_soup):
    current_category = "Su"
    if not scrape_cimri_product.check_offline_market(su_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(su_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(su_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(su_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(su_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(su_product_soup)
    new_su = scrape_cimri_product.Product(current_product_name, main_category, current_category, "",
                                          price=current_product_cheapest_price,
                                          market_products=current_product_market_products,
                                          similar_products=current_product_similar_products,
                                          features=current_product_feature_dict)
    return new_su


def scrape_su_products():
    su_product_urls = scrape_cimri_url.get_category_urls(su_category_urls)
    su_list = []
    for su_product_url in su_product_urls:
        su_product_soup = scrape_cimri_product.get_page_data(str(su_product_url))
        if None is not scrape_product_su(su_product_soup):
            su_list.append(scrape_product_su(su_product_soup))
        time.sleep(3)
    return su_list


############################################################################################


def scrape_product_maden_suyu(maden_suyu_product_soup):
    current_category = "Maden Suyu"
    if not scrape_cimri_product.check_offline_market(maden_suyu_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(maden_suyu_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(maden_suyu_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(maden_suyu_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(maden_suyu_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(maden_suyu_product_soup)
    new_maden_suyu = scrape_cimri_product.Product(current_product_name, main_category, current_category, "",
                                             price=current_product_cheapest_price,
                                             market_products=current_product_market_products,
                                             similar_products=current_product_similar_products,
                                             features=current_product_feature_dict)
    return new_maden_suyu


def scrape_maden_suyu_products():
    maden_suyu_product_urls = scrape_cimri_url.get_category_urls(maden_suyu_category_urls)
    maden_suyu_list = []
    for maden_suyu_product_url in maden_suyu_product_urls:
        maden_suyu_product_soup = scrape_cimri_product.get_page_data(str(maden_suyu_product_url))
        if None is not scrape_product_maden_suyu(maden_suyu_product_soup):
            maden_suyu_list.append(scrape_product_maden_suyu(maden_suyu_product_soup))
        time.sleep(3)
    return maden_suyu_list


############################################################################################


def scrape_product_soguk_kahve(soguk_kahve_product_soup):
    current_category = "Soğuk Kahve"
    if not scrape_cimri_product.check_offline_market(soguk_kahve_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(soguk_kahve_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(soguk_kahve_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(soguk_kahve_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(soguk_kahve_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(soguk_kahve_product_soup)
    new_soguk_kahve = scrape_cimri_product.Product(current_product_name, main_category, current_category, "",
                                                   price=current_product_cheapest_price,
                                                   market_products=current_product_market_products,
                                                   similar_products=current_product_similar_products,
                                                   features=current_product_feature_dict)
    return new_soguk_kahve


def scrape_soguk_kahve_products():
    soguk_kahve_product_urls = scrape_cimri_url.get_category_urls(soguk_kahve_category_urls)
    soguk_kahve_list = []
    for soguk_kahve_product_url in soguk_kahve_product_urls:
        soguk_kahve_product_soup = scrape_cimri_product.get_page_data(str(soguk_kahve_product_url))
        if None is not scrape_product_soguk_kahve(soguk_kahve_product_soup):
            soguk_kahve_list.append(scrape_product_soguk_kahve(soguk_kahve_product_soup))
        time.sleep(3)
    return soguk_kahve_list


############################################################################################


def scrape_product_ayran(ayran_product_soup):
    current_category = "Ayran"
    if not scrape_cimri_product.check_offline_market(ayran_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(ayran_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(ayran_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(ayran_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(ayran_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(ayran_product_soup)
    new_ayran = scrape_cimri_product.Product(current_product_name, main_category, current_category, "",
                                             price=current_product_cheapest_price,
                                             market_products=current_product_market_products,
                                             similar_products=current_product_similar_products,
                                             features=current_product_feature_dict)
    return new_ayran


def scrape_ayran_products():
    ayran_product_urls = scrape_cimri_url.get_category_urls(ayran_category_urls)
    ayran_list = []
    for ayran_product_url in ayran_product_urls:
        ayran_product_soup = scrape_cimri_product.get_page_data(str(ayran_product_url))
        if None is not scrape_product_ayran(ayran_product_soup):
            ayran_list.append(scrape_product_ayran(ayran_product_soup))
        time.sleep(3)
    return ayran_list


############################################################################################

print(len(scrape_gazli_icecek_products()))