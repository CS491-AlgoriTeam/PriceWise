// shoppingListDetails.dart
import 'package:flutter/material.dart';
import 'package:pwfe/classes/ShoppingList.dart';
import 'package:pwfe/classes/UsersShoppingLists.dart';
import 'package:pwfe/components/bars/navigation_bar_bottom.dart';
import 'package:pwfe/components/buttons/button_blue_lighter_rounded.dart';
import 'package:pwfe/pages/ShowSuggestedListsPage.dart';

class ShoppingListDetailsPage extends StatelessWidget {
  UsersShoppingLists usersShoppingLists = UsersShoppingLists.instance;
  int index;

  ShoppingListDetailsPage({Key? key, required this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping List Detailzzzz'),
      ),
      body: Column(
        children: [
          Text("debug------------"),
          Expanded(
            // Wrap the ListView.builder with Expanded
            child: ListView.builder(
              itemCount: usersShoppingLists
                  .getShoppingList(index)
                  .getProducts()
                  .length,
              itemBuilder: (BuildContext context, int itemIndex) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("your items: "),
                      Text(
                          'Product: ${usersShoppingLists.getShoppingList(index).getProductAtIndex(itemIndex).getProductName()}'),
                      Text(
                          'Price: ${usersShoppingLists.getShoppingList(index).getProductAtIndex(itemIndex).getProductPrice().toString()}'),
                      Text(
                          'Amount: ${usersShoppingLists.getShoppingList(index).getAmount(usersShoppingLists.getShoppingList(index).getProductAtIndex(itemIndex).getProductName())}'),
                    ],
                  ),
                );
              },
            ),
          ),
          Text(
              "Total Price: ${usersShoppingLists.getShoppingList(index).getShoppingListPrice()}"),
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          button_blue_lighter_rounded(context, "Show suggested Lists",
              (p0) => const ShowSuggestedListsPage()),
          const SizedBox(height: 16),
          navigation_bar_bottom(context),
        ],
      ),
    );
  }
}
