import scrape_cimri_product
import scrape_cimri_url
from requests_html import HTMLSession
from bs4 import BeautifulSoup
import requests
import time
import threading

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


def scrape_cay_products():
    current_category = "Çay"
    cay_product_urls = scrape_cimri_url.get_category_urls(cay_category_urls)
    cay_list = []
    for cay_product_url in cay_product_urls:
        cay_product_soup = scrape_cimri_product.get_page_data(str(cay_product_url))
        current_product_cay = scrape_cimri_product.scrape_product(cay_product_soup,
                                                                  main_category,
                                                                  current_category, "")
        if None is not current_product_cay:
            cay_list.append(current_product_cay)
        time.sleep(3)
    cay_list = scrape_cimri_product.organize_similar_products(cay_list)
    return cay_list


############################################################################################
def scrape_kahve_products():
    current_category = "Kahve"
    kahve_product_urls = scrape_cimri_url.get_category_urls(kahve_category_urls)
    kahve_list = []
    for kahve_product_url in kahve_product_urls:
        kahve_product_soup = scrape_cimri_product.get_page_data(str(kahve_product_url))
        current_product_kahve = scrape_cimri_product.scrape_product(kahve_product_soup,
                                                                    main_category,
                                                                    current_category, "")
        if None is not current_product_kahve:
            kahve_list.append(current_product_kahve)
        time.sleep(3)
    kahve_list = scrape_cimri_product.organize_similar_products(kahve_list)
    return kahve_list


############################################################################################
def scrape_sicak_toz_icecek_products():
    current_category = "Sıcak Toz İçecek"
    sicak_toz_icecek_product_urls = scrape_cimri_url.get_category_urls(sicak_toz_icecek_category_urls)
    sicak_toz_icecek_list = []
    for sicak_toz_icecek_product_url in sicak_toz_icecek_product_urls:
        sicak_toz_icecek_product_soup = scrape_cimri_product.get_page_data(str(sicak_toz_icecek_product_url))
        current_product_sicak_toz_icecek = scrape_cimri_product.scrape_product(sicak_toz_icecek_product_soup,
                                                                               main_category,
                                                                               current_category, "")
        if None is not current_product_sicak_toz_icecek:
            sicak_toz_icecek_list.append(current_product_sicak_toz_icecek)
        time.sleep(3)
    sicak_toz_icecek_list = scrape_cimri_product.organize_similar_products(sicak_toz_icecek_list)
    return sicak_toz_icecek_list


############################################################################################
def scrape_limonata_meyve_suyu_products():
    current_category = "Limonata Meyve Suyu"
    limonata_meyve_suyu_product_urls = scrape_cimri_url.get_category_urls(limonata_meyve_suyu_category_urls)
    limonata_meyve_suyu_list = []
    for limonata_meyve_suyu_product_url in limonata_meyve_suyu_product_urls:
        limonata_meyve_suyu_product_soup = scrape_cimri_product.get_page_data(str(limonata_meyve_suyu_product_url))
        current_product_limonata_meyve_suyu = scrape_cimri_product.scrape_product(limonata_meyve_suyu_product_soup,
                                                                                  main_category,
                                                                                  current_category, "")
        if None is not current_product_limonata_meyve_suyu:
            limonata_meyve_suyu_list.append(current_product_limonata_meyve_suyu)
        time.sleep(3)
    limonata_meyve_suyu_list = scrape_cimri_product.organize_similar_products(limonata_meyve_suyu_list)
    return limonata_meyve_suyu_list


############################################################################################
def scrape_gazli_icecek_products():
    current_category = "Gazli İcecek"
    gazli_icecek_product_urls = scrape_cimri_url.get_category_urls(gazli_icecek_category_urls)
    gazli_icecek_list = []
    for gazli_icecek_product_url in gazli_icecek_product_urls:
        gazli_icecek_product_soup = scrape_cimri_product.get_page_data(str(gazli_icecek_product_url))
        current_product_gazli_icecek = scrape_cimri_product.scrape_product(gazli_icecek_product_soup,
                                                                           main_category,
                                                                           current_category, "")
        if None is not current_product_gazli_icecek:
            gazli_icecek_list.append(current_product_gazli_icecek)
        time.sleep(3)
    gazli_icecek_list = scrape_cimri_product.organize_similar_products(gazli_icecek_list)
    return gazli_icecek_list


############################################################################################
def scrape_soguk_toz_icecekler_products():
    current_category = "SoĞuk Toz İçecekler"
    soguk_toz_icecekler_product_urls = scrape_cimri_url.get_category_urls(soguk_toz_icecekler_category_urls)
    soguk_toz_icecekler_list = []
    for soguk_toz_icecekler_product_url in soguk_toz_icecekler_product_urls:
        soguk_toz_icecekler_product_soup = scrape_cimri_product.get_page_data(str(soguk_toz_icecekler_product_url))
        current_product_soguk_toz_icecekler = scrape_cimri_product.scrape_product(soguk_toz_icecekler_product_soup,
                                                                                  main_category,
                                                                                  current_category, "")
        if None is not current_product_soguk_toz_icecekler:
            soguk_toz_icecekler_list.append(current_product_soguk_toz_icecekler)
        time.sleep(3)
    soguk_toz_icecekler_list = scrape_cimri_product.organize_similar_products(soguk_toz_icecekler_list)
    return soguk_toz_icecekler_list


############################################################################################
def scrape_geleneksel_icecekler_products():
    current_category = "Geleneksel İçecekler"
    geleneksel_icecekler_product_urls = scrape_cimri_url.get_category_urls(geleneksel_icecekler_category_urls)
    geleneksel_icecekler_list = []
    for geleneksel_icecekler_product_url in geleneksel_icecekler_product_urls:
        geleneksel_icecekler_product_soup = scrape_cimri_product.get_page_data(str(geleneksel_icecekler_product_url))
        current_product_geleneksel_icecekler = scrape_cimri_product.scrape_product(geleneksel_icecekler_product_soup,
                                                                                   main_category,
                                                                                   current_category, "")
        if None is not current_product_geleneksel_icecekler:
            geleneksel_icecekler_list.append(current_product_geleneksel_icecekler)
        time.sleep(3)
    geleneksel_icecekler_list = scrape_cimri_product.organize_similar_products(geleneksel_icecekler_list)
    return geleneksel_icecekler_list


############################################################################################
def scrape_su_products():
    current_category = "Su"
    su_product_urls = scrape_cimri_url.get_category_urls(su_category_urls)
    su_list = []
    for su_product_url in su_product_urls:
        su_product_soup = scrape_cimri_product.get_page_data(str(su_product_url))
        current_product_su = scrape_cimri_product.scrape_product(su_product_soup, main_category,
                                                                 current_category, "")
        if None is not current_product_su:
            su_list.append(current_product_su)
        time.sleep(3)
    su_list = scrape_cimri_product.organize_similar_products(su_list)
    return su_list


############################################################################################
def scrape_maden_suyu_products():
    current_category = "Maden Suyu"
    maden_suyu_product_urls = scrape_cimri_url.get_category_urls(maden_suyu_category_urls)
    maden_suyu_list = []
    for maden_suyu_product_url in maden_suyu_product_urls:
        maden_suyu_product_soup = scrape_cimri_product.get_page_data(str(maden_suyu_product_url))
        current_product_maden_suyu = scrape_cimri_product.scrape_product(maden_suyu_product_soup, main_category,
                                                                         current_category, "")
        if None is not current_product_maden_suyu:
            maden_suyu_list.append(current_product_maden_suyu)
        time.sleep(3)
    maden_suyu_list = scrape_cimri_product.organize_similar_products(maden_suyu_list)
    return maden_suyu_list


############################################################################################
def scrape_soguk_kahve_products():
    current_category = "Soğuk Kahve"
    soguk_kahve_product_urls = scrape_cimri_url.get_category_urls(soguk_kahve_category_urls)
    soguk_kahve_list = []
    for soguk_kahve_product_url in soguk_kahve_product_urls:
        soguk_kahve_product_soup = scrape_cimri_product.get_page_data(str(soguk_kahve_product_url))
        current_product_soguk_kahve = scrape_cimri_product.scrape_product(soguk_kahve_product_soup, main_category,
                                                                          current_category, "")
        if None is not current_product_soguk_kahve:
            soguk_kahve_list.append(current_product_soguk_kahve)
        time.sleep(3)
    soguk_kahve_list = scrape_cimri_product.organize_similar_products(soguk_kahve_list)
    return soguk_kahve_list


############################################################################################
def scrape_ayran_products():
    current_category = "Ayran"
    ayran_product_urls = scrape_cimri_url.get_category_urls(ayran_category_urls)
    ayran_list = []
    for ayran_product_url in ayran_product_urls:
        ayran_product_soup = scrape_cimri_product.get_page_data(str(ayran_product_url))
        current_product_ayran = scrape_cimri_product.scrape_product(ayran_product_soup, main_category,
                                                                    current_category, "")
        if None is not current_product_ayran:
            ayran_list.append(current_product_ayran)
        time.sleep(3)
    ayran_list = scrape_cimri_product.organize_similar_products(ayran_list)
    return ayran_list


############################################################################################

product_list = scrape_ayran_products()
i = 0
for product in product_list:
    i = i + 1
    print(i)
    print(product)
    print()

word_dictionary = {}
feature_list = []
for product in product_list:
    words = (product.get_product_name()).split()
    feature_dict = (product.get_features()).keys()
    for feature in feature_dict:
        if feature not in feature_list:
            feature_list.append(feature)
    for word in words:
        word = word.lower()
        if word in word_dictionary:
            word_dictionary[word] += 1
        else:
            word_dictionary[word] = 1
print(word_dictionary)
print(feature_list)
