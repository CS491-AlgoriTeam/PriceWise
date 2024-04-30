// subcategory_page.dart
/*import 'package:flutter/material.dart';

class SubcategoryPage extends StatelessWidget {
  final String mainCategory;
  final String subCategory;

  const SubcategoryPage({Key? key, required this.mainCategory, required this.subCategory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$subCategory in $mainCategory'),
      ),
      body: Center(
        child: Text('Showing items for $subCategory in $mainCategory category'),
      ),
    );
  }
}
*/
/*
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('allProducts')
            .doc(mainCategory)
            .collection(subCategory)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);  // Add this line to print the error message to the console.
            return Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.data!.docs.isEmpty) {
            print('No documents found.');
            print('Querying Firestore path: allProducts/$mainCategory/$subCategory');

            return Center(child: Text('No data available'));
          }

          snapshot.data!.docs.forEach((doc) {
            print(doc.data()); // Print the data of each document
            print('Querying Firestore path: allProducts/$mainCategory/$subCategory');

          });

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              // Assuming 'subcategory2Name' is the field you want to display
              var subcategory2Doc = snapshot.data!.docs[index];
              String subcategory2Name = subcategory2Doc.id; // or get a field like subcategory2Doc['name']
              
              // Fetch products for this subcategory2
              var products = subcategory2Doc['Products'] as Map; // Ensure the structure matches your Firestore

              return buildSubcategory2Item(context, subcategory2Name, products);
            },
          );
        },
      ),
    );
  }

  Widget buildSubcategory2Item(BuildContext context, String subcategory2Name, Map products) {
    return Container(
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ExpansionTile(
        title: Text(
          subcategory2Name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        children: products.keys.map<Widget>((productName) {
          return ListTile(
            title: Text(productName),
            onTap: () {
              // Handle your onTap here
            },
          );
        }).toList(),
      ),
    );
  }
}
*/


/*
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SubcategoryPage extends StatelessWidget {
  final String mainCategory;
  final String subCategory;

  SubcategoryPage({required this.mainCategory, required this.subCategory});

  @override
  Widget build(BuildContext context) {
    var docRef = FirebaseFirestore.instance.collection('allProducts').doc(mainCategory);
    docRef.get().then((docSnapshot) {
      if (docSnapshot.exists) {
        print('Main category exists');
        docRef.collection(subCategory).get().then((subCatSnapshot) {
          if (subCatSnapshot.size > 0) {
            print('Subcategory has documents');
          } else {
            print('Subcategory is empty');
          }
        });
      } else {
        print('Main category does not exist');
      }
    }).catchError((error) {
      print('Error: $error');
    });

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
            return Center(child: Text('No subcategories available'));
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              return Subcategory2ProductsWidget(
                mainCategory: mainCategory,
                subCategory: subCategory,
                subcategory2Name: document.id,
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

class Subcategory2ProductsWidget extends StatelessWidget {
  final String mainCategory;
  final String subCategory;
  final String subcategory2Name;

  Subcategory2ProductsWidget({
    required this.mainCategory,
    required this.subCategory,
    required this.subcategory2Name,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('allProducts')
          .doc(mainCategory)
          .collection(subCategory)
          .doc(subcategory2Name)
          .collection('Products')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (snapshot.data!.docs.isEmpty) {
          return ListTile(title: Text('$subcategory2Name has no products'));
        }

        return ExpansionTile(
          title: Text(subcategory2Name),
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            return ListTile(
              title: Text(document.id), // replace with the field that contains the product name
              // You might want to handle onTap here
            );
          }).toList(),
        );
      },
    );
  }
}
*/
/*
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pwfe/components/bars/navigation_bar_bottom.dart'; // Ensure you have this component available

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
            return Center(child: Text('No subcategories available'));
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              return buildSubcategory2Item(
                mainCategory: mainCategory,
                subCategory: subCategory,
                subcategory2Name: document.id,
                context: context,
              );
            }).toList(),
          );
        },
      ),
      bottomNavigationBar: navigation_bar_bottom(context),
    );
  }

  Widget buildSubcategory2Item({required String mainCategory, required String subCategory, required String subcategory2Name, required BuildContext context}) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('allProducts')
          .doc(mainCategory)
          .collection(subCategory)
          .doc(subcategory2Name)
          .collection('Products')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (snapshot.data!.docs.isEmpty) {
          return ListTile(title: Text('$subcategory2Name has no products'));
        }

        return Container(
          margin: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.blue[100],
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue[200],
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Text(
                  subcategory2Name,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              ...snapshot.data!.docs.map((DocumentSnapshot document) {
                return ListTile(
                  title: Text(document.id), // Display the document ID or a specific field as needed
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pwfe/components/bars/navigation_bar_bottom.dart';

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
                // Access the product data here
                var product = snapshot.data!.docs[index];

                // Placeholder for product name and image retrieval
                String productName = product.id; // Adjust the field name as per your Firestore
                String? productImage = product['product_image_url']; // This should match your Firestore field

                return buildProductItem(productName, productImage);
              },
            ),
          ],
        ),
      );
    },
  );
}
Widget buildProductItem(String productName, String? productImageUrl) {
  // Define a default image path
  String defaultImageAssetPath = 'assets/logo.png';
  String displayName = productName.length > 14 ? productName.substring(0, 14) : productName;

  // Determine which image to use: Network image if URL is valid, otherwise an asset image
  Widget imageWidget;
  if (productImageUrl != null && productImageUrl.isNotEmpty) {
    imageWidget = Image.network(
      productImageUrl,
      fit: BoxFit.cover,
      errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
        // If there's an error loading the network image, use the default asset image
        return Image.asset(defaultImageAssetPath, fit: BoxFit.cover);
      },
    );
  } else {
    // If the imageURL is null or empty, use the default asset image
    imageWidget = Image.asset(defaultImageAssetPath, fit: BoxFit.cover);
  }

  return InkWell(
    onTap: () {
      // TODO: Implement navigation to the product detail page
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
              displayName, // Use the trimmed name here
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
