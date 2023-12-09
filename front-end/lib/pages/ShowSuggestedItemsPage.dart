import 'package:flutter/material.dart';

class SuggestedItems extends StatefulWidget {
  const SuggestedItems({super.key});

  @override
  State<SuggestedItems> createState() => _SuggestedItemsState();
}

class _SuggestedItemsState extends State<SuggestedItems> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Suggested Items Page'),
      ),
      body: Center(
        child: Text('Suggested Items Content'),
      ),
    );
  }
}
