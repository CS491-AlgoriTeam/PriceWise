import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pwfe/components/bars/navigation_bar_bottom.dart';
import 'package:pwfe/components/buttons/button_blue_lighter_rounded.dart';
import 'package:pwfe/pages/ShowSuggestedListsPage.dart';
import 'package:pwfe/pages/MyShoppingListsPage.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ShoppingListDetailsPage extends StatefulWidget {
  final String listId;
  ShoppingListDetailsPage({Key? key, required this.listId}) : super(key: key);

  @override
  _ShoppingListDetailsPageState createState() =>
      _ShoppingListDetailsPageState();
}

class _ShoppingListDetailsPageState extends State<ShoppingListDetailsPage> {
  List<Map<String, dynamic>> items = [];
  double total = 0;
  final User? user = FirebaseAuth.instance.currentUser;
  List<DocumentSnapshot> _shoppingLists = [];
  List<Map<String, dynamic>> suggestedItems = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchShoppingListItems();
    _fetchShoppingLists();
    _fetchSuggestedItems();
  }

  void _fetchShoppingListItems() async {
    FirebaseFirestore.instance
        .collection('shoppingLists')
        .doc(widget.listId)
        .collection('items')
        .snapshots()
        .listen((snapshot) {
      double tempTotal = 0;
      List<Map<String, dynamic>> tempList = [];
      for (var doc in snapshot.docs) {
        Map<String, dynamic> item = doc.data();
        item['id'] = doc.id;
        tempList.add(item);
        tempTotal += item['price'] * item['amount'];
      }

      setState(() {
        items = tempList;
        total = tempTotal;
      });
      _updateTotalPrice();
    });
  }

  void _updateItemAmount(String itemId, int amount) {
    if (amount <= 0) {
      FirebaseFirestore.instance
          .collection('shoppingLists')
          .doc(widget.listId)
          .collection('items')
          .doc(itemId)
          .delete();
    } else {
      FirebaseFirestore.instance
          .collection('shoppingLists')
          .doc(widget.listId)
          .collection('items')
          .doc(itemId)
          .update({'amount': amount});
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
      DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
          .collection('shoppingLists')
          .doc(docId)
          .get();
      Map<String, dynamic> listData =
          docSnapshot.data() as Map<String, dynamic>;

      await FirebaseFirestore.instance.collection('deletedShoppingLists').add({
        ...listData,
        'deletedAt': FieldValue.serverTimestamp(),
        'userId': user.uid,
      });

      final QuerySnapshot deletedListsSnapshot = await FirebaseFirestore
          .instance
          .collection('deletedShoppingLists')
          .where('userId', isEqualTo: user.uid)
          .orderBy('deletedAt', descending: true)
          .get();

      if (deletedListsSnapshot.docs.length > 5) {
        await FirebaseFirestore.instance
            .collection('deletedShoppingLists')
            .doc(deletedListsSnapshot.docs.last.id)
            .delete();
      }

      await FirebaseFirestore.instance
          .collection('shoppingLists')
          .doc(docId)
          .delete();
      if (user != null) {
        _fetchShoppingLists();
      }

      print("Shopping List Deleted and backup created");
    } catch (e) {
      print("Error handling shopping list deletion: $e");
    }
  }
  void _updateTotalPrice() {
  if (user != null && widget.listId.isNotEmpty) {
    FirebaseFirestore.instance
      .collection('shoppingLists')
      .doc(widget.listId)
      .update({'totalPrice': total})
      .then((_) => print("Total price updated successfully"))
      .catchError((error) => print("Failed to update total price: $error"));
  }
}

  void _fetchSuggestedItems() async {
    try {
      // Fetch items from the shopping list
      var shoppingListSnapshot = await FirebaseFirestore.instance
          .collection('shoppingLists/${widget.listId}/items')
          .get();

      // Extract names and prices of items in the shopping list
      Map<String, double> shoppingListItems = {};
      for (var doc in shoppingListSnapshot.docs) {
        var itemData = doc.data() as Map<String, dynamic>;
        String originalName = itemData['name'];
        double originalPrice = itemData['price'];
        shoppingListItems[originalName] = originalPrice;
      }

      List<Map<String, dynamic>> newItems = [];
      for (var doc in shoppingListSnapshot.docs) {
        var itemData = doc.data() as Map<String, dynamic>;
        String originalName = itemData['name'];
        double originalPrice = itemData['price'];

        var productsSnapshot = await FirebaseFirestore.instance
            .collection(
                'allProducts/${itemData['main_category']}/${itemData['sub_category']}/${itemData['sub_category2']}/Products')
            .get();

        Map<String, dynamic>? cheapestItem;
        double maxSimilarity = 0.0;

        for (var productDoc in productsSnapshot.docs) {
          var productData = productDoc.data();
          String candidateName = productData['product_name'];

          // Skip if the item is already in the shopping list
          if (shoppingListItems.containsKey(candidateName)) continue;

          double candidatePrice = productData['product_cheapest_price'];

          // Check if the suggested item is cheaper than the original item
          if (candidatePrice >= originalPrice) continue;

          // Check if the suggested item price is less than 50% of the original item price
          if (candidatePrice < 0.5 * originalPrice) continue;

          double similarity = _calculateSimilarity(originalName, candidateName);

          if (similarity > maxSimilarity) {
            maxSimilarity = similarity;
            cheapestItem = {
              'id': productDoc.id, // Store the suggested item ID
              'product_name': candidateName,
              'price': candidatePrice,
              'amount': itemData['amount'],
              'product_image_url': productDoc['product_image_url'],
              'main_category': productDoc['main_category'],
              'sub_category': productDoc['sub_category'],
              'sub_category2': productDoc['sub_category2']
            };
          }
        }

        if (cheapestItem != null) {
          newItems.add(cheapestItem);
        }
      }

      setState(() {
        suggestedItems = newItems;
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching suggested items: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  double _calculateSimilarity(String original, String candidate) {
    List<String> originalWords = original.toLowerCase().split(' ');
    List<String> candidateWords = candidate.toLowerCase().split(' ');

    var intersection =
        originalWords.toSet().intersection(candidateWords.toSet()).length;
    var union = originalWords.toSet().union(candidateWords.toSet()).length;

    return intersection / union.toDouble();
  }
  
  void _addProductToShoppingList(Map<String, dynamic> product) {
  if (user == null) {
    print("User is not logged in");
    return;
  }

  // Create a new item with the details of the suggested item
  Map<String, dynamic> newItem = {
    'name': product['product_name'],
    'amount': 1, // You might have a default amount or get this dynamically
    'price': product['price'],
    'main_category': product['main_category'],
    'sub_category': product['sub_category'],
    'sub_category2': product['sub_category2']

    // Include other necessary fields here, such as category if needed
  };

  // Add the new item to the shopping list
  FirebaseFirestore.instance
      .collection('shoppingLists')
      .doc(widget.listId)
      .collection('items')
      .add(newItem)
      .then((value) {
        print('Item added to the list');
        // Optional: Update UI or state if needed
      })
      .catchError((error) {
        print('Error adding item to the list: $error');
      });
}

    Widget buildCarouselItem(Map<String, dynamic> item) {
    String displayName =
        item['product_name'].length > 14 ? item['product_name'].substring(0, 14) : item['product_name'];
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                child: Image.network(
                  item['product_image_url'] ?? 'assets/logo.png',
                  fit: BoxFit.cover,
                  //width: double.infinity,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(displayName, style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Text('₺${item['price'].toStringAsFixed(2)}'),
            ElevatedButton(
              onPressed: () => _addProductToShoppingList(item),
              child: Text('+'),
              style: ElevatedButton.styleFrom(
                primary: Colors.lightBlue[50],
                onPrimary: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping List Details'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              _deleteList(context, widget.listId);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyShoppingLists(),
                ),
              );
            },
          ),
        ],
      ),
      /*body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(*/
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: items.length,
              itemBuilder: (context, index) {
                var item = items[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  color: Colors.lightBlue[200],
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.shopping_cart, color: Colors.blue),
                    ),
                    title: Text(
                      item['name'],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'Amount: ${item['amount']}   Price: ${item['price'].toStringAsFixed(2)}₺',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        IconButton(
                          icon: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.lightBlue[100],
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.add, color: Colors.black),
                          ),
                          onPressed: () {
                            _updateItemAmount(item['id'], item['amount'] + 1);
                          },
                        ),
                        IconButton(
                          icon: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.lightBlue[100],
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.remove, color: Colors.red),
                          ),
                          onPressed: () {
                            _updateItemAmount(item['id'], item['amount'] - 1);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
            // Suggested items carousel/*
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
                        'Suggestions for This List',
                        style: TextStyle(
                          color: Colors.black, // Custom color for the title
                          fontWeight: FontWeight.bold, // Bold text
                          fontSize: 24, // Custom font size
                        ),
                      ),
                    ),
                  ),
              
              isLoading
                  ? CircularProgressIndicator()
                  : suggestedItems.isEmpty
                          ? Center(child: Text('No suggested items'))
                  : CarouselSlider.builder(
                      itemCount: suggestedItems.length,
                      itemBuilder: (context, index, realIndex) {
                        return buildCarouselItem(suggestedItems[index]);
                      },
                      options: CarouselOptions(
                        enlargeCenterPage: false,
                        height: 150,
                        viewportFraction: 0.35,
                        aspectRatio: 3.0,
                        initialPage: 2,
                        autoPlay: true,
                      ),
                    ),
                ],
            ),
            ),
            Padding(
                padding: const EdgeInsets.only(
                    bottom: 25.0), // Adjust the padding as needed
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.lightBlue[100],
                        border: Border.all(color: Colors.lightBlue),
                        borderRadius: BorderRadius.circular(27),
                      ),
                      child: Text(
                        'Total: ${total.toStringAsFixed(2)}₺',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ShowSuggestedListsPage(
                                      listId: widget.listId,
                                    )));
                      },
                      child: Text(
                        'Show Suggestions',
                        style: TextStyle(
                          color: Colors.white, // Text color
                          fontSize: 16, // Font size
                          fontWeight: FontWeight.bold, // Font weight
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue, // Background color of the button
                        onPrimary: Colors
                            .white, // Text color when the button is in focus/hover/pressed
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(27),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 35, vertical: 16),
                        textStyle: TextStyle(
                          fontSize:
                              16, // This can be set here or directly in the Text widget
                          fontWeight: FontWeight
                              .bold, // This can be set here or directly in the Text widget
                        ),
                      ),
                    ),
                  ],
                )
              ),
          ],
        ),
      bottomNavigationBar: navigation_bar_bottom(context),
    );
  }
}