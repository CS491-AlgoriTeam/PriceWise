import 'package:flutter/material.dart';

class MyHistoryPage extends StatelessWidget {
  const MyHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyHistoryPage'),
      ),
      body: const Center(
        child: Text('MyHistoryPage Content'),
      ),
    );
  }
}
