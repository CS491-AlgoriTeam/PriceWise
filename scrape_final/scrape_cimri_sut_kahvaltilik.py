import scrape_cimri_product
import scrape_cimri_url
from requests_html import HTMLSession
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




def scrape_bal_recel_products():
    current_category = "Bal ve Reçel"
    bal_recel_product_urls = scrape_cimri_url.get_category_urls(bal_recel_category_urls)
    bal_recel_list = []
    for bal_recel_product_url in bal_recel_product_urls:
        bal_recel_product_soup = scrape_cimri_product.get_page_data(str(bal_recel_product_url))
        current_product_bal_recel = scrape_cimri_product.scrape_product(bal_recel_product_soup, main_category,
                                                                        current_category, "")
        if None is not current_product_bal_recel:
            bal_recel_list.append(current_product_bal_recel)
        time.sleep(3)
    bal_recel_list = scrape_cimri_product.organize_similar_products(bal_recel_list)
    return bal_recel_list


############################################################################################


def scrape_tahin_pekmez_helva_products():
    current_category = "Tahin Pekmez ve Helva"
    tahin_pekmez_helva_product_urls = scrape_cimri_url.get_category_urls(tahin_pekmez_helva_category_urls)
    tahin_pekmez_helva_list = []
    for tahin_pekmez_helva_product_url in tahin_pekmez_helva_product_urls:
        tahin_pekmez_helva_product_soup = scrape_cimri_product.get_page_data(str(tahin_pekmez_helva_product_url))
        current_product_tahin_pekmez_helva = scrape_cimri_product.scrape_product(tahin_pekmez_helva_product_soup,
                                                                                 main_category,
                                                                                 current_category, "")
        if None is not current_product_tahin_pekmez_helva:
            tahin_pekmez_helva_list.append(current_product_tahin_pekmez_helva)
        time.sleep(3)
    tahin_pekmez_helva_list = scrape_cimri_product.organize_similar_products(tahin_pekmez_helva_list)
    return tahin_pekmez_helva_list


############################################################################################
def scrape_peynir_products():
    current_category = "Peynir"
    peynir_product_urls = scrape_cimri_url.get_category_urls(peynir_category_urls)
    peynir_list = []
    for peynir_product_url in peynir_product_urls:
        peynir_product_soup = scrape_cimri_product.get_page_data(str(peynir_product_url))
        current_product_peynir = scrape_cimri_product.scrape_product(peynir_product_soup, main_category,
                                                                     current_category, "")
        if None is not current_product_peynir:
            peynir_list.append(current_product_peynir)
        time.sleep(3)
    peynir_list = scrape_cimri_product.organize_similar_products(peynir_list)
    return peynir_list


############################################################################################

def scrape_zeytin_products():
    current_category = "Zeytin"
    zeytin_product_urls = scrape_cimri_url.get_category_urls(zeytin_category_urls)
    zeytin_list = []
    for zeytin_product_url in zeytin_product_urls:
        zeytin_product_soup = scrape_cimri_product.get_page_data(str(zeytin_product_url))
        current_product_zeytin = scrape_cimri_product.scrape_product(zeytin_product_soup, main_category,
                                                                     current_category, "")
        if None is not current_product_zeytin:
            zeytin_list.append(current_product_zeytin)
        time.sleep(3)
    zeytin_list = scrape_cimri_product.organize_similar_products(zeytin_list)
    return zeytin_list


############################################################################################
def scrape_surulebilir_products():
    current_category = "Sürülebilir"
    surulebilir_product_urls = scrape_cimri_url.get_category_urls(surulebilir_category_urls)
    surulebilir_list = []
    for surulebilir_product_url in surulebilir_product_urls:
        surulebilir_product_soup = scrape_cimri_product.get_page_data(str(surulebilir_product_url))
        current_product_surulebilir = scrape_cimri_product.scrape_product(surulebilir_product_soup, main_category,
                                                                          current_category, "")
        if None is not current_product_surulebilir:
            surulebilir_list.append(current_product_surulebilir)
        time.sleep(3)
    surulebilir_list = scrape_cimri_product.organize_similar_products(surulebilir_list)
    return surulebilir_list


############################################################################################
def scrape_kahvaltilik_gevrek_products():
    current_category = "Kahvaltılık Gevrek"
    kahvaltilik_gevrek_product_urls = scrape_cimri_url.get_category_urls(kahvaltilik_gevrek_category_urls)
    kahvaltilik_gevrek_list = []
    for kahvaltilik_gevrek_product_url in kahvaltilik_gevrek_product_urls:
        kahvaltilik_gevrek_product_soup = scrape_cimri_product.get_page_data(str(kahvaltilik_gevrek_product_url))
        current_product_kahvaltilik_gevrek = scrape_cimri_product.scrape_product(kahvaltilik_gevrek_product_soup,
                                                                                 main_category,
                                                                                 current_category, "")
        if None is not current_product_kahvaltilik_gevrek:
            kahvaltilik_gevrek_list.append(current_product_kahvaltilik_gevrek)
        time.sleep(3)
    kahvaltilik_gevrek_list = scrape_cimri_product.organize_similar_products(kahvaltilik_gevrek_list)
    return kahvaltilik_gevrek_list


############################################################################################
def scrape_tereyag_margarin_products():
    current_category = "Tereyağ ve Margarin"
    tereyag_margarin_product_urls = scrape_cimri_url.get_category_urls(tereyag_margarin_category_urls)
    tereyag_margarin_list = []
    for tereyag_margarin_product_url in tereyag_margarin_product_urls:
        tereyag_margarin_product_soup = scrape_cimri_product.get_page_data(str(tereyag_margarin_product_url))
        current_product_tereyag_margarin = scrape_cimri_product.scrape_product(tereyag_margarin_product_soup,
                                                                               main_category,
                                                                               current_category, "")
        if None is not current_product_tereyag_margarin:
            tereyag_margarin_list.append(current_product_tereyag_margarin)
        time.sleep(3)
    tereyag_margarin_list = scrape_cimri_product.organize_similar_products(tereyag_margarin_list)
    return tereyag_margarin_list


############################################################################################
def scrape_yogurt_products():
    current_category = "Yoğurt"
    yogurt_product_urls = scrape_cimri_url.get_category_urls(yogurt_category_urls)
    yogurt_list = []
    for yogurt_product_url in yogurt_product_urls:
        yogurt_product_soup = scrape_cimri_product.get_page_data(str(yogurt_product_url))
        current_product_yogurt = scrape_cimri_product.scrape_product(yogurt_product_soup,
                                                                     main_category,
                                                                     current_category, "")
        if None is not current_product_yogurt:
            yogurt_list.append(current_product_yogurt)
        time.sleep(3)
    yogurt_list = scrape_cimri_product.organize_similar_products(yogurt_list)
    return yogurt_list


############################################################################################

def scrape_sut_products():
    current_category = "Süt"
    sut_product_urls = scrape_cimri_url.get_category_urls(sut_category_urls)
    sut_list = []
    for sut_product_url in sut_product_urls:
        sut_product_soup = scrape_cimri_product.get_page_data(str(sut_product_url))
        current_product_sut = scrape_cimri_product.scrape_product(sut_product_soup,
                                                                  main_category,
                                                                  current_category, "")
        if None is not current_product_sut:
            sut_list.append(current_product_sut)
        time.sleep(3)
    sut_list = scrape_cimri_product.organize_similar_products(sut_list)
    return sut_list


############################################################################################
def scrape_yumurta_products():
    current_category = "Yumurta"
    yumurta_product_urls = scrape_cimri_url.get_category_urls(yumurta_category_urls)
    yumurta_list = []
    for yumurta_product_url in yumurta_product_urls:
        yumurta_product_soup = scrape_cimri_product.get_page_data(str(yumurta_product_url))
        current_product_yumurta = scrape_cimri_product.scrape_product(yumurta_product_soup,
                                                                      main_category,
                                                                      current_category, "")
        if None is not current_product_yumurta:
            yumurta_list.append(current_product_yumurta)
        time.sleep(3)
    yumurta_list = scrape_cimri_product.organize_similar_products(yumurta_list)
    return yumurta_list


############################################################################################
def scrape_kaymak_products():
    current_category = "Kaymak"
    kaymak_product_urls = scrape_cimri_url.get_category_urls(kaymak_category_urls)
    kaymak_list = []
    for kaymak_product_url in kaymak_product_urls:
        kaymak_product_soup = scrape_cimri_product.get_page_data(str(kaymak_product_url))
        current_product_kaymak = scrape_cimri_product.scrape_product(kaymak_product_soup,
                                                                     main_category,
                                                                     current_category, "")
        if None is not current_product_kaymak:
            kaymak_list.append(current_product_kaymak)
        time.sleep(3)
    kaymak_list = scrape_cimri_product.organize_similar_products(kaymak_list)
    return kaymak_list


############################################################################################


product_list = scrape_kaymak_products()
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
