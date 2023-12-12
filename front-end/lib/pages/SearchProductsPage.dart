// search_page.dart
import 'package:flutter/material.dart';
import 'package:pwfe/classes/Product.dart';
import 'package:pwfe/pages/ProductSellers.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Product> allProducts = List.generate(
      100,
      (index) =>
          Product(productName: 'Item $index', productPrice: index.toDouble()));
  List<Product> displayedProducts = [];

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
              child: TextField(
                onChanged: filterProducts,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
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
                        builder: (context) => const ProductSellers(),
                      ),
                    );
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
