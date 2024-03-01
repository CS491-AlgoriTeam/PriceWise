import scrape_cimri_product
import scrape_cimri_url
from requests_html import HTMLSession
from bs4 import BeautifulSoup
import requests
import time

session = HTMLSession()

main_category = "Gıda"

baharat_category_urls = "https://www.cimri.com/market/baharat?onlyOffline=true"
tuz_category_urls = "https://www.cimri.com/market/tuz?onlyOffline=true"
hazir_corba_bulyon_category_urls = "https://www.cimri.com/market/hazir-corba-ve-bulyon?onlyOffline=true"
seker_category_urls = "https://www.cimri.com/market/toz-ve-kup-seker?onlyOffline=true"

sos_category_urls = "https://www.cimri.com/market/sos?onlyOffline=true"
konserve_category_urls = "https://www.cimri.com/market/konserve?onlyOffline=true"
kuru_sebze_category_urls = "https://www.cimri.com/market/kuru-sebze?onlyOffline=true"
hazir_yemek_category_urls = "https://www.cimri.com/market/hazir-yemekler?onlyOffline=true"
dondurulmus_gida_category_urls = "https://www.cimri.com/market/dondurulmus-gida?onlyOffline=true"

kuruyemis_category_urls = "https://www.cimri.com/market/kuruyemis?onlyOffline=true"
sekerleme_sakiz_category_urls = "https://www.cimri.com/market/sekerleme-sakiz?onlyOffline=true"
cikolata_gofret_category_urls = "https://www.cimri.com/market/cikolata-ve-gofret?onlyOffline=true"
tatli_pasta_category_urls = "https://www.cimri.com/market/tatli-ve-pasta?onlyOffline=true"
biskuvi_kek_category_urls = "https://www.cimri.com/market/biskuvi-ve-kek?onlyOffline=true"
kraker_kurabiye_category_urls = "https://www.cimri.com/market/kraker-ve-kurabiye?onlyOffline=true"
cips_category_urls = "https://www.cimri.com/market/cips?onlyOffline=true"
dondurma_category_urls = "https://www.cimri.com/market/dondurma?onlyOffline=true"

kuru_meyve_category_urls = "https://www.cimri.com/market/kuru-meyve?onlyOffline=true"
granola_bar_category_urls = "https://www.cimri.com/market/granola-ve-bar?onlyOffline=true"

bitkisel_yaglar_category_urls = "https://www.cimri.com/market/bitkisel-yaglar?onlyOffline=true"
tatli_pasta_malzemeleri_category_urls = "https://www.cimri.com/market/tatli-ve-pasta-malzemeleri?onlyOffline=true"
bakliyat_category_urls = "https://www.cimri.com/market/bakliyat?onlyOffline=true"
un_irmik_category_urls = "https://www.cimri.com/market/un-ve-irmik?onlyOffline=true"
siviyag_zeytinyagi_category_urls = "https://www.cimri.com/market/sivi-yag-ve-zeytinyagi?onlyOffline=true"
makarnalar_category_urls = "https://www.cimri.com/market/makarnalar?onlyOffline=true"
unlu_mamuller_category_urls = "https://www.cimri.com/market/unlu-mamuller?onlyOffline=true"


def scrape_product_baharat(baharat_product_soup):
    current_category = "Tuz, Şeker ve Baharat"
    current_category_1 = "Baharat"
    if not scrape_cimri_product.check_offline_market(baharat_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(baharat_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(baharat_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(baharat_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(baharat_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(baharat_product_soup)
    new_baharat = scrape_cimri_product.Product(current_product_name, main_category, current_category,
                                               current_category_1,
                                               price=current_product_cheapest_price,
                                               market_products=current_product_market_products,
                                               similar_products=current_product_similar_products,
                                               features=current_product_feature_dict)
    return new_baharat


def scrape_baharat_products():
    baharat_product_urls = scrape_cimri_url.get_category_urls(baharat_category_urls)
    baharat_list = []
    for baharat_product_url in baharat_product_urls:
        baharat_product_soup = scrape_cimri_product.get_page_data(str(baharat_product_url))
        if None is not scrape_product_baharat(baharat_product_soup):
            baharat_list.append(scrape_product_baharat(baharat_product_soup))
        time.sleep(3)
    return baharat_list


############################################################################################


def scrape_product_tuz(tuz_product_soup):
    current_category = "Tuz, Şeker ve Baharat"
    current_category_1 = "Tuz"
    if not scrape_cimri_product.check_offline_market(tuz_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(tuz_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(tuz_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(tuz_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(tuz_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(tuz_product_soup)
    new_tuz = scrape_cimri_product.Product(current_product_name, main_category, current_category, current_category_1,
                                           price=current_product_cheapest_price,
                                           market_products=current_product_market_products,
                                           similar_products=current_product_similar_products,
                                           features=current_product_feature_dict)
    return new_tuz


def scrape_tuz_products():
    tuz_product_urls = scrape_cimri_url.get_category_urls(tuz_category_urls)
    tuz_list = []
    for tuz_product_url in tuz_product_urls:
        tuz_product_soup = scrape_cimri_product.get_page_data(str(tuz_product_url))
        if None is not scrape_product_tuz(tuz_product_soup):
            tuz_list.append(scrape_product_tuz(tuz_product_soup))
        time.sleep(3)
    return tuz_list


############################################################################################


def scrape_product_hazir_corba_bulyon(hazir_corba_bulyon_product_soup):
    current_category = "Tuz, Şeker ve Baharat"
    current_category_1 = "Hazır Çorba ve Bulyon"
    if not scrape_cimri_product.check_offline_market(hazir_corba_bulyon_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(hazir_corba_bulyon_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(hazir_corba_bulyon_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(hazir_corba_bulyon_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(hazir_corba_bulyon_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(hazir_corba_bulyon_product_soup)
    new_hazir_corba_bulyon = scrape_cimri_product.Product(current_product_name, main_category, current_category,
                                                          current_category_1,
                                                          price=current_product_cheapest_price,
                                                          market_products=current_product_market_products,
                                                          similar_products=current_product_similar_products,
                                                          features=current_product_feature_dict)
    return new_hazir_corba_bulyon


def scrape_hazir_corba_bulyon_products():
    hazir_corba_bulyon_product_urls = scrape_cimri_url.get_category_urls(hazir_corba_bulyon_category_urls)
    hazir_corba_bulyon_list = []
    for hazir_corba_bulyon_product_url in hazir_corba_bulyon_product_urls:
        hazir_corba_bulyon_product_soup = scrape_cimri_product.get_page_data(str(hazir_corba_bulyon_product_url))
        if None is not scrape_product_hazir_corba_bulyon(hazir_corba_bulyon_product_soup):
            hazir_corba_bulyon_list.append(scrape_product_hazir_corba_bulyon(hazir_corba_bulyon_product_soup))
        time.sleep(3)
    return hazir_corba_bulyon_list


############################################################################################


def scrape_product_seker(seker_product_soup):
    current_category = "Tuz, Şeker ve Baharat"
    current_category_1 = "Şeker"
    if not scrape_cimri_product.check_offline_market(seker_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(seker_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(seker_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(seker_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(seker_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(seker_product_soup)
    new_seker = scrape_cimri_product.Product(current_product_name, main_category, current_category, current_category_1,
                                             price=current_product_cheapest_price,
                                             market_products=current_product_market_products,
                                             similar_products=current_product_similar_products,
                                             features=current_product_feature_dict)
    return new_seker


def scrape_seker_products():
    seker_product_urls = scrape_cimri_url.get_category_urls(seker_category_urls)
    seker_list = []
    for seker_product_url in seker_product_urls:
        seker_product_soup = scrape_cimri_product.get_page_data(str(seker_product_url))
        if None is not scrape_product_seker(seker_product_soup):
            seker_list.append(scrape_product_seker(seker_product_soup))
        time.sleep(3)
    return seker_list


############################################################################################


def scrape_product_sos(sos_product_soup):
    current_category = "Konserve Sos ve Hazır Yemek"
    current_category_1 = "Sos"
    if not scrape_cimri_product.check_offline_market(sos_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(sos_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(sos_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(sos_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(sos_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(sos_product_soup)
    new_sos = scrape_cimri_product.Product(current_product_name, main_category, current_category, current_category_1,
                                           price=current_product_cheapest_price,
                                           market_products=current_product_market_products,
                                           similar_products=current_product_similar_products,
                                           features=current_product_feature_dict)
    return new_sos


def scrape_sos_products():
    sos_product_urls = scrape_cimri_url.get_category_urls(sos_category_urls)
    sos_list = []
    for sos_product_url in sos_product_urls:
        sos_product_soup = scrape_cimri_product.get_page_data(str(sos_product_url))
        if None is not scrape_product_sos(sos_product_soup):
            sos_list.append(scrape_product_sos(sos_product_soup))
        time.sleep(3)
    return sos_list


############################################################################################


def scrape_product_konserve(konserve_product_soup):
    current_category = "Konserve, Sos ve Hazır Yemek"
    current_category_1 = "Konserve"
    if not scrape_cimri_product.check_offline_market(konserve_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(konserve_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(konserve_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(konserve_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(konserve_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(konserve_product_soup)
    new_konserve = scrape_cimri_product.Product(current_product_name, main_category, current_category,
                                                current_category_1,
                                                price=current_product_cheapest_price,
                                                market_products=current_product_market_products,
                                                similar_products=current_product_similar_products,
                                                features=current_product_feature_dict)
    return new_konserve


def scrape_konserve_products():
    konserve_product_urls = scrape_cimri_url.get_category_urls(konserve_category_urls)
    konserve_list = []
    for konserve_product_url in konserve_product_urls:
        konserve_product_soup = scrape_cimri_product.get_page_data(str(konserve_product_url))
        if None is not scrape_product_konserve(konserve_product_soup):
            konserve_list.append(scrape_product_konserve(konserve_product_soup))
        time.sleep(3)
    return konserve_list


############################################################################################


def scrape_product_kuru_sebze(kuru_sebze_product_soup):
    current_category = "Konserve, Sos ve Hazır Yemek"
    current_category_1 = "Kuru Sebze"
    if not scrape_cimri_product.check_offline_market(kuru_sebze_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(kuru_sebze_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(kuru_sebze_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(kuru_sebze_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(kuru_sebze_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(kuru_sebze_product_soup)
    new_kuru_sebze = scrape_cimri_product.Product(current_product_name, main_category, current_category,
                                                  current_category_1,
                                                  price=current_product_cheapest_price,
                                                  market_products=current_product_market_products,
                                                  similar_products=current_product_similar_products,
                                                  features=current_product_feature_dict)
    return new_kuru_sebze


def scrape_kuru_sebze_products():
    kuru_sebze_product_urls = scrape_cimri_url.get_category_urls(kuru_sebze_category_urls)
    kuru_sebze_list = []
    for kuru_sebze_product_url in kuru_sebze_product_urls:
        kuru_sebze_product_soup = scrape_cimri_product.get_page_data(str(kuru_sebze_product_url))
        if None is not scrape_product_kuru_sebze(kuru_sebze_product_soup):
            kuru_sebze_list.append(scrape_product_kuru_sebze(kuru_sebze_product_soup))
        time.sleep(3)
    return kuru_sebze_list


############################################################################################


def scrape_product_hazir_yemek(hazir_yemek_product_soup):
    current_category = "Konserve, Sos ve Hazır Yemek"
    current_category_1 = "Hazır Yemek"
    if not scrape_cimri_product.check_offline_market(hazir_yemek_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(hazir_yemek_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(hazir_yemek_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(hazir_yemek_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(hazir_yemek_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(hazir_yemek_product_soup)
    new_hazir_yemek = scrape_cimri_product.Product(current_product_name, main_category, current_category,
                                                   current_category_1,
                                                   price=current_product_cheapest_price,
                                                   market_products=current_product_market_products,
                                                   similar_products=current_product_similar_products,
                                                   features=current_product_feature_dict)
    return new_hazir_yemek


def scrape_hazir_yemek_products():
    hazir_yemek_product_urls = scrape_cimri_url.get_category_urls(hazir_yemek_category_urls)
    hazir_yemek_list = []
    for hazir_yemek_product_url in hazir_yemek_product_urls:
        hazir_yemek_product_soup = scrape_cimri_product.get_page_data(str(hazir_yemek_product_url))
        if None is not scrape_product_hazir_yemek(hazir_yemek_product_soup):
            hazir_yemek_list.append(scrape_product_hazir_yemek(hazir_yemek_product_soup))
        time.sleep(3)
    return hazir_yemek_list


############################################################################################


def scrape_product_dondurulmus_gida(dondurulmus_gida_product_soup):
    current_category = "Konserve, Sos ve Hazır Yemek"
    current_category_1 = "Dondurulmuş Gıda"
    if not scrape_cimri_product.check_offline_market(dondurulmus_gida_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(dondurulmus_gida_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(dondurulmus_gida_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(dondurulmus_gida_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(dondurulmus_gida_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(dondurulmus_gida_product_soup)
    new_dondurulmus_gida = scrape_cimri_product.Product(current_product_name, main_category, current_category,
                                                        current_category_1,
                                                        price=current_product_cheapest_price,
                                                        market_products=current_product_market_products,
                                                        similar_products=current_product_similar_products,
                                                        features=current_product_feature_dict)
    return new_dondurulmus_gida


def scrape_dondurulmus_gida_products():
    dondurulmus_gida_product_urls = scrape_cimri_url.get_category_urls(dondurulmus_gida_category_urls)
    dondurulmus_gida_list = []
    for dondurulmus_gida_product_url in dondurulmus_gida_product_urls:
        dondurulmus_gida_product_soup = scrape_cimri_product.get_page_data(str(dondurulmus_gida_product_url))
        if None is not scrape_product_dondurulmus_gida(dondurulmus_gida_product_soup):
            dondurulmus_gida_list.append(scrape_product_dondurulmus_gida(dondurulmus_gida_product_soup))
        time.sleep(3)
    return dondurulmus_gida_list


############################################################################################


def scrape_product_kuruyemis(kuruyemis_product_soup):
    current_category = "Atıştırmalık"
    current_category_1 = "Kuruyemiş"
    if not scrape_cimri_product.check_offline_market(kuruyemis_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(kuruyemis_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(kuruyemis_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(kuruyemis_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(kuruyemis_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(kuruyemis_product_soup)
    new_kuruyemis = scrape_cimri_product.Product(current_product_name, main_category, current_category,
                                                 current_category_1,
                                                 price=current_product_cheapest_price,
                                                 market_products=current_product_market_products,
                                                 similar_products=current_product_similar_products,
                                                 features=current_product_feature_dict)
    return new_kuruyemis


def scrape_kuruyemis_products():
    kuruyemis_product_urls = scrape_cimri_url.get_category_urls(kuruyemis_category_urls)
    kuruyemis_list = []
    for kuruyemis_product_url in kuruyemis_product_urls:
        kuruyemis_product_soup = scrape_cimri_product.get_page_data(str(kuruyemis_product_url))
        if None is not scrape_product_kuruyemis(kuruyemis_product_soup):
            kuruyemis_list.append(scrape_product_kuruyemis(kuruyemis_product_soup))
        time.sleep(3)
    return kuruyemis_list


############################################################################################


def scrape_product_sekerleme_sakiz(sekerleme_sakiz_product_soup):
    current_category = "Atıştırmalık"
    current_category_1 = "Şekerleme Sakız"
    if not scrape_cimri_product.check_offline_market(sekerleme_sakiz_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(sekerleme_sakiz_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(sekerleme_sakiz_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(sekerleme_sakiz_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(sekerleme_sakiz_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(sekerleme_sakiz_product_soup)
    new_sekerleme_sakiz = scrape_cimri_product.Product(current_product_name, main_category, current_category,
                                                       current_category_1,
                                                       price=current_product_cheapest_price,
                                                       market_products=current_product_market_products,
                                                       similar_products=current_product_similar_products,
                                                       features=current_product_feature_dict)
    return new_sekerleme_sakiz


def scrape_sekerleme_sakiz_products():
    sekerleme_sakiz_product_urls = scrape_cimri_url.get_category_urls(sekerleme_sakiz_category_urls)
    sekerleme_sakiz_list = []
    for sekerleme_sakiz_product_url in sekerleme_sakiz_product_urls:
        sekerleme_sakiz_product_soup = scrape_cimri_product.get_page_data(str(sekerleme_sakiz_product_url))
        if None is not scrape_product_sekerleme_sakiz(sekerleme_sakiz_product_soup):
            sekerleme_sakiz_list.append(scrape_product_sekerleme_sakiz(sekerleme_sakiz_product_soup))
        time.sleep(3)
    return sekerleme_sakiz_list


############################################################################################


def scrape_product_cikolata_gofret(cikolata_gofret_product_soup):
    current_category = "Atıştırmalık"
    current_category_1 = "Çikolata ve Gofret"
    if not scrape_cimri_product.check_offline_market(cikolata_gofret_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(cikolata_gofret_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(cikolata_gofret_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(cikolata_gofret_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(cikolata_gofret_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(cikolata_gofret_product_soup)
    new_cikolata_gofret = scrape_cimri_product.Product(current_product_name, main_category, current_category,
                                                       current_category_1,
                                                       price=current_product_cheapest_price,
                                                       market_products=current_product_market_products,
                                                       similar_products=current_product_similar_products,
                                                       features=current_product_feature_dict)
    return new_cikolata_gofret


def scrape_cikolata_gofret_products():
    cikolata_gofret_product_urls = scrape_cimri_url.get_category_urls(cikolata_gofret_category_urls)
    cikolata_gofret_list = []
    for cikolata_gofret_product_url in cikolata_gofret_product_urls:
        cikolata_gofret_product_soup = scrape_cimri_product.get_page_data(str(cikolata_gofret_product_url))
        if None is not scrape_product_cikolata_gofret(cikolata_gofret_product_soup):
            cikolata_gofret_list.append(scrape_product_cikolata_gofret(cikolata_gofret_product_soup))
        time.sleep(3)
    return cikolata_gofret_list


############################################################################################


def scrape_product_tatli_pasta(tatli_pasta_product_soup):
    current_category = "Atıştırmalık"
    current_category_1 = "Tatlı ve Pasta"
    if not scrape_cimri_product.check_offline_market(tatli_pasta_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(tatli_pasta_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(tatli_pasta_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(tatli_pasta_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(tatli_pasta_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(tatli_pasta_product_soup)
    new_tatli_pasta = scrape_cimri_product.Product(current_product_name, main_category, current_category,
                                                   current_category_1,
                                                   price=current_product_cheapest_price,
                                                   market_products=current_product_market_products,
                                                   similar_products=current_product_similar_products,
                                                   features=current_product_feature_dict)
    return new_tatli_pasta


def scrape_tatli_pasta_products():
    tatli_pasta_product_urls = scrape_cimri_url.get_category_urls(tatli_pasta_category_urls)
    tatli_pasta_list = []
    for tatli_pasta_product_url in tatli_pasta_product_urls:
        tatli_pasta_product_soup = scrape_cimri_product.get_page_data(str(tatli_pasta_product_url))
        if None is not scrape_product_tatli_pasta(tatli_pasta_product_soup):
            tatli_pasta_list.append(scrape_product_tatli_pasta(tatli_pasta_product_soup))
        time.sleep(3)
    return tatli_pasta_list


############################################################################################


def scrape_product_biskuvi_kek(biskuvi_kek_product_soup):
    current_category = "Atıştırmalık"
    current_category_1 = "Bisküvi ve Kek"
    if not scrape_cimri_product.check_offline_market(biskuvi_kek_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(biskuvi_kek_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(biskuvi_kek_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(biskuvi_kek_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(biskuvi_kek_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(biskuvi_kek_product_soup)
    new_biskuvi_kek = scrape_cimri_product.Product(current_product_name, main_category, current_category,
                                                   current_category_1,
                                                   price=current_product_cheapest_price,
                                                   market_products=current_product_market_products,
                                                   similar_products=current_product_similar_products,
                                                   features=current_product_feature_dict)
    return new_biskuvi_kek


def scrape_biskuvi_kek_products():
    biskuvi_kek_product_urls = scrape_cimri_url.get_category_urls(biskuvi_kek_category_urls)
    biskuvi_kek_list = []
    for biskuvi_kek_product_url in biskuvi_kek_product_urls:
        biskuvi_kek_product_soup = scrape_cimri_product.get_page_data(str(biskuvi_kek_product_url))
        if None is not scrape_product_biskuvi_kek(biskuvi_kek_product_soup):
            biskuvi_kek_list.append(scrape_product_biskuvi_kek(biskuvi_kek_product_soup))
        time.sleep(3)
    return biskuvi_kek_list


############################################################################################


def scrape_product_kraker_kurabiye(kraker_kurabiye_product_soup):
    current_category = "Atıştırmalık"
    current_category_1 = "Kraker ve Kurabiye"
    if not scrape_cimri_product.check_offline_market(kraker_kurabiye_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(kraker_kurabiye_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(kraker_kurabiye_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(kraker_kurabiye_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(kraker_kurabiye_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(kraker_kurabiye_product_soup)
    new_kraker_kurabiye = scrape_cimri_product.Product(current_product_name, main_category, current_category,
                                                       current_category_1,
                                                       price=current_product_cheapest_price,
                                                       market_products=current_product_market_products,
                                                       similar_products=current_product_similar_products,
                                                       features=current_product_feature_dict)
    return new_kraker_kurabiye


def scrape_kraker_kurabiye_products():
    kraker_kurabiye_product_urls = scrape_cimri_url.get_category_urls(kraker_kurabiye_category_urls)
    kraker_kurabiye_list = []
    for kraker_kurabiye_product_url in kraker_kurabiye_product_urls:
        kraker_kurabiye_product_soup = scrape_cimri_product.get_page_data(str(kraker_kurabiye_product_url))
        if None is not scrape_product_kraker_kurabiye(kraker_kurabiye_product_soup):
            kraker_kurabiye_list.append(scrape_product_kraker_kurabiye(kraker_kurabiye_product_soup))
        time.sleep(3)
    return kraker_kurabiye_list


############################################################################################


def scrape_product_cips(cips_product_soup):
    current_category = "Atıştırmalık"
    current_category_1 = "Cips"
    if not scrape_cimri_product.check_offline_market(cips_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(cips_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(cips_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(cips_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(cips_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(cips_product_soup)
    new_cips = scrape_cimri_product.Product(current_product_name, main_category, current_category, current_category_1,
                                            price=current_product_cheapest_price,
                                            market_products=current_product_market_products,
                                            similar_products=current_product_similar_products,
                                            features=current_product_feature_dict)
    return new_cips


def scrape_cips_products():
    cips_product_urls = scrape_cimri_url.get_category_urls(cips_category_urls)
    cips_list = []
    for cips_product_url in cips_product_urls:
        cips_product_soup = scrape_cimri_product.get_page_data(str(cips_product_url))
        if None is not scrape_product_cips(cips_product_soup):
            cips_list.append(scrape_product_cips(cips_product_soup))
        time.sleep(3)
    return cips_list


############################################################################################


def scrape_product_dondurma(dondurma_product_soup):
    current_category = "Atıştırmalık"
    current_category_1 = "Dondurma"
    if not scrape_cimri_product.check_offline_market(dondurma_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(dondurma_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(dondurma_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(dondurma_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(dondurma_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(dondurma_product_soup)
    new_dondurma = scrape_cimri_product.Product(current_product_name, main_category, current_category,
                                                current_category_1,
                                                price=current_product_cheapest_price,
                                                market_products=current_product_market_products,
                                                similar_products=current_product_similar_products,
                                                features=current_product_feature_dict)
    return new_dondurma


def scrape_dondurma_products():
    dondurma_product_urls = scrape_cimri_url.get_category_urls(dondurma_category_urls)
    dondurma_list = []
    for dondurma_product_url in dondurma_product_urls:
        dondurma_product_soup = scrape_cimri_product.get_page_data(str(dondurma_product_url))
        if None is not scrape_product_dondurma(dondurma_product_soup):
            dondurma_list.append(scrape_product_dondurma(dondurma_product_soup))
        time.sleep(3)
    return dondurma_list


############################################################################################


def scrape_product_kuru_meyve(kuru_meyve_product_soup):
    current_category = "Fit & Form"
    current_category_1 = "Kuru Meyve"
    if not scrape_cimri_product.check_offline_market(kuru_meyve_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(kuru_meyve_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(kuru_meyve_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(kuru_meyve_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(kuru_meyve_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(kuru_meyve_product_soup)
    new_kuru_meyve = scrape_cimri_product.Product(current_product_name, main_category, current_category,
                                                  current_category_1,
                                                  price=current_product_cheapest_price,
                                                  market_products=current_product_market_products,
                                                  similar_products=current_product_similar_products,
                                                  features=current_product_feature_dict)
    return new_kuru_meyve


def scrape_kuru_meyve_products():
    kuru_meyve_product_urls = scrape_cimri_url.get_category_urls(kuru_meyve_category_urls)
    kuru_meyve_list = []
    for kuru_meyve_product_url in kuru_meyve_product_urls:
        kuru_meyve_product_soup = scrape_cimri_product.get_page_data(str(kuru_meyve_product_url))
        if None is not scrape_product_kuru_meyve(kuru_meyve_product_soup):
            kuru_meyve_list.append(scrape_product_kuru_meyve(kuru_meyve_product_soup))
        time.sleep(3)
    return kuru_meyve_list


############################################################################################


def scrape_product_granola_bar(granola_bar_product_soup):
    current_category = "Fit & Form"
    current_category_1 = "Granola ve Bar"
    if not scrape_cimri_product.check_offline_market(granola_bar_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(granola_bar_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(granola_bar_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(granola_bar_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(granola_bar_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(granola_bar_product_soup)
    new_granola_bar = scrape_cimri_product.Product(current_product_name, main_category, current_category,
                                                   current_category_1,
                                                   price=current_product_cheapest_price,
                                                   market_products=current_product_market_products,
                                                   similar_products=current_product_similar_products,
                                                   features=current_product_feature_dict)
    return new_granola_bar


def scrape_granola_bar_products():
    granola_bar_product_urls = scrape_cimri_url.get_category_urls(granola_bar_category_urls)
    granola_bar_list = []
    for granola_bar_product_url in granola_bar_product_urls:
        granola_bar_product_soup = scrape_cimri_product.get_page_data(str(granola_bar_product_url))
        if None is not scrape_product_granola_bar(granola_bar_product_soup):
            granola_bar_list.append(scrape_product_granola_bar(granola_bar_product_soup))
        time.sleep(3)
    return granola_bar_list


############################################################################################


def scrape_product_bitkisel_yaglar(bitkisel_yaglar_product_soup):
    current_category = "Temel Gıda"
    current_category_1 = "Bitkisel Yağlar"
    if not scrape_cimri_product.check_offline_market(bitkisel_yaglar_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(bitkisel_yaglar_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(bitkisel_yaglar_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(bitkisel_yaglar_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(bitkisel_yaglar_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(bitkisel_yaglar_product_soup)
    new_bitkisel_yaglar = scrape_cimri_product.Product(current_product_name, main_category, current_category,
                                                       current_category_1,
                                                       price=current_product_cheapest_price,
                                                       market_products=current_product_market_products,
                                                       similar_products=current_product_similar_products,
                                                       features=current_product_feature_dict)
    return new_bitkisel_yaglar


def scrape_bitkisel_yaglar_products():
    bitkisel_yaglar_product_urls = scrape_cimri_url.get_category_urls(bitkisel_yaglar_category_urls)
    bitkisel_yaglar_list = []
    for bitkisel_yaglar_product_url in bitkisel_yaglar_product_urls:
        bitkisel_yaglar_product_soup = scrape_cimri_product.get_page_data(str(bitkisel_yaglar_product_url))
        if None is not scrape_product_bitkisel_yaglar(bitkisel_yaglar_product_soup):
            bitkisel_yaglar_list.append(scrape_product_bitkisel_yaglar(bitkisel_yaglar_product_soup))
        time.sleep(3)
    return bitkisel_yaglar_list


############################################################################################


def scrape_product_tatli_pasta_malzemeleri(tatli_pasta_malzemeleri_product_soup):
    current_category = "Temel Gıda"
    current_category_1 = "Tatlı ve Pasta Malzemeleri"
    if not scrape_cimri_product.check_offline_market(tatli_pasta_malzemeleri_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(tatli_pasta_malzemeleri_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(tatli_pasta_malzemeleri_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(tatli_pasta_malzemeleri_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(tatli_pasta_malzemeleri_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(tatli_pasta_malzemeleri_product_soup)
    new_tatli_pasta_malzemeleri = scrape_cimri_product.Product(current_product_name, main_category, current_category,
                                                               current_category_1,
                                                               price=current_product_cheapest_price,
                                                               market_products=current_product_market_products,
                                                               similar_products=current_product_similar_products,
                                                               features=current_product_feature_dict)
    return new_tatli_pasta_malzemeleri


def scrape_tatli_pasta_malzemeleri_products():
    tatli_pasta_malzemeleri_product_urls = scrape_cimri_url.get_category_urls(tatli_pasta_malzemeleri_category_urls)
    tatli_pasta_malzemeleri_list = []
    for tatli_pasta_malzemeleri_product_url in tatli_pasta_malzemeleri_product_urls:
        tatli_pasta_malzemeleri_product_soup = scrape_cimri_product.get_page_data(str(tatli_pasta_malzemeleri_product_url))
        if None is not scrape_product_tatli_pasta_malzemeleri(tatli_pasta_malzemeleri_product_soup):
            tatli_pasta_malzemeleri_list.append(scrape_product_tatli_pasta_malzemeleri(tatli_pasta_malzemeleri_product_soup))
        time.sleep(3)
    return tatli_pasta_malzemeleri_list


############################################################################################


def scrape_product_bakliyat(bakliyat_product_soup):
    current_category = "Temel Gıda"
    current_category_1 = "Bakliyat"
    if not scrape_cimri_product.check_offline_market(bakliyat_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(bakliyat_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(bakliyat_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(bakliyat_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(bakliyat_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(bakliyat_product_soup)
    new_bakliyat = scrape_cimri_product.Product(current_product_name, main_category, current_category,
                                                current_category_1,
                                                price=current_product_cheapest_price,
                                                market_products=current_product_market_products,
                                                similar_products=current_product_similar_products,
                                                features=current_product_feature_dict)
    return new_bakliyat


def scrape_bakliyat_products():
    bakliyat_product_urls = scrape_cimri_url.get_category_urls(bakliyat_category_urls)
    bakliyat_list = []
    for bakliyat_product_url in bakliyat_product_urls:
        bakliyat_product_soup = scrape_cimri_product.get_page_data(str(bakliyat_product_url))
        if None is not scrape_product_bakliyat(bakliyat_product_soup):
            bakliyat_list.append(scrape_product_bakliyat(bakliyat_product_soup))
        time.sleep(3)
    return bakliyat_list


############################################################################################


def scrape_product_un_irmik(un_irmik_product_soup):
    current_category = "Temel Gıda"
    current_category_1 = "Un ve İrmik"
    if not scrape_cimri_product.check_offline_market(un_irmik_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(un_irmik_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(un_irmik_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(un_irmik_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(un_irmik_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(un_irmik_product_soup)
    new_un_irmik = scrape_cimri_product.Product(current_product_name, main_category, current_category,
                                                current_category_1,
                                                price=current_product_cheapest_price,
                                                market_products=current_product_market_products,
                                                similar_products=current_product_similar_products,
                                                features=current_product_feature_dict)
    return new_un_irmik


def scrape_un_irmik_products():
    un_irmik_product_urls = scrape_cimri_url.get_category_urls(un_irmik_category_urls)
    un_irmik_list = []
    for un_irmik_product_url in un_irmik_product_urls:
        un_irmik_product_soup = scrape_cimri_product.get_page_data(str(un_irmik_product_url))
        if None is not scrape_product_un_irmik(un_irmik_product_soup):
            un_irmik_list.append(scrape_product_un_irmik(un_irmik_product_soup))
        time.sleep(3)
    return un_irmik_list


############################################################################################


def scrape_product_siviyag_zeytinyagi(siviyag_zeytinyagi_product_soup):
    current_category = "Temel Gıda"
    current_category_1 = "Sıvı Yağ ve Zeytinyağı"
    if not scrape_cimri_product.check_offline_market(siviyag_zeytinyagi_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(siviyag_zeytinyagi_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(siviyag_zeytinyagi_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(siviyag_zeytinyagi_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(siviyag_zeytinyagi_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(siviyag_zeytinyagi_product_soup)
    new_siviyag_zeytinyagi = scrape_cimri_product.Product(current_product_name, main_category, current_category,
                                                          current_category_1,
                                                          price=current_product_cheapest_price,
                                                          market_products=current_product_market_products,
                                                          similar_products=current_product_similar_products,
                                                          features=current_product_feature_dict)
    return new_siviyag_zeytinyagi


def scrape_siviyag_zeytinyagi_products():
    siviyag_zeytinyagi_product_urls = scrape_cimri_url.get_category_urls(siviyag_zeytinyagi_category_urls)
    siviyag_zeytinyagi_list = []
    for siviyag_zeytinyagi_product_url in siviyag_zeytinyagi_product_urls:
        siviyag_zeytinyagi_product_soup = scrape_cimri_product.get_page_data(str(siviyag_zeytinyagi_product_url))
        if None is not scrape_product_siviyag_zeytinyagi(siviyag_zeytinyagi_product_soup):
            siviyag_zeytinyagi_list.append(scrape_product_siviyag_zeytinyagi(siviyag_zeytinyagi_product_soup))
        time.sleep(3)
    return siviyag_zeytinyagi_list


############################################################################################


def scrape_product_makarnalar(makarnalar_product_soup):
    current_category = "Temel Gıda"
    current_category_1 = "Makarnalar"
    if not scrape_cimri_product.check_offline_market(makarnalar_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(makarnalar_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(makarnalar_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(makarnalar_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(makarnalar_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(makarnalar_product_soup)
    new_makarnalar = scrape_cimri_product.Product(current_product_name, main_category, current_category,
                                                  current_category_1,
                                                  price=current_product_cheapest_price,
                                                  market_products=current_product_market_products,
                                                  similar_products=current_product_similar_products,
                                                  features=current_product_feature_dict)
    return new_makarnalar


def scrape_makarnalar_products():
    makarnalar_product_urls = scrape_cimri_url.get_category_urls(makarnalar_category_urls)
    makarnalar_list = []
    for makarnalar_product_url in makarnalar_product_urls:
        makarnalar_product_soup = scrape_cimri_product.get_page_data(str(makarnalar_product_url))
        if None is not scrape_product_makarnalar(makarnalar_product_soup):
            makarnalar_list.append(scrape_product_makarnalar(makarnalar_product_soup))
        time.sleep(3)
    return makarnalar_list


############################################################################################


def scrape_product_unlu_mamuller(unlu_mamuller_product_soup):
    current_category = "Temel Gıda"
    current_category_1 = "Unlu Mamüller"
    if not scrape_cimri_product.check_offline_market(unlu_mamuller_product_soup):
        return
    current_product_name = scrape_cimri_product.get_product_name(unlu_mamuller_product_soup)
    current_product_cheapest_price = scrape_cimri_product.get_product_cheapest_price(unlu_mamuller_product_soup)
    current_product_market_products = scrape_cimri_product.get_market_product_array(unlu_mamuller_product_soup)
    current_product_similar_products = scrape_cimri_product.get_similar_products(unlu_mamuller_product_soup)
    current_product_feature_dict = scrape_cimri_product.get_product_feature(unlu_mamuller_product_soup)
    new_unlu_mamuller = scrape_cimri_product.Product(current_product_name, main_category, current_category,
                                                     current_category_1,
                                                     price=current_product_cheapest_price,
                                                     market_products=current_product_market_products,
                                                     similar_products=current_product_similar_products,
                                                     features=current_product_feature_dict)
    return new_unlu_mamuller


def scrape_unlu_mamuller_products():
    unlu_mamuller_product_urls = scrape_cimri_url.get_category_urls(unlu_mamuller_category_urls)
    unlu_mamuller_list = []
    for unlu_mamuller_product_url in unlu_mamuller_product_urls:
        unlu_mamuller_product_soup = scrape_cimri_product.get_page_data(str(unlu_mamuller_product_url))
        if None is not scrape_product_unlu_mamuller(unlu_mamuller_product_soup):
            unlu_mamuller_list.append(scrape_product_unlu_mamuller(unlu_mamuller_product_soup))
        time.sleep(3)
    return unlu_mamuller_list


############################################################################################
