// search_page.dart
import 'package:flutter/material.dart';
import 'package:pwfe/classes/Product.dart';
import 'package:pwfe/classes/ShoppingList.dart';
import 'package:pwfe/classes/UsersShoppingLists.dart';
import 'package:pwfe/pages/ProductSellers.dart';
import 'package:pwfe/utils/DatabaseHelper.dart';
import 'package:sqflite/sqflite.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // variables
  UsersShoppingLists shoppingLists = UsersShoppingLists.instance;
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

  DatabaseHelper _databaseController = DatabaseHelper();

  List<Product> allProducts = List.generate(
      100,
      (index) =>
          Product(productName: 'Item $index', productPrice: index.toDouble()));

  @override
  void initState() {
    super.initState();
    displayedProducts = List.from(List.empty());
    allProducts.add(Product(productName: "xd", productPrice: 31.31));
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
                          builder: (context) => ProductSellers(),
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
