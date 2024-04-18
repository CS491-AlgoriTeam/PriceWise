import 'package:flutter/material.dart';
import 'package:pwfe/components/bars/navigation_bar_bottom.dart';
import 'package:pwfe/pages/ShowSuggestedItemsPage.dart';


class ShowSuggestedListsPage extends StatelessWidget {
  const ShowSuggestedListsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data for suggested lists
    final List<Map<String, dynamic>> suggestedLists = [
      {"name": "Migros + A101", "price": "16.57\$", "icon": Icons.shopping_cart, "color": Colors.red},
      {"name": "Migros + BIM", "price": "17.82\$", "icon": Icons.local_grocery_store, "color": Colors.green},
      {"name": "A101 + BIM", "price": "19.82\$", "icon": Icons.local_grocery_store, "color": Colors.blue},
      {"name": "Migros", "price": "20.12\$", "icon": Icons.local_grocery_store, "color": Colors.yellow},

      // Add more items here
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Suggested Lists'),
      ),
      body: ListView.builder(
        itemCount: suggestedLists.length,
        itemBuilder: (BuildContext context, int index) {
          final item = suggestedLists[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
            color: Colors.lightBlue[100],
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: item["color"],
                child: Icon(item["icon"], color: Colors.white),
              ),
              title: Text(item["name"]),
              subtitle: Text(item["price"]),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
              // Add your item click logic here
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SuggestedItems()));
            },
            ),
          );
        },
      ),
      bottomNavigationBar: navigation_bar_bottom(context),
    );
  }
}

/*import 'package:flutter/material.dart';
import 'package:pwfe/pages/ShowSuggestedItemsPage.dart';

class ShowSuggestedListsPage extends StatelessWidget {
  const ShowSuggestedListsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Show Suggestions'),
      ),
      body: ListView.builder(
        itemCount: 10, // Set the number of items in your list
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text('Item $index'),
            onTap: () {
              // Add your item click logic here
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SuggestedItems()));
            },
          );
        },
      ),
    );
  }
}
*/