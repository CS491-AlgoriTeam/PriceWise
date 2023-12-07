// shoppingListDetails.dart
import 'package:flutter/material.dart';

class ShoppingListDetails extends StatelessWidget {
    final int itemIndex;

  ShoppingListDetails({required this.itemIndex});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('shoppingListDetails'),
      ),
      body: Center(
        child: Text('shoppingListDetails Content'),
      ),
    );
  }
}