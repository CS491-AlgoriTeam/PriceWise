import 'package:pwfe/classes/ShoppingLists.dart';

class UsersShoppingListsList {
  List<ShoppingList> usersShoppingListsList;

  UsersShoppingListsList({required this.usersShoppingListsList});

  int getNumberOfShoppingLists(String name) {
    return usersShoppingListsList.length;
  }

  void addShoppingList(ShoppingList shoppingListName) {
    // add shopping list logic
  }
}
