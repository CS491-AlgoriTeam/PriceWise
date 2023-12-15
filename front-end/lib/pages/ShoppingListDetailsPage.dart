// shoppingListDetails.dart
import 'package:flutter/material.dart';
import 'package:pwfe/classes/UsersShoppingLists.dart';
import 'package:pwfe/components/bars/navigation_bar_bottom.dart';
import 'package:pwfe/components/buttons/button_blue_lighter_rounded.dart';
import 'package:pwfe/pages/ShowSuggestedListsPage.dart';


class ShoppingListDetailsPage extends StatelessWidget {
  final int index;
  ShoppingListDetailsPage({Key? key, required this.index}) : super(key: key);
  UsersShoppingLists theShoppingList = UsersShoppingLists.instance;
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


/*class ShoppingListDetailsPage extends StatelessWidget {
  final int index;
  ShoppingListDetailsPage({Key? key, required this.index}) : super(key: key);
  UsersShoppingLists theShoppingList = UsersShoppingLists.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping List Details'),
      ),
      body: Column(
        children: [
          Expanded(
            // Wrap the ListView.builder with Expanded
            child: ListView.builder(
              itemCount:
                  theShoppingList.getShoppingList(index).getProducts().length,
              itemBuilder: (BuildContext context, int itemIndex) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          'Product: ${theShoppingList.getShoppingList(index).getProductAtIndex(itemIndex).getProductName()}'),
                      Text(
                          'Price: ${theShoppingList.getShoppingList(index).getProductAtIndex(itemIndex).getProductPrice().toString()}'),
                      Text(
                          'Amount: ${theShoppingList.getShoppingList(index).getAmount(theShoppingList.getShoppingList(index).getProductAtIndex(itemIndex).getProductName())}'),
                    ],
                  ),
                );
              },
            ),
          ),
          Text(
              "Total Price: ${theShoppingList.getShoppingList(index).getShoppingListPrice()}"),
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          button_blue_lighter_rounded(context, "Show suggested Lists",
              (p0) => const ShowSuggestedListsPage()),
          const SizedBox(height: 16),
          navigation_bar_bottom(context),
        ],
      ),
    );
  }
}*/
