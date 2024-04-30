/*import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pwfe/components/bars/app_bar_top.dart';
import 'package:pwfe/components/bars/navigation_bar_bottom.dart';
import 'package:pwfe/components/buttons/button_blue_lighter_rounded.dart';
import 'package:pwfe/pages/AddShoppingListPage.dart';
import 'package:pwfe/pages/ShoppingListDetailsPage.dart';

class MyShoppingLists extends StatefulWidget {
  MyShoppingLists({Key? key}) : super(key: key);

  @override
  _MyShoppingListsState createState() => _MyShoppingListsState();
}

class _MyShoppingListsState extends State<MyShoppingLists> {
  final User? user = FirebaseAuth.instance.currentUser;
  List<DocumentSnapshot> _shoppingLists = [];

  void _deleteList(BuildContext context, String docId) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return;

  try {
    // Step 1: Fetch the list to be deleted
    DocumentSnapshot docSnapshot = await FirebaseFirestore.instance.collection('shoppingLists').doc(docId).get();
    Map<String, dynamic> listData = docSnapshot.data() as Map<String, dynamic>;

    // Step 2: Add the list to 'deletedShoppingLists' with 'deletedAt'
    await FirebaseFirestore.instance.collection('deletedShoppingLists').add({
      ...listData,
      'deletedAt': FieldValue.serverTimestamp(), // Add current timestamp
      'userId': user.uid, // Ensure user ID is included
    });

    // Step 3: Check and maintain only the 5 most recent deletions
    final QuerySnapshot deletedListsSnapshot = await FirebaseFirestore.instance
        .collection('deletedShoppingLists')
        .where('userId', isEqualTo: user.uid)
        .orderBy('deletedAt', descending: true)
        .get();

    if (deletedListsSnapshot.docs.length > 5) {
      // If more than 5, delete the oldest
      await FirebaseFirestore.instance.collection('deletedShoppingLists').doc(deletedListsSnapshot.docs.last.id).delete();
    }

    // Step 4: Delete the list from the original collection
    await FirebaseFirestore.instance.collection('shoppingLists').doc(docId).delete();
    if (user != null) {
        _fetchShoppingLists();
      }

    print("Shopping List Deleted and backup created");
    
    // Optionally, refresh the list of shopping lists
    //_fetchShoppingLists(); // Call your method to refresh shopping lists if exists
  } catch (e) {
    print("Error handling shopping list deletion: $e");
  }
}

  
  @override
  void initState() {
    super.initState();
    if (user != null) {
      _fetchShoppingLists();
    }
  }

  void _fetchShoppingLists() async {
    final String uid = user!.uid;
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('shoppingLists')
        .where('userId', isEqualTo: uid)
        .orderBy('createdAt', descending: true)
        .get();

    setState(() {
      _shoppingLists = result.docs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: app_bar_top(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _shoppingLists.length,
              itemBuilder: (BuildContext context, int index) {
                final doc = _shoppingLists[index].data() as Map<String, dynamic>;
                return GestureDetector(
                  onTap: () {
                    String docId = _shoppingLists[index].id;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShoppingListDetailsPage(listId: docId),
                      ),
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
                            // Use IconData for the icon if possible
                            child: Icon(Icons.list, color: Colors.blue),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            doc['listName'],
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
                          onPressed: () {
                            // Retrieve the document ID of the shopping list to be deleted
                            String docId = _shoppingLists[index].id;
                            // Call _deleteList with the document ID
                            _deleteList(context, docId);
                          },
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
}*/

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:pwfe/pages/AddShoppingListPage.dart';
import 'package:pwfe/pages/ShoppingListDetailsPage.dart';
import 'package:pwfe/components/bars/navigation_bar_bottom.dart';
import 'package:pwfe/pages/ShowItem.dart';

class MyShoppingLists extends StatefulWidget {
  MyShoppingLists({Key? key}) : super(key: key);

  @override
  _MyShoppingListsState createState() => _MyShoppingListsState();
}

class _MyShoppingListsState extends State<MyShoppingLists> {
  final User? user = FirebaseAuth.instance.currentUser;
  List<DocumentSnapshot> _shoppingLists = [];
  final TextEditingController _searchController = TextEditingController(); // Controller for search field

  // Example data for "sales" and "recipes", replace with your actual data source
  List<Map<String, String>> salesItems = [
    {'name': 'Item 1', 'price': '9.99', 'photo': 'assets/logo.png'},
    {'name': 'Item 2', 'price': '9.99', 'photo': 'assets/logo.png'},
    {'name': 'Item 3', 'price': '9.99', 'photo': 'assets/logo.png'},
    {'name': 'Item 4', 'price': '9.99', 'photo': 'assets/logo.png'},
    // Add more items...
  ];

  List<Map<String, String>> recipeItems = [
    {'name': 'Recipe 1', 'photo': 'assets/logo.png'},
    {'name': 'Recipe 2', 'photo': 'assets/logo.png'},
    {'name': 'Recipe 3', 'photo': 'assets/logo.png'},
    // Add more recipes...
  ];

  // Implement initState, _fetchShoppingLists, and _deleteList methods as before
  @override
  void initState() {
    super.initState();
    if (user != null) {
      _fetchShoppingLists();
    }
  }

  void _fetchShoppingLists() async {
    final String uid = user!.uid;
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('shoppingLists')
        .where('userId', isEqualTo: uid)
        .orderBy('createdAt', descending: true)
        .get();

    setState(() {
      _shoppingLists = result.docs;
    });
  }

  void _deleteList(BuildContext context, String docId) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      // Step 1: Fetch the list to be deleted
      DocumentSnapshot docSnapshot = await FirebaseFirestore.instance.collection('shoppingLists').doc(docId).get();
      Map<String, dynamic> listData = docSnapshot.data() as Map<String, dynamic>;

      // Step 2: Add the list to 'deletedShoppingLists' with 'deletedAt'
      await FirebaseFirestore.instance.collection('deletedShoppingLists').add({
        ...listData,
        'deletedAt': FieldValue.serverTimestamp(), // Add current timestamp
        'userId': user.uid, // Ensure user ID is included
      });

      // Step 3: Check and maintain only the 5 most recent deletions
      final QuerySnapshot deletedListsSnapshot = await FirebaseFirestore.instance
          .collection('deletedShoppingLists')
          .where('userId', isEqualTo: user.uid)
          .orderBy('deletedAt', descending: true)
          .get();

      if (deletedListsSnapshot.docs.length > 5) {
        // If more than 5, delete the oldest
        await FirebaseFirestore.instance.collection('deletedShoppingLists').doc(deletedListsSnapshot.docs.last.id).delete();
      }

      // Step 4: Delete the list from the original collection
      await FirebaseFirestore.instance.collection('shoppingLists').doc(docId).delete();
      if (user != null) {
          _fetchShoppingLists();
        }

      print("Shopping List Deleted and backup created");
      
      // Optionally, refresh the list of shopping lists
      //_fetchShoppingLists(); // Call your method to refresh shopping lists if exists
    } catch (e) {
      print("Error handling shopping list deletion: $e");
    }
  }
  // Build item card for carousel
  /*Widget buildItemCardSales(Map<String, String> item) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.60, // This is 80% of screen width
      height: 200, // Example height, adjust as necessary
      child: Card(
        child: Column(
          children: <Widget>[
            Image.asset(item['photo']!),
            Text(item['name']!),
            if (item.containsKey('price')) Text(item['price']!),
          ],
        ),
      ),
    );
  }*/
  Widget buildItemCardSales(Map<String, String> item) {
    return GestureDetector(
      /*onTap: () {
        // Navigate to the ItemDetailsPage
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ItemDetailsPage(item: item)),
        );
      },*/
      child: Container(
        width: MediaQuery.of(context).size.width * 0.60, // This is 80% of screen width
        height: 200, // Example height, adjust as necessary
        child: Card(
          child: Column(
            children: <Widget>[
              Image.asset(item['photo']!),
              Text(item['name']!),
              if (item.containsKey('price')) Text(item['price']!),
            ],
          ),
        ),
      ),
    );
  }
   // Build item card for carousel
  Widget buildItemCardRecipe(Map<String, String> item) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.3, // This is 80% of screen width
      height: 100, // Example height, adjust as necessary
      child: Card(
        child: Column(
          children: <Widget>[
            Image.asset(item['photo']!),
            Text(item['name']!),
            if (item.containsKey('price')) Text(item['price']!),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PriceWise'),
        elevation: 0, // Remove shadow if desired
        automaticallyImplyLeading: false, // This will hide the back button
      ),
      body: SingleChildScrollView( // Wrap with SingleChildScrollView for proper scrolling
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.lightBlue[100],
                  borderRadius: BorderRadius.circular(32), // Rounded corners
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search for items',
                    border: InputBorder.none, // Remove underline
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Adjust field padding
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        // Implement search functionality based on _searchController.text
                      },
                    ),
                  ),
                  onSubmitted: (value) {
                    // Implement what should happen when the user submits their search query
                  },
                ),
              ),
            ),

            // Padding and title for sales
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '   Sales',
                  style: TextStyle(
                    color: Colors.black, // Change to your desired color
                    fontWeight: FontWeight.bold, // Makes the text bold
                    fontSize: 24, // Adjust the font size as needed
                  ),
                ),
              ),
            ),

            // Sales carousel with custom box dimensions
            CarouselSlider.builder(
              itemCount: salesItems.length,
              itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                  buildItemCardSales(salesItems[itemIndex]),
              options: CarouselOptions(
                enlargeCenterPage: true,
                viewportFraction: 0.40,
                aspectRatio: 2.0, // Change this value to adjust width/height ratio
                initialPage: 2,
                autoPlay: false,
              ),
            ),

            // Recipes section with background
            Container(
              margin: const EdgeInsets.all(10), // Outer margin for the entire Recipes section
              decoration: BoxDecoration(
                color: Colors.blue[50], // Light orange color for the background
                borderRadius: BorderRadius.circular(20), // Rounded corners
              ),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0), // Padding for the title inside the container
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Recipes',
                        style: TextStyle(
                          color: Colors.black, // Custom color for the title
                          fontWeight: FontWeight.bold, // Bold text
                          fontSize: 24, // Custom font size
                        ),
                      ),
                    ),
                  ),
                  CarouselSlider.builder(
                    itemCount: recipeItems.length,
                    itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                        buildItemCardRecipe(recipeItems[itemIndex]),
                    options: CarouselOptions(
                      enlargeCenterPage: false,
                      viewportFraction: 0.25,
                      aspectRatio: 3.0, // Adjust width/height ratio
                      initialPage: 2,
                      autoPlay: false,
                    ),
                  ),
                ],
              ),
            ),

            // My Lists section with background
            Container(
              margin: const EdgeInsets.all(8), // Outer margin for the entire My Lists section
              decoration: BoxDecoration(
                color: Colors.blue[100], // Light orange color for the background
                borderRadius: BorderRadius.circular(20), // Rounded corners
              ),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0), // Padding for the title inside the container
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'My Lists',
                        style: TextStyle(
                          color: Colors.black, // Custom color for the title
                          fontWeight: FontWeight.bold, // Bold text
                          fontSize: 24, // Custom font size
                        ),
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(), // Disable ListView's scrolling
                    itemCount: _shoppingLists.length,
                    itemBuilder: (BuildContext context, int index) {
                      final doc = _shoppingLists[index].data() as Map<String, dynamic>;
                      return GestureDetector(
                        onTap: () {
                          String docId = _shoppingLists[index].id;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShoppingListDetailsPage(listId: docId),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Margin for each list item
                          height: 70,
                          decoration: BoxDecoration(
                            color: Colors.lightBlue[200],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(16),
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Icon(Icons.list, color: Colors.blue),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  doc['listName'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.black),
                                onPressed: () {
                                  // Handle edit button tap
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  String docId = _shoppingLists[index].id;
                                  _deleteList(context, docId);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddShoppingListPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: navigation_bar_bottom(context),
    );
  }
}
