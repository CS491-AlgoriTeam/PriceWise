import 'package:flutter/material.dart';
import 'package:pwfe/pages/MyProfilePage.dart';
import 'package:pwfe/pages/MyShoppingListsPage.dart';
import 'package:pwfe/pages/SearchProductsPage.dart';

BottomNavigationBar navigation_bar_bottom(BuildContext context) {
  return BottomNavigationBar(
    onTap: (int index) {
      // handle navigate to
      _navigateTo(context, index);
    },
    items: const [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Main Page',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.explore),
        label: 'Explore',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: 'Profile',
      ),
    ],
    unselectedItemColor: Colors.grey[850],  // Dark grey for unselected items
    selectedItemColor: Colors.grey[850],    // Dark grey for the selected item
    unselectedLabelStyle: TextStyle(color: Colors.grey[850]),  // Style for labels
    selectedLabelStyle: TextStyle(color: Colors.grey[850]),
  );
}

void _navigateTo(BuildContext context, int index) {
  switch (index) {
    case 0:
      // Shopping Lists
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyShoppingLists()),
      );
      break;
    case 1:
      // Search Products
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SearchPage(selectedListId: "")),
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

BottomNavigationBar navigation_bar_bottom2(BuildContext context, String selectedListId, Function(String) onExploreSelected) {
  return BottomNavigationBar(
    onTap: (int index) {
      if (index == 1) {
        onExploreSelected(selectedListId); // Use the callback for the Explore item
      } else {
        _navigateTo(context, index);
      }
    },
    items: const [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Main Page',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.explore),
        label: 'Explore',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: 'Profile',
      ),
    ],
    unselectedItemColor: Colors.grey[850],
    selectedItemColor: Colors.grey[850],
  );
}

void _navigateTo2(BuildContext context, int index) {
  switch (index) {
    case 0:
      Navigator.push(context, MaterialPageRoute(builder: (context) => MyShoppingLists()));
      break;
    case 2:
      Navigator.push(context, MaterialPageRoute(builder: (context) => MyProfilePage()));
      break;
  }
}