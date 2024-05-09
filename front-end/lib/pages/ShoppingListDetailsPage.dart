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
  final String listId;
  ShoppingListDetailsPage({Key? key, required this.listId}) : super(key: key);

  @override
  _ShoppingListDetailsPageState createState() =>
      _ShoppingListDetailsPageState();
}

class _ShoppingListDetailsPageState extends State<ShoppingListDetailsPage> {
  List<Map<String, dynamic>> items = [];
  double total = 0;
<<<<<<< Updated upstream
=======
  final User? user = FirebaseAuth.instance.currentUser;
  List<DocumentSnapshot> _shoppingLists = [];
  List<Map<String, dynamic>> suggestedItems = [];
  bool isLoading = true;
>>>>>>> Stashed changes

  @override
  void initState() {
    super.initState();
    _fetchShoppingListItems();
<<<<<<< Updated upstream
=======
    _fetchShoppingLists();
    _fetchSuggestedItems();
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
=======

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
>>>>>>> Stashed changes

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
              'amount': itemData['amount']
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping List Details'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.cancel),
            onPressed: () {
<<<<<<< Updated upstream
              // Cancel action
=======
              _deleteList(context, widget.listId);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyShoppingLists(),
                ),
              );
>>>>>>> Stashed changes
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
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
<<<<<<< Updated upstream
                    title: Text(item['name']),
                    subtitle: Text(
                        'Amount: ${item['amount']}   Price: \$${item['price'].toStringAsFixed(2)}'),
=======
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
>>>>>>> Stashed changes
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        IconButton(
<<<<<<< Updated upstream
                          icon: Icon(Icons.add),
=======
                          icon: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.lightBlue[100],
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.add, color: Colors.black),
                          ),
>>>>>>> Stashed changes
                          onPressed: () {
                            _updateItemAmount(item['id'], item['amount'] + 1);
                          },
                        ),
                        IconButton(
<<<<<<< Updated upstream
                          icon: Icon(Icons.remove),
=======
                          icon: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.lightBlue[100],
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.remove, color: Colors.red),
                          ),
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
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
=======
            Container(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Suggested Items',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  isLoading
                      ? Center(child: CircularProgressIndicator())
                      : suggestedItems.isEmpty
                          ? Center(child: Text('No suggested items'))
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: suggestedItems.length,
                              itemBuilder: (context, index) {
                                var item = suggestedItems[index];
                                return Card(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 4),
                                  color: Colors.lightBlue[200],
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: Icon(Icons.shopping_cart,
                                          color: Colors
                                              .blue), // Shopping cart icon
                                    ),
                                    title: Text(
                                      item['product_name'],
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text(
                                      'Price: ${item['price'].toStringAsFixed(2)}₺',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    trailing: IconButton(
                                      icon: Container(
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.lightBlue[100],
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(Icons.add,
                                            color: Colors.black),
                                      ),
                                      onPressed: () {
                                        // Create a new item with the details of the suggested item
                                        Map<String, dynamic> newItem = {
                                          'name': item['product_name'],
                                          'amount': item['amount'],
                                          'price': item['price'],
                                        };

                                        // Add the new item to the shopping list
                                        FirebaseFirestore.instance
                                            .collection('shoppingLists')
                                            .doc(widget.listId)
                                            .collection('items')
                                            .add(newItem)
                                            .then((value) {
                                          // Item added successfully
                                          print('Item added to the list');
                                        }).catchError((error) {
                                          // Error adding item to the list
                                          print(
                                              'Error adding item to the list: $error');
                                        });
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                ],
>>>>>>> Stashed changes
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
                )),
          ],
        ),
      ),
      bottomNavigationBar: navigation_bar_bottom(context),
    );
  }
}
//
