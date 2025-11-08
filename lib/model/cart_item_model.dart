class CartItemModel {
  final String id;
  final String title;
  final String subtitle;
  final double price;
  int quantity;
  final String logoUrl;

  CartItemModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.price,
    this.quantity = 1,
    required this.logoUrl,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'subtitle': subtitle,
    'price': price,
    'quantity': quantity,
    'logoUrl': logoUrl,
  };

  factory CartItemModel.fromMap(Map<String, dynamic> map) => CartItemModel(
    id: map['id'],
    title: map['title'],
    subtitle: map['subtitle'],
    price: map['price'],
    quantity: map['quantity'],
    logoUrl: map['logoUrl'],
  );
}
