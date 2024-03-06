import scrape_cimri_product
import scrape_cimri_url
from requests_html import HTMLSession
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


def scrape_baharat_products():
    current_category = "Tuz, Şeker ve Baharat"
    current_category_1 = "Baharat"
    baharat_product_urls = scrape_cimri_url.get_category_urls(baharat_category_urls)
    baharat_list = []
    for baharat_product_url in baharat_product_urls:
        baharat_product_soup = scrape_cimri_product.get_page_data(str(baharat_product_url))
        current_product_baharat = scrape_cimri_product.scrape_product(baharat_product_soup,
                                                                      main_category, current_category,
                                                                      current_category_1)
        if None is not current_product_baharat:
            baharat_list.append(current_product_baharat)
        time.sleep(3)
    baharat_list = scrape_cimri_product.organize_similar_products(baharat_list)
    return baharat_list


############################################################################################
def scrape_tuz_products():
    current_category = "Tuz, Şeker ve Baharat"
    current_category_1 = "Tuz"
    tuz_product_urls = scrape_cimri_url.get_category_urls(tuz_category_urls)
    tuz_list = []
    for tuz_product_url in tuz_product_urls:
        tuz_product_soup = scrape_cimri_product.get_page_data(str(tuz_product_url))
        current_product_tuz = scrape_cimri_product.scrape_product(tuz_product_soup,
                                                                  main_category, current_category,
                                                                  current_category_1)
        if None is not current_product_tuz:
            tuz_list.append(current_product_tuz)
        time.sleep(3)
    tuz_list = scrape_cimri_product.organize_similar_products(tuz_list)
    return tuz_list


############################################################################################
def scrape_hazir_corba_bulyon_products():
    current_category = "Tuz, Şeker ve Baharat"
    current_category_1 = "Hazır Çorba ve Bulyon"
    hazir_corba_bulyon_product_urls = scrape_cimri_url.get_category_urls(hazir_corba_bulyon_category_urls)
    hazir_corba_bulyon_list = []
    for hazir_corba_bulyon_product_url in hazir_corba_bulyon_product_urls:
        hazir_corba_bulyon_product_soup = scrape_cimri_product.get_page_data(str(hazir_corba_bulyon_product_url))
        current_product_hazir_corba_bulyon = scrape_cimri_product.scrape_product(hazir_corba_bulyon_product_soup,
                                                                                 main_category, current_category,
                                                                                 current_category_1)
        if None is not current_product_hazir_corba_bulyon:
            hazir_corba_bulyon_list.append(current_product_hazir_corba_bulyon)
        time.sleep(3)
    hazir_corba_bulyon_list = scrape_cimri_product.organize_similar_products(hazir_corba_bulyon_list)
    return hazir_corba_bulyon_list


############################################################################################
def scrape_seker_products():
    current_category = "Tuz, Şeker ve Baharat"
    current_category_1 = "Şeker"
    seker_product_urls = scrape_cimri_url.get_category_urls(seker_category_urls)
    seker_list = []
    for seker_product_url in seker_product_urls:
        seker_product_soup = scrape_cimri_product.get_page_data(str(seker_product_url))
        current_product_seker = scrape_cimri_product.scrape_product(seker_product_soup,
                                                                    main_category, current_category,
                                                                    current_category_1)
        if None is not current_product_seker:
            seker_list.append(current_product_seker)
        time.sleep(3)
    seker_list = scrape_cimri_product.organize_similar_products(seker_list)
    return seker_list


############################################################################################
def scrape_sos_products():
    current_category = "Konserve Sos ve Hazır Yemek"
    current_category_1 = "Sos"
    sos_product_urls = scrape_cimri_url.get_category_urls(sos_category_urls)
    sos_list = []
    for sos_product_url in sos_product_urls:
        sos_product_soup = scrape_cimri_product.get_page_data(str(sos_product_url))
        current_product_sos = scrape_cimri_product.scrape_product(sos_product_soup,
                                                                  main_category, current_category,
                                                                  current_category_1)
        if None is not current_product_sos:
            sos_list.append(current_product_sos)
        time.sleep(3)
    sos_list = scrape_cimri_product.organize_similar_products(sos_list)
    return sos_list


############################################################################################
def scrape_konserve_products():
    current_category = "Konserve, Sos ve Hazır Yemek"
    current_category_1 = "Konserve"
    konserve_product_urls = scrape_cimri_url.get_category_urls(konserve_category_urls)
    konserve_list = []
    for konserve_product_url in konserve_product_urls:
        konserve_product_soup = scrape_cimri_product.get_page_data(str(konserve_product_url))
        current_product_konserve = scrape_cimri_product.scrape_product(konserve_product_soup,
                                                                       main_category, current_category,
                                                                       current_category_1)
        if None is not current_product_konserve:
            konserve_list.append(current_product_konserve)
        time.sleep(3)
    konserve_list = scrape_cimri_product.organize_similar_products(konserve_list)
    return konserve_list


############################################################################################
def scrape_kuru_sebze_products():
    current_category = "Konserve, Sos ve Hazır Yemek"
    current_category_1 = "Kuru Sebze"
    kuru_sebze_product_urls = scrape_cimri_url.get_category_urls(kuru_sebze_category_urls)
    kuru_sebze_list = []
    for kuru_sebze_product_url in kuru_sebze_product_urls:
        kuru_sebze_product_soup = scrape_cimri_product.get_page_data(str(kuru_sebze_product_url))
        current_product_kuru_sebze = scrape_cimri_product.scrape_product(kuru_sebze_product_soup,
                                                                         main_category, current_category,
                                                                         current_category_1)
        if None is not current_product_kuru_sebze:
            kuru_sebze_list.append(current_product_kuru_sebze)
        time.sleep(3)
    kuru_sebze_list = scrape_cimri_product.organize_similar_products(kuru_sebze_list)
    return kuru_sebze_list


############################################################################################
def scrape_hazir_yemek_products():
    current_category = "Konserve, Sos ve Hazır Yemek"
    current_category_1 = "Hazır Yemek"
    hazir_yemek_product_urls = scrape_cimri_url.get_category_urls(hazir_yemek_category_urls)
    hazir_yemek_list = []
    for hazir_yemek_product_url in hazir_yemek_product_urls:
        hazir_yemek_product_soup = scrape_cimri_product.get_page_data(str(hazir_yemek_product_url))
        current_product_hazir_yemek = scrape_cimri_product.scrape_product(hazir_yemek_product_soup,
                                                                          main_category, current_category,
                                                                          current_category_1)
        if None is not current_product_hazir_yemek:
            hazir_yemek_list.append(current_product_hazir_yemek)
        time.sleep(3)
    hazir_yemek_list = scrape_cimri_product.organize_similar_products(hazir_yemek_list)
    return hazir_yemek_list


############################################################################################
def scrape_dondurulmus_gida_products():
    current_category = "Konserve, Sos ve Hazır Yemek"
    current_category_1 = "Dondurulmuş Gıda"
    dondurulmus_gida_product_urls = scrape_cimri_url.get_category_urls(dondurulmus_gida_category_urls)
    dondurulmus_gida_list = []
    for dondurulmus_gida_product_url in dondurulmus_gida_product_urls:
        dondurulmus_gida_product_soup = scrape_cimri_product.get_page_data(str(dondurulmus_gida_product_url))
        current_product_dondurulmus_gida = scrape_cimri_product.scrape_product(dondurulmus_gida_product_soup,
                                                                               main_category, current_category,
                                                                               current_category_1)
        if None is not current_product_dondurulmus_gida:
            dondurulmus_gida_list.append(current_product_dondurulmus_gida)
        time.sleep(3)
    dondurulmus_gida_list = scrape_cimri_product.organize_similar_products(dondurulmus_gida_list)
    return dondurulmus_gida_list


############################################################################################
def scrape_kuruyemis_products():
    current_category = "Atıştırmalık"
    current_category_1 = "Kuruyemiş"
    kuruyemis_product_urls = scrape_cimri_url.get_category_urls(kuruyemis_category_urls)
    kuruyemis_list = []
    for kuruyemis_product_url in kuruyemis_product_urls:
        kuruyemis_product_soup = scrape_cimri_product.get_page_data(str(kuruyemis_product_url))
        current_product_kuruyemis = scrape_cimri_product.scrape_product(kuruyemis_product_soup,
                                                                        main_category, current_category,
                                                                        current_category_1)
        if None is not current_product_kuruyemis:
            kuruyemis_list.append(current_product_kuruyemis)
        time.sleep(3)
    kuruyemis_list = scrape_cimri_product.organize_similar_products(kuruyemis_list)
    return kuruyemis_list


############################################################################################
def scrape_sekerleme_sakiz_products():
    current_category = "Atıştırmalık"
    current_category_1 = "Şekerleme Sakız"
    sekerleme_sakiz_product_urls = scrape_cimri_url.get_category_urls(sekerleme_sakiz_category_urls)
    sekerleme_sakiz_list = []
    for sekerleme_sakiz_product_url in sekerleme_sakiz_product_urls:
        sekerleme_sakiz_product_soup = scrape_cimri_product.get_page_data(str(sekerleme_sakiz_product_url))
        current_product_sekerleme_sakiz = scrape_cimri_product.scrape_product(sekerleme_sakiz_product_soup,
                                                                              main_category, current_category,
                                                                              current_category_1)
        if None is not current_product_sekerleme_sakiz:
            sekerleme_sakiz_list.append(current_product_sekerleme_sakiz)
        time.sleep(3)
    sekerleme_sakiz_list = scrape_cimri_product.organize_similar_products(sekerleme_sakiz_list)
    return sekerleme_sakiz_list


############################################################################################
def scrape_cikolata_gofret_products():
    current_category = "Atıştırmalık"
    current_category_1 = "Çikolata ve Gofret"
    cikolata_gofret_product_urls = scrape_cimri_url.get_category_urls(cikolata_gofret_category_urls)
    cikolata_gofret_list = []
    for cikolata_gofret_product_url in cikolata_gofret_product_urls:
        cikolata_gofret_product_soup = scrape_cimri_product.get_page_data(str(cikolata_gofret_product_url))
        current_product_cikolata_gofret = scrape_cimri_product.scrape_product(cikolata_gofret_product_soup,
                                                                              main_category, current_category,
                                                                              current_category_1)
        if None is not current_product_cikolata_gofret:
            cikolata_gofret_list.append(current_product_cikolata_gofret)
        time.sleep(3)
    cikolata_gofret_list = scrape_cimri_product.organize_similar_products(cikolata_gofret_list)
    return cikolata_gofret_list


############################################################################################
def scrape_tatli_pasta_products():
    current_category = "Atıştırmalık"
    current_category_1 = "Tatlı ve Pasta"
    tatli_pasta_product_urls = scrape_cimri_url.get_category_urls(tatli_pasta_category_urls)
    tatli_pasta_list = []
    for tatli_pasta_product_url in tatli_pasta_product_urls:
        tatli_pasta_product_soup = scrape_cimri_product.get_page_data(str(tatli_pasta_product_url))
        current_product_tatli_pasta = scrape_cimri_product.scrape_product(tatli_pasta_product_soup,
                                                                          main_category, current_category,
                                                                          current_category_1)
        if None is not current_product_tatli_pasta:
            tatli_pasta_list.append(current_product_tatli_pasta)
        time.sleep(3)
    tatli_pasta_list = scrape_cimri_product.organize_similar_products(tatli_pasta_list)
    return tatli_pasta_list


############################################################################################
def scrape_biskuvi_kek_products():
    current_category = "Atıştırmalık"
    current_category_1 = "Bisküvi ve Kek"
    biskuvi_kek_product_urls = scrape_cimri_url.get_category_urls(biskuvi_kek_category_urls)
    biskuvi_kek_list = []
    for biskuvi_kek_product_url in biskuvi_kek_product_urls:
        biskuvi_kek_product_soup = scrape_cimri_product.get_page_data(str(biskuvi_kek_product_url))
        current_product_biskuvi_kek = scrape_cimri_product.scrape_product(biskuvi_kek_product_soup,
                                                                          main_category, current_category,
                                                                          current_category_1)
        if None is not current_product_biskuvi_kek:
            biskuvi_kek_list.append(current_product_biskuvi_kek)
        time.sleep(3)
    return biskuvi_kek_list


############################################################################################
def scrape_kraker_kurabiye_products():
    current_category = "Atıştırmalık"
    current_category_1 = "Kraker ve Kurabiye"
    kraker_kurabiye_product_urls = scrape_cimri_url.get_category_urls(kraker_kurabiye_category_urls)
    kraker_kurabiye_list = []
    for kraker_kurabiye_product_url in kraker_kurabiye_product_urls:
        kraker_kurabiye_product_soup = scrape_cimri_product.get_page_data(str(kraker_kurabiye_product_url))
        current_product_kraker_kurabiye = scrape_cimri_product.scrape_product(kraker_kurabiye_product_soup,
                                                                              main_category, current_category,
                                                                              current_category_1)
        if None is not current_product_kraker_kurabiye:
            kraker_kurabiye_list.append(current_product_kraker_kurabiye)
        time.sleep(3)
    return kraker_kurabiye_list


############################################################################################
def scrape_cips_products():
    current_category = "Atıştırmalık"
    current_category_1 = "Cips"
    cips_product_urls = scrape_cimri_url.get_category_urls(cips_category_urls)
    cips_list = []
    for cips_product_url in cips_product_urls:
        cips_product_soup = scrape_cimri_product.get_page_data(str(cips_product_url))
        current_product_cips = scrape_cimri_product.scrape_product(cips_product_soup,
                                                                   main_category, current_category,
                                                                   current_category_1)
        if None is not current_product_cips:
            cips_list.append(current_product_cips)
        time.sleep(3)
    cips_list = scrape_cimri_product.organize_similar_products(cips_list)
    return cips_list


############################################################################################
def scrape_dondurma_products():
    current_category = "Atıştırmalık"
    current_category_1 = "Dondurma"
    dondurma_product_urls = scrape_cimri_url.get_category_urls(dondurma_category_urls)
    dondurma_list = []
    for dondurma_product_url in dondurma_product_urls:
        dondurma_product_soup = scrape_cimri_product.get_page_data(str(dondurma_product_url))
        current_product_dondurma = scrape_cimri_product.scrape_product(dondurma_product_soup,
                                                                       main_category, current_category,
                                                                       current_category_1)
        if None is not current_product_dondurma:
            dondurma_list.append(current_product_dondurma)
        time.sleep(3)
    dondurma_list = scrape_cimri_product.organize_similar_products(dondurma_list)
    return dondurma_list


############################################################################################
def scrape_kuru_meyve_products():
    current_category = "Fit & Form"
    current_category_1 = "Kuru Meyve"
    kuru_meyve_product_urls = scrape_cimri_url.get_category_urls(kuru_meyve_category_urls)
    kuru_meyve_list = []
    for kuru_meyve_product_url in kuru_meyve_product_urls:
        kuru_meyve_product_soup = scrape_cimri_product.get_page_data(str(kuru_meyve_product_url))
        current_product_kuru_meyve = scrape_cimri_product.scrape_product(kuru_meyve_product_soup,
                                                                         main_category, current_category,
                                                                         current_category_1)
        if None is not current_product_kuru_meyve:
            kuru_meyve_list.append(current_product_kuru_meyve)
        time.sleep(3)
    kuru_meyve_list = scrape_cimri_product.organize_similar_products(kuru_meyve_list)
    return kuru_meyve_list


############################################################################################
def scrape_granola_bar_products():
    current_category = "Fit & Form"
    current_category_1 = "Granola ve Bar"
    granola_bar_product_urls = scrape_cimri_url.get_category_urls(granola_bar_category_urls)
    granola_bar_list = []
    for granola_bar_product_url in granola_bar_product_urls:
        granola_bar_product_soup = scrape_cimri_product.get_page_data(str(granola_bar_product_url))
        current_product_granola_bar = scrape_cimri_product.scrape_product(granola_bar_product_soup,
                                                                          main_category, current_category,
                                                                          current_category_1)
        if None is not current_product_granola_bar:
            granola_bar_list.append(current_product_granola_bar)
        time.sleep(3)
    granola_bar_list = scrape_cimri_product.organize_similar_products(granola_bar_list)
    return granola_bar_list


############################################################################################
def scrape_bitkisel_yaglar_products():
    current_category = "Temel Gıda"
    current_category_1 = "Bitkisel Yağlar"
    bitkisel_yaglar_product_urls = scrape_cimri_url.get_category_urls(bitkisel_yaglar_category_urls)
    bitkisel_yaglar_list = []
    for bitkisel_yaglar_product_url in bitkisel_yaglar_product_urls:
        bitkisel_yaglar_product_soup = scrape_cimri_product.get_page_data(str(bitkisel_yaglar_product_url))
        current_product_bitkisel_yaglar = scrape_cimri_product.scrape_product(bitkisel_yaglar_product_soup,
                                                                              main_category, current_category,
                                                                              current_category_1)
        if None is not current_product_bitkisel_yaglar:
            bitkisel_yaglar_list.append(current_product_bitkisel_yaglar)
        time.sleep(3)
    bitkisel_yaglar_list = scrape_cimri_product.organize_similar_products(bitkisel_yaglar_list)
    return bitkisel_yaglar_list


############################################################################################
def scrape_tatli_pasta_malzemeleri_products():
    current_category = "Temel Gıda"
    current_category_1 = "Tatlı ve Pasta Malzemeleri"
    tatli_pasta_malzemeleri_product_urls = scrape_cimri_url.get_category_urls(tatli_pasta_malzemeleri_category_urls)
    tatli_pasta_malzemeleri_list = []
    for tatli_pasta_malzemeleri_product_url in tatli_pasta_malzemeleri_product_urls:
        tatli_pasta_malzemeleri_product_soup = scrape_cimri_product.get_page_data(
            str(tatli_pasta_malzemeleri_product_url))
        current_product_tatli_pasta_malzemeleri = scrape_cimri_product.scrape_product(
            tatli_pasta_malzemeleri_product_soup, main_category, current_category, current_category_1)
        if None is not current_product_tatli_pasta_malzemeleri:
            tatli_pasta_malzemeleri_list.append(current_product_tatli_pasta_malzemeleri)
        time.sleep(3)
    tatli_pasta_malzemeleri_list = scrape_cimri_product.organize_similar_products(tatli_pasta_malzemeleri_list)
    return tatli_pasta_malzemeleri_list


############################################################################################
def scrape_bakliyat_products():
    current_category = "Temel Gıda"
    current_category_1 = "Bakliyat"
    bakliyat_product_urls = scrape_cimri_url.get_category_urls(bakliyat_category_urls)
    bakliyat_list = []
    for bakliyat_product_url in bakliyat_product_urls:
        bakliyat_product_soup = scrape_cimri_product.get_page_data(str(bakliyat_product_url))
        current_product_bakliyat = scrape_cimri_product.scrape_product(bakliyat_product_soup, main_category,
                                                                       current_category, current_category_1)
        if None is not current_product_bakliyat:
            bakliyat_list.append(current_product_bakliyat)
        time.sleep(3)
    bakliyat_list = scrape_cimri_product.organize_similar_products(bakliyat_list)
    return bakliyat_list


############################################################################################
def scrape_un_irmik_products():
    current_category = "Temel Gıda"
    current_category_1 = "Un ve İrmik"
    un_irmik_product_urls = scrape_cimri_url.get_category_urls(un_irmik_category_urls)
    un_irmik_list = []
    for un_irmik_product_url in un_irmik_product_urls:
        un_irmik_product_soup = scrape_cimri_product.get_page_data(str(un_irmik_product_url))
        current_product_un_irmik = scrape_cimri_product.scrape_product(un_irmik_product_soup, main_category,
                                                                       current_category, current_category_1)
        if None is not current_product_un_irmik:
            un_irmik_list.append(current_product_un_irmik)
        time.sleep(3)
    un_irmik_list = scrape_cimri_product.organize_similar_products(un_irmik_list)
    return un_irmik_list


############################################################################################
def scrape_siviyag_zeytinyagi_products():
    current_category = "Temel Gıda"
    current_category_1 = "Sıvı Yağ ve Zeytinyağı"
    siviyag_zeytinyagi_product_urls = scrape_cimri_url.get_category_urls(siviyag_zeytinyagi_category_urls)
    siviyag_zeytinyagi_list = []
    for siviyag_zeytinyagi_product_url in siviyag_zeytinyagi_product_urls:
        siviyag_zeytinyagi_product_soup = scrape_cimri_product.get_page_data(str(siviyag_zeytinyagi_product_url))
        current_product_siviyag_zeytinyagi = scrape_cimri_product.scrape_product(
            siviyag_zeytinyagi_product_soup, main_category, current_category, current_category_1)
        if None is not current_product_siviyag_zeytinyagi:
            siviyag_zeytinyagi_list.append(current_product_siviyag_zeytinyagi)
        time.sleep(3)
    siviyag_zeytinyagi_list = scrape_cimri_product.organize_similar_products(siviyag_zeytinyagi_list)
    return siviyag_zeytinyagi_list


############################################################################################
def scrape_makarnalar_products():
    current_category = "Temel Gıda"
    current_category_1 = "Makarnalar"
    makarnalar_product_urls = scrape_cimri_url.get_category_urls(makarnalar_category_urls)
    makarnalar_list = []
    for makarnalar_product_url in makarnalar_product_urls:
        makarnalar_product_soup = scrape_cimri_product.get_page_data(str(makarnalar_product_url))
        current_product_makarnalar = scrape_cimri_product.scrape_product(makarnalar_product_soup, main_category,
                                                                         current_category, current_category_1)
        if None is not current_product_makarnalar:
            makarnalar_list.append(current_product_makarnalar)
        time.sleep(3)
    makarnalar_list = scrape_cimri_product.organize_similar_products(makarnalar_list)
    return makarnalar_list


############################################################################################
def scrape_unlu_mamuller_products():
    current_category = "Temel Gıda"
    current_category_1 = "Unlu Mamüller"
    unlu_mamuller_product_urls = scrape_cimri_url.get_category_urls(unlu_mamuller_category_urls)
    unlu_mamuller_list = []
    for unlu_mamuller_product_url in unlu_mamuller_product_urls:
        unlu_mamuller_product_soup = scrape_cimri_product.get_page_data(str(unlu_mamuller_product_url))
        current_product_unlu_mamuller = scrape_cimri_product.scrape_product(unlu_mamuller_product_soup, main_category,
                                                                            current_category, current_category_1)
        if None is not current_product_unlu_mamuller:
            unlu_mamuller_list.append(current_product_unlu_mamuller)
        time.sleep(3)
    unlu_mamuller_list = scrape_cimri_product.organize_similar_products(unlu_mamuller_list)
    return unlu_mamuller_list


############################################################################################


product_list = scrape_unlu_mamuller_products()
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
