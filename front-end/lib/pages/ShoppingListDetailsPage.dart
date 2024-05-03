// shoppingListDetails.dart
/*import 'package:flutter/material.dart';
import 'package:pwfe/components/bars/navigation_bar_bottom.dart';
import 'package:pwfe/components/buttons/button_blue_lighter_rounded.dart';
import 'package:pwfe/pages/ShowSuggestedListsPage.dart';


class ShoppingListDetailsPage extends StatelessWidget {
  final int index;
  ShoppingListDetailsPage({Key? key, required this.index}) : super(key: key);
  //changed again check db
  //UsersShoppingLists theShoppingList = UsersShoppingLists.instance;
  final List<Map<String, dynamic>> items = [
    {'name': 'Amasya Elması', 'amount': 4, 'price': 0.18},
    {'name': 'Tam Yağlı Süt', 'amount': 2, 'price': 1.08},
    {'name': 'Çikolatalı Gofret', 'amount': 2, 'price': 0.30},
    {'name': 'Konserve Mısır', 'amount': 1, 'price': 2.22},
  ];

  @override
  Widget build(BuildContext context) {
    double total = items.fold(0, (sum, item) => sum + item['price'] * item['amount']);

    return Scaffold(
      appBar: AppBar(
        title: Text('All I Need'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.cancel),
            onPressed: () {
              // Cancel action
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
                return ShoppingListItem(
                  name: items[index]['name'],
                  amount: items[index]['amount'],
                  price: items[index]['price'],
                );
              },
            ),
          ),
          TotalAmount(total: total),
          ShowSuggestionsButton(),
        ],
      ),
      bottomNavigationBar: navigation_bar_bottom(context),
    );
  }
}

class ShoppingListItem extends StatelessWidget {
  final String name;
  final int amount;
  final double price;

  const ShoppingListItem({
    Key? key,
    required this.name,
    required this.amount,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.lightBlue[200], // Use the backgroundColor here
      child: ListTile(
        leading: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(Icons.shopping_cart, color: Colors.blue),
                          ),
        title: Text(name),
        subtitle: Text('Amount: $amount   Price: \$${price.toStringAsFixed(2)}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                // Add action
              },
            ),
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: () {
                // Remove action
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TotalAmount extends StatelessWidget {
  final double total;

  const TotalAmount({Key? key, required this.total}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.lightBlue[100],
        border: Border.all(color: Colors.lightBlue),
        borderRadius: BorderRadius.circular(27),
      ),
      child: Text(
        'Total: \$${total.toStringAsFixed(2)}',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class ShowSuggestionsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ShowSuggestedListsPage()));
        },
        child: Text('Show Suggestions'),
        style: ElevatedButton.styleFrom(
          primary: Colors.lightBlue,
          onPrimary: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        ),
      ),
    );
  }
}
*/
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pwfe/components/bars/navigation_bar_bottom.dart';
import 'package:pwfe/components/buttons/button_blue_lighter_rounded.dart';
import 'package:pwfe/pages/ShowSuggestedListsPage.dart';

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

  @override
  void initState() {
    super.initState();
    _fetchShoppingListItems();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping List Details'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.cancel),
            onPressed: () {
              // Cancel action
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
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  color: Colors.lightBlue[200],
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.shopping_cart, color: Colors.blue),
                    ),
                    title: Text(item['name']),
                    subtitle: Text(
                        'Amount: ${item['amount']}   Price: \$${item['price'].toStringAsFixed(2)}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            _updateItemAmount(item['id'], item['amount'] + 1);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.remove),
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
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.lightBlue[100],
              border: Border.all(color: Colors.lightBlue),
              borderRadius: BorderRadius.circular(27),
            ),
            child: Text(
              'Total: \$${total.toStringAsFixed(2)}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ShowSuggestedListsPage()));
              },
              child: Text('Show Suggestions'),
              style: ElevatedButton.styleFrom(
                //primary: Colors.lightBlue,
                //onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: navigation_bar_bottom(context),
    );
  }
}
