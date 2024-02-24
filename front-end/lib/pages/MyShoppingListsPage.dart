// MyShoppingListsPage.dart
import 'package:flutter/material.dart';
import 'package:pwfe/components/bars/app_bar_top.dart';
import 'package:pwfe/components/bars/navigation_bar_bottom.dart';
import 'package:pwfe/components/buttons/button_blue_lighter_rounded.dart';
import 'package:pwfe/pages/AddShoppingListPage.dart';
import 'package:pwfe/pages/ShoppingListDetailsPage.dart';

class MyShoppingLists extends StatelessWidget {
  MyShoppingLists({Key? key}) : super(key: key);
  //UsersShoppingLists testingShoppingLists = UsersShoppingLists.instance;

  void _deleteList(BuildContext context, int index) {
    // Here you would call your method to delete the list from the data source
    // For example, if you have a method in your UsersShoppingLists class to remove a list by index
    //testingShoppingLists.removeShoppingList(index);

    // Then, refresh the UI by popping the current page off the navigation stack
    // and pushing it back on. There are more efficient ways to do this with state management solutions.
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyShoppingLists()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: app_bar_top(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              //itemCount: testingShoppingLists.getUsersShoppingListsSize(),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ShoppingListDetailsPage(index: index)),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.all(16),
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.lightBlue[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(Icons.shopping_cart, color: Colors.blue),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'testingShoppingLists.getShoppingList(index).shoppingListName',//modified check again on db
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.black),
                          onPressed: () {
                            // Handle edit button tap
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteList(context, index),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          button_blue_lighter_rounded(
              context, "addList", (p0) => const AddShoppingListPage()),
          navigation_bar_bottom(context),
        ],
      ),
    );
  }
}