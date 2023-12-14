import 'package:flutter/material.dart';
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
}
