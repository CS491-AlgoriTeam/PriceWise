// shoppingLists.dart
import 'package:flutter/material.dart';
import 'package:pwfe/pages/EditShoppingListPage.dart';
import 'package:pwfe/pages/MyProfilePage.dart';
import 'package:pwfe/pages/SearchProductsPage.dart';
import 'package:pwfe/pages/ShoppingListDetailsPage.dart';

class ShoppingLists extends StatefulWidget {
  @override
  _ShoppingListsScreenState createState() => _ShoppingListsScreenState();
}

class _ShoppingListsScreenState extends State<ShoppingLists> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PriceWise'),
        backgroundColor: Colors.lightBlue,
      ),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          _navigateTo(index);
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Shopping Lists',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'My Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'My Shopping Lists',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return _buildShoppingListItem(index);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildShoppingListItem(int index) {
    return GestureDetector(
      onTap: () {
        _navigateToItemDetails(index);
      },
      child: Container(
        color: Colors.amber,
        child: ListTile(
          title: Text('Item ${index + 1}'),
          trailing: IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // Handle edit button tap for the specific item
              _editShoppingListItem(index);
            },
          ),
        ),
      ),
    );
  }

  void _navigateToItemDetails(int index) {
    // Implement navigation logic to the details page for the specific item
    // For example:
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ShoppingListDetailsPage(itemIndex: index)),
    );
    print('ShoppingList Item ${index + 1}');
  }

  void _editShoppingListItem(int index) {
    // Implement logic to handle editing the specific shopping list item
    // You can navigate to a new page for editing or show a dialog, etc.
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => EditShoppingList()));
    print('Edit Item ${index + 1}');
  }

  void _navigateTo(int index) {
    switch (index) {
      case 0:
        // Shopping Lists
        // No need to navigate if already on the Shopping Lists page
        break;
      case 1:
        // Search
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SearchPage()),
        );
        break;
      case 2:
        // My Profile
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyProfilePage()),
        );
        break;
    }
  }
}
