// shoppingListDetails.dart
import 'package:flutter/material.dart';
import 'package:pwfe/classes/Product.dart';
import 'package:pwfe/classes/ShoppingList.dart';
import 'package:pwfe/classes/UsersShoppingLists.dart';
import 'package:pwfe/pages/MyShoppingListsPage.dart';
import 'package:pwfe/components/bars/navigation_bar_bottom.dart';

class ShoppingListDetailsPage extends StatelessWidget {
  final int index;
  ShoppingListDetailsPage({Key? key, required this.index}) : super(key: key);
  UsersShoppingLists theShoppingList = UsersShoppingLists.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping List Details'),
      ),
      body: ListView.builder(
        itemCount: theShoppingList.getShoppingList(index).getProducts().length,
        itemBuilder: (BuildContext context, int itemIndex) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    'Product: ${theShoppingList.getShoppingList(index).getProduct(itemIndex).getProductName()}'),
                Text(
                    'Price: ${theShoppingList.getShoppingList(index).getProduct(itemIndex).getProductPrice().toString()}'),
                Text(
                    'Amount: ${theShoppingList.getShoppingList(index).getAmount(theShoppingList.getShoppingList(index).getProduct(itemIndex).getProductName())}'),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: navigation_bar_bottom(context),
    );
  }
}
