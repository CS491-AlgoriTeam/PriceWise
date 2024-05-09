import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pwfe/components/bars/navigation_bar_bottom.dart';
import 'package:pwfe/pages/ShowSuggestedItemsPage.dart';
import 'dart:math';
import 'package:flutter/foundation.dart'; // For compute function

class ShowSuggestedListsPage extends StatefulWidget {
  final String listId;
  ShowSuggestedListsPage({Key? key, required this.listId}) : super(key: key);

  @override
  _ShowSuggestedListsPageState createState() => _ShowSuggestedListsPageState();
}

class _ShowSuggestedListsPageState extends State<ShowSuggestedListsPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Color> colors = [Colors.blue, Colors.lightBlue, Colors.blueAccent];
  List<Map<String, dynamic>> suggestedLists = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchAndCreateSuggestedLists();
  }


Future<void> _fetchAndCreateSuggestedLists() async {
  var originalListSnapshot = await _firestore.collection('shoppingLists/${widget.listId}/items').get();
  int originalItemCount = originalListSnapshot.docs.length;

  var suggestedListsSnapshot = await _firestore.collection('shoppingLists/${widget.listId}/suggestedLists').get();
  bool shouldRecreate = suggestedListsSnapshot.docs.any((doc) {
    var items = doc.data()['items'] as List<dynamic>;
    return items.length != originalItemCount;
  });

  if (shouldRecreate || suggestedListsSnapshot.docs.isEmpty) {
    // If item counts do not match or no lists exist, delete and recreate
    await _deleteExistingSuggestedLists(suggestedListsSnapshot.docs);
    await _createSuggestedItemsList();
    await _createMarketSpecificSuggestedLists();
  }

  await _fetchSuggestedListsFromFirestore(); // Always fetch to display lists
  setState(() {
    isLoading = false;
  });
}

Future<void> _deleteExistingSuggestedLists(List<QueryDocumentSnapshot> docs) async {
  for (var doc in docs) {
    await _firestore.collection('shoppingLists/${widget.listId}/suggestedLists').doc(doc.id).delete();
  }
}

Future<void> _fetchSuggestedListsFromFirestore() async {
  suggestedLists.clear();
  var snapshot = await _firestore.collection('shoppingLists/${widget.listId}/suggestedLists')
    .orderBy('totalPrice', descending: false) // Order by price ascending
    .get();
  for (var doc in snapshot.docs) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    suggestedLists.add({
      'market': data['market'] ?? 'Various', // Handle null case
      'type': 'Specific Market',
      'totalPrice': data['totalPrice'],
      'id': doc.id,
    });
  }
}
/*
Future<void> _createSuggestedItemsList() async {
  var shoppingListSnapshot = await _firestore.collection('shoppingLists/${widget.listId}/items').get();
  double totalSuggestedPrice = 0.0;
  List<Map<String, dynamic>> newItems = [];

  for (var doc in shoppingListSnapshot.docs) {
    var itemData = doc.data() as Map<String, dynamic>;
    String originalName = itemData['name'];
    double originalPrice = itemData['price']; // Assuming 'price' field exists in itemData

    var productsSnapshot = await _firestore.collection('allProducts/${itemData['main_category']}/${itemData['sub_category']}/${itemData['sub_category2']}/Products').get();

    Map<String, dynamic>? cheapestItem;
    double? lowestPrice;
    double maxSimilarity = 0.0; // Initial high similarity threshold

    for (var productDoc in productsSnapshot.docs) {
      var productData = productDoc.data();
      double candidatePrice = productData['product_cheapest_price'];
      String candidateName = productData['product_name'];
      double similarity = _calculateSimilarity(originalName, candidateName);

      // Check if the candidate price is at least 50% of the original price and has higher similarity
      if (candidatePrice >= originalPrice * 0.5 && (lowestPrice == null || (candidatePrice < lowestPrice && similarity > maxSimilarity))) {
        lowestPrice = candidatePrice;
        maxSimilarity = similarity;
        cheapestItem = {
          'product_name': candidateName,
          'product_cheapest_price': candidatePrice,
          'amount': itemData['amount'] // Preserving the amount from original item
        };
      }
    }

    if (cheapestItem != null) {
      totalSuggestedPrice += cheapestItem['product_cheapest_price'] * cheapestItem['amount'];
      newItems.add(cheapestItem);
    }
  }

  if (newItems.isNotEmpty) {
    DocumentReference ref = await _firestore.collection('shoppingLists/${widget.listId}/suggestedLists')
      .add({
        'totalPrice': totalSuggestedPrice,
        'createdAt': FieldValue.serverTimestamp(),
        'items': newItems.map((item) => {
          'name': item['product_name'],
          'price': item['product_cheapest_price'],
          'amount': item['amount']
        }).toList(),
      });

    suggestedLists.add({
      'type': 'General Cheapest',
      'market': 'Various',
      'totalPrice': totalSuggestedPrice,
      'id': ref.id
    });
  }
}*/

Future<void> _createSuggestedItemsList() async {
  var shoppingListSnapshot = await _firestore.collection('shoppingLists/${widget.listId}/items').get();
  double totalSuggestedPrice = 0.0;
  List<Map<String, dynamic>> newItems = [];

  for (var doc in shoppingListSnapshot.docs) {
    var itemData = doc.data() as Map<String, dynamic>;
    String originalName = itemData['name'];
    double originalPrice = itemData['price']; // Assuming 'price' field exists in itemData
    String mainCategory = itemData['main_category'];
    String subCategory = itemData['sub_category'];
    String subCategory2 = itemData['sub_category2'];

    var productsSnapshot = await _firestore.collection('allProducts/$mainCategory/$subCategory/$subCategory2/Products')
      .orderBy('product_cheapest_price', descending: false)
      .get();

    Map<String, dynamic>? cheapestItem;
    double? lowestPrice;
    double maxSimilarity = 0.0;

    for (var productDoc in productsSnapshot.docs) {
      var productData = productDoc.data();
      double candidatePrice = productData['product_cheapest_price'];
      String candidateName = productData['product_name'];
      double similarity = _calculateSimilarity(originalName, candidateName);

      // Check if the candidate price is at least 50% of the original price and has higher similarity
      if (candidatePrice >= originalPrice * 0.5 && (lowestPrice == null || (candidatePrice < lowestPrice && similarity > maxSimilarity))) {
        lowestPrice = candidatePrice;
        maxSimilarity = similarity;
        cheapestItem = {
          'product_name': candidateName,
          'product_cheapest_price': candidatePrice,
          'amount': itemData['amount'],
          'main_category': mainCategory,  // Include main category
          'sub_category': subCategory,    // Include sub category
          'sub_category2': subCategory2   // Include sub category 2
        };
      }
    }

    if (cheapestItem != null) {
      totalSuggestedPrice += cheapestItem['product_cheapest_price'] * cheapestItem['amount'];
      newItems.add(cheapestItem);
    }
  }

  if (newItems.isNotEmpty) {
    DocumentReference ref = await _firestore.collection('shoppingLists/${widget.listId}/suggestedLists')
      .add({
        'totalPrice': totalSuggestedPrice,
        'createdAt': FieldValue.serverTimestamp(),
        'items': newItems,
      });

    suggestedLists.add({
      'type': 'General Cheapest',
      'market': 'Various',
      'totalPrice': totalSuggestedPrice,
      'id': ref.id
    });
  }
}
/*
Future<void> _createMarketSpecificSuggestedLists() async {
  var shoppingListSnapshot = await FirebaseFirestore.instance.collection('shoppingLists/${widget.listId}/items').get();

  // First, gather all markets for items in the original list
  Map<String, Set<String>> itemMarkets = {};
  for (var doc in shoppingListSnapshot.docs) {
    var itemData = doc.data() as Map<String, dynamic>;
    var productsSnapshot = await FirebaseFirestore.instance.collection('allProducts/${itemData['main_category']}/${itemData['sub_category']}/${itemData['sub_category2']}/Products').get();
    
    for (var productDoc in productsSnapshot.docs) {
      var productData = productDoc.data();
      var markets = productData['market_product_array'] ?? [];
      markets.forEach((marketEntry) {
        var marketName = marketEntry['market'];
        if (itemMarkets[itemData['name']] == null) {
          itemMarkets[itemData['name']] = Set<String>();
        }
        itemMarkets[itemData['name']]!.add(marketName);
      });
    }
  }

  // Create a list for each market with the cheapest item options that match the market
  Map<String, List<Map<String, dynamic>>> marketSpecificLists = {};
  for (var marketName in itemMarkets.values.expand((i) => i).toSet()) {
    List<Map<String, dynamic>> marketList = [];

    for (var itemDoc in shoppingListSnapshot.docs) {
      var itemData = itemDoc.data() as Map<String, dynamic>;
      var cheapestItem = await _findCheapestItemForMarket(itemData, marketName);

      if (cheapestItem != null) {
        marketList.add({
          'name': cheapestItem['product_name'],
          'price': cheapestItem['price'],
          'amount': itemData['amount'],
          'market': marketName
        });
      }
    }

    if (marketList.length == shoppingListSnapshot.docs.length) { // Ensure full list completion
      double totalPrice = marketList.fold(0, (sum, item) => sum + (item['price'] * item['amount']));
      await FirebaseFirestore.instance.collection('shoppingLists/${widget.listId}/suggestedLists').add({
        'market': marketName,
        'totalPrice': totalPrice,
        'createdAt': FieldValue.serverTimestamp(),
        'items': marketList,
      });
    }
  }
}*/

Future<void> _createMarketSpecificSuggestedLists() async {
  var shoppingListSnapshot = await FirebaseFirestore.instance.collection('shoppingLists/${widget.listId}/items').get();

  Map<String, Set<String>> itemMarkets = {};
  for (var doc in shoppingListSnapshot.docs) {
    var itemData = doc.data() as Map<String, dynamic>;
    var productsSnapshot = await FirebaseFirestore.instance.collection('allProducts/${itemData['main_category']}/${itemData['sub_category']}/${itemData['sub_category2']}/Products').get();
    
    for (var productDoc in productsSnapshot.docs) {
      var productData = productDoc.data();
      var markets = productData['market_product_array'] ?? [];
      markets.forEach((marketEntry) {
        var marketName = marketEntry['market'];
        if (itemMarkets[itemData['name']] == null) {
          itemMarkets[itemData['name']] = Set<String>();
        }
        itemMarkets[itemData['name']]!.add(marketName);
      });
    }
  }

  Map<String, List<Map<String, dynamic>>> marketSpecificLists = {};
  for (var marketName in itemMarkets.values.expand((i) => i).toSet()) {
    List<Map<String, dynamic>> marketList = [];

    for (var itemDoc in shoppingListSnapshot.docs) {
      var itemData = itemDoc.data() as Map<String, dynamic>;
      var cheapestItem = await _findCheapestItemForMarket(itemData, marketName);

      if (cheapestItem != null) {
        marketList.add({
          'name': cheapestItem['product_name'],
          'price': cheapestItem['price'],
          'amount': itemData['amount'],
          'market': marketName,
          'main_category': itemData['main_category'],  // Include main category
          'sub_category': itemData['sub_category'],    // Include sub category
          'sub_category2': itemData['sub_category2']   // Include sub category 2
        });
      }
    }

    if (marketList.length == shoppingListSnapshot.docs.length) {
      double totalPrice = marketList.fold(0, (sum, item) => sum + (item['price'] * item['amount']));
      await FirebaseFirestore.instance.collection('shoppingLists/${widget.listId}/suggestedLists').add({
        'market': marketName,
        'totalPrice': totalPrice,
        'createdAt': FieldValue.serverTimestamp(),
        'items': marketList,
      });
    }
  }
}

Future<Map<String, dynamic>?> _findCheapestItemForMarket(Map<String, dynamic> itemData, String marketName) async {
  var productsSnapshot = await FirebaseFirestore.instance
    .collection('allProducts/${itemData['main_category']}/${itemData['sub_category']}/${itemData['sub_category2']}/Products')
    .get();

  String originalName = itemData['name'];
  double originalPrice = itemData['price'];
  double minAcceptablePrice = originalPrice * 0.5; // Setting the minimum price to 50% of the original item's price
  Map<String, dynamic>? cheapestItem;
  double? lowestPrice;
  double maxSimilarity = 0.0; // Tracks the highest similarity found

  for (var productDoc in productsSnapshot.docs) {
    var productData = productDoc.data();
    var markets = productData['market_product_array'] ?? [];

    for (var marketEntry in markets) {
      if (marketEntry['market'] == marketName) {
        double price = marketEntry['price'];
        String candidateName = productData['product_name'];
        double similarity = _calculateSimilarity(originalName, candidateName);

        // Check if the item price is within the acceptable range and has the highest similarity
        if ((lowestPrice == null || price < lowestPrice) && similarity > maxSimilarity && price >= minAcceptablePrice) {
          lowestPrice = price;
          maxSimilarity = similarity;
          cheapestItem = {
            'product_name': candidateName,
            'price': price
          };
        }
      }
    }
  }

  return cheapestItem;
}

double _calculateSimilarity(String original, String candidate) {
  // Split both strings into words
  List<String> originalWords = original.toLowerCase().split(' ');
  List<String> candidateWords = candidate.toLowerCase().split(' ');

  // Calculate intersection and union for Jaccard index
  var intersection = originalWords.toSet().intersection(candidateWords.toSet()).length;
  var union = originalWords.toSet().union(candidateWords.toSet()).length;

  return intersection / union.toDouble(); // Jaccard similarity index
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: Text('Suggested Lists')),
    body: isLoading
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
            
            itemCount: suggestedLists.length,
            itemBuilder: (context, index) {
              var list = suggestedLists[index];
              Color selColor = colors[Random().nextInt(colors.length)];
              bool isCheapest = index == 0; // First item is the cheapest
              
              return Padding(
              padding: const EdgeInsets.only(right: 10.0, left: 10.0),
              
              child: Card(
                color: selColor,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.white, // White circle background
                    child: Icon(Icons.shopping_cart, color: selColor),
                  ),
                  title: Text(
                    '${list['market']} - ${list['type']}',
                    style: TextStyle(
                      fontSize: 16.0, // Adjust font size
                      fontWeight: FontWeight.bold, // Make text bold
                      color: Colors.white, // Change text color
                    ),
                  ),
                  subtitle: Text(
                    'Total: ${list['totalPrice'].toStringAsFixed(2)}₺',
                    style: TextStyle(
                      fontSize: 18.0, // Adjust font size
                      fontWeight: FontWeight.bold, // Change font weight if necessary
                      color: Colors.black, // Change text color
                    ),
                  ),
                  trailing: isCheapest ? IconTheme(
                    data: IconThemeData(
                      size: 40.0, // Adjust icon size
                      color: Colors.white, // Adjust icon color
                    ),
                    child: Icon(Icons.star),
                  ) : null, // Green star for the cheapest
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SuggestedItemsPage(listId: widget.listId, list2Id: list['id']),
                      ),
                    );
                  },
                ),
              ),
              );
            },
          ),
    bottomNavigationBar: navigation_bar_bottom(context),
  );
}
}