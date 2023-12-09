// shoppingListDetails.dart
import 'package:flutter/material.dart';
import 'package:pwfe/main.dart';
import 'package:pwfe/components/button_helper.dart';
import 'package:pwfe/pages/ShowSuggestedListsPage.dart';
import 'package:pwfe/pages/SignupPage.dart';

class ShoppingListDetailsPage extends StatelessWidget {
  final int itemIndex;

  ShoppingListDetailsPage({required this.itemIndex});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('shoppingListDetails'),
        ),
        body: Center(
          child: xdButton(
            context,
            'Go to Page 2',
            (context) => SignUpPage(),
          ),
        ));
  }
}
