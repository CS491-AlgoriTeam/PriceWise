/*import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RecipeDetailsPage extends StatefulWidget {
  final String recipeName;

  RecipeDetailsPage({Key? key, required this.recipeName}) : super(key: key);

  @override
  _RecipeDetailsPageState createState() => _RecipeDetailsPageState();
}

class _RecipeDetailsPageState extends State<RecipeDetailsPage> {
  List<DocumentSnapshot> items = [];
  double total = 0;

  @override
  void initState() {
    super.initState();
    fetchItems();
  }

  void fetchItems() async {
    FirebaseFirestore.instance
      .collection('recipes')
      .doc(widget.recipeName)
      .collection('items')
      .get()
      .then((snapshot) {
        if (snapshot.docs.isNotEmpty) {
          double sum = 0;
          for (var doc in snapshot.docs) {
            sum += doc.data()['price'] as double;
          }

          setState(() {
            items = snapshot.docs;
            total = sum;
          });
        }
      });
  }

  void addToMyLists() async {
    // Assuming you have a function to add to lists
    // addRecipeToList(widget.recipeName, total);
    print("Added to My Lists");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipeName + " Details"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/${widget.recipeName}.jpeg'), // Display the recipe photo
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(widget.recipeName, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(items[index]['name']),
                  trailing: Text("\$${items[index]['price']}"),
                );
              },
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total: \$${total.toStringAsFixed(2)}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  ElevatedButton(
                    onPressed: addToMyLists,
                    child: Text("Add to My Lists"),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pwfe/components/bars/navigation_bar_bottom.dart';
import 'package:pwfe/pages/MyShoppingListsPage.dart';

class RecipeDetailsPage extends StatefulWidget {
  final String recipeName;

  RecipeDetailsPage({Key? key, required this.recipeName}) : super(key: key);

  @override
  _RecipeDetailsPageState createState() => _RecipeDetailsPageState();
}

class _RecipeDetailsPageState extends State<RecipeDetailsPage> {
  List<DocumentSnapshot> items = [];
  double total = 0;

  @override
  void initState() {
    super.initState();
    fetchItems();
  }

  void fetchItems() async {
    FirebaseFirestore.instance
      .collection('recipes')
      .doc(widget.recipeName)
      .collection('items')
      .get()
      .then((snapshot) {
        if (snapshot.docs.isNotEmpty) {
          double sum = 0;
          for (var doc in snapshot.docs) {
            sum += doc.data()['price'] as double;
          }

          setState(() {
            items = snapshot.docs;
            total = sum;
          });
        }
      });
  }

void addToMyLists() async {
  final User? user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    print("User not logged in");
    return;
  }

  try {
    // Fetch the original recipe document
    DocumentSnapshot recipeDoc = await FirebaseFirestore.instance
        .collection('recipes')
        .doc(widget.recipeName)
        .get();

    // Create the new shopping list with the base fields
    DocumentReference newListRef = await FirebaseFirestore.instance.collection('shoppingLists').add({
      'color': 4280391411,
      'createdAt': FieldValue.serverTimestamp(),
      'icon': null,
      'listName': widget.recipeName,
      'userId': user.uid,
    });

    // Copy all items from the recipe's item sub-collection to the new list
    QuerySnapshot itemsSnapshot = await FirebaseFirestore.instance
        .collection('recipes')
        .doc(widget.recipeName)
        .collection('items')
        .get();

    for (var item in itemsSnapshot.docs) {
      newListRef.collection('items').add(item.data() as Map<String, dynamic>);
    }

    // Optionally, navigate to the MyShoppingLists page
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyShoppingLists()));

    print("Recipe added to My Lists with items copied");
  } catch (e) {
    print("Error adding recipe to My Lists: $e");
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipeName + " Details"),
        backgroundColor: Colors.white, // Adjust the color to match your theme
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.lightBlue[50],
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
                child: Image.asset(
                  'assets/${widget.recipeName}.jpeg',
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(4.0),
                child: Text(widget.recipeName, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ),
              ...items.map((DocumentSnapshot document) {
                Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  padding: EdgeInsets.all(4),
                  child: ListTile(
                    title: Text(data['name'], style: TextStyle(color: Colors.black87)),
                    trailing: Text("${data['price'].toStringAsFixed(2)}₺", style: TextStyle(fontSize: 16.0,color: Colors.black87)),
                  ),
                );
              }).toList(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total: ${total.toStringAsFixed(2)}₺", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
                    ElevatedButton(
                      onPressed: addToMyLists,
                      child: Text("Add to My Lists"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue[300], // button color
                        onPrimary: Colors.white, // text color
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: navigation_bar_bottom(context),
    );
  }
}

