import 'package:flutter/material.dart';
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
}
