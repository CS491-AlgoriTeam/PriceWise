import 'package:pwfe/classes/ShoppingList.dart';

class ShoppingListsData {
  final int userID;
  final ShoppingList shoppingList;

  ShoppingListsData({required this.userID, required this.shoppingList});

  int getUserID() {
    return userID;
  }

  ShoppingList getShoppingLists() {
    return shoppingList;
  }

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'shoppingLists': shoppingList,
    };
  }

  ShoppingListsData.fromMap(Map<String, dynamic> map)
      : userID = map['userID'],
        shoppingList = map['shoppingLists'];

  @override
  String toString() {
    return 'User{userID: $userID, shoppingLists: $shoppingList}';
  }
}
