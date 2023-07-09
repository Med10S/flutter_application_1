class CartProduct {
  final String productImage;
  final String productId;
  final String productName;
  final double productPrice;
  int quantity;
  final int stock;

  CartProduct({
    required this.productImage,
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.quantity,
    required this.stock,
  });
  toJson() {
    return {
      'productImage': productImage,
      'productId': productId,
      'productName': productName,
      'productPrice': productPrice,
      'quantity': quantity,
      'stock': stock,
    };
  }
}
