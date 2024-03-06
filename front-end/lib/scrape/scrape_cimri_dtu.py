import scrape_cimri_product
import scrape_cimri_url
from requests_html import HTMLSession
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


def scrape_oda_kokusu_products():
    current_category = "Ev Temizliği"
    current_category_1 = "Oda Kokusu"
    oda_kokusu_product_urls = scrape_cimri_url.get_category_urls(oda_kokusu_category_urls)
    oda_kokusu_list = []
    for oda_kokusu_product_url in oda_kokusu_product_urls:
        oda_kokusu_product_soup = scrape_cimri_product.get_page_data(str(oda_kokusu_product_url))
        current_product_oda_kokusu = scrape_cimri_product.scrape_product(oda_kokusu_product_soup,
                                                                         main_category,
                                                                         current_category, current_category_1)
        if None is not current_product_oda_kokusu:
            oda_kokusu_list.append(current_product_oda_kokusu)
        time.sleep(3)
    return oda_kokusu_list


############################################################################################
def scrape_parlatici_temizleyiciler_products():
    current_category = "Ev Temizliği"
    current_category_1 = "Parlatıcı ve Temizliyiciler"
    parlatici_temizleyiciler_product_urls = scrape_cimri_url.get_category_urls(parlatici_temizleyiciler_category_urls)
    parlatici_temizleyiciler_list = []
    for parlatici_temizleyiciler_product_url in parlatici_temizleyiciler_product_urls:
        parlatici_temizleyiciler_product_soup = scrape_cimri_product.get_page_data(str(parlatici_temizleyiciler_product_url))
        current_product_parlatici_temizleyiciler = scrape_cimri_product.scrape_product(parlatici_temizleyiciler_product_soup,
                                                                                       main_category,
                                                                                       current_category, current_category_1)
        if None is not current_product_parlatici_temizleyiciler:
            parlatici_temizleyiciler_list.append(current_product_parlatici_temizleyiciler)
        time.sleep(3)
    parlatici_temizleyiciler_list = scrape_cimri_product.organize_similar_products(parlatici_temizleyiciler_list)
    return parlatici_temizleyiciler_list


############################################################################################
def scrape_temizlik_malzemeleri_products():
    current_category = "Ev Temizliği"
    current_category_1 = "Temizlik Malzemeleri"
    temizlik_malzemeleri_product_urls = scrape_cimri_url.get_category_urls(temizlik_malzemeleri_category_urls)
    temizlik_malzemeleri_list = []
    for temizlik_malzemeleri_product_url in temizlik_malzemeleri_product_urls:
        temizlik_malzemeleri_product_soup = scrape_cimri_product.get_page_data(str(temizlik_malzemeleri_product_url))
        current_product_temizlik_malzemeleri = scrape_cimri_product.scrape_product(temizlik_malzemeleri_product_soup,
                                                                                   main_category,
                                                                                   current_category, current_category_1)
        if None is not current_product_temizlik_malzemeleri:
            temizlik_malzemeleri_list.append(current_product_temizlik_malzemeleri)
        time.sleep(3)
    temizlik_malzemeleri_list = scrape_cimri_product.organize_similar_products(temizlik_malzemeleri_list)
    return temizlik_malzemeleri_list


############################################################################################
def scrape_hali_sampuani_products():
    current_category = "Ev Temizliği"
    current_category_1 = "Halı Şampuanı"
    hali_sampuani_product_urls = scrape_cimri_url.get_category_urls(hali_sampuani_category_urls)
    hali_sampuani_list = []
    for hali_sampuani_product_url in hali_sampuani_product_urls:
        hali_sampuani_product_soup = scrape_cimri_product.get_page_data(str(hali_sampuani_product_url))
        current_product_hali_sampuani = scrape_cimri_product.scrape_product(hali_sampuani_product_soup,
                                                                            main_category,
                                                                            current_category, current_category_1)
        if None is not current_product_hali_sampuani:
            hali_sampuani_list.append(current_product_hali_sampuani)
        time.sleep(3)
    hali_sampuani_list = scrape_cimri_product.organize_similar_products(hali_sampuani_list)
    return hali_sampuani_list


############################################################################################
def scrape_camasir_deterjani_products():
    current_category = "Çamaşır Yıkama"
    current_category_1 = "Çamaşır Deterjanı"
    camasir_deterjani_product_urls = scrape_cimri_url.get_category_urls(camasir_deterjani_category_urls)
    camasir_deterjani_list = []
    for camasir_deterjani_product_url in camasir_deterjani_product_urls:
        camasir_deterjani_product_soup = scrape_cimri_product.get_page_data(str(camasir_deterjani_product_url))
        current_product_camasir_deterjani = scrape_cimri_product.scrape_product(camasir_deterjani_product_soup,
                                                                                main_category,
                                                                                current_category, current_category_1)
        if None is not current_product_camasir_deterjani:
            camasir_deterjani_list.append(current_product_camasir_deterjani)
        time.sleep(3)
    camasir_deterjani_list = scrape_cimri_product.organize_similar_products(camasir_deterjani_list)
    return camasir_deterjani_list


############################################################################################
def scrape_camasir_makinesi_urunleri_products():
    current_category = "Çamaşır Yıkama"
    current_category_1 = "Çamaşır Makinesi Ürünleri"
    camasir_makinesi_urunleri_product_urls = scrape_cimri_url.get_category_urls(camasir_makinesi_urunleri_category_urls)
    camasir_makinesi_urunleri_list = []
    for camasir_makinesi_urunleri_product_url in camasir_makinesi_urunleri_product_urls:
        camasir_makinesi_urunleri_product_soup = scrape_cimri_product.get_page_data(str(camasir_makinesi_urunleri_product_url))
        current_product_camasir_makinesi_urunleri = scrape_cimri_product.scrape_product(camasir_makinesi_urunleri_product_soup,
                                                                                        main_category,
                                                                                        current_category, current_category_1)
        if None is not current_product_camasir_makinesi_urunleri:
            camasir_makinesi_urunleri_list.append(current_product_camasir_makinesi_urunleri)
        time.sleep(3)
    camasir_makinesi_urunleri_list = scrape_cimri_product.organize_similar_products(camasir_makinesi_urunleri_list)
    return camasir_makinesi_urunleri_list


############################################################################################
def scrape_bulasik_deterjani_products():
    current_category = "Bulaşık Yıkama"
    current_category_1 = "Bulaşık Deterjanı"
    bulasik_deterjani_product_urls = scrape_cimri_url.get_category_urls(bulasik_deterjani_category_urls)
    bulasik_deterjani_list = []
    for bulasik_deterjani_product_url in bulasik_deterjani_product_urls:
        bulasik_deterjani_product_soup = scrape_cimri_product.get_page_data(str(bulasik_deterjani_product_url))
        current_product_bulasik_deterjani = scrape_cimri_product.scrape_product(bulasik_deterjani_product_soup,
                                                                                main_category,
                                                                                current_category, current_category_1)
        if None is not current_product_bulasik_deterjani:
            bulasik_deterjani_list.append(current_product_bulasik_deterjani)
        time.sleep(3)
    return bulasik_deterjani_list


############################################################################################
def scrape_bulasik_makinesi_tableti_products():
    current_category = "Bulaşık Yıkama"
    current_category_1 = "Bulaşık Makinesi Tableti"
    bulasik_makinesi_tableti_product_urls = scrape_cimri_url.get_category_urls(bulasik_makinesi_tableti_category_urls)
    bulasik_makinesi_tableti_list = []
    for bulasik_makinesi_tableti_product_url in bulasik_makinesi_tableti_product_urls:
        bulasik_makinesi_tableti_product_soup = scrape_cimri_product.get_page_data(str(bulasik_makinesi_tableti_product_url))
        current_product_bulasik_makinesi_tableti = scrape_cimri_product.scrape_product(bulasik_makinesi_tableti_product_soup,
                                                                                       main_category,
                                                                                       current_category, current_category_1)
        if None is not current_product_bulasik_makinesi_tableti:
            bulasik_makinesi_tableti_list.append(current_product_bulasik_makinesi_tableti)
        time.sleep(3)
    bulasik_makinesi_tableti_list = scrape_cimri_product.organize_similar_products(bulasik_makinesi_tableti_list)
    return bulasik_makinesi_tableti_list


############################################################################################
def scrape_bulasik_makinesi_urunleri_products():
    current_category = "Bulaşık Yıkama"
    current_category_1 = "Bulaşık Makinesi Ürünleri"
    bulasik_makinesi_urunleri_product_urls = scrape_cimri_url.get_category_urls(bulasik_makinesi_urunleri_category_urls)
    bulasik_makinesi_urunleri_list = []
    for bulasik_makinesi_urunleri_product_url in bulasik_makinesi_urunleri_product_urls:
        bulasik_makinesi_urunleri_product_soup = scrape_cimri_product.get_page_data(str(bulasik_makinesi_urunleri_product_url))
        current_product_bulasik_makinesi_urunleri = scrape_cimri_product.scrape_product(bulasik_makinesi_urunleri_product_soup,
                                                                                        main_category,
                                                                                        current_category, current_category_1)
        if None is not current_product_bulasik_makinesi_urunleri:
            bulasik_makinesi_urunleri_list.append(current_product_bulasik_makinesi_urunleri)
        time.sleep(3)
    bulasik_makinesi_urunleri_list = scrape_cimri_product.organize_similar_products(bulasik_makinesi_urunleri_list)
    return bulasik_makinesi_urunleri_list


############################################################################################
def scrape_bulasik_makinesi_deterjani_products():
    current_category = "Bulaşık Yıkama"
    current_category_1 = "Bulaşık Makinesi Deterjanı"
    bulasik_makinesi_deterjani_product_urls = scrape_cimri_url.get_category_urls(bulasik_makinesi_deterjani_category_urls)
    bulasik_makinesi_deterjani_list = []
    for bulasik_makinesi_deterjani_product_url in bulasik_makinesi_deterjani_product_urls:
        bulasik_makinesi_deterjani_product_soup = scrape_cimri_product.get_page_data(str(bulasik_makinesi_deterjani_product_url))
        current_product_bulasik_makinesi_deterjani = scrape_cimri_product.scrape_product(bulasik_makinesi_deterjani_product_soup,
                                                                                         main_category,
                                                                                         current_category, current_category_1)
        if None is not current_product_bulasik_makinesi_deterjani:
            bulasik_makinesi_deterjani_list.append(current_product_bulasik_makinesi_deterjani)
        time.sleep(3)
    bulasik_makinesi_deterjani_list = scrape_cimri_product.organize_similar_products(bulasik_makinesi_deterjani_list)
    return bulasik_makinesi_deterjani_list


############################################################################################
def scrape_pecete_products():
    current_category = "Kağıt Ürünleri"
    current_category_1 = "Peçete"
    pecete_product_urls = scrape_cimri_url.get_category_urls(pecete_category_urls)
    pecete_list = []
    for pecete_product_url in pecete_product_urls:
        pecete_product_soup = scrape_cimri_product.get_page_data(str(pecete_product_url))
        current_product_pecete = scrape_cimri_product.scrape_product(pecete_product_soup,
                                                                     main_category,
                                                                     current_category, current_category_1)
        if None is not current_product_pecete:
            pecete_list.append(current_product_pecete)
        time.sleep(3)
    pecete_list = scrape_cimri_product.organize_similar_products(pecete_list)
    return pecete_list


############################################################################################
def scrape_islak_mendil_products():
    current_category = "Kağıt Ürünleri"
    current_category_1 = "Islak Mendil"
    islak_mendil_product_urls = scrape_cimri_url.get_category_urls(islak_mendil_category_urls)
    islak_mendil_list = []
    for islak_mendil_product_url in islak_mendil_product_urls:
        islak_mendil_product_soup = scrape_cimri_product.get_page_data(str(islak_mendil_product_url))
        current_product_islak_mendil = scrape_cimri_product.scrape_product(islak_mendil_product_soup,
                                                                           main_category,
                                                                           current_category, current_category_1)
        if None is not current_product_islak_mendil:
            islak_mendil_list.append(current_product_islak_mendil)
        time.sleep(3)
    islak_mendil_list = scrape_cimri_product.organize_similar_products(islak_mendil_list)
    return islak_mendil_list


############################################################################################
def scrape_kagit_havlu_products():
    current_category = "Kağıt Ürünleri"
    current_category_1 = "Kağıt Havlu"
    kagit_havlu_product_urls = scrape_cimri_url.get_category_urls(kagit_havlu_category_urls)
    kagit_havlu_list = []
    for kagit_havlu_product_url in kagit_havlu_product_urls:
        kagit_havlu_product_soup = scrape_cimri_product.get_page_data(str(kagit_havlu_product_url))
        current_product_kagit_havlu = scrape_cimri_product.scrape_product(kagit_havlu_product_soup,
                                                                          main_category,
                                                                          current_category, current_category_1)
        if None is not current_product_kagit_havlu:
            kagit_havlu_list.append(current_product_kagit_havlu)
        time.sleep(3)
    kagit_havlu_list = scrape_cimri_product.organize_similar_products(kagit_havlu_list)
    return kagit_havlu_list


############################################################################################
def scrape_tuvalet_kagidi_products():
    current_category = "Kağıt Ürünleri"
    current_category_1 = "Tuvalet Kağıdı"
    tuvalet_kagidi_product_urls = scrape_cimri_url.get_category_urls(tuvalet_kagidi_category_urls)
    tuvalet_kagidi_list = []
    for tuvalet_kagidi_product_url in tuvalet_kagidi_product_urls:
        tuvalet_kagidi_product_soup = scrape_cimri_product.get_page_data(str(tuvalet_kagidi_product_url))
        current_product_tuvalet_kagidi = scrape_cimri_product.scrape_product(tuvalet_kagidi_product_soup,
                                                                             main_category,
                                                                             current_category, current_category_1)
        if None is not current_product_tuvalet_kagidi:
            tuvalet_kagidi_list.append(current_product_tuvalet_kagidi)
        time.sleep(3)
    tuvalet_kagidi_list = scrape_cimri_product.organize_similar_products(tuvalet_kagidi_list)
    return tuvalet_kagidi_list


############################################################################################
def scrape_kagit_mendil_products():
    current_category = "Kağıt Ürünleri"
    current_category_1 = "Kağıt Mendil"
    kagit_mendil_product_urls = scrape_cimri_url.get_category_urls(kagit_mendil_category_urls)
    kagit_mendil_list = []
    for kagit_mendil_product_url in kagit_mendil_product_urls:
        kagit_mendil_product_soup = scrape_cimri_product.get_page_data(str(kagit_mendil_product_url))
        current_product_kagit_mendil = scrape_cimri_product.scrape_product(kagit_mendil_product_soup,
                                                                           main_category,
                                                                           current_category, current_category_1)
        if None is not current_product_kagit_mendil:
            kagit_mendil_list.append(current_product_kagit_mendil)
        time.sleep(3)
    kagit_mendil_list = scrape_cimri_product.organize_similar_products(kagit_mendil_list)
    return kagit_mendil_list


############################################################################################
def scrape_cop_posetleri_products():
    current_category = "Mutfak Sarf Malzemeleri"
    current_category_1 = "Çöp Poşetleri"
    cop_posetleri_product_urls = scrape_cimri_url.get_category_urls(cop_posetleri_category_urls)
    cop_posetleri_list = []
    for cop_posetleri_product_url in cop_posetleri_product_urls:
        cop_posetleri_product_soup = scrape_cimri_product.get_page_data(str(cop_posetleri_product_url))
        current_product_cop_posetleri = scrape_cimri_product.scrape_product(cop_posetleri_product_soup,
                                                                            main_category,
                                                                            current_category, current_category_1)
        if None is not current_product_cop_posetleri:
            cop_posetleri_list.append(current_product_cop_posetleri)
        time.sleep(3)
    cop_posetleri_list = scrape_cimri_product.organize_similar_products(cop_posetleri_list)
    return cop_posetleri_list


############################################################################################
def scrape_strec_film_products():
    current_category = "Mutfak Sarf Malzemeleri"
    current_category_1 = "Streç Film"
    strec_film_product_urls = scrape_cimri_url.get_category_urls(strec_film_category_urls)
    strec_film_list = []
    for strec_film_product_url in strec_film_product_urls:
        strec_film_product_soup = scrape_cimri_product.get_page_data(str(strec_film_product_url))
        current_product_strec_film = scrape_cimri_product.scrape_product(strec_film_product_soup,
                                                                         main_category,
                                                                         current_category, current_category_1)
        if None is not current_product_strec_film:
            strec_film_list.append(current_product_strec_film)
        time.sleep(3)
    strec_film_list = scrape_cimri_product.organize_similar_products(strec_film_list)
    return strec_film_list


############################################################################################
def scrape_buzdolabi_poseti_products():
    current_category = "Mutfak Sarf Malzemeleri"
    current_category_1 = "Buzdolabı Poşeti"
    buzdolabi_poseti_product_urls = scrape_cimri_url.get_category_urls(buzdolabi_poseti_category_urls)
    buzdolabi_poseti_list = []
    for buzdolabi_poseti_product_url in buzdolabi_poseti_product_urls:
        buzdolabi_poseti_product_soup = scrape_cimri_product.get_page_data(str(buzdolabi_poseti_product_url))
        current_product_buzdolabi_poseti = scrape_cimri_product.scrape_product(buzdolabi_poseti_product_soup,
                                                                               main_category,
                                                                               current_category, current_category_1)
        if None is not current_product_buzdolabi_poseti:
            buzdolabi_poseti_list.append(current_product_buzdolabi_poseti)
        time.sleep(3)
    buzdolabi_poseti_list = scrape_cimri_product.organize_similar_products(buzdolabi_poseti_list)
    return buzdolabi_poseti_list


############################################################################################
def scrape_pisirme_kagidi_products():
    current_category = "Mutfak Sarf Malzemeleri"
    current_category_1 = "Pişirme Kağıdı"
    pisirme_kagidi_product_urls = scrape_cimri_url.get_category_urls(pisirme_kagidi_category_urls)
    pisirme_kagidi_list = []
    for pisirme_kagidi_product_url in pisirme_kagidi_product_urls:
        pisirme_kagidi_product_soup = scrape_cimri_product.get_page_data(str(pisirme_kagidi_product_url))
        current_product_pisirme_kagidi = scrape_cimri_product.scrape_product(pisirme_kagidi_product_soup,
                                                                             main_category,
                                                                             current_category, current_category_1)
        if None is not current_product_pisirme_kagidi:
            pisirme_kagidi_list.append(current_product_pisirme_kagidi)
        time.sleep(3)
    pisirme_kagidi_list = scrape_cimri_product.organize_similar_products(pisirme_kagidi_list)
    return pisirme_kagidi_list


############################################################################################
def scrape_aluminyum_folyo_products():
    current_category = "Mutfak Sarf Malzemeleri"
    current_category_1 = "Aluminyum Folyo"
    aluminyum_folyo_product_urls = scrape_cimri_url.get_category_urls(aluminyum_folyo_category_urls)
    aluminyum_folyo_list = []
    for aluminyum_folyo_product_url in aluminyum_folyo_product_urls:
        aluminyum_folyo_product_soup = scrape_cimri_product.get_page_data(str(aluminyum_folyo_product_url))
        current_product_aluminyum_folyo = scrape_cimri_product.scrape_product(aluminyum_folyo_product_soup,
                                                                              main_category,
                                                                              current_category, current_category_1)
        if None is not current_product_aluminyum_folyo:
            aluminyum_folyo_list.append(current_product_aluminyum_folyo)
        time.sleep(3)
    aluminyum_folyo_list = scrape_cimri_product.organize_similar_products(aluminyum_folyo_list)
    return aluminyum_folyo_list


############################################################################################
def scrape_firin_torbasi_products():
    current_category = "Mutfak Sarf Malzemeleri"
    current_category_1 = "Fırın Torbası"
    firin_torbasi_product_urls = scrape_cimri_url.get_category_urls(firin_torbasi_category_urls)
    firin_torbasi_list = []
    for firin_torbasi_product_url in firin_torbasi_product_urls:
        firin_torbasi_product_soup = scrape_cimri_product.get_page_data(str(firin_torbasi_product_url))
        current_product_firin_torbasi = scrape_cimri_product.scrape_product(firin_torbasi_product_soup, main_category,
                                                                            current_category, current_category_1)
        if None is not current_product_firin_torbasi:
            firin_torbasi_list.append(current_product_firin_torbasi)
        time.sleep(3)
    firin_torbasi_list = scrape_cimri_product.organize_similar_products(firin_torbasi_list)
    return firin_torbasi_list


############################################################################################


product_list = scrape_firin_torbasi_products()
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
