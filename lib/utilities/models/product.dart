class Product {
  String image;
  String name;
  String description;
  double price;

  Product(this.image, this.name, this.description, this.price);

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'name': name,
      'description': description,
      'price': price,
    };
  }

  factory Product.fromSnapshot(Map<String, dynamic> snapshot) {
    return Product(
      snapshot['image'],
      snapshot['name'],
      snapshot['description'],
      snapshot['price'].toDouble(),
    );
  }
}
