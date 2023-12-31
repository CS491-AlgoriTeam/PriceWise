// MyShoppingListsPage.dart
import 'package:flutter/material.dart';
import 'package:pwfe/classes/UsersShoppingLists.dart';
import 'package:pwfe/components/bars/app_bar_top.dart';
import 'package:pwfe/components/bars/navigation_bar_bottom.dart';
import 'package:pwfe/components/buttons/button_blue_lighter_rounded.dart';
import 'package:pwfe/pages/AddShoppingListPage.dart';
import 'package:pwfe/pages/ShoppingListDetailsPage.dart';

class MyShoppingLists extends StatelessWidget {
  MyShoppingLists({Key? key}) : super(key: key);
  UsersShoppingLists testingShoppingLists = UsersShoppingLists.instance;

  void _deleteList(BuildContext context, int index) {
    // Here you would call your method to delete the list from the data source
    // For example, if you have a method in your UsersShoppingLists class to remove a list by index
    testingShoppingLists.removeShoppingList(index);

    // Then, refresh the UI by popping the current page off the navigation stack
    // and pushing it back on. There are more efficient ways to do this with state management solutions.
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyShoppingLists()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: app_bar_top(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: testingShoppingLists.getUsersShoppingListsSize(),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ShoppingListDetailsPage(index: index)),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.all(16),
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.lightBlue[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(Icons.shopping_cart, color: Colors.blue),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            testingShoppingLists.getShoppingList(index).shoppingListName,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.black),
                          onPressed: () {
                            // Handle edit button tap
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteList(context, index),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          button_blue_lighter_rounded(
              context, "addList", (p0) => const AddShoppingListPage()),
          navigation_bar_bottom(context),
        ],
      ),
    );
  }
}

/*import 'package:flutter/material.dart';
import 'package:pwfe/classes/UsersShoppingLists.dart';
import 'package:pwfe/components/bars/app_bar_top.dart';
import 'package:pwfe/components/bars/navigation_bar_bottom.dart';
import 'package:pwfe/components/buttons/button_blue_lighter_rounded.dart';
import 'package:pwfe/pages/AddShoppingListPage.dart';
import 'package:pwfe/pages/ShoppingListDetailsPage.dart';

class MyShoppingLists extends StatelessWidget {
  MyShoppingLists({Key? key}) : super(key: key);
  UsersShoppingLists testingShoppingLists = UsersShoppingLists.instance;
  int index = 0;
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: app_bar_top(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: testingShoppingLists.getUsersShoppingListsSize(),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    // Handle onTap for the selected shopping list
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ShoppingListDetailsPage(index: index)));
                    print(
                        "Tapped on ${testingShoppingLists.getShoppingList(index).shoppingListName}");
                    // this print is for testing purposes
                    print(testingShoppingLists.isReallyEmpty());
                  },
                  child: Container(
                    margin: EdgeInsets.all(16),
                    height: 70, // Adjust height as needed
                    decoration: BoxDecoration(
                      color: Colors.lightBlue[100], // Background color
                      borderRadius: BorderRadius.circular(12), // Border radius
                      // Add more decoration as needed
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16),
                        //  child: Icon(Icons.shopping_cart, color: Colors.blue), // Replace with your icon
                        child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.shopping_cart, color: Colors.blue),
                        ),
                        
                      ),
                        Text(
                          testingShoppingLists.getShoppingList(index).shoppingListName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.black, // Font color
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.black), // Replace with your icon
                          onPressed: () {
                            // Handle edit button tap
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20), // Adjust the height as needed
          button_blue_lighter_rounded(
              context, "addList", (p0) => const AddShoppingListPage()),
          navigation_bar_bottom(context),
        ],
      ),
    );
  }
}*/
  /*@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: app_bar_top(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: testingShoppingLists.getUsersShoppingListsSize(),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    // Handle onTap for the selected shopping list
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ShoppingListDetailsPage(index: index)));
                    print(
                        "Tapped on ${testingShoppingLists.getShoppingList(index).shoppingListName}");
                    // this print is for testing purposes
                    print(testingShoppingLists.isReallyEmpty());
                  },
                  child: SizedBox(
                    height: 50,
                    child: Center(
                      child: Text(
                        (' ${testingShoppingLists.getShoppingList(index).shoppingListName}'),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          button_blue_lighter_rounded(
              context, "addList", (p0) => const AddShoppingListPage()),
          navigation_bar_bottom(context),
        ],
      ),
    );
  }
}
last cahanges
*/

/*return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Lists'),
      ),
      body: Column(
        children: testingShoppingLists.asMap().entries.map((entry) {
          int index = entry.key;

          return GestureDetector(
            onTap: () {
              // Add your item click logic here
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShoppingListDetailsPage(index: index),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(5),
              color: Colors.green[100],
              child: ListTile(
                title: Text(shoppingList.shoppingListName),
              ),
            ),
          );
        }).toList(),
      ),
      bottomNavigationBar: navigation_bar_bottom(context),
    );
  }}*/

/*
  old version commented out for improvements 
class MyShoppingLists extends StatefulWidget {
  @override
  _ShoppingListsScreenState createState() => _ShoppingListsScreenState();
}

class _ShoppingListsScreenState extends State<MyShoppingLists> {
  int _currentIndex = 0;
  
  
 /*
 // testing  
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
  */

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
          title: Text(),
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
        // Search Products
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

*/
