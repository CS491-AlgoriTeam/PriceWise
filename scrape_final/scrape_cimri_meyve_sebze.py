import scrape_cimri_product
import scrape_cimri_url
from requests_html import HTMLSession
import time

session = HTMLSession()

main_category = "Meyve ve Sebze"
sebze_category_urls = "https://www.cimri.com/market/sebze?onlyOffline=true"
meyve_category_urls = "https://www.cimri.com/market/meyve?onlyOffline=true"


#######################################################################################################
def scrape_sebze_products():
    current_category = "Sebze"
    sebze_product_urls = scrape_cimri_url.get_category_urls(sebze_category_urls)
    sebze_list = []
    for sebze_product_url in sebze_product_urls:
        sebze_product_soup = scrape_cimri_product.get_page_data(str(sebze_product_url))
        current_product_sebze = scrape_cimri_product.scrape_product(sebze_product_soup, main_category,
                                                                    current_category, "")
        if None is not current_product_sebze:
            sebze_list.append(current_product_sebze)
        time.sleep(3)

    sebze_list = scrape_cimri_product.organize_similar_products(sebze_list)
    return sebze_list


############################################################################################

def scrape_meyve_products():
    current_category = "Meyve"
    meyve_product_urls = scrape_cimri_url.get_category_urls(meyve_category_urls)
    meyve_list = []
    for meyve_product_url in meyve_product_urls:
        meyve_product_soup = scrape_cimri_product.get_page_data(str(meyve_product_url))
        current_product_meyve = scrape_cimri_product.scrape_product(meyve_product_soup, main_category,
                                                                    current_category, "")
        if None is not current_product_meyve:
            meyve_list.append(current_product_meyve)
        time.sleep(3)
    meyve_list = scrape_cimri_product.organize_similar_products(meyve_list)
    return meyve_list
###########################################################################################################


product_list = scrape_meyve_products()
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
