import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pwfe/components/bars/navigation_bar_bottom.dart';

class SuggestedItemsPage extends StatefulWidget {
  final String listId;
  final String list2Id;
  SuggestedItemsPage({Key? key, required this.listId, required this.list2Id})
      : super(key: key);

  @override
  _SuggestedItemsPageState createState() => _SuggestedItemsPageState();
}

class _SuggestedItemsPageState extends State<SuggestedItemsPage> {
  List<Map<String, dynamic>> suggestedItems = [];
  double total = 0;

  @override
  void initState() {
    super.initState();
    _fetchSuggestedItems();
  }

  void _fetchSuggestedItems() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('shoppingLists/${widget.listId}/suggestedLists')
        .doc(widget.list2Id)
        .get();

    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      List<dynamic> items = data['items'] ?? [];
      double tempTotal = 0;

      suggestedItems = items.map((item) {
        tempTotal += item['price'] * item['amount'];
        return {
          'name': item['name'],
          'price': item['price'],
          'amount': item['amount']
        };
      }).toList();

      setState(() {
        total = tempTotal;
      });
    }
  }

  // Function to add suggested items to user's shopping lists
  void _addToMyLists() async {
    var user = FirebaseAuth.instance.currentUser;
    if (user == null) return; // Ensure user is logged in

    DocumentSnapshot suggestedListSnapshot = await FirebaseFirestore.instance
        .collection('shoppingLists/${widget.listId}/suggestedLists')
        .doc(widget.list2Id)
        .get();

    if (!suggestedListSnapshot.exists) {
      print('No suggested list found');
      return;
    }

    Map<String, dynamic> suggestedListData =
        suggestedListSnapshot.data() as Map<String, dynamic>;
    String market = suggestedListData['market'] ?? 'Default Market';
    List<dynamic> items = suggestedListData['items'];

    // Create new shopping list
    DocumentReference newListRef =
        await FirebaseFirestore.instance.collection('shoppingLists').add({
      'userId': user.uid,
      'listName': '$market List',
      'createdAt': FieldValue.serverTimestamp(),
      'icon':
          58780, // example icon, you might want to set this dynamically or allow user to choose
      'color':
          4288585374 // example color, you might want to make this selectable or random
    });

    // Add items to the new shopping list
    for (var item in items) {
      await newListRef.collection('items').add({
        'name': item['name'],
        'price': item['price'],
        'amount': item['amount'],
        'main_category': item[
            'main_category'], // Assuming these fields are available in the suggested item
        'sub_category': item['sub_category'],
        'sub_category2': item['sub_category2']
      });
    }

    // Provide feedback or navigate user
    print('New list added to My Lists');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Suggested Items for List'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: suggestedItems.length,
              itemBuilder: (context, index) {
                var item = suggestedItems[index];
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
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'Amount: ${item['amount']}   Price: ${item['price'].toStringAsFixed(2)}₺',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 76, 76, 76),
                      ),
                    ),
                  ),
                );
              },
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
                      // Add to user's lists
                      _addToMyLists();
                    },
                    child: Text(
                      'Add to My Lists',
                      style: TextStyle(
                        color: Colors.white, // Text color
                        fontSize: 16, // Font size
                        fontWeight: FontWeight.bold, // Font weight
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      //primary: Colors.blue, // Background color of the button
                      //onPrimary: Colors.white, // Text color when the button is in focus/hover/pressed
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
              )),
        ],
      ),
      bottomNavigationBar: navigation_bar_bottom(context),
    );
  }
}
