/*import 'package:flutter/material.dart';
import 'package:pwfe/classes/Product.dart';

class ProductSellers extends StatefulWidget {
  const ProductSellers({
    Key? key,
  }) : super(key: key);

  @override
  _ProductSellersState createState() => _ProductSellersState();
}

class _ProductSellersState extends State<ProductSellers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sellers Profile'),
      ),
      body: CustomScrollView(),
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:pwfe/classes/Product.dart';
import 'package:pwfe/components/bars/navigation_bar_bottom.dart';

class ProductSellers extends StatefulWidget {
  final Product product;

  const ProductSellers({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  _ProductSellersState createState() => _ProductSellersState();
}

class _ProductSellersState extends State<ProductSellers> {
  // Sample data, replace this with your actual data
  final List<Map<String, dynamic>> sellersData = [
    {'sellerName': 'Seller A', 'price': 18.0},
    {'sellerName': 'Seller B', 'price': 21.0},
    {'sellerName': 'Seller C', 'price': 23.0},
    // Add more sellers as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seller Profile'),
        backgroundColor: Colors.white, // Customize app bar color
      ),
      bottomNavigationBar: navigation_bar_bottom(context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sellers of ${widget.product.getProductName()}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: sellersData.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(
                        sellersData[index]['sellerName'],
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('Price: ${sellersData[index]['price']}'),
                      trailing: TextButton(
                        onPressed: () {
                          _addToShoppingList(sellersData[index]);
                        },
                        style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        foregroundColor: MaterialStateProperty.all(Colors.white), // Text color
                      ),
                      child: Text(
                        '+ Add to List',
                        style: TextStyle(fontSize: 12, color: Colors.white), // Ensure text is white
                      ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addToShoppingList(Map<String, dynamic> sellerInfo) {
    print('Added ${sellerInfo['sellerName']} to the shopping list');
  }
}