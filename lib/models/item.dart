class Item {
  final String? name;
  final String? description;
  final double price;
  final String? imageLink;

  Item(
      {required this.name,
      this.description,
      required this.price,
      required this.imageLink});
}
