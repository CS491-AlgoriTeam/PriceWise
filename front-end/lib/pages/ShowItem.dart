import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pwfe/components/bars/navigation_bar_bottom.dart';
import 'package:pwfe/pages/SubCategoryPage.dart';
import 'package:firebase_auth/firebase_auth.dart';

//class ItemDetailsPage extends StatelessWidget {
//  final Map<String, String> item;
class ItemDetailsPage extends StatelessWidget {
  final DocumentSnapshot productData;
  final String mainCategory;
  final String subCategory;
  final String subcategory2Name;
  final String selectedListId;

  ItemDetailsPage({
    Key? key,
    required this.productData,
    required this.mainCategory,
    required this.subCategory,
    required this.subcategory2Name,
    required this.selectedListId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? features =
        productData['features'] as Map<String, dynamic>?;

    String totalWeight = features?['Toplam Ağırlık'] as String? ?? '';
    String productType = features?['Ürün Tipi'] as String? ?? '';

    String displayText = '';
    if (totalWeight.isNotEmpty && productType.isNotEmpty) {
      displayText = 'Toplam Ağırlık: $totalWeight, Ürün Tipi: $productType';
    } else if (totalWeight.isNotEmpty) {
      displayText = 'Toplam Ağırlık: $totalWeight';
    } else if (productType.isNotEmpty) {
      displayText = 'Ürün Tipi: $productType';
    } else {
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
                          : Image.asset('assets/logo.png', fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(productData['product_name'] ?? 'Item Name',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold)),
                        Text(
                            '${productData['product_cheapest_price'].toStringAsFixed(2)}\₺',
                            style: TextStyle(fontSize: 30)),
                        //Text(productData['features']?.toString() ?? 'Item Details', style: TextStyle(fontSize: 16)),
                        Text(displayText, style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            buildSectionContainer(
                context, 'Other Sellers', buildSellersList(productData)),
            //buildSectionContainer(context, 'Similar Products', buildSimilarProductsGrid(context, productData)),
            buildSectionContainer(context, 'Similar Products',
                buildSimilarProductsGrid(context, productData)),

            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  _addProductToShoppingList(
                    productData.data() as Map<String, dynamic>,
                    selectedListId,
                  );
                },
                child: Text('Add to List'),
                style: ElevatedButton.styleFrom(
                  //primary: Colors.blue[300],
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

  Widget buildSectionContainer(
      BuildContext context, String title, Widget child) {
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
            child: Text(title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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

  Widget buildSimilarProductsGrid(
      BuildContext context, DocumentSnapshot productData) {
    List<dynamic> similarProducts = productData['similar_product_array'] ?? [];

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 5 / 6,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      itemCount: similarProducts.length,
      itemBuilder: (context, index) {
        String productName = similarProducts[index]['product_name']
            .replaceAll("Similar Product: ", "");
        productName = productName.replaceAll(",", "");
        productName = productName.replaceAll("'", "");

        print(productName);
        return FutureBuilder<DocumentSnapshot?>(
          future: fetchProductDetails(productName),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData) {
              return Center(child: Text('No data available'));
            }
            if (snapshot.error != null) {
              return Center(child: Text('Error loading data'));
            }
            DocumentSnapshot? productDetails = snapshot.data;
            if (productDetails != null) {
              return buildProductItem(context, productDetails);
            } else {
              return Center(child: Text('Product not found'));
            }
          },
        );
      },
    );
  }

// Dummy function for fetching product details by name, implement according to your Firestore structure
  Future<DocumentSnapshot?> fetchProductDetails(String productName) async {
    try {
      var querySnapshot = await FirebaseFirestore.instance
          .collection('allProducts')
          .doc(mainCategory)
          .collection(subCategory)
          .doc(subcategory2Name)
          .collection('Products') // Ensure this is the correct collection path
          .where('product_name',
              isEqualTo:
                  productName) // 'name' should be the field in Firestore that holds the product name
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first;
      } else {
        print("No document found for product name:$productName");
        print(subcategory2Name);
        return null;
      }
    } catch (e) {
      print("Error fetching product details: $e");
      return null;
    }
  }

  Widget buildProductItem(BuildContext context, DocumentSnapshot product) {
    String productName = product
        .id; // You might want to use a more descriptive field from Firestore
    String? productImageUrl = product['product_image_url'];
    String displayName =
        productName.length > 14 ? productName.substring(0, 14) : productName;

    // Define a default image path
    String defaultImageAssetPath = 'assets/logo.png';

    Widget imageWidget = (productImageUrl != null && productImageUrl.isNotEmpty)
        ? Image.network(
            productImageUrl,
            fit: BoxFit.cover,
            errorBuilder: (BuildContext context, Object exception,
                StackTrace? stackTrace) {
              return Image.asset(defaultImageAssetPath, fit: BoxFit.cover);
            },
          )
        : Image.asset(defaultImageAssetPath, fit: BoxFit.cover);

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ItemDetailsPage(
              productData: product,
              mainCategory: mainCategory,
              subCategory: subCategory,
              subcategory2Name: subcategory2Name,
              selectedListId: selectedListId,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.all(2.0),
        decoration: BoxDecoration(
          color: Colors.white, // Background color of the item
          borderRadius: BorderRadius.circular(12), // Rounded corners
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                child: imageWidget,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                displayName,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addProductToShoppingList(
      Map<String, dynamic> product, String selectedListId) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userId = user.uid;

      // Add the product to the selected list
      FirebaseFirestore.instance
          .collection('shoppingLists')
          .doc(selectedListId) // Use selected list ID
          .collection('items')
          .add({
        'name': product['product_name'],
        'amount': 1, // Assuming the initial amount is 1
        'price': product['product_cheapest_price'],
        'main_category': mainCategory,
        'sub_category': subCategory,
        'sub_category2': subcategory2Name,
        // Add other necessary fields here
      }).then((value) {
        print('Product added to shopping list');

        // Update the product names collection
        //_updateProductNamesCollection(selectedListId, product['product_name']);
      }).catchError((error) {
        print('Failed to add product to shopping list: $error');
      });
    } else {
      print('User is not logged in');
    }
  }

  void _updateProductNamesCollection(
      String selectedListId, String productName) {
    // Reference to the productNames document within the selected shopping list
    DocumentReference productNamesRef = FirebaseFirestore.instance
        .collection('shoppingLists')
        .doc(selectedListId)
        .collection('productNames')
        .doc('allProducts');

    // Check if the document exists
    productNamesRef.get().then((docSnapshot) {
      if (docSnapshot.exists) {
        // If the document exists, update the productNames collection
        productNamesRef.update({
          'names': FieldValue.arrayUnion([productName])
        }).then((_) {
          print('Product name added to productNames collection');
        }).catchError((error) {
          print('Failed to update productNames collection: $error');
        });
      } else {
        // If the document doesn't exist, create it and then update the productNames collection
        productNamesRef.set({
          'names': [productName]
        }).then((_) {
          print('ProductNames document created');
          print('Product name added to productNames collection');
        }).catchError((error) {
          print('Failed to create productNames document: $error');
        });
      }
    }).catchError((error) {
      print('Error checking productNames document existence: $error');
    });
  }
}
