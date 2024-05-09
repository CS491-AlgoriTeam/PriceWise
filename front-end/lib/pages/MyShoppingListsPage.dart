import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:pwfe/pages/AddShoppingListPage.dart';
import 'package:pwfe/pages/RecipeDetailsPage.dart';
import 'package:pwfe/pages/ShoppingListDetailsPage.dart';
import 'package:pwfe/components/bars/navigation_bar_bottom.dart';
import 'package:pwfe/pages/ShowItem.dart';
import 'package:pwfe/pages/SearchProductsPage.dart';
import 'package:pwfe/components/globals/globals.dart' as globals;

class MyShoppingLists extends StatefulWidget {
  MyShoppingLists({Key? key}) : super(key: key);

  @override
  _MyShoppingListsState createState() => _MyShoppingListsState();
}

class _MyShoppingListsState extends State<MyShoppingLists> {
  final User? user = FirebaseAuth.instance.currentUser;
  List<DocumentSnapshot> _shoppingLists = [];
  List<DocumentSnapshot> _salesItems = []; // List to store sales items
  List<DocumentSnapshot> _recipeItems = [];
  final TextEditingController _searchController =
      TextEditingController(); // Controller for search field

  bool _areSalesLoading = true;
  bool _areListsLoading  = true;
  bool _areRecipesLoading  = true;

  // Implement initState, _fetchShoppingLists, and _deleteList
  @override
  void initState() {
    super.initState();
    if (user != null) {
      _fetchShoppingLists();
      _fetchSalesItems();
      _fetchRecipeItems();

    }
  }
  void _fetchRecipeItems() async {
    FirebaseFirestore.instance
      .collection('recipes')
      .get()
      .then((result) {
        setState(() {
          _recipeItems = result.docs;
          _areRecipesLoading = false;

        });
      });
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
      _areListsLoading= false;

    });
  }
  
  void _deleteList(BuildContext context, String docId) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return;

  try {
    // Step 1: Fetch the list to be deleted
    DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
        .collection('shoppingLists')
        .doc(docId)
        .get();

    if (!docSnapshot.exists) {
      print("List not found!");
      return;
    }

    Map<String, dynamic> listData = docSnapshot.data() as Map<String, dynamic>;

    // Fetch the items under this list
    QuerySnapshot itemsSnapshot = await FirebaseFirestore.instance
        .collection('shoppingLists/$docId/items')
        .get();

    List<Map<String, dynamic>> items = itemsSnapshot.docs.map((doc) => {
      'name': doc['name'],
      'price': doc['price'],
      'amount': doc['amount'],
      'main_category': doc['main_category'],
      'sub_category': doc['sub_category'],
      'sub_category2': doc['sub_category2']
    }).toList();

    // Ensure 'listName' and 'userId' are included
    String listName = listData['listName'] ?? 'Default List Name';
    String userId = user.uid; // or listData['userId'] if it's already included in the list data

    // Step 2: Add the list along with its items to 'deletedShoppingLists'
    DocumentReference deletedRef = await FirebaseFirestore.instance.collection('deletedShoppingLists').add({
      ...listData,
      'listName': listName,  // Make sure to include the list name
      'userId': userId,      // Include user ID explicitly
      'deletedAt': FieldValue.serverTimestamp(), // Add current timestamp
      'items': items, // Include the copied items
    });

    // Step 3: Check and maintain only the 5 most recent deletions
    final QuerySnapshot deletedListsSnapshot = await FirebaseFirestore
        .instance
        .collection('deletedShoppingLists')
        .where('userId', isEqualTo: userId)
        .orderBy('deletedAt', descending: true)
        .get();

    if (deletedListsSnapshot.docs.length > 5) {
      // If more than 5, delete the oldest
      await FirebaseFirestore.instance
          .collection('deletedShoppingLists')
          .doc(deletedListsSnapshot.docs.last.id)
          .delete();
    }

    // Step 4: Delete the original list and its items
    await FirebaseFirestore.instance
        .collection('shoppingLists')
        .doc(docId)
        .collection('items')
        .get()
        .then((snapshot) {
          for (DocumentSnapshot ds in snapshot.docs) {
            ds.reference.delete();
          }
        });
    await FirebaseFirestore.instance
        .collection('shoppingLists')
        .doc(docId)
        .delete();

    print("Shopping List Deleted and backup created");
    _fetchShoppingLists();

  } catch (e) {
    print("Error handling shopping list deletion: $e");
  }
}


  void _fetchSalesItems() async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('saleProducts')
        .get();

    setState(() {
      _salesItems = result.docs;
      _areSalesLoading = false;

    });
  }

Widget buildItemCardSales(DocumentSnapshot item) {
    String main = item['main_category'];
    String sub = item['sub_category'];
    String sub2 = item['sub_category2'];
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ItemDetailsPage(productData: item, mainCategory: main, subCategory: sub, subcategory2Name: sub2, selectedListId: globals.selectedList),
            ),
          );
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.60, // 60% of screen width
        // Increase the height or make it dynamic based on the content

        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Adjust space distribution
            children: <Widget>[
              Expanded(
                child: Image.network(
                  item['product_image_url'] ?? 'assets/logo.png',
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 4), // Add padding
                child: Text(
                  '${item['bs_price']}₺ before sale',
                  style: TextStyle(color: Colors.black,fontSize: 16), // Adjust font size
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 4), // Add padding
                child: Text(
                  '${item['product_cheapest_price']}₺ now',
                  style: TextStyle(color: Colors.blue,fontSize: 20), // Adjust font size
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget buildItemCardRecipe(DocumentSnapshot recipe) {
    String recipeName = recipe.id; // Assuming the document ID is the recipe name
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeDetailsPage(recipeName: recipeName),
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.3, // Adjust width as needed
        child: Card(
          child: Column(
            children: <Widget>[
              Image.asset('assets/${recipeName}.jpeg', fit: BoxFit.cover),
              Text(recipeName, style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PriceWise'),
        elevation: 0, // Remove shadow if desired
        automaticallyImplyLeading: false, // This will hide the back button
      ),
      body:  _areSalesLoading || _areListsLoading || _areRecipesLoading // Show Loading Screen
          ? Center(
              child: CircularProgressIndicator(),
            )
          :SingleChildScrollView(
        // Wrap with SingleChildScrollView for proper scrolling
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
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10), // Adjust field padding
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        // Implement search functionality based on _searchController.text
                      },
                    ),
                  ),
                  onSubmitted: (value) {
                    // Implement what should happen when the user submits their search query mb
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
              itemCount: _salesItems.length,
              itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                  buildItemCardSales(_salesItems[itemIndex]),
              options: CarouselOptions(
                enlargeCenterPage: true,
                viewportFraction: 0.40,
                aspectRatio: 2.0,
                autoPlay: true,
              ),
            ),

            // Recipes section with background
            Container(
              margin: const EdgeInsets.all(
                  10), // Outer margin for the entire Recipes section
              decoration: BoxDecoration(
                color: Colors.blue[50], // Light orange color for the background
                borderRadius: BorderRadius.circular(20), // Rounded corners
              ),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(
                        8.0), // Padding for the title inside the container
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
                    itemCount: _recipeItems.length,
                    itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                        buildItemCardRecipe(_recipeItems[itemIndex]),

                    options: CarouselOptions(
                      enlargeCenterPage: false,
                      viewportFraction: 0.25,
                      aspectRatio: 3.3, // Adjust width/height ratio
                      initialPage: 2,
                      autoPlay: false,
                    ),
                  ),
                ],
              ),
            ),
            // My Lists section with background
                  // My Lists section with adjusted title row
                  Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'My Lists',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
                              FloatingActionButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const AddShoppingListPage(),
                                    ),
                                  );
                                },
                                child: Icon(Icons.add),
                                backgroundColor: Colors.blue,
                                mini: true,  // Use mini FAB for better fitting
                              ),
                            ],
                          ),
                        ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _shoppingLists.length,
                    itemBuilder: (BuildContext context, int index) {
                      final doc =
                          _shoppingLists[index].data() as Map<String, dynamic>;
                      final docId = _shoppingLists[index].id;
                      final isSelected = docId == globals.selectedList;

                      IconData listIcon = IconData(
                          doc['icon'] as int? ?? Icons.list.codePoint,
                          fontFamily: 'MaterialIcons');
                      Color listColor =
                          Color(doc['color'] as int? ?? Colors.blue.value);

                      return GestureDetector(
                        onTap: () {
                          String docId = _shoppingLists[index].id;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ShoppingListDetailsPage(listId: docId),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          height: 70,
                          decoration: BoxDecoration(
                            color: listColor.withOpacity(
                                0.2), // Use the list color with some transparency
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: CircleAvatar(
                                  backgroundColor:
                                      listColor, // Use the list color
                                  child: Icon(listIcon,
                                      color: Colors.white), // Display the icon
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
                                icon:
                                    const Icon(Icons.edit, color: Colors.black),
                                onPressed: () {
                                  // Handle edit button tap
                                },
                              ),
                              IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  _deleteList(context, docId);
                                },
                              ),
                              // Selection button with toggle functionality
                              IconButton(
                                icon: isSelected
                                    ? const Icon(Icons.check_circle,
                                        color: Colors.green)
                                    : const Icon(Icons.radio_button_unchecked),
                                onPressed: () {
                                  _handleListSelection(
                                      docId); // Update selected list ID
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
      bottomNavigationBar: navigation_bar_bottom2(context, globals.selectedList, _navigateToExplore),

    );
  }
  void _navigateToExplore(String listId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SearchPage(selectedListId: listId)),
    );
  }

  void _handleListSelection(String selectedListId) {
    setState(() {
      globals.selectedList = selectedListId;
    });
  }
}