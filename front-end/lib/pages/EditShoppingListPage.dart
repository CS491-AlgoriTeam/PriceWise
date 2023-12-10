import 'package:flutter/material.dart';

class EditShoppingList extends StatelessWidget {
  const EditShoppingList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Shopping List'),
      ),
      body: const Center(
        child: Text('Edit Shopping List content'),
      ),
    );
  }
}