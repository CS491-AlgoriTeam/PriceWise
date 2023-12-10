import 'package:pwfe/classes/ShoppingList.dart';

class UsersShoppingLists {
  List<ShoppingList> usersShoppingLists;

  UsersShoppingLists({
    required this.usersShoppingLists,
  });

  void addShoppingList(String name) {
    usersShoppingLists.add(ShoppingList(shoppingListName: name, products: []));
  }

  List<ShoppingList> getUsersShoppingLists() {
    return usersShoppingLists;
  }

  ShoppingList getShoppingList(int index) {
    return usersShoppingLists[index];
  }

  void addProductToShoppingList(int index, String name, double price) {
    usersShoppingLists[index].addProduct(name, price);
  }

  int getUsersShoppingListsSize() {
    return usersShoppingLists.length;
  }

  bool isReallyEmpty() {
    return usersShoppingLists.isEmpty;
  }
}


/*
Singleton version
class UsersShoppingLists {
  List<ShoppingList> usersShoppingLists;

  // Private constructor
  UsersShoppingLists._internal({required this.usersShoppingLists});

  // Singleton instance
  static final UsersShoppingLists _instance = UsersShoppingLists._internal(
    usersShoppingLists: [],
  );

  // Static method to access the instance
  static UsersShoppingLists get instance => _instance;

  void addShoppingList(String name) {
    usersShoppingLists.add(ShoppingList(shoppingListName: name, products: []));
  }

  List<ShoppingList> getUsersShoppingLists() {
    return usersShoppingLists;
  }

  ShoppingList getShoppingList(int index) {
    return usersShoppingLists[index];
  }

  void addProductToShoppingList(int index, String name, double price) {
    usersShoppingLists[index].addProduct(name, price);
  }

  int getUsersShoppingListsSize() {
    return usersShoppingLists.length;
  }

  bool isReallyEmpty() {
    return usersShoppingLists.isEmpty;
  }
}

 */