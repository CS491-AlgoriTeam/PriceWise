// search_page.dart
import 'package:flutter/material.dart';
import 'package:pwfe/classes/Product.dart';
import 'package:pwfe/classes/ShoppingList.dart';
import 'package:pwfe/classes/UsersShoppingLists.dart';
import 'package:pwfe/pages/ProductSellers.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // variables
  UsersShoppingLists shoppingLists = UsersShoppingLists.instance;
  List<Product> displayedProducts = [];
  String? selectedListName; // Variable to hold the selected list name

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

  void filterProducts(String query) {
    setState(() {
      displayedProducts = allProducts
          .where((product) =>
              product.productName.toLowerCase().contains(query.toLowerCase()))
          .toList();
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
                  /*// Show the selected list name above the DropdownButton
                  selectedListName != null
                      ? Text('Selected List: $selectedListName')
                      : Container(),*/
                  // Add DropdownButton here
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
