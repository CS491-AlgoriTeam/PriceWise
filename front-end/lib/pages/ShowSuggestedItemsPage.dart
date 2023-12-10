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
        title: const Text('Suggested Items Page'),
      ),
      body: const Center(
        child: Text('Suggested Items Content'),
      ),
    );
  }
}
