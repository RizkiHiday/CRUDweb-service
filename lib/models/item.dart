class Item {
  final String id;
  final String name;
  final String description;
  final double price;

  Item({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
  });

  // Konversi dari JSON ke Item
  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'] != null ? json['price'].toDouble() : 0.0,
    );
  }

  // Konversi dari Item ke JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'price': price,
    };
  }
}
