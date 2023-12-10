// shoppingListDetails.dart
import 'package:flutter/material.dart';
import 'package:pwfe/pages/MyShoppingListsPage.dart';

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

List<ShoppingListItems> testingShoppingListItems1 = [
  ShoppingListItems(productName: "Amasya Elmasi", price: 0.18, amountNumber: 4),
  ShoppingListItems(productName: "Tam yağli süt", price: 1.08, amountNumber: 2),
  ShoppingListItems(
      productName: "cikolatali gofret", price: 0.30, amountNumber: 2),
  ShoppingListItems(
      productName: "konserve misir", price: 2.22, amountNumber: 1),
];

List<ShoppingListItems> testingShoppingListItems2 = [
  ShoppingListItems(
      productName: "list_2_product_1", price: 0.21, amountNumber: 1),
  ShoppingListItems(
      productName: "list_2_product_2", price: 0.22, amountNumber: 2),
  ShoppingListItems(
      productName: "list_2_product_3", price: 0.23, amountNumber: 3),
  ShoppingListItems(
      productName: "list_2_product_4", price: 0.24, amountNumber: 4),
];

List<ShoppingListItems> testingShoppingListItems3 = [
  ShoppingListItems(
      productName: "list_3_product_1", price: 0.31, amountNumber: 1),
  ShoppingListItems(
      productName: "list_3_product_2", price: 0.32, amountNumber: 2),
  ShoppingListItems(
      productName: "list_3_product_3", price: 0.33, amountNumber: 3),
  ShoppingListItems(
      productName: "list_3_product_4", price: 0.34, amountNumber: 4),
];

List<ShoppingListItems> testingShoppingListItems4 = [
  ShoppingListItems(
      productName: "list_4_product_1", price: 0.41, amountNumber: 1),
  ShoppingListItems(
      productName: "list_4_product_2", price: 0.42, amountNumber: 2),
  ShoppingListItems(
      productName: "list_4_product_3", price: 0.43, amountNumber: 3),
  ShoppingListItems(
      productName: "list_4_product_4", price: 0.44, amountNumber: 4),
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
            Text('Product: ${testingShoppingListItems1[index].productName}'),
            Text('Price: ${testingShoppingListItems1[index].price}'),
            Text('Amount: ${testingShoppingListItems1[index].amountNumber}'),
            // Add more details based on the selected item if needed
          ],
        ),
      ),
    );
  }
}
