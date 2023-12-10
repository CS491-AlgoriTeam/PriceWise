// shoppingListDetails.dart
import 'package:flutter/material.dart';

class ShoppingListItems {
  final String productName;
  final double price;
  final int amountNumber;

  ShoppingListItems({
    required this.productName,
    required this.price,
    required this.amountNumber,
  });
}

List<ShoppingListItems> testingShoppingListItems = [
  ShoppingListItems(
      productName: "Amasya Elmasi", price: 0.18, amountNumber: 4),
  ShoppingListItems(
      productName: "Tam yağli süt", price: 1.08, amountNumber: 2),
  ShoppingListItems(
      productName: "cikolatali gofret", price: 0.30, amountNumber: 2),
  ShoppingListItems(
      productName: "konserve misir", price: 2.22, amountNumber: 1),
];

class ShoppingListDetailsPage extends StatelessWidget {
  final int index;

  const ShoppingListDetailsPage({Key? key, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping List Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Product: ${testingShoppingListItems[index].productName}'),
            Text('Price: ${testingShoppingListItems[index].price}'),
            Text('Amount: ${testingShoppingListItems[index].amountNumber}'),
            // Add more details based on the selected item if needed
          ],
        ),
      ),
    );
  }
}
