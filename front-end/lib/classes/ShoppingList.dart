import 'package:pwfe/classes/Product.dart';

class ShoppingList {
  String shoppingListName;
  List<Product> products;

  ShoppingList({required this.shoppingListName, required this.products});

  String getShoppingListName() {
    return shoppingListName;
  }

  List<Product> getProducts() {
    return products;
  }

  Product getProductAtIndex(int index) {
    return products[index];
  }

  int getAmount(String name) {
    int amount = 0;
    for (int i = 0; i < products.length; i++) {
      if (name == products[i].productName) {
        amount++;
      }
    }
    return amount;
  }

  void addProduct(String name, double price) {
    products.add(Product(productName: name, productPrice: price));
  }

  double getShoppingListPrice() {
    double productsPrice = 0;
    for (int i = 0; i < products.length; i++) {
      productsPrice += products[i].getProductPrice();
    }
    return productsPrice;
  }
}
  /*Product addProduct(String productName, double productPrice) {
    Product newProduct =
        Product(productName: productName, productPrice: productPrice);
    products.add(newProduct);
    return newProduct;
  }*/
  /*void removeProduct(String productName) {
    products.remove(productName);
  }*/

// if we need the class
  /*import 'package:pwfe/classes/ShoppingList.dart';

class UsersShoppingListsList {
  List<ShoppingList> usersShoppingListsList;

  UsersShoppingListsList({required this.usersShoppingListsList});

  int getNumberOfShoppingLists(String name) {
    return usersShoppingListsList.length;
  }

  void addShoppingList(ShoppingList shoppingListName) {
    // add shopping list logic
  }
}*/

