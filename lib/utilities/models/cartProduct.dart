import 'package:cloud_firestore/cloud_firestore.dart';

class CartProduct {
  final String productImage;
  final String productId;
  final String productName;
  final double productPrice;
  final String status;
  int quantity;
  final int stock;

  CartProduct({
    required this.productImage,
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.quantity,
    required this.stock,
    required this.status,
  });
  factory CartProduct.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    return CartProduct(
      productImage: data['productImage'],
      productId: data['productId'],
      productName: data['productName'],
      productPrice: data['productPrice'].toDouble(),
      quantity: data['quantity'],
      stock: data['stock'],
      status: data['status'],
    );
  }
  toJson() {
    return {
      'productImage': productImage,
      'productId': productId,
      'productName': productName,
      'productPrice': productPrice,
      'quantity': quantity,
      'stock': stock,
      'status': status,
    };
  }
}
