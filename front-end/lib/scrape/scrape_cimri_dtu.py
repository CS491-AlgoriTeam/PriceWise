import scrape_cimri_product
import scrape_cimri_url
from requests_html import HTMLSession
from bs4 import BeautifulSoup
import requests
import time

session = HTMLSession()

main_category = "Deterjan ve Temizlik Ürünleri"


oda_kokusu_category_urls = "https://www.cimri.com/market/oda-kokusu?onlyOffline=true"
parlatici_temizleyiciler_category_urls = "https://www.cimri.com/market/parlatici-ve-temizleyiciler?onlyOffline=true"
temizlik_malzemeleri_category_urls = "https://www.cimri.com/market/temizlik-malzemeleri?onlyOffline=true"
hali_sampuani_category_urls = "https://www.cimri.com/market/hali-sampuani?onlyOffline=true"

camasir_deterjani_category_urls = "https://www.cimri.com/market/camasir-deterjani?onlyOffline=true"
camasir_makinesi_urunleri_category_urls = "https://www.cimri.com/market/camasir-makinesi-urunleri?onlyOffline=true"

bulasik_deterjani_category_urls = "https://www.cimri.com/market/bulasik-deterjani?onlyOffline=true"
bulasik_makinesi_tableti_category_urls = "https://www.cimri.com/market/bulasik-makinesi-tableti?onlyOffline=true"
bulasik_makinesi_urunleri_category_urls = "https://www.cimri.com/market/bulasik-makinesi-urunleri?onlyOffline=true"
bulasik_makinesi_deterjani_category_urls = "https://www.cimri.com/market/bulasik-makinesi-deterjani?onlyOffline=true"

pecete_category_urls = "https://www.cimri.com/market/pecete?onlyOffline=true"
islak_mendil_category_urls = "https://www.cimri.com/market/islak-mendil?onlyOffline=true"
kagit_havlu_category_urls = "https://www.cimri.com/market/kagit-havlu?onlyOffline=true"
tuvalet_kagidi_category_urls = "https://www.cimri.com/market/tuvalet-kagidi?onlyOffline=true"
kagit_mendil_category_urls = "https://www.cimri.com/market/kagit-mendil?onlyOffline=true"

cop_posetleri_category_urls = "https://www.cimri.com/market/cop-posetleri?onlyOffline=true"
strec_film_category_urls = "https://www.cimri.com/market/strec-film?onlyOffline=true"
buzdolabi_poseti_category_urls = "https://www.cimri.com/market/buzdolabi-poseti?onlyOffline=true"
pisirme_kagidi_category_urls = "https://www.cimri.com/market/pisirme-kagidi?onlyOffline=true"
aluminyum_folyo_category_urls = "https://www.cimri.com/market/aluminyum-folyo?onlyOffline=true"
firin_torbasi_category_urls = "https://www.cimri.com/market/firin-torbasi?onlyOffline=true"



def scrape_product_oda_kokusu(oda_kokusu_product_soup):
    current_category = "Ev Temizliği"
    current_category_1 = "Oda Kokusu"
    if not scrape_cimri_product.check_offline_market(oda_kokusu_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(oda_kokusu_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(oda_kokusu_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(oda_kokusu_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(oda_kokusu_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(oda_kokusu_product_soup)
    new_oda_kokusu = scrape_cimri_product.Product(current_product_name, main_category, current_category,
                                                  current_category_1,
                                                  price=current_product_cheapest_price,
                                                  market_products=current_product_market_products,
                                                  similar_products=current_product_similar_products,
                                                  features=current_product_feature_dict)
    return new_oda_kokusu


def scrape_oda_kokusu_products():
    oda_kokusu_product_urls = scrape_cimri_url.get_category_urls(oda_kokusu_category_urls)
    oda_kokusu_list = []
    for oda_kokusu_product_url in oda_kokusu_product_urls:
        oda_kokusu_product_soup = scrape_cimri_product.get_page_data(str(oda_kokusu_product_url))
        if None is not scrape_product_oda_kokusu(oda_kokusu_product_soup):
            oda_kokusu_list.append(scrape_product_oda_kokusu(oda_kokusu_product_soup))
        time.sleep(3)
    return oda_kokusu_list


############################################################################################


def scrape_product_parlatici_temizleyiciler(parlatici_temizleyiciler_product_soup):
    current_category = "Ev Temizliği"
    current_category_1 = "Parlatıcı ve Temizliyiciler"
    if not scrape_cimri_product.check_offline_market(parlatici_temizleyiciler_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(parlatici_temizleyiciler_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(parlatici_temizleyiciler_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(parlatici_temizleyiciler_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(parlatici_temizleyiciler_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(parlatici_temizleyiciler_product_soup)
    new_parlatici_temizleyiciler = scrape_cimri_product.Product(current_product_name, main_category, current_category,
                                                                current_category_1,
                                                                price=current_product_cheapest_price,
                                                                market_products=current_product_market_products,
                                                                similar_products=current_product_similar_products,
                                                                features=current_product_feature_dict)
    return new_parlatici_temizleyiciler


def scrape_parlatici_temizleyiciler_products():
    parlatici_temizleyiciler_product_urls = scrape_cimri_url.get_category_urls(parlatici_temizleyiciler_category_urls)
    parlatici_temizleyiciler_list = []
    for parlatici_temizleyiciler_product_url in parlatici_temizleyiciler_product_urls:
        parlatici_temizleyiciler_product_soup = scrape_cimri_product.get_page_data(str(parlatici_temizleyiciler_product_url))
        if None is not scrape_product_parlatici_temizleyiciler(parlatici_temizleyiciler_product_soup):
            parlatici_temizleyiciler_list.append(scrape_product_parlatici_temizleyiciler(parlatici_temizleyiciler_product_soup))
        time.sleep(3)
    return parlatici_temizleyiciler_list


############################################################################################


def scrape_product_temizlik_malzemeleri(temizlik_malzemeleri_product_soup):
    current_category = "Ev Temizliği"
    current_category_1 = "Temizlik Malzemeleri"
    if not scrape_cimri_product.check_offline_market(temizlik_malzemeleri_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(temizlik_malzemeleri_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(temizlik_malzemeleri_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(temizlik_malzemeleri_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(temizlik_malzemeleri_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(temizlik_malzemeleri_product_soup)
    new_temizlik_malzemeleri = scrape_cimri_product.Product(current_product_name, main_category, current_category,
                                                            current_category_1,
                                                            price=current_product_cheapest_price,
                                                            market_products=current_product_market_products,
                                                            similar_products=current_product_similar_products,
                                                            features=current_product_feature_dict)
    return new_temizlik_malzemeleri


def scrape_temizlik_malzemeleri_products():
    temizlik_malzemeleri_product_urls = scrape_cimri_url.get_category_urls(temizlik_malzemeleri_category_urls)
    temizlik_malzemeleri_list = []
    for temizlik_malzemeleri_product_url in temizlik_malzemeleri_product_urls:
        temizlik_malzemeleri_product_soup = scrape_cimri_product.get_page_data(str(temizlik_malzemeleri_product_url))
        if None is not scrape_product_temizlik_malzemeleri(temizlik_malzemeleri_product_soup):
            temizlik_malzemeleri_list.append(scrape_product_temizlik_malzemeleri(temizlik_malzemeleri_product_soup))
        time.sleep(3)
    return temizlik_malzemeleri_list


############################################################################################


def scrape_product_hali_sampuani(hali_sampuani_product_soup):
    current_category = "Ev Temizliği"
    current_category_1 = "Halı Şampuanı"
    if not scrape_cimri_product.check_offline_market(hali_sampuani_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(hali_sampuani_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(hali_sampuani_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(hali_sampuani_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(hali_sampuani_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(hali_sampuani_product_soup)
    new_hali_sampuani = scrape_cimri_product.Product(current_product_name, main_category, current_category,
                                                     current_category_1,
                                                     price=current_product_cheapest_price,
                                                     market_products=current_product_market_products,
                                                     similar_products=current_product_similar_products,
                                                     features=current_product_feature_dict)
    return new_hali_sampuani


def scrape_hali_sampuani_products():
    hali_sampuani_product_urls = scrape_cimri_url.get_category_urls(hali_sampuani_category_urls)
    hali_sampuani_list = []
    for hali_sampuani_product_url in hali_sampuani_product_urls:
        hali_sampuani_product_soup = scrape_cimri_product.get_page_data(str(hali_sampuani_product_url))
        if None is not scrape_product_hali_sampuani(hali_sampuani_product_soup):
            hali_sampuani_list.append(scrape_product_hali_sampuani(hali_sampuani_product_soup))
        time.sleep(3)
    return hali_sampuani_list


############################################################################################


def scrape_product_camasir_deterjani(camasir_deterjani_product_soup):
    current_category = "Çamaşır Yıkama"
    current_category_1 = "Çamaşır Deterjanı"
    if not scrape_cimri_product.check_offline_market(camasir_deterjani_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(camasir_deterjani_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(camasir_deterjani_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(camasir_deterjani_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(camasir_deterjani_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(camasir_deterjani_product_soup)
    new_camasir_deterjani = scrape_cimri_product.Product(current_product_name, main_category, current_category,
                                                         current_category_1,
                                                         price=current_product_cheapest_price,
                                                         market_products=current_product_market_products,
                                                         similar_products=current_product_similar_products,
                                                         features=current_product_feature_dict)
    return new_camasir_deterjani


def scrape_camasir_deterjani_products():
    camasir_deterjani_product_urls = scrape_cimri_url.get_category_urls(camasir_deterjani_category_urls)
    camasir_deterjani_list = []
    for camasir_deterjani_product_url in camasir_deterjani_product_urls:
        camasir_deterjani_product_soup = scrape_cimri_product.get_page_data(str(camasir_deterjani_product_url))
        if None is not scrape_product_camasir_deterjani(camasir_deterjani_product_soup):
            camasir_deterjani_list.append(scrape_product_camasir_deterjani(camasir_deterjani_product_soup))
        time.sleep(3)
    return camasir_deterjani_list


############################################################################################


def scrape_product_camasir_makinesi_urunleri(camasir_makinesi_urunleri_product_soup):
    current_category = "Çamaşır Yıkama"
    current_category_1 = "Çamaşır Makinesi Ürünleri"
    if not scrape_cimri_product.check_offline_market(camasir_makinesi_urunleri_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(camasir_makinesi_urunleri_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(camasir_makinesi_urunleri_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(camasir_makinesi_urunleri_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(camasir_makinesi_urunleri_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(camasir_makinesi_urunleri_product_soup)
    new_camasir_makinesi_urunleri = scrape_cimri_product.Product(current_product_name, main_category, current_category,
                                                                 current_category_1,
                                                                 price=current_product_cheapest_price,
                                                                 market_products=current_product_market_products,
                                                                 similar_products=current_product_similar_products,
                                                                 features=current_product_feature_dict)
    return new_camasir_makinesi_urunleri


def scrape_camasir_makinesi_urunleri_products():
    camasir_makinesi_urunleri_product_urls = scrape_cimri_url.get_category_urls(camasir_makinesi_urunleri_category_urls)
    camasir_makinesi_urunleri_list = []
    for camasir_makinesi_urunleri_product_url in camasir_makinesi_urunleri_product_urls:
        camasir_makinesi_urunleri_product_soup = scrape_cimri_product.get_page_data(str(camasir_makinesi_urunleri_product_url))
        if None is not scrape_product_camasir_makinesi_urunleri(camasir_makinesi_urunleri_product_soup):
            camasir_makinesi_urunleri_list.append(scrape_product_camasir_makinesi_urunleri(camasir_makinesi_urunleri_product_soup))
        time.sleep(3)
    return camasir_makinesi_urunleri_list


############################################################################################


def scrape_product_bulasik_deterjani(bulasik_deterjani_product_soup):
    current_category = "Bulaşık Yıkama"
    current_category_1 = "Bulaşık Deterjanı"
    if not scrape_cimri_product.check_offline_market(bulasik_deterjani_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(bulasik_deterjani_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(bulasik_deterjani_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(bulasik_deterjani_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(bulasik_deterjani_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(bulasik_deterjani_product_soup)
    new_bulasik_deterjani = scrape_cimri_product.Product(current_product_name, main_category, current_category,
                                                         current_category_1,
                                                         price=current_product_cheapest_price,
                                                         market_products=current_product_market_products,
                                                         similar_products=current_product_similar_products,
                                                         features=current_product_feature_dict)
    return new_bulasik_deterjani


def scrape_bulasik_deterjani_products():
    bulasik_deterjani_product_urls = scrape_cimri_url.get_category_urls(bulasik_deterjani_category_urls)
    bulasik_deterjani_list = []
    for bulasik_deterjani_product_url in bulasik_deterjani_product_urls:
        bulasik_deterjani_product_soup = scrape_cimri_product.get_page_data(str(bulasik_deterjani_product_url))
        if None is not scrape_product_bulasik_deterjani(bulasik_deterjani_product_soup):
            bulasik_deterjani_list.append(scrape_product_bulasik_deterjani(bulasik_deterjani_product_soup))
        time.sleep(3)
    return bulasik_deterjani_list


############################################################################################


def scrape_product_bulasik_makinesi_tableti(bulasik_makinesi_tableti_product_soup):
    current_category = "Bulaşık Yıkama"
    current_category_1 = "Bulaşık Makinesi Tableti"
    if not scrape_cimri_product.check_offline_market(bulasik_makinesi_tableti_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(bulasik_makinesi_tableti_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(bulasik_makinesi_tableti_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(bulasik_makinesi_tableti_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(bulasik_makinesi_tableti_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(bulasik_makinesi_tableti_product_soup)
    new_bulasik_makinesi_tableti = scrape_cimri_product.Product(current_product_name, main_category, current_category,
                                                                current_category_1,
                                                                price=current_product_cheapest_price,
                                                                market_products=current_product_market_products,
                                                                similar_products=current_product_similar_products,
                                                                features=current_product_feature_dict)
    return new_bulasik_makinesi_tableti


def scrape_bulasik_makinesi_tableti_products():
    bulasik_makinesi_tableti_product_urls = scrape_cimri_url.get_category_urls(bulasik_makinesi_tableti_category_urls)
    bulasik_makinesi_tableti_list = []
    for bulasik_makinesi_tableti_product_url in bulasik_makinesi_tableti_product_urls:
        bulasik_makinesi_tableti_product_soup = scrape_cimri_product.get_page_data(str(bulasik_makinesi_tableti_product_url))
        if None is not scrape_product_bulasik_makinesi_tableti(bulasik_makinesi_tableti_product_soup):
            bulasik_makinesi_tableti_list.append(scrape_product_bulasik_makinesi_tableti(bulasik_makinesi_tableti_product_soup))
        time.sleep(3)
    return bulasik_makinesi_tableti_list


############################################################################################


def scrape_product_bulasik_makinesi_urunleri(bulasik_makinesi_urunleri_product_soup):
    current_category = "Bulaşık Yıkama"
    current_category_1 = "Bulaşık Makinesi Ürünleri"
    if not scrape_cimri_product.check_offline_market(bulasik_makinesi_urunleri_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(bulasik_makinesi_urunleri_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(bulasik_makinesi_urunleri_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(bulasik_makinesi_urunleri_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(bulasik_makinesi_urunleri_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(bulasik_makinesi_urunleri_product_soup)
    new_bulasik_makinesi_urunleri = scrape_cimri_product.Product(current_product_name, main_category, current_category,
                                                                 current_category_1,
                                                                 price=current_product_cheapest_price,
                                                                 market_products=current_product_market_products,
                                                                 similar_products=current_product_similar_products,
                                                                 features=current_product_feature_dict)
    return new_bulasik_makinesi_urunleri


def scrape_bulasik_makinesi_urunleri_products():
    bulasik_makinesi_urunleri_product_urls = scrape_cimri_url.get_category_urls(bulasik_makinesi_urunleri_category_urls)
    bulasik_makinesi_urunleri_list = []
    for bulasik_makinesi_urunleri_product_url in bulasik_makinesi_urunleri_product_urls:
        bulasik_makinesi_urunleri_product_soup = scrape_cimri_product.get_page_data(str(bulasik_makinesi_urunleri_product_url))
        if None is not scrape_product_bulasik_makinesi_urunleri(bulasik_makinesi_urunleri_product_soup):
            bulasik_makinesi_urunleri_list.append(scrape_product_bulasik_makinesi_urunleri(bulasik_makinesi_urunleri_product_soup))
        time.sleep(3)
    return bulasik_makinesi_urunleri_list


############################################################################################


def scrape_product_bulasik_makinesi_deterjani(bulasik_makinesi_deterjani_product_soup):
    current_category = "Bulaşık Yıkama"
    current_category_1 = "Bulaşık Makinesi Deterjanı"
    if not scrape_cimri_product.check_offline_market(bulasik_makinesi_deterjani_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(bulasik_makinesi_deterjani_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(bulasik_makinesi_deterjani_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(bulasik_makinesi_deterjani_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(bulasik_makinesi_deterjani_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(bulasik_makinesi_deterjani_product_soup)
    new_bulasik_makinesi_deterjani = scrape_cimri_product.Product(current_product_name, main_category, current_category,
                                                                  current_category_1,
                                                                  price=current_product_cheapest_price,
                                                                  market_products=current_product_market_products,
                                                                  similar_products=current_product_similar_products,
                                                                  features=current_product_feature_dict)
    return new_bulasik_makinesi_deterjani


def scrape_bulasik_makinesi_deterjani_products():
    bulasik_makinesi_deterjani_product_urls = scrape_cimri_url.get_category_urls(bulasik_makinesi_deterjani_category_urls)
    bulasik_makinesi_deterjani_list = []
    for bulasik_makinesi_deterjani_product_url in bulasik_makinesi_deterjani_product_urls:
        bulasik_makinesi_deterjani_product_soup = scrape_cimri_product.get_page_data(str(bulasik_makinesi_deterjani_product_url))
        if None is not scrape_product_bulasik_makinesi_deterjani(bulasik_makinesi_deterjani_product_soup):
            bulasik_makinesi_deterjani_list.append(scrape_product_bulasik_makinesi_deterjani(bulasik_makinesi_deterjani_product_soup))
        time.sleep(3)
    return bulasik_makinesi_deterjani_list


############################################################################################


def scrape_product_pecete(pecete_product_soup):
    current_category = "Kağıt Ürünleri"
    current_category_1 = "Peçete"
    if not scrape_cimri_product.check_offline_market(pecete_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(pecete_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(pecete_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(pecete_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(pecete_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(pecete_product_soup)
    new_pecete = scrape_cimri_product.Product(current_product_name, main_category, current_category, current_category_1,
                                              price=current_product_cheapest_price,
                                              market_products=current_product_market_products,
                                              similar_products=current_product_similar_products,
                                              features=current_product_feature_dict)
    return new_pecete


def scrape_pecete_products():
    pecete_product_urls = scrape_cimri_url.get_category_urls(pecete_category_urls)
    pecete_list = []
    for pecete_product_url in pecete_product_urls:
        pecete_product_soup = scrape_cimri_product.get_page_data(str(pecete_product_url))
        if None is not scrape_product_pecete(pecete_product_soup):
            pecete_list.append(scrape_product_pecete(pecete_product_soup))
        time.sleep(3)
    return pecete_list


############################################################################################


def scrape_product_islak_mendil(islak_mendil_product_soup):
    current_category = "Kağıt Ürünleri"
    current_category_1 = "Islak Mendil"
    if not scrape_cimri_product.check_offline_market(islak_mendil_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(islak_mendil_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(islak_mendil_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(islak_mendil_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(islak_mendil_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(islak_mendil_product_soup)
    new_islak_mendil = scrape_cimri_product.Product(current_product_name, main_category, current_category,
                                                    current_category_1,
                                                    price=current_product_cheapest_price,
                                                    market_products=current_product_market_products,
                                                    similar_products=current_product_similar_products,
                                                    features=current_product_feature_dict)
    return new_islak_mendil


def scrape_islak_mendil_products():
    islak_mendil_product_urls = scrape_cimri_url.get_category_urls(islak_mendil_category_urls)
    islak_mendil_list = []
    for islak_mendil_product_url in islak_mendil_product_urls:
        islak_mendil_product_soup = scrape_cimri_product.get_page_data(str(islak_mendil_product_url))
        if None is not scrape_product_islak_mendil(islak_mendil_product_soup):
            islak_mendil_list.append(scrape_product_islak_mendil(islak_mendil_product_soup))
        time.sleep(3)
    return islak_mendil_list


############################################################################################


def scrape_product_kagit_havlu(kagit_havlu_product_soup):
    current_category = "Kağıt Ürünleri"
    current_category_1 = "Kağıt Havlu"
    if not scrape_cimri_product.check_offline_market(kagit_havlu_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(kagit_havlu_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(kagit_havlu_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(kagit_havlu_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(kagit_havlu_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(kagit_havlu_product_soup)
    new_kagit_havlu = scrape_cimri_product.Product(current_product_name, main_category, current_category,
                                                   current_category_1,
                                                   price=current_product_cheapest_price,
                                                   market_products=current_product_market_products,
                                                   similar_products=current_product_similar_products,
                                                   features=current_product_feature_dict)
    return new_kagit_havlu


def scrape_kagit_havlu_products():
    kagit_havlu_product_urls = scrape_cimri_url.get_category_urls(kagit_havlu_category_urls)
    kagit_havlu_list = []
    for kagit_havlu_product_url in kagit_havlu_product_urls:
        kagit_havlu_product_soup = scrape_cimri_product.get_page_data(str(kagit_havlu_product_url))
        if None is not scrape_product_kagit_havlu(kagit_havlu_product_soup):
            kagit_havlu_list.append(scrape_product_kagit_havlu(kagit_havlu_product_soup))
        time.sleep(3)
    return kagit_havlu_list


############################################################################################


def scrape_product_tuvalet_kagidi(tuvalet_kagidi_product_soup):
    current_category = "Kağıt Ürünleri"
    current_category_1 = "Tuvalet Kağıdı"
    if not scrape_cimri_product.check_offline_market(tuvalet_kagidi_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(tuvalet_kagidi_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(tuvalet_kagidi_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(tuvalet_kagidi_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(tuvalet_kagidi_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(tuvalet_kagidi_product_soup)
    new_tuvalet_kagidi = scrape_cimri_product.Product(current_product_name, main_category, current_category,
                                                      current_category_1,
                                                      price=current_product_cheapest_price,
                                                      market_products=current_product_market_products,
                                                      similar_products=current_product_similar_products,
                                                      features=current_product_feature_dict)
    return new_tuvalet_kagidi


def scrape_tuvalet_kagidi_products():
    tuvalet_kagidi_product_urls = scrape_cimri_url.get_category_urls(tuvalet_kagidi_category_urls)
    tuvalet_kagidi_list = []
    for tuvalet_kagidi_product_url in tuvalet_kagidi_product_urls:
        tuvalet_kagidi_product_soup = scrape_cimri_product.get_page_data(str(tuvalet_kagidi_product_url))
        if None is not scrape_product_tuvalet_kagidi(tuvalet_kagidi_product_soup):
            tuvalet_kagidi_list.append(scrape_product_tuvalet_kagidi(tuvalet_kagidi_product_soup))
        time.sleep(3)
    return tuvalet_kagidi_list


############################################################################################


def scrape_product_kagit_mendil(kagit_mendil_product_soup):
    current_category = "Kağıt Ürünleri"
    current_category_1 = "Kağıt Mendil"
    if not scrape_cimri_product.check_offline_market(kagit_mendil_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(kagit_mendil_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(kagit_mendil_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(kagit_mendil_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(kagit_mendil_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(kagit_mendil_product_soup)
    new_kagit_mendil = scrape_cimri_product.Product(current_product_name, main_category, current_category,
                                                    current_category_1,
                                                    price=current_product_cheapest_price,
                                                    market_products=current_product_market_products,
                                                    similar_products=current_product_similar_products,
                                                    features=current_product_feature_dict)
    return new_kagit_mendil


def scrape_kagit_mendil_products():
    kagit_mendil_product_urls = scrape_cimri_url.get_category_urls(kagit_mendil_category_urls)
    kagit_mendil_list = []
    for kagit_mendil_product_url in kagit_mendil_product_urls:
        kagit_mendil_product_soup = scrape_cimri_product.get_page_data(str(kagit_mendil_product_url))
        if None is not scrape_product_kagit_mendil(kagit_mendil_product_soup):
            kagit_mendil_list.append(scrape_product_kagit_mendil(kagit_mendil_product_soup))
        time.sleep(3)
    return kagit_mendil_list


############################################################################################


def scrape_product_cop_posetleri(cop_posetleri_product_soup):
    current_category = "Mutfak Sarf Malzemeleri"
    current_category_1 = "Çöp Poşetleri"
    if not scrape_cimri_product.check_offline_market(cop_posetleri_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(cop_posetleri_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(cop_posetleri_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(cop_posetleri_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(cop_posetleri_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(cop_posetleri_product_soup)
    new_cop_posetleri = scrape_cimri_product.Product(current_product_name, main_category, current_category,
                                                     current_category_1,
                                                     price=current_product_cheapest_price,
                                                     market_products=current_product_market_products,
                                                     similar_products=current_product_similar_products,
                                                     features=current_product_feature_dict)
    return new_cop_posetleri


def scrape_cop_posetleri_products():
    cop_posetleri_product_urls = scrape_cimri_url.get_category_urls(cop_posetleri_category_urls)
    cop_posetleri_list = []
    for cop_posetleri_product_url in cop_posetleri_product_urls:
        cop_posetleri_product_soup = scrape_cimri_product.get_page_data(str(cop_posetleri_product_url))
        if None is not scrape_product_cop_posetleri(cop_posetleri_product_soup):
            cop_posetleri_list.append(scrape_product_cop_posetleri(cop_posetleri_product_soup))
        time.sleep(3)
    return cop_posetleri_list


############################################################################################


def scrape_product_strec_film(strec_film_product_soup):
    current_category = "Mutfak Sarf Malzemeleri"
    current_category_1 = "Streç Film"
    if not scrape_cimri_product.check_offline_market(strec_film_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(strec_film_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(strec_film_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(strec_film_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(strec_film_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(strec_film_product_soup)
    new_strec_film = scrape_cimri_product.Product(current_product_name, main_category, current_category,
                                                  current_category_1,
                                                  price=current_product_cheapest_price,
                                                  market_products=current_product_market_products,
                                                  similar_products=current_product_similar_products,
                                                  features=current_product_feature_dict)
    return new_strec_film


def scrape_strec_film_products():
    strec_film_product_urls = scrape_cimri_url.get_category_urls(strec_film_category_urls)
    strec_film_list = []
    for strec_film_product_url in strec_film_product_urls:
        strec_film_product_soup = scrape_cimri_product.get_page_data(str(strec_film_product_url))
        if None is not scrape_product_strec_film(strec_film_product_soup):
            strec_film_list.append(scrape_product_strec_film(strec_film_product_soup))
        time.sleep(3)
    return strec_film_list


############################################################################################


def scrape_product_buzdolabi_poseti(buzdolabi_poseti_product_soup):
    current_category = "Mutfak Sarf Malzemeleri"
    current_category_1 = "Buzdolabı Poşeti"
    if not scrape_cimri_product.check_offline_market(buzdolabi_poseti_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(buzdolabi_poseti_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(buzdolabi_poseti_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(buzdolabi_poseti_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(buzdolabi_poseti_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(buzdolabi_poseti_product_soup)
    new_buzdolabi_poseti = scrape_cimri_product.Product(current_product_name, main_category, current_category,
                                                        current_category_1,
                                                        price=current_product_cheapest_price,
                                                        market_products=current_product_market_products,
                                                        similar_products=current_product_similar_products,
                                                        features=current_product_feature_dict)
    return new_buzdolabi_poseti


def scrape_buzdolabi_poseti_products():
    buzdolabi_poseti_product_urls = scrape_cimri_url.get_category_urls(buzdolabi_poseti_category_urls)
    buzdolabi_poseti_list = []
    for buzdolabi_poseti_product_url in buzdolabi_poseti_product_urls:
        buzdolabi_poseti_product_soup = scrape_cimri_product.get_page_data(str(buzdolabi_poseti_product_url))
        if None is not scrape_product_buzdolabi_poseti(buzdolabi_poseti_product_soup):
            buzdolabi_poseti_list.append(scrape_product_buzdolabi_poseti(buzdolabi_poseti_product_soup))
        time.sleep(3)
    return buzdolabi_poseti_list


############################################################################################


def scrape_product_pisirme_kagidi(pisirme_kagidi_product_soup):
    current_category = "Mutfak Sarf Malzemeleri"
    current_category_1 = "Pişirme Kağıdı"
    if not scrape_cimri_product.check_offline_market(pisirme_kagidi_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(pisirme_kagidi_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(pisirme_kagidi_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(pisirme_kagidi_product_soup)
    current_product_similar_products = []
    current_product_feature_dict = scrape_cimri_product.get_product_feature(pisirme_kagidi_product_soup)
    new_pisirme_kagidi = scrape_cimri_product.Product(current_product_name, main_category, current_category,
                                                      current_category_1,
                                                      price=current_product_cheapest_price,
                                                      market_products=current_product_market_products,
                                                      similar_products=current_product_similar_products,
                                                      features=current_product_feature_dict)
    return new_pisirme_kagidi


def scrape_pisirme_kagidi_products():
    pisirme_kagidi_product_urls = scrape_cimri_url.get_category_urls(pisirme_kagidi_category_urls)
    pisirme_kagidi_list = []
    for pisirme_kagidi_product_url in pisirme_kagidi_product_urls:
        pisirme_kagidi_product_soup = scrape_cimri_product.get_page_data(str(pisirme_kagidi_product_url))
        if None is not scrape_product_pisirme_kagidi(pisirme_kagidi_product_soup):
            pisirme_kagidi_list.append(scrape_product_pisirme_kagidi(pisirme_kagidi_product_soup))
        time.sleep(3)
    return pisirme_kagidi_list


############################################################################################


def scrape_product_aluminyum_folyo(aluminyum_folyo_product_soup):
    current_category = "Mutfak Sarf Malzemeleri"
    current_category_1 = "Aluminyum Folyo"
    if not scrape_cimri_product.check_offline_market(aluminyum_folyo_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(aluminyum_folyo_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(aluminyum_folyo_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(aluminyum_folyo_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(aluminyum_folyo_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(aluminyum_folyo_product_soup)
    new_aluminyum_folyo = scrape_cimri_product.Product(current_product_name, main_category, current_category,
                                                       current_category_1,
                                                       price=current_product_cheapest_price,
                                                       market_products=current_product_market_products,
                                                       similar_products=current_product_similar_products,
                                                       features=current_product_feature_dict)
    return new_aluminyum_folyo


def scrape_aluminyum_folyo_products():
    aluminyum_folyo_product_urls = scrape_cimri_url.get_category_urls(aluminyum_folyo_category_urls)
    aluminyum_folyo_list = []
    for aluminyum_folyo_product_url in aluminyum_folyo_product_urls:
        aluminyum_folyo_product_soup = scrape_cimri_product.get_page_data(str(aluminyum_folyo_product_url))
        if None is not scrape_product_aluminyum_folyo(aluminyum_folyo_product_soup):
            aluminyum_folyo_list.append(scrape_product_aluminyum_folyo(aluminyum_folyo_product_soup))
        time.sleep(3)
    return aluminyum_folyo_list


############################################################################################


def scrape_product_firin_torbasi(firin_torbasi_product_soup):
    current_category = "Mutfak Sarf Malzemeleri"
    current_category_1 = "Fırın Torbası"
    if not scrape_cimri_product.check_offline_market(firin_torbasi_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(firin_torbasi_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(firin_torbasi_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(firin_torbasi_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(firin_torbasi_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(firin_torbasi_product_soup)
    new_firin_torbasi = scrape_cimri_product.Product(current_product_name, main_category, current_category,
                                                     current_category_1,
                                                     price=current_product_cheapest_price,
                                                     market_products=current_product_market_products,
                                                     similar_products=current_product_similar_products,
                                                     features=current_product_feature_dict)
    return new_firin_torbasi


def scrape_firin_torbasi_products():
    firin_torbasi_product_urls = scrape_cimri_url.get_category_urls(firin_torbasi_category_urls)
    firin_torbasi_list = []
    for firin_torbasi_product_url in firin_torbasi_product_urls:
        firin_torbasi_product_soup = scrape_cimri_product.get_page_data(str(firin_torbasi_product_url))
        if None is not scrape_product_firin_torbasi(firin_torbasi_product_soup):
            firin_torbasi_list.append(scrape_product_firin_torbasi(firin_torbasi_product_soup))
        time.sleep(3)
    return firin_torbasi_list


############################################################################################
