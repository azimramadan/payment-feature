class ProductModel {
  final String id;
  final String imagePath;
  final String name;
  final double price;
  int availableQuantity;
  bool isInCart;

  ProductModel({
    required this.id,
    required this.imagePath,
    required this.name,
    required this.price,
    required this.availableQuantity,
    this.isInCart = false,
  });
}
