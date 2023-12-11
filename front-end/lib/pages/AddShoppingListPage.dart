import 'package:flutter/material.dart';
import 'package:pwfe/classes/UsersShoppingLists.dart';
import 'package:pwfe/components/bars/app_bar_top.dart';
import 'package:pwfe/components/bars/navigation_bar_bottom.dart';
import 'package:pwfe/components/buttons/button_blue_lighter_rounded.dart';
import 'package:pwfe/components/text-form-fields/text_form_field_blue_darker.dart';
import 'package:pwfe/pages/MyShoppingListsPage.dart';

class AddShoppingListPage extends StatefulWidget {
  const AddShoppingListPage({Key? key}) : super(key: key);

  @override
  State<AddShoppingListPage> createState() => _AddShoppingListPageState();
}

class _AddShoppingListPageState extends State<AddShoppingListPage> {
  final addShoppingListController = TextEditingController();
  UsersShoppingLists theShoppingList = UsersShoppingLists.instance;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    addShoppingListController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Shopping List'),
      ),
      body: Column(
        children: [
          TextField(
            controller: addShoppingListController,
            decoration: InputDecoration(labelText: 'Shopping List Name'),
          ),
          // Add more widgets here as needed
        ],
      ),
      // Use a ButtonBar to contain the ElevatedButton
      bottomNavigationBar: ButtonBar(
        alignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              // Show the dialog
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    // Retrieve the text that the user has entered by using the
                    // TextEditingController.
                    content: Text(addShoppingListController.text),
                  );
                },
              );

              // Add the shopping list
              theShoppingList.addShoppingList(addShoppingListController.text);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyShoppingLists()));
            },
            child: Text('Add Shopping List'),
          ),
        ],
      ),
    );
  }
}
