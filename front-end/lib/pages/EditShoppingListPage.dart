import 'package:flutter/material.dart';

class EditShoppingListPage extends StatelessWidget {
  const EditShoppingListPage({super.key});

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