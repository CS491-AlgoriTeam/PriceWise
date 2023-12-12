import 'package:pwfe/classes/Product.dart';

class ProductListDummyData {
  final List<Product> productListDummyData;

  ProductListDummyData(this.productListDummyData);

  void addProductToDummyData(String name, double price) {
    productListDummyData.add(Product(productName: name, productPrice: price));
  }
}
