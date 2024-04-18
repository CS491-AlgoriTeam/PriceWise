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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pwfe/components/bars/navigation_bar_bottom.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Explore'),
        automaticallyImplyLeading: false,

      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('Products').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          // List to hold all category widgets
          List<Widget> categoryWidgets = [];
          snapshot.data!.docs.forEach((categoryDoc) {
            // For each category, create a widget
            Widget categoryWidget = buildCategory(categoryDoc);
            categoryWidgets.add(categoryWidget);
          });

          return ListView(
            children: categoryWidgets,
          );
        },
      ),
      bottomNavigationBar: navigation_bar_bottom(context), // Assuming this method is defined elsewhere
    );
  }

  Widget buildCategory(DocumentSnapshot categoryDoc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8),
          color: Colors.lightBlue[50],
          child: Text(
            categoryDoc.id, // Category name
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection('Products/${categoryDoc.id}/Sub Category').snapshots(),
          builder: (context, subSnapshot) {
            if (!subSnapshot.hasData) {
              return SizedBox();
            }
            List<Widget> productListWidgets = [];
            subSnapshot.data!.docs.forEach((subCategoryDoc) {
              productListWidgets.add(buildSubCategory(subCategoryDoc, categoryDoc.id));
            });
            return Column(children: productListWidgets);
          },
        ),
      ],
    );
  }

  Widget buildSubCategory(DocumentSnapshot subCategoryDoc, String categoryName) {
    return ExpansionTile(
      title: Text(subCategoryDoc.id),
      children: [
        StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection('Products/$categoryName/Sub Category/${subCategoryDoc.id}/Product Name').snapshots(),
          builder: (context, productSnapshot) {
            if (!productSnapshot.hasData) {
              return SizedBox();
            }
            List<Widget> productWidgets = productSnapshot.data!.docs.map((productDoc) {
              return buildProductItem(productDoc);
            }).toList();
            return GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 1 / 1.2, // Adjust the ratio based on your content
              children: productWidgets,
            );
          },
        ),
      ],
    );
  }

  Widget buildProductItem(DocumentSnapshot productDoc) {
    Map<String, dynamic> productData = productDoc.data() as Map<String, dynamic>;
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Image.network(
              productData['product_image_url'],
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(productData['product_name'], style: TextStyle(fontWeight: FontWeight.bold)),
                Text('\$${productData['product_cheapest_price']}'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
