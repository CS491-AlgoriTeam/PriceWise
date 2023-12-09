import 'package:flutter/material.dart';
import 'package:pwfe/pages/ShowSuggestedItemsPage.dart';

class ShowSuggestions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Show Suggestions'),
      ),
      body: ListView.builder(
        itemCount: 10, // Set the number of items in your list
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text('Item $index'),
            onTap: () {
              // Add your item click logic here
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SuggestedItems()));
            },
          );
        },
      ),
    );
  }
}
