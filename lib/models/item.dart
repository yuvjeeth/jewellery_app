class Item{
  final int? id;
  final String? name;
  final String? description;
  final num price;
  final String? image;

  Item(
      {required this.id,
      required this.name,
      this.description,
      required this.price,
      this.image});
}