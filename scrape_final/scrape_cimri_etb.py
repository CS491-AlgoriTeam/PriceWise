import scrape_cimri_product
import scrape_cimri_url
from requests_html import HTMLSession
import time

session = HTMLSession()

main_category = "Et, Tavuk ve Balık"

et_category_urls = "https://www.cimri.com/market/kirmizi-et?onlyOffline=true"
sarkuteri_category_urls = "https://www.cimri.com/market/sarkuteri?onlyOffline=true"
tavuk_category_urls = "https://www.cimri.com/market/beyaz-et?onlyOffline=true"
balik_category_urls = "https://www.cimri.com/market/deniz-urunu?onlyOffline=true"


"""
et_word_dictionary = {'dana': 122, 'kuzu': 55, 'döner': 4, 
                      'kol': 8, 'kokoreç': 2, ,
                      'pirzola': 6, 'dondurulmus': 1, 'kıyma': 14, 'yağlı': 6,
                      'migros': 5, 'ciğer': 3, 'kuşbaşı': 14, 'uzman': 35, 'kasap': 36, 'beşler': 9, 'dondurulmuş': 2,
                      'but': 4, 'yürek': 5, 'billur': 1, 'reyondan': 49, 'peşrev': 2, 'çelebi': 2, 'tire': 5,
                      'köfte': 24, 'kontrafile': 4, 'dalak': 2, '200': 4, 'haket': 3, 'yağsız': 6, 'biftek': 6,
                      'yöresel': 11, 'çorbalık': 1, 'kıvırcık': 23, 'böbrek': 1, 'koç': 1, 'yumurtası': 1, 'bonfile': 7,
                      'gıda': 4, 'nuar': 3, 'rosto': 2, 'tk': 6, 'pınar': 2, '225': 1, 'özel': 1, 'burger': 4, 'eti': 3,
                      'şiş': 5, 'küşleme': 1, 'külbastı': 3,
                      'fırınlık': 2, 'stragonofluk': 1, 'antrikot': 7, 
                      'obak': 2, 'fileto': 1'kontrfile': 1, 'orvital': 1,
                      'organik': 1, 'fiorucci': 1, '120': 1, 'isıl': 1, 'i̇şlem': 1, 'uygulanmamış': 1, 'kürlenmiş': 1,
                      ''gerdan': 6, 'tranç': 2, 'oğlak': 1, 'kapama': 1, 'lokum': 2, 'sote': 4,
                      'izgaralık': 1, 'satır': 3, 'sotelik': 1, 'beyti': 2, 'kaburga': 6, 'dardanel': 1, '185': 1,
                      'parmak': 1, 'soslu': 4, 'i̇ncik': 3, 'kemiksiz': 2, 'kelle': 1,
                      'yarım': 2, 'tas': 1, 'kebap': 1, '%15': 1, 'izgara': 2, 'doğranmış': 1, 'akşeker': 1, 'şef': 1,
                      'kuru': 2, 'karaciğer': 1,  'donuk': 2, 'dana-kuzu': 2,  
                      'gulaşlık': 2, 'fermente': 1, 'gold': 1, 'sucuk': 1, 'füme': 3, 'rostoluk': 2,
                      'kıymalık': 3, 'yemeklik': 4, 'döş': 1, 'rulo': 1, 'haşlamalık': 2, 'kalp': 1, 'hamburger': 1,
                      'saç': 2, 'kavurmalık': 3, 'kapamalık': 2, 'laz': 2, 'kızı': 2, '150': 2, 'kavurma': 2, 'çöp': 2,
                      'misket': 1, 'bahar': 1, 'hindi': 1, 'dilimli': 1, 'kemikli': 1, 'i̇nciksiz': 1, '750': 1,
                      'pöç': 1, 'yanak': 1, '240': 1, 'mini': 1, 'miks': 1, 'kaşarlı': 1, '480': 1, 'akçasaray': 1,
                      'siyah': 1, 'sarımsaklı': 1, 'akçaabat': 1, 'brisket': 1, 'anket': 1, 'polonez': 1, 'rozbif': 1,
                      'biberli': 1, 'i̇şkembe': 6, 'kurek': 1, 'özlem': 1, '100': 1, 'az': 1, 'fleminyon': 1,
                      'tandır': 1, '(brisket)': 1, 'sac': 1, 'güngörmez': 1, 'klasik': 2,
                      'mangal': 1, 'dil': 1, 
                      'ribs': 1, 'aypa': 1, 'tava': 1, 'kombinet': 2,  'steak': 1, 'i̇likli': 1, 'kemik': 1}
"""


####################################################################################################
def scrape_et_products():
    current_category = "Et"
    et_product_urls = scrape_cimri_url.get_category_urls(et_category_urls)
    et_list = []
    for et_product_url in et_product_urls:
        et_product_soup = scrape_cimri_product.get_page_data(str(et_product_url))
        current_product_et = scrape_cimri_product.scrape_product(et_product_soup, main_category,
                                                                 current_category, "")
        if None is not current_product_et:
            et_list.append(current_product_et)
        time.sleep(3)
    et_list = scrape_cimri_product.organize_similar_products(et_list)
    return et_list


######################################################################################
def scrape_sarkuteri_products():
    current_category = "Şarküteri"
    sarkuteri_product_urls = scrape_cimri_url.get_category_urls(sarkuteri_category_urls)
    sarkuteri_list = []
    for sarkuteri_product_url in sarkuteri_product_urls:
        sarkuteri_product_soup = scrape_cimri_product.get_page_data(str(sarkuteri_product_url))
        current_product_sarkuteri = scrape_cimri_product.scrape_product(sarkuteri_product_soup, main_category,
                                                                        current_category, "")
        if None is not current_product_sarkuteri:
            sarkuteri_list.append(current_product_sarkuteri)
        time.sleep(3)
    sarkuteri_list = scrape_cimri_product.organize_similar_products(sarkuteri_list)
    return sarkuteri_list


######################################################################################
def scrape_tavuk_products():
    current_category = "Tavuk"
    tavuk_product_urls = scrape_cimri_url.get_category_urls(tavuk_category_urls)
    tavuk_list = []
    for tavuk_product_url in tavuk_product_urls:
        tavuk_product_soup = scrape_cimri_product.get_page_data(str(tavuk_product_url))
        current_product_tavuk = scrape_cimri_product.scrape_product(tavuk_product_soup, main_category,
                                                                    current_category, "")
        if None is not current_product_tavuk:
            tavuk_list.append(current_product_tavuk)
        time.sleep(3)
    tavuk_list = scrape_cimri_product.organize_similar_products(tavuk_list)
    return tavuk_list


######################################################################################
def scrape_balik_products():
    current_category = "Balık"
    balik_product_urls = scrape_cimri_url.get_category_urls(balik_category_urls)
    balik_list = []

    for balik_product_url in balik_product_urls:
        balik_product_soup = scrape_cimri_product.get_page_data(str(balik_product_url))
        current_product_balik = scrape_cimri_product.scrape_product(balik_product_soup, main_category,
                                                                    current_category, "")
        if None is not current_product_balik:
            balik_list.append(current_product_balik)
        time.sleep(3)
    balik_list = scrape_cimri_product.organize_similar_products(balik_list)
    return balik_list


####################################################################


product_list = scrape_tavuk_products()
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
