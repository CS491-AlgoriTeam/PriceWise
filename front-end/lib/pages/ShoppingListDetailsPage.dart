import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pwfe/components/bars/navigation_bar_bottom.dart';
import 'package:pwfe/components/buttons/button_blue_lighter_rounded.dart';
import 'package:pwfe/pages/ShowSuggestedListsPage.dart';
import 'package:pwfe/pages/MyShoppingListsPage.dart';

class ShoppingListDetailsPage extends StatefulWidget {
  final String
      listId; // Assuming you pass the specific list ID when navigating to this page.
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

  @override
  void initState() {
    super.initState();
    _fetchShoppingListItems();
    _fetchShoppingLists();
  }

  void _fetchShoppingListItems() async {
    // Assuming your items are stored in a subcollection or referenced by ID within each shopping list document
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
        item['id'] = doc.id; // Keep the document ID for later operations
        tempList.add(item);
        tempTotal += item['price'] * item['amount'];
      }

      setState(() {
        items = tempList;
        total = tempTotal;
      });
    });
  }

  void _updateItemAmount(String itemId, int amount) {
    // Check if the amount is zero for deletion, else update
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
      // Step 1: Fetch the list to be deleted
      DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
          .collection('shoppingLists')
          .doc(docId)
          .get();
      Map<String, dynamic> listData =
          docSnapshot.data() as Map<String, dynamic>;

      // Step 2: Add the list to 'deletedShoppingLists' with 'deletedAt'
      await FirebaseFirestore.instance.collection('deletedShoppingLists').add({
        ...listData,
        'deletedAt': FieldValue.serverTimestamp(), // Add current timestamp
        'userId': user.uid, // Ensure user ID is included
      });

      // Step 3: Check and maintain only the 5 most recent deletions
      final QuerySnapshot deletedListsSnapshot = await FirebaseFirestore
          .instance
          .collection('deletedShoppingLists')
          .where('userId', isEqualTo: user.uid)
          .orderBy('deletedAt', descending: true)
          .get();

      if (deletedListsSnapshot.docs.length > 5) {
        // If more than 5, delete the oldest
        await FirebaseFirestore.instance
            .collection('deletedShoppingLists')
            .doc(deletedListsSnapshot.docs.last.id)
            .delete();
      }

      // Step 4: Delete the list from the original collection
      await FirebaseFirestore.instance
          .collection('shoppingLists')
          .doc(docId)
          .delete();
      if (user != null) {
        _fetchShoppingLists();
      }

      print("Shopping List Deleted and backup created");
      //Navigator.pop(context, true); // Sending back 'true' as a result indicating successful deletion

      // Optionally, refresh the list of shopping lists
      //_fetchShoppingLists(); // Call your method to refresh shopping lists if exists
    } catch (e) {
      print("Error handling shopping list deletion: $e");
    }
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
                  builder: (context) =>  MyShoppingLists(),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
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
                        fontSize: 16, // Set your desired size
                        fontWeight: FontWeight.bold, // Make text bold
                      ),
                    ),
                    subtitle: Text(
                      'Amount: ${item['amount']}   Price: ${item['price'].toStringAsFixed(2)}₺',
                      style: TextStyle(
                        fontSize: 16, // Set your desired size for subtitle
                        fontWeight: FontWeight.normal, // You can change this to FontWeight.bold if needed
                      ),
                    ),
    
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        IconButton(
                          icon: Container(
                            padding: EdgeInsets.all(8), // Adjust the padding to fit the icon size
                            decoration: BoxDecoration(
                              color: Colors.lightBlue[100], // Set the background color
                              shape: BoxShape.circle, // Set the shape to a circle
                            ),
                            child: Icon(Icons.add, color: Colors.black), // Set icon color to contrast with background
                          ),
                          onPressed: () {
                            _updateItemAmount(item['id'], item['amount'] + 1);
                          },
                        ),
                        IconButton(
                          icon: Container(
                            padding: EdgeInsets.all(8), // Adjust the padding to fit the icon size
                            decoration: BoxDecoration(
                              color: Colors.lightBlue[100], // Set the background color
                              shape: BoxShape.circle, // Set the shape to a circle
                            ),
                            child: Icon(Icons.remove, color: Colors.red), // Set icon color to contrast with background
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
          Padding(
          padding: const EdgeInsets.only(bottom: 25.0), // Adjust the padding as needed
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
                        builder: (context) =>  ShowSuggestedListsPage(listId: widget.listId,)));
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
                  onPrimary: Colors.white, // Text color when the button is in focus/hover/pressed
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(27),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 35, vertical: 16),
                  textStyle: TextStyle(
                    fontSize: 16, // This can be set here or directly in the Text widget
                    fontWeight: FontWeight.bold, // This can be set here or directly in the Text widget
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
