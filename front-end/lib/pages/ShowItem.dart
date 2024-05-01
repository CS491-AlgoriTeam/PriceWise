import 'package:flutter/material.dart';
import 'package:pwfe/components/bars/navigation_bar_bottom.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//class ItemDetailsPage extends StatelessWidget {
//  final Map<String, String> item;
class ItemDetailsPage extends StatelessWidget {
  final DocumentSnapshot productData;

  ItemDetailsPage({Key? key, required this.productData}) : super(key: key);

   @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? features = productData['features'] as Map<String, dynamic>?;

    String totalWeight = features?['Toplam Ağırlık'] as String? ?? '';
    String productType = features?['Ürün Tipi'] as String? ?? '';

    String displayText = '';
    if (totalWeight.isNotEmpty && productType.isNotEmpty) {
      displayText = 'Toplam Ağırlık: $totalWeight, Ürün Tipi: $productType';
    } else if (totalWeight.isNotEmpty) {
      displayText = 'Toplam Ağırlık: $totalWeight';
    } else if (productType.isNotEmpty) {
      displayText = 'Ürün Tipi: $productType';
    }
    else{
      displayText = '   ';
    }
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
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: productData['product_image_url'] != null && productData['product_image_url'].isNotEmpty
                          ? Image.network(productData['product_image_url'], fit: BoxFit.cover)
                          : Image.asset('assets/default.png', fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(productData['product_name'] ?? 'Item Name', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        Text('${productData['product_cheapest_price'].toStringAsFixed(2)}\₺',
                            style: TextStyle(fontSize: 30)),
                        //Text(productData['features']?.toString() ?? 'Item Details', style: TextStyle(fontSize: 16)),
                        Text(displayText, style: TextStyle(fontSize: 16)),

                      ],
                    ),
                  ),
                ],
              ),
            ),
            buildSectionContainer(context, 'Other Sellers', buildSellersList(productData)),
            buildSectionContainer(context, 'Similar Products', buildSimilarProductsGrid(context, productData)),

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

Widget buildSellersList(DocumentSnapshot product) {
  List<dynamic> sellers = product['market_product_array'] ?? [];
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: sellers.map<Widget>((seller) {
      return ListTile(
        title: Text(seller['market']),
        trailing: Text('${seller['price'].toString()}\₺'),
      );
    }).toList(),
  );
}

Widget buildSimilarProductsGrid(BuildContext context, DocumentSnapshot product) {
  List<dynamic> similarProducts = product['similar_product_array'] ?? [];
  return GridView.count(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(), // To disable GridView's scrolling
    crossAxisCount: 3,
    children: similarProducts.map<Widget>((productDetail) {
      String productName = productDetail['product_name'].replaceAll("Similar Product: ", "");
      String productImageUrl = productDetail['product_image_url']; // Ensure this field exists

      return InkWell(
        onTap: () {
          // Fetch the entire DocumentSnapshot for the tapped product if needed
          // For now, let's assume 'productDetail' includes necessary DocumentSnapshot data
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ItemDetailsPage(productData: productDetail), // Ensure this constructor and data type are correctly set up in ItemDetailsPage
            ),
          );
        },
        child: Card(
          child: Column(
            children: [
              Expanded(
                child: productImageUrl.isNotEmpty
                  ? Image.network(productImageUrl, fit: BoxFit.cover)
                  : Image.asset('assets/default.png', fit: BoxFit.cover),  // Default image if URL is empty
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  productName,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      );
    }).toList(),
  );
}
}
