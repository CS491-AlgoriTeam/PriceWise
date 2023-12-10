import 'package:pwfe/models/Product.dart';

class ShoppingList {
  String shoppingListName;
  List<Product> products;

  ShoppingList({required this.shoppingListName, required this.products});

  int getAmount(String name) {
    int amount = 0;
    for (int i = 0; i < products.length; i++) {
      if (name == products[i].productName) {
        amount++;
      }
    }
    return amount;
  }
}
