// shoppingLists.dart
import 'package:flutter/material.dart';
import 'package:pwfe/lists/my-shopping-lists.dart';
import 'package:pwfe/pages/EditShoppingListPage.dart';
import 'package:pwfe/pages/MyProfilePage.dart';
import 'package:pwfe/pages/SearchProductsPage.dart';
import 'package:pwfe/pages/ShoppingListDetailsPage.dart';

class MyShoppingLists extends StatelessWidget {
  const MyShoppingLists({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<TestData> testingData = [
      TestData(productName: "Amasya Elmasi", price: 0.18, amountNumber: 4),
      TestData(productName: "Tam yağli süt", price: 1.08, amountNumber: 2),
      TestData(productName: "cikolatali gofret", price: 0.30, amountNumber: 2),
      TestData(productName: "konserve misir", price: 2.22, amountNumber: 1),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Lists'),
      ),
      body: Column(
        children: testingData.map((testingData) {
          return Container(
            child: ListTile(
              title: Text(testingData.productName +
                  "\t" +
                  testingData.price.toString() +
                  "\t" +
                  testingData.amountNumber.toString()),
              //subtitle: Text("Price: \$${testingData.price.toString()}"),
            ),
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(5),
            color: Colors.green[100],
          );
        }).toList(),
      ),
    );
  }
}
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