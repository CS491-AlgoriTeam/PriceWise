import 'package:flutter/material.dart';
import 'package:pwfe/components/bars/navigation_bar_bottom.dart';
import 'package:pwfe/pages/SubCategoryPage.dart';

class SearchPage extends StatelessWidget {
  final String selectedListId;
  final Map<String, List<String>> categories = {
    'Gıda': [
      'Temel Gıda',
      'Konserve Sos ve Hazır Yemek',
      'Konserve',
      'Atıştırmalık',
      'Fit & Form',
      'Tuz'
    ],
    'Et, Tavuk ve Balık': ['Tavuk', 'Et', 'Balık', 'Şarküteri'],
    'Meyve ve Sebze': ['Meyve', 'Sebze'],
    'Süt ve Kahvaltlık': [
      'Yumurta',
      'Süt',
      'Yoğurt',
      'Tereyağ ve Margarin',
      'Kaymak',
      'Zeytin',
      'Bal ve Reçel',
      'Sürülebilir',
      'Kahvaltılık Gevrek'
    ],
    'Deterjan ve Temizlik Ürünleri': [
      'Bulaşık Yıkama',
      'Ev Temizliği',
      'Çamaşır Yıkama',
      'Mutfak Sarf Malzemeleri',
      'Kağıt Ürünleri'
    ],
    'İçecekler': [
      'Ayran',
      'Gazli İcecek',
      'Geleneksel İçecekler',
      'Kahve',
      'Limonata Meyve Suyu',
      'Maden Suyu',
      'SoĞuk Toz İçecekler',
      'Soğuk Kahve',
      'Su',
      'Çay',
      'Sıcak Toz İçecek'
    ],
    // Add more categories and subcategories here
  };

  SearchPage({required this.selectedListId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Explore'),
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          String mainCategory = categories.keys.elementAt(index);
          List<String> subCategories = categories.values.elementAt(index);
          return buildCategory(mainCategory, subCategories);
        },
      ),
      bottomNavigationBar:
          navigation_bar_bottom(context), // Your custom bottom navigation bar
    );
  }

  Widget buildCategory(String mainCategory, List<String> subCategories) {
    return Container(
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.blue[100], // Adjust the color to match profile page
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch the column
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.blue[200], // Adjust the color to match profile page
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Text(
              mainCategory,
              style: TextStyle(
                color: Colors.black, // Custom color for the title
                fontWeight: FontWeight.bold, // Bold text
                fontSize: 24, // Custom font size
              ),
              textAlign: TextAlign.left,
            ),
          ),
          GridView.builder(
            shrinkWrap: true, // Use it to make GridView inside ListView
            physics:
                NeverScrollableScrollPhysics(), // to disable GridView's scrolling
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: (4 / 6),
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: subCategories.length,
            itemBuilder: (context, index) {
              return buildSubCategory(
                  context, mainCategory, subCategories[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget buildSubCategory(
      BuildContext context, String mainCategory, String subCategory) {
    // Build subcategory item with image and name
    String imageName = subCategory
        .toLowerCase()
        .replaceAll(' ', '_'); // image name from subcategory name

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SubcategoryPage(
              mainCategory: mainCategory,
              subCategory: subCategory,
              selectedListId: selectedListId,
            ),
          ),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.lightBlue,
                    spreadRadius: 1,
                    //offset: Offset(0, 4), // changes position of shadow
                  ),
                ],
                image: DecorationImage(
                  image: AssetImage(
                      'assets/$imageName.jpeg'), // Assuming you have the images in the correct path
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 5),
          Text(subCategory),
        ],
      ),
    );
  }
}
