import 'package:flutter/material.dart';
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
}
