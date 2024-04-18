import 'package:flutter/material.dart';
import 'package:pwfe/components/bars/navigation_bar_bottom.dart';

class ItemDetailsPage extends StatelessWidget {
  final Map<String, String> item;

  ItemDetailsPage({Key? key, required this.item}) : super(key: key);
  
  final Map<String, dynamic> itemData = {
    'name': 'Gala Apples',
    'photoUrl': 'assets/apples.png', // Add your local or network image path
    'cheapestPrice': 30.90,
    'detail': '1 lb bag of fresh Gala apples'
  };

  final List<Map<String, String>> otherSellers = [
    {'name': 'Sellers 1', 'price': '31.50'},
    {'name': 'Sellers 2', 'price': '32.00'},
    // Add more sellers if needed
  ];

  final List<String> similarProductImages = [
    'assets/product1.png', // Add your local or network image paths
    'assets/product2.png',
    'assets/product3.png',
    // Add more product images if needed
  ];

  // Same local data as before...

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PriceWise'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Item information container
            Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 120.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[300], // Placeholder color
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Image.asset(
                          item['photoUrl'] ?? 'assets/default.png', // Fallback to a default asset if necessary
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item['name'] ?? 'Item Name', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        Text('\$${item['cheapestPrice']}',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                        Text(item['detail'] ?? 'Item Details', style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            buildSectionContainer(context, 'Other Sellers', buildSellersList(otherSellers)),
            buildSectionContainer(context, 'Similar Products', buildSimilarProductsGrid(similarProductImages)),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Implement add to list functionality
                },
                child: Text('Add to List'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: navigation_bar_bottom(context),
    );
  }

  Widget buildSectionContainer(BuildContext context, String title, Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.lightBlue[50],
        borderRadius: BorderRadius.circular(12.0),
      ),
      margin: EdgeInsets.all(16.0),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          child,
        ],
      ),
    );
  }

  Widget buildSellersList(List<Map<String, String>> sellers) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Text('Other Sellers', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        ...sellers.map((seller) => ListTile(
          title: Text(seller['name']!),
          trailing: Text(seller['price']!),
        )).toList(),
      ],
    );
  }

  Widget buildSimilarProductsGrid(List<String> productImages) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Text('Similar Products', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        GridView.count(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(), // to disable GridView's scrolling
          crossAxisCount: 3,
          children: productImages.map((imageUrl) => Card(
            child: Image.asset(imageUrl, fit: BoxFit.cover),
          )).toList(),
        ),
      ],
    );
  }
}
