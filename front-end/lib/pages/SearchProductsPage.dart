// search_page.dart
import 'package:flutter/material.dart';
import 'package:pwfe/pages/ProductSellers.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search page'),
      ),
      body: ListView.builder(
        itemCount: 10, // Set the number of items in your list
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text('Item $index'),
            onTap: () {
              // Add your item click logic here
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ProductSellers()));
            },
          );
        },
      ),
    );
  }
}
