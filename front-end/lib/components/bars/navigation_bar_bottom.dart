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
  );
}

/*void _navigateTo(BuildContext context, int index) {
  // Get the current route
  String currentRoute = ModalRoute.of(context)!.settings.name ?? "";

  // Check if the current page is already the one corresponding to the selected index
  if ((index == 0 && currentRoute == MyShoppingLists.routeName) ||
      (index == 1 && currentRoute == SearchPage.routeName) ||
      (index == 2 && currentRoute == MyProfilePage.routeName)) {
    // Do nothing if already on the selected page
    return;
  }

  // Navigate to the selected page
  switch (index) {
    case 0:
      // Shopping Lists
      Navigator.pushReplacementNamed(context, MyShoppingLists.routeName);
      break;
    case 1:
      // Search Products
      Navigator.pushReplacementNamed(context, SearchPage.routeName);
      break;
    case 2:
      // My Profile
      Navigator.pushReplacementNamed(context, MyProfilePage.routeName);
      break;
  }
}
*/


// does not check if already on the page
// need to be changed
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
        MaterialPageRoute(builder: (context) => const SearchPage()),
      );
      break;
    case 2:
      // My Profile
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  MyProfilePage()),
      );
      break;
  }
}
