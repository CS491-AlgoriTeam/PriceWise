class Product {
  String productName;
  double productPrice;
  Product({required this.productName, required this.productPrice});

  String getProductName() {
    return productName;
  }

  double getProductPrice() {
    return productPrice;
  }

  void setProductName(String productName) {
    this.productName = productName;
  }

  void setProductPrice(double productPrice) {
    this.productPrice = productPrice;
  }

  Map<String, dynamic> toMap() {
    return {
      'productName': productName,
      'productPrice': productPrice,
    };
  }

  fromMapObject(Map<String, dynamic> map) {
    this.productName = map['productName'];
    this.productPrice = map['productPrice'];
  }

  @override
  String toString() {
    return 'Product{productName: $productName, productPrice: $productPrice}';
  }
}
