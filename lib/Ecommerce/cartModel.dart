class Cart {
  int? id;
  String? productId;
  String? productName;
  int? productPrice;
  int? quantity;
  String? image;

  Cart({
    this.id,
    required this.productId,
    required this.productName,
    required this.productPrice,
    this.quantity=1,
    required this.image,
  });

  Cart.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        productId = res['productId'],
        productName = res['productName'],
        productPrice = res['productPrice'],
        quantity = res['quantity'],
        image = res['image'];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'productId': productId,
      'productName': productName,
      'productPrice': productPrice,
      'quantity': quantity,
      'image': image,
    };
  }
}
