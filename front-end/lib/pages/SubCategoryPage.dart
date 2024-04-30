import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pwfe/components/bars/navigation_bar_bottom.dart';
import 'package:pwfe/pages/ShowItem.dart';

class SubcategoryPage extends StatelessWidget {
  final String mainCategory;
  final String subCategory;

  SubcategoryPage({required this.mainCategory, required this.subCategory});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$subCategory in $mainCategory'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('allProducts')
            .doc(mainCategory)
            .collection(subCategory)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No products available'));
          }
          // We map each subcategory2 to its own grid view.
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot subcategory2Document) {
              return buildSubcategory2Grid(context, subcategory2Document);
            }).toList(),
          );
        },
      ),
      bottomNavigationBar: navigation_bar_bottom(context),
    );
  }

Widget buildSubcategory2Grid(BuildContext context, DocumentSnapshot subcategory2Document) {
  // We use the document ID as the subcategory2 name
  String subcategory2Name = subcategory2Document.id;

  // Assuming subcategory2Name is a collection that contains the products
  return StreamBuilder<QuerySnapshot>(
    stream: subcategory2Document.reference.collection('Products').snapshots(),
    builder: (context, snapshot) {
      if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      }
      if (snapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator();
      }
      if (snapshot.data!.docs.isEmpty) {
        return ListTile(title: Text('No products in $subcategory2Name'));
      }

      // Create a grid for each subcategory2
      return Container(
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.blue[100], // Background color for the heading
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
              color: Colors.blue[200], // Adjust the color to match profile page
              borderRadius: BorderRadius.circular(12.0),
              ),
              child: Text(
                subcategory2Name,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            GridView.builder(
              padding: EdgeInsets.all(4),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // Number of columns in the grid
                childAspectRatio: 5/6, // Aspect ratio of the items
                crossAxisSpacing: 1, // Horizontal space between items
                mainAxisSpacing: 1, // Vertical space between items
              ),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                // Access the product document here
                var product = snapshot.data!.docs[index];
                return buildProductItem(context, product); // Pass context and the product document
              },
            ),
          ],
        ),
      );
    },
  );
}
Widget buildProductItem(BuildContext context, DocumentSnapshot product) {
  String productName = product.id;  // You might want to use a more descriptive field from Firestore
  String? productImageUrl = product['product_image_url'];
  String displayName = productName.length > 14 ? productName.substring(0, 14) : productName;

  // Define a default image path
  String defaultImageAssetPath = 'assets/logo.png';

  Widget imageWidget = (productImageUrl != null && productImageUrl.isNotEmpty)
    ? Image.network(
        productImageUrl,
        fit: BoxFit.cover,
        errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
          return Image.asset(defaultImageAssetPath, fit: BoxFit.cover);
        },
      )
    : Image.asset(defaultImageAssetPath, fit: BoxFit.cover);

  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ItemDetailsPage(productData: product),
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

}
