import scrape_cimri_product
import scrape_cimri_url
from requests_html import HTMLSession
from bs4 import BeautifulSoup
import requests
import time

session = HTMLSession()

main_category = "Süt ve Kahvaltlık"

bal_recel_category_urls = "https://www.cimri.com/market/bal-ve-recel?onlyOffline=true"
tahin_pekmez_helva_category_urls = "https://www.cimri.com/market/tahin-pekmez-ve-helva?onlyOffline=true"
peynir_category_urls = "https://www.cimri.com/market/peynir?onlyOffline=true"
zeytin_category_urls = "https://www.cimri.com/market/zeytin?onlyOffline=true"
surulebilir_category_urls = "https://www.cimri.com/market/surulebilir?onlyOffline=true"
kahvaltilik_gevrek_category_urls = "https://www.cimri.com/market/kahvaltilik-gevrek?onlyOffline=true"
tereyag_margarin_category_urls = "https://www.cimri.com/market/tereyag-ve-margarin?onlyOffline=true"
yogurt_category_urls = "https://www.cimri.com/market/yogurt?onlyOffline=true"
sut_category_urls = "https://www.cimri.com/market/sut?onlyOffline=true"
yumurta_category_urls = "https://www.cimri.com/market/yumurta?onlyOffline=true"
kaymak_category_urls = "https://www.cimri.com/market/kaymak?onlyOffline=true"



def scrape_product_bal_recel(bal_recel_product_soup):
    current_category = "Bal ve Reçel"
    if not scrape_cimri_product.check_offline_market(bal_recel_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(bal_recel_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(bal_recel_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(bal_recel_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(bal_recel_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(bal_recel_product_soup)
    new_bal_recel = scrape_cimri_product.Product(current_product_name, main_category, current_category, "",
                                                 price=current_product_cheapest_price,
                                                 market_products=current_product_market_products,
                                                 similar_products=current_product_similar_products,
                                                 features=current_product_feature_dict)
    return new_bal_recel


def scrape_bal_recel_products():
    bal_recel_product_urls = scrape_cimri_url.get_category_urls(bal_recel_category_urls)
    bal_recel_list = []
    for bal_recel_product_url in bal_recel_product_urls:
        bal_recel_product_soup = scrape_cimri_product.get_page_data(str(bal_recel_product_url))
        if None is not scrape_product_bal_recel(bal_recel_product_soup):
            bal_recel_list.append(scrape_product_bal_recel(bal_recel_product_soup))
        time.sleep(3)
    return bal_recel_list


############################################################################################


def scrape_product_tahin_pekmez_helva(tahin_pekmez_helva_product_soup):
    current_category = "Tahin Pekmez ve Helva"
    if not scrape_cimri_product.check_offline_market(tahin_pekmez_helva_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(tahin_pekmez_helva_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(tahin_pekmez_helva_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(tahin_pekmez_helva_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(tahin_pekmez_helva_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(tahin_pekmez_helva_product_soup)
    new_tahin_pekmez_helva = scrape_cimri_product.Product(current_product_name, main_category, current_category, "",
                                             price=current_product_cheapest_price,
                                             market_products=current_product_market_products,
                                             similar_products=current_product_similar_products,
                                             features=current_product_feature_dict)
    return new_tahin_pekmez_helva


def scrape_tahin_pekmez_helva_products():
    tahin_pekmez_helva_product_urls = scrape_cimri_url.get_category_urls(tahin_pekmez_helva_category_urls)
    tahin_pekmez_helva_list = []
    for tahin_pekmez_helva_product_url in tahin_pekmez_helva_product_urls:
        tahin_pekmez_helva_product_soup = scrape_cimri_product.get_page_data(str(tahin_pekmez_helva_product_url))
        if None is not scrape_product_tahin_pekmez_helva(tahin_pekmez_helva_product_soup):
            tahin_pekmez_helva_list.append(scrape_product_tahin_pekmez_helva(tahin_pekmez_helva_product_soup))
        time.sleep(3)
    return tahin_pekmez_helva_list


############################################################################################


def scrape_product_peynir(peynir_product_soup):
    current_category = "Peynir"
    if not scrape_cimri_product.check_offline_market(peynir_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(peynir_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(peynir_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(peynir_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(peynir_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(peynir_product_soup)
    new_peynir = scrape_cimri_product.Product(current_product_name, main_category, current_category, "",
                                             price=current_product_cheapest_price,
                                             market_products=current_product_market_products,
                                             similar_products=current_product_similar_products,
                                             features=current_product_feature_dict)
    return new_peynir


def scrape_peynir_products():
    peynir_product_urls = scrape_cimri_url.get_category_urls(peynir_category_urls)
    peynir_list = []
    for peynir_product_url in peynir_product_urls:
        peynir_product_soup = scrape_cimri_product.get_page_data(str(peynir_product_url))
        if None is not scrape_product_peynir(peynir_product_soup):
            peynir_list.append(scrape_product_peynir(peynir_product_soup))
        time.sleep(3)
    return peynir_list


############################################################################################


def scrape_product_zeytin(zeytin_product_soup):
    current_category = "Zeytin"
    if not scrape_cimri_product.check_offline_market(zeytin_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(zeytin_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(zeytin_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(zeytin_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(zeytin_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(zeytin_product_soup)
    new_zeytin = scrape_cimri_product.Product(current_product_name, main_category, current_category, "",
                                             price=current_product_cheapest_price,
                                             market_products=current_product_market_products,
                                             similar_products=current_product_similar_products,
                                             features=current_product_feature_dict)
    return new_zeytin


def scrape_zeytin_products():
    zeytin_product_urls = scrape_cimri_url.get_category_urls(zeytin_category_urls)
    zeytin_list = []
    for zeytin_product_url in zeytin_product_urls:
        zeytin_product_soup = scrape_cimri_product.get_page_data(str(zeytin_product_url))
        if None is not scrape_product_zeytin(zeytin_product_soup):
            zeytin_list.append(scrape_product_zeytin(zeytin_product_soup))
        time.sleep(3)
    return zeytin_list


############################################################################################


def scrape_product_surulebilir(surulebilir_product_soup):
    current_category = "Sürülebilir"
    if not scrape_cimri_product.check_offline_market(surulebilir_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(surulebilir_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(surulebilir_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(surulebilir_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(surulebilir_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(surulebilir_product_soup)
    new_surulebilir = scrape_cimri_product.Product(current_product_name, main_category, current_category, "",
                                             price=current_product_cheapest_price,
                                             market_products=current_product_market_products,
                                             similar_products=current_product_similar_products,
                                             features=current_product_feature_dict)
    return new_surulebilir


def scrape_surulebilir_products():
    surulebilir_product_urls = scrape_cimri_url.get_category_urls(surulebilir_category_urls)
    surulebilir_list = []
    for surulebilir_product_url in surulebilir_product_urls:
        surulebilir_product_soup = scrape_cimri_product.get_page_data(str(surulebilir_product_url))
        if None is not scrape_product_surulebilir(surulebilir_product_soup):
            surulebilir_list.append(scrape_product_surulebilir(surulebilir_product_soup))
        time.sleep(3)
    return surulebilir_list


############################################################################################


def scrape_product_kahvaltilik_gevrek(kahvaltilik_gevrek_product_soup):
    current_category = "Kahvaltılık Gevrek"
    if not scrape_cimri_product.check_offline_market(kahvaltilik_gevrek_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(kahvaltilik_gevrek_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(kahvaltilik_gevrek_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(kahvaltilik_gevrek_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(kahvaltilik_gevrek_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(kahvaltilik_gevrek_product_soup)
    new_kahvaltilik_gevrek = scrape_cimri_product.Product(current_product_name, main_category, current_category, "",
                                             price=current_product_cheapest_price,
                                             market_products=current_product_market_products,
                                             similar_products=current_product_similar_products,
                                             features=current_product_feature_dict)
    return new_kahvaltilik_gevrek


def scrape_kahvaltilik_gevrek_products():
    kahvaltilik_gevrek_product_urls = scrape_cimri_url.get_category_urls(kahvaltilik_gevrek_category_urls)
    kahvaltilik_gevrek_list = []
    for kahvaltilik_gevrek_product_url in kahvaltilik_gevrek_product_urls:
        kahvaltilik_gevrek_product_soup = scrape_cimri_product.get_page_data(str(kahvaltilik_gevrek_product_url))
        if None is not scrape_product_kahvaltilik_gevrek(kahvaltilik_gevrek_product_soup):
            kahvaltilik_gevrek_list.append(scrape_product_kahvaltilik_gevrek(kahvaltilik_gevrek_product_soup))
        time.sleep(3)
    return kahvaltilik_gevrek_list


############################################################################################


def scrape_product_tereyag_margarin(tereyag_margarin_product_soup):
    current_category = "Tereyağ ve Margarin"
    if not scrape_cimri_product.check_offline_market(tereyag_margarin_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(tereyag_margarin_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(tereyag_margarin_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(tereyag_margarin_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(tereyag_margarin_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(tereyag_margarin_product_soup)
    new_tereyag_margarin = scrape_cimri_product.Product(current_product_name, main_category, current_category, "",
                                             price=current_product_cheapest_price,
                                             market_products=current_product_market_products,
                                             similar_products=current_product_similar_products,
                                             features=current_product_feature_dict)
    return new_tereyag_margarin


def scrape_tereyag_margarin_products():
    tereyag_margarin_product_urls = scrape_cimri_url.get_category_urls(tereyag_margarin_category_urls)
    tereyag_margarin_list = []
    for tereyag_margarin_product_url in tereyag_margarin_product_urls:
        tereyag_margarin_product_soup = scrape_cimri_product.get_page_data(str(tereyag_margarin_product_url))
        if None is not scrape_product_tereyag_margarin(tereyag_margarin_product_soup):
            tereyag_margarin_list.append(scrape_product_tereyag_margarin(tereyag_margarin_product_soup))
        time.sleep(3)
    return tereyag_margarin_list


############################################################################################


def scrape_product_yogurt(yogurt_product_soup):
    current_category = "Yoğurt"
    if not scrape_cimri_product.check_offline_market(yogurt_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(yogurt_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(yogurt_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(yogurt_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(yogurt_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(yogurt_product_soup)
    new_yogurt = scrape_cimri_product.Product(current_product_name, main_category, current_category, "",
                                             price=current_product_cheapest_price,
                                             market_products=current_product_market_products,
                                             similar_products=current_product_similar_products,
                                             features=current_product_feature_dict)
    return new_yogurt


def scrape_yogurt_products():
    yogurt_product_urls = scrape_cimri_url.get_category_urls(yogurt_category_urls)
    yogurt_list = []
    for yogurt_product_url in yogurt_product_urls:
        yogurt_product_soup = scrape_cimri_product.get_page_data(str(yogurt_product_url))
        if None is not scrape_product_yogurt(yogurt_product_soup):
            yogurt_list.append(scrape_product_yogurt(yogurt_product_soup))
        time.sleep(3)
    return yogurt_list


############################################################################################


def scrape_product_sut(sut_product_soup):
    current_category = "Süt"
    if not scrape_cimri_product.check_offline_market(sut_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(sut_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(sut_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(sut_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(sut_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(sut_product_soup)
    new_sut = scrape_cimri_product.Product(current_product_name, main_category, current_category, "",
                                             price=current_product_cheapest_price,
                                             market_products=current_product_market_products,
                                             similar_products=current_product_similar_products,
                                             features=current_product_feature_dict)
    return new_sut


def scrape_sut_products():
    sut_product_urls = scrape_cimri_url.get_category_urls(sut_category_urls)
    sut_list = []
    for sut_product_url in sut_product_urls:
        sut_product_soup = scrape_cimri_product.get_page_data(str(sut_product_url))
        if None is not scrape_product_sut(sut_product_soup):
            sut_list.append(scrape_product_sut(sut_product_soup))
        time.sleep(3)
    return sut_list


############################################################################################


def scrape_product_yumurta(yumurta_product_soup):
    current_category = "Yumurta"
    if not scrape_cimri_product.check_offline_market(yumurta_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(yumurta_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(yumurta_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(yumurta_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(yumurta_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(yumurta_product_soup)
    new_yumurta = scrape_cimri_product.Product(current_product_name, main_category, current_category, "",
                                             price=current_product_cheapest_price,
                                             market_products=current_product_market_products,
                                             similar_products=current_product_similar_products,
                                             features=current_product_feature_dict)
    return new_yumurta


def scrape_yumurta_products():
    yumurta_product_urls = scrape_cimri_url.get_category_urls(yumurta_category_urls)
    yumurta_list = []
    for yumurta_product_url in yumurta_product_urls:
        yumurta_product_soup = scrape_cimri_product.get_page_data(str(yumurta_product_url))
        if None is not scrape_product_yumurta(yumurta_product_soup):
            yumurta_list.append(scrape_product_yumurta(yumurta_product_soup))
        time.sleep(3)
    return yumurta_list


############################################################################################


def scrape_product_kaymak(kaymak_product_soup):
    current_category = "Kaymak"
    if not scrape_cimri_product.check_offline_market(kaymak_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(kaymak_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(kaymak_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(kaymak_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(kaymak_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(kaymak_product_soup)
    new_kaymak = scrape_cimri_product.Product(current_product_name, main_category, current_category, "",
                                             price=current_product_cheapest_price,
                                             market_products=current_product_market_products,
                                             similar_products=current_product_similar_products,
                                             features=current_product_feature_dict)
    return new_kaymak


def scrape_kaymak_products():
    kaymak_product_urls = scrape_cimri_url.get_category_urls(kaymak_category_urls)
    kaymak_list = []
    for kaymak_product_url in kaymak_product_urls:
        kaymak_product_soup = scrape_cimri_product.get_page_data(str(kaymak_product_url))
        if None is not scrape_product_kaymak(kaymak_product_soup):
            kaymak_list.append(scrape_product_kaymak(kaymak_product_soup))
        time.sleep(3)
    return kaymak_list


############################################################################################

print(len(scrape_tahin_pekmez_helva_products()))
