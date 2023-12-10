class Product {
  String productName;
  double productPrice;
  Product({required this.productName, required this.productPrice});

  String getProductName(){
    return productName;
  }

  double getProductPrice(){
    return productPrice;
  }
}
