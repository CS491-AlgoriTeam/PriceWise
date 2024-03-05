from requests_html import HTMLSession
from bs4 import BeautifulSoup
import requests
import time

session = HTMLSession()
main_url = "https://www.cimri.com/market/bitkisel-yaglar?onlyOffline=true"
base_url = "https://www.cimri.com"

"""
tuz_seker_baharat_gida_category_urls = [
                      "https://www.cimri.com/market/baharat?onlyOffline=true",
                      "https://www.cimri.com/market/tuz?onlyOffline=true",
                      "https://www.cimri.com/market/hazir-corba-ve-bulyon?onlyOffline=true",
                      "https://www.cimri.com/market/toz-ve-kup-seker?onlyOffline=true"]

konserve_sos_hazir_yemek_gida_category_urls = [
                      "https://www.cimri.com/market/sos?onlyOffline=true",
                      "https://www.cimri.com/market/konserve?onlyOffline=true",
                      "https://www.cimri.com/market/kuru-sebze?onlyOffline=true",
                      "https://www.cimri.com/market/hazir-yemekler?onlyOffline=true",
                      "https://www.cimri.com/market/dondurulmus-gida?onlyOffline=true"]

atistirmalik_gida_category_urls = [
                      "https://www.cimri.com/market/kuruyemis?onlyOffline=true",
                      "https://www.cimri.com/market/sekerleme-sakiz?onlyOffline=true",
                      "https://www.cimri.com/market/cikolata-ve-gofret?onlyOffline=true",
                      "https://www.cimri.com/market/tatli-ve-pasta?onlyOffline=true",
                      "https://www.cimri.com/market/biskuvi-ve-kek?onlyOffline=true",
                      "https://www.cimri.com/market/kraker-ve-kurabiye?onlyOffline=true",
                      "https://www.cimri.com/market/cips?onlyOffline=true",
                      "https://www.cimri.com/market/dondurma?onlyOffline=true"]

fit_form_gida_category_urls = [
                      "https://www.cimri.com/market/kuru-meyve?onlyOffline=true",
                      "https://www.cimri.com/market/granola-ve-bar?onlyOffline=true"]

temel_gida_category_urls = [
                      "https://www.cimri.com/market/bitkisel-yaglar?onlyOffline=true",
                      "https://www.cimri.com/market/tatli-ve-pasta-malzemeleri?onlyOffline=true",
                      "https://www.cimri.com/market/bakliyat?onlyOffline=true",
                      "https://www.cimri.com/market/un-ve-irmik?onlyOffline=true",
                      "https://www.cimri.com/market/sivi-yag-ve-zeytinyagi?onlyOffline=true",
                      "https://www.cimri.com/market/makarnalar?onlyOffline=true",
                      "https://www.cimri.com/market/unlu-mamuller?onlyOffline=true"]


gida_category_urls = ["https://www.cimri.com/market/bitkisel-yaglar?onlyOffline=true",
                      "https://www.cimri.com/market/tatli-ve-pasta-malzemeleri?onlyOffline=true",
                      "https://www.cimri.com/market/bakliyat?onlyOffline=true",
                      "https://www.cimri.com/market/un-ve-irmik?onlyOffline=true",
                      "https://www.cimri.com/market/sivi-yag-ve-zeytinyagi?onlyOffline=true",
                      "https://www.cimri.com/market/makarnalar?onlyOffline=true",
                      "https://www.cimri.com/market/unlu-mamuller?onlyOffline=true",
                      "https://www.cimri.com/market/kuruyemis?onlyOffline=true",
                      "https://www.cimri.com/market/sekerleme-sakiz?onlyOffline=true",
                      "https://www.cimri.com/market/cikolata-ve-gofret?onlyOffline=true",
                      "https://www.cimri.com/market/tatli-ve-pasta?onlyOffline=true",
                      "https://www.cimri.com/market/biskuvi-ve-kek?onlyOffline=true",
                      "https://www.cimri.com/market/kraker-ve-kurabiye?onlyOffline=true",
                      "https://www.cimri.com/market/cips?onlyOffline=true",
                      "https://www.cimri.com/market/dondurma?onlyOffline=true",
                      "https://www.cimri.com/market/baharat?onlyOffline=true",
                      "https://www.cimri.com/market/tuz?onlyOffline=true",
                      "https://www.cimri.com/market/hazir-corba-ve-bulyon?onlyOffline=true",
                      "https://www.cimri.com/market/toz-ve-kup-seker?onlyOffline=true,"
                      "https://www.cimri.com/market/sos?onlyOffline=true",
                      "https://www.cimri.com/market/konserve?onlyOffline=true",
                      "https://www.cimri.com/market/kuru-sebze?onlyOffline=true",
                      "https://www.cimri.com/market/hazir-yemekler?onlyOffline=true",
                      "https://www.cimri.com/market/dondurulmus-gida?onlyOffline=true",
                      "https://www.cimri.com/market/kuru-meyve?onlyOffline=true",
                      "https://www.cimri.com/market/granola-ve-bar?onlyOffline=true"]


sut_ve_kahvaltilik_category_urls = ["https://www.cimri.com/market/bal-ve-recel?onlyOffline=true",
                                    "https://www.cimri.com/market/bal-ve-recel?onlyOffline=true"
                                    "https://www.cimri.com/market/peynir?onlyOffline=true",
                                    "https://www.cimri.com/market/zeytin?onlyOffline=true",
                                    "https://www.cimri.com/market/surulebilir?onlyOffline=true",
                                    "https://www.cimri.com/market/kahvaltilik-gevrek?onlyOffline=true",
                                    "https://www.cimri.com/market/tereyag-ve-margarin?onlyOffline=true",
                                    "https://www.cimri.com/market/yogurt?onlyOffline=true",
                                    "https://www.cimri.com/market/sut?onlyOffline=true",
                                    "https://www.cimri.com/market/yumurta?onlyOffline=true",
                                    "https://www.cimri.com/market/kaymak?onlyOffline=true"]

meyve_ve_sebze_category_urls = ["https://www.cimri.com/market/sebze?onlyOffline=true",
                                "https://www.cimri.com/market/meyve?onlyOffline=true"]

icecek_category_urls = ["https://www.cimri.com/market/cay?onlyOffline=true",
                        "https://www.cimri.com/market/kahve?onlyOffline=true",
                        "https://www.cimri.com/market/sicak-toz-icecek?onlyOffline=true",
                        "https://www.cimri.com/market/limonata-ve-meyve-suyu?onlyOffline=true",
                        "https://www.cimri.com/market/gazli-icecek?onlyOffline=true",
                        "https://www.cimri.com/market/soguk-toz-icecekler?onlyOffline=true",
                        "https://www.cimri.com/market/geleneksel-icecekler?onlyOffline=true",
                        "https://www.cimri.com/market/su?onlyOffline=true",
                        "https://www.cimri.com/market/maden-suyu-ve-soda?onlyOffline=true",
                        "https://www.cimri.com/market/soguk-kahveler?onlyOffline=true",
                        "https://www.cimri.com/market/ayran?onlyOffline=true"]

et_tavuk_ve_balik_category_urls = ["https://www.cimri.com/market/sarkuteri?onlyOffline=true",
                                   "https://www.cimri.com/market/kirmizi-et?onlyOffline=true",
                                   "https://www.cimri.com/market/beyaz-et?onlyOffline=true",
                                   "https://www.cimri.com/market/deniz-urunu?onlyOffline=true"]

ev_temizligi_deterjan_ve_temizlik_urunleri_category_urls = [
                                               "https://www.cimri.com/market/oda-kokusu?onlyOffline=true",
                                               "https://www.cimri.com/market/parlatici-ve-temizleyiciler?onlyOffline=true",
                                               "https://www.cimri.com/market/temizlik-malzemeleri?onlyOffline=true",
                                               "https://www.cimri.com/market/hali-sampuani?onlyOffline=true"]

camasir_yikama_deterjan_ve_temizlik_urunleri_category_urls = [
                                               "https://www.cimri.com/market/camasir-deterjani?onlyOffline=true",
                                               "https://www.cimri.com/market/camasir-makinesi-urunleri?onlyOffline=true"]

bulasik_yikama_deterjan_ve_temizlik_urunleri_category_urls = [
                                               "https://www.cimri.com/market/bulasik-deterjani?onlyOffline=true",
                                               "https://www.cimri.com/market/bulasik-makinesi-tableti?onlyOffline=true",
                                               "https://www.cimri.com/market/bulasik-makinesi-urunleri?onlyOffline=true",
                                               "https://www.cimri.com/market/bulasik-makinesi-deterjani?onlyOffline=true"]

kagit_deterjan_ve_temizlik_urunleri_category_urls = [
                                               "https://www.cimri.com/market/pecete?onlyOffline=true",
                                               "https://www.cimri.com/market/islak-mendil?onlyOffline=true",
                                               "https://www.cimri.com/market/kagit-havlu?onlyOffline=true",
                                               "https://www.cimri.com/market/tuvalet-kagidi?onlyOffline=true",
                                               "https://www.cimri.com/market/kagit-mendil?onlyOffline=true"]

mutfak_deterjan_ve_temizlik_urunleri_category_urls = [
                                               "https://www.cimri.com/market/cop-posetleri?onlyOffline=true",
                                               "https://www.cimri.com/market/strec-film?onlyOffline=true",
                                               "https://www.cimri.com/market/buzdolabi-poseti?onlyOffline=true",
                                               "https://www.cimri.com/market/pisirme-kagidi?onlyOffline=true",
                                               "https://www.cimri.com/market/aluminyum-folyo?onlyOffline=true",
                                               "https://www.cimri.com/market/firin-torbasi?onlyOffline=true"]


deterjan_ve_temizlik_urunleri_category_urls = ["https://www.cimri.com/market/oda-kokusu?onlyOffline=true",
                                               "https://www.cimri.com/market/parlatici-ve-temizleyiciler?onlyOffline=true",
                                               "https://www.cimri.com/market/temizlik-malzemeleri?onlyOffline=true",
                                               "https://www.cimri.com/market/hali-sampuani?onlyOffline=true",
                                               "https://www.cimri.com/market/camasir-deterjani?onlyOffline=true",
                                               "https://www.cimri.com/market/camasir-makinesi-urunleri?onlyOffline=true",
                                               "https://www.cimri.com/market/bulasik-deterjani?onlyOffline=true",
                                               "https://www.cimri.com/market/bulasik-makinesi-tableti?onlyOffline=true",
                                               "https://www.cimri.com/market/bulasik-makinesi-urunleri?onlyOffline=true",
                                               "https://www.cimri.com/market/bulasik-makinesi-deterjani?onlyOffline=true",
                                               "https://www.cimri.com/market/pecete?onlyOffline=true",
                                               "https://www.cimri.com/market/islak-mendil?onlyOffline=true",
                                               "https://www.cimri.com/market/kagit-havlu?onlyOffline=true",
                                               "https://www.cimri.com/market/tuvalet-kagidi?onlyOffline=true",
                                               "https://www.cimri.com/market/kagit-mendil?onlyOffline=true",
                                               "https://www.cimri.com/market/cop-posetleri?onlyOffline=true",
                                               "https://www.cimri.com/market/strec-film?onlyOffline=true",
                                               "https://www.cimri.com/market/buzdolabi-poseti?onlyOffline=true",
                                               "https://www.cimri.com/market/pisirme-kagidi?onlyOffline=true",
                                               "https://www.cimri.com/market/aluminyum-folyo?onlyOffline=true",
                                               "https://www.cimri.com/market/firin-torbasi?onlyOffline=true"]
"""


def get_page_data(url):
    http_request = requests.get(url)
    html_text = http_request.text
    parsed_html = BeautifulSoup(html_text, "html.parser")
    return parsed_html


def get_next_page(soup):
    page = soup.find('div', {"class": "Pagination_pagination__6kvLO"})
    if not page.find("button", {"class": "Pagination_nextButton__Bi042 Pagination_disabled__2vtkb"}):
        next_url = "https://www.cimri.com" + str(page.find("a", {"class": "Pagination_nextButton__Bi042"})['href'])
        return next_url
    else:
        return


def get_product_urls(soup):
    product_urls = soup.find_all('div', {'class': 'ProductCard_productCard__412iI'})
    return product_urls


def get_category_urls(url):
    final_product_urls = []
    current_url = url
    while current_url is not None:
        current_parsed_html = get_page_data(current_url)
        current_products = get_product_urls(current_parsed_html)
        for current_product in current_products:
            final_product_urls.append(base_url + str(current_product.find('a')['href']))
        current_url = get_next_page(current_parsed_html)
    return final_product_urls


def get_a_category_urls(input_urls):
    final_all_product_urls = []
    for category_url in input_urls:
        final_all_product_urls.extend(get_category_urls(category_url))
    return final_all_product_urls
