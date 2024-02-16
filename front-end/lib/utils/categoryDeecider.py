category_keywords = {
    'Meyveler': ['elma', 'muz', 'portakal', 'mandalin', 'armut', 'nar', 'şeftali', 'avokado'],
    'Sebzeler': ['salatalık', 'domates', 'soğan', 'patates', 'havuç', 'limon', 'biber'],
    'Bulaşık Deterjanları': ['deterjan', 'tablet'],
    'Çikolatalar': ['çikolata', 'gofret'],
    'Yumuşatıcılar': ['yumuşatıcı', ''],
    'Süt Ürünleri': ['yoğurt', 'süt', 'peynir'],
    'İçecekler': ['kola', 'fanta', 'su'],
    # Add more categories
}

def determine_category(product_name):
    for category, keywords in category_keywords.items():
        if any(keyword in product_name.lower() for keyword in keywords):
            return category
    return "Other"  # Default category if no keywords match