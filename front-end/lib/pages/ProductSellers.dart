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
    {'sellerName': 'Seller A', 'price': 20.0},
    {'sellerName': 'Seller B', 'price': 25.0},
    {'sellerName': 'Seller C', 'price': 18.0},
    // Add more sellers as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seller Profile'),
      ),
      bottomNavigationBar: navigation_bar_bottom(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Sellers of ${widget.product.getProductName()}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: sellersData.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(sellersData[index]['sellerName']),
                  subtitle: Text('Price: \$${sellersData[index]['price']}'),
                  // You can customize the ListTile as needed
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
