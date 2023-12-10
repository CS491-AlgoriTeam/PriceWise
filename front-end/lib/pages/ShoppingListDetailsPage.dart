// shoppingListDetails.dart
import 'package:flutter/material.dart';
import 'package:pwfe/classes/Product.dart';
import 'package:pwfe/classes/ShoppingList.dart';
import 'package:pwfe/classes/UsersShoppingLists.dart';
import 'package:pwfe/pages/MyShoppingListsPage.dart';

class ShoppingListDetailsPage extends StatelessWidget {
  final int index;
  ShoppingListDetailsPage({Key? key, required this.index}) : super(key: key);
  UsersShoppingLists theShoppingList =
      MyShoppingLists.getTestingShoppingLists();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Shopping List Details'),
        ),
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
              'Product: ${theShoppingList.getShoppingList(0).getProduct(index).getProductName()}'),
          Text(
              'Price: ${theShoppingList.getShoppingList(0).getProduct(index).getProductPrice().toString()}'),
          Text(
              'Amount: ${theShoppingList.getShoppingList(0).getAmount(theShoppingList.getShoppingList(0).getProduct(index).getProductName())}'),
        ])));
  }
}
