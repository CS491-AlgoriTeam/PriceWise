// shoppingListDetails.dart
import 'package:flutter/material.dart';
import 'package:pwfe/components/buttton_blue_darker_rounded.dart';
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
          child: buttton_blue_darker_rounded(
            context,
            'Go to Page 2',
            (context) => SignUpPage(),
          ),
        ));
  }
}
