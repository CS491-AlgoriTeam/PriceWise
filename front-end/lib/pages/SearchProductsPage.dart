/* search_page.dart
import 'package:flutter/material.dart';
import 'package:pwfe/pages/ProductSellers.dart';
import 'package:sqflite/sqflite.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  /* variables
  //UsersShoppingLists shoppingLists = UsersShoppingLists.instance;
  List<Product> displayedProducts = [];
  // biraz ezikçe ama şimdilik böyle
  List<ShoppingList> testShooingLists = [
    ShoppingList(
        shoppingListName: "shoppingList1",
        products: [Product(productName: "product1", productPrice: 1.0)]),
    ShoppingList(
        shoppingListName: "shoppingList2",
        products: [Product(productName: "product2", productPrice: 2.0)])
  ];
  String? selectedListName; // Variable to hold the selected list name

  //DatabaseHelper _databaseController = DatabaseHelper();

  List<Product> allProducts = List.generate(
      100,
      (index) =>
          Product(productName: 'Item $index', productPrice: index.toDouble()));
*/
  @override
  void initState() {
    super.initState();
    //displayedProducts = List.from(List.empty());
    //allProducts.add(Product(productName: "xd", productPrice: 31.31));
  }

  void filterProducts(String query) async {
    final productMapList = await _databaseController.getProductMapList();

    setState(() {
      displayedProducts = productMapList
          .where((product) => product['productName']
              .toLowerCase()
              .contains(query.toLowerCase()))
          .map<Product>((product) {
        var productInstance = Product(
          productName: product['productName'],
          productPrice: product['productPrice'],
        );
        productInstance.fromMapObject(product);
        return productInstance;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search page'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    onChanged: filterProducts,
                    decoration: const InputDecoration(
                      hintText: 'Search...',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  DropdownButton<String>(
                    value: selectedListName,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedListName =
                            newValue; // Update the selected list name
                      });
                    },
                    items: shoppingLists
                        .getUsersShoppingLists()
                        .map((ShoppingList list) {
                      return DropdownMenuItem<String>(
                        value: list.shoppingListName,
                        child: Text(list.shoppingListName),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(displayedProducts[index].productName),
                      GestureDetector(
                        onTap: () {
                          // Add your logic for onPressed here
                          // For example, you can call a function or navigate to another page.
                          print(
                              "Add to list pressed for ${displayedProducts[index].productName}");
                        },
                        child: Text("Add to list"),
                      ),
                      Text(displayedProducts[index].productPrice.toString()),
                    ],
                  ),
                  onTap: () {
                    // Add your item click logic here
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductSellers(product: Product(productName: "Amasya Elması", productPrice: 20),),
                        ));
                  },
                );
              },
              childCount: displayedProducts.length,
            ),
          ),
        ],
      ),
    );
  }
}
*/

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
      'Sıcak Toz İçecekeler'
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
              childAspectRatio: (5 / 6),
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
                    offset: Offset(0, 4), // changes position of shadow
                  ),
                ],
                image: DecorationImage(
                  image: AssetImage(
                      'assets/$imageName.png'), // Assuming you have the images in the correct path
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
