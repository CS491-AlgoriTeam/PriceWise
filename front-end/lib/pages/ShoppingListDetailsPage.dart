// shoppingListDetails.dart
import 'package:flutter/material.dart';
import 'package:pwfe/pages/ShowSuggestedListsPage.dart';

class ShoppingListDetailsPage extends StatelessWidget {
  final int itemIndex;

  ShoppingListDetailsPage({required this.itemIndex});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('shoppingListDetails'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('shoppingListDetails Content'),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ShowSuggestions()), // Use the class name of your sign-in page
                );
              },
              child: Text('Show Suggestions'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlue,
                foregroundColor: Colors.white,
                minimumSize: Size(330, 54),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(47),
                ),
                padding: EdgeInsets.symmetric(vertical: 10),
                textStyle: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ));
  }
}
