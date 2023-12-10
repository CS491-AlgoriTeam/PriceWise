import 'package:flutter/material.dart';

class ProductSellers extends StatelessWidget {
  const ProductSellers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sellers Profile'),
      ),
      body: const Center(
        child: Text('Sellers Content'),
      ),
    );
  }
}
