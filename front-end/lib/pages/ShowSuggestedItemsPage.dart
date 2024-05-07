import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pwfe/components/bars/navigation_bar_bottom.dart';

class SuggestedItemsPage extends StatefulWidget {
  final String listId;
  final String list2Id;
  SuggestedItemsPage({Key? key, required this.listId, required this.list2Id}) : super(key: key);

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
                  // Add to user's lists
                  print('Add to My Lists functionality to be implemented.');
                },
                child: Text('Add to My Lists'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(27),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 35, vertical: 16),
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
