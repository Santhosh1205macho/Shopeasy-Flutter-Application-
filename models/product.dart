class Product {
  final int id;
  final String name;
  final String category;
  final String image;
  final String description;
  final double price;

  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.image,
    required this.description,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final int id = (json['id'] as num?)?.toInt() ?? 0;
    final String apiCategory =
        (json['category'] ?? '').toString().toLowerCase();
    String category;
    if (apiCategory.contains('shoe')) {
      category = 'Shoes';
    } else if (apiCategory.contains('shirt') ||
        apiCategory.contains('dress') ||
        apiCategory.contains('tops')) {
      category = 'Clothing';
    } else if (apiCategory.contains('smartphone') ||
        apiCategory.contains('laptop') ||
        apiCategory.contains('tablet') ||
        apiCategory.contains('mobile') ||
        apiCategory.contains('computer') ||
        apiCategory.contains('electronics')) {
      category = 'Electronics';
    } else {
      category =
          ['Electronics', 'Clothing', 'Shoes', 'Books'][(id - 1).abs() % 4];
    }

    String name = (json['title'] ?? 'Product').toString();
    String image = (json['thumbnail'] ?? '').toString();
    if (id == 1) {
      name = 'Laptop';
      category = 'Electronics';
      image = 'assets/images/laptop.jpg';
    } else if (id == 2) {
      name = 'Smart Watch';
      category = 'Electronics';
      image = 'assets/images/smartwatch.jpg';
    } else if (id == 3) {
      name = 'Smartphone';
      category = 'Electronics';
      image = 'assets/images/smartphone.jpg';
    } else if (id == 4) {
      name = 'Men T-Shirt';
      category = 'Clothing';
      image = 'assets/images/tshirt.jpg';
    } else if (id == 5) {
      name = 'Dart Book';
      category = 'Books';
      image = 'assets/images/dart_book.jpg';
    } else if (id == 6) {
      name = 'Flutter Book';
      category = 'Books';
      image = 'assets/images/flutter_book.jpg';
    } else if (id == 7) {
      name = 'Wireless Headphones';
      category = 'Electronics';
      image = 'assets/images/headphones.jpg';
    } else if (id == 8) {
      name = 'Sneakers';
      category = 'Shoes';
      image = 'assets/images/sneakers.jpg';
    } else if (id == 9) {
      name = 'Running Shoes';
      category = 'Shoes';
      image = 'assets/images/running_shoes.jpg';
    } else if (id == 10) {
      name = 'Leather Jacket';
      category = 'Clothing';
      image = 'assets/images/leather_jacket.jpg';
    }

    return Product(
      id: id,
      name: name,
      category: category,
      image: image,
      description:
          (json['description'] ?? 'A quality product for everyday use.')
              .toString(),
      price: (json['price'] as num?)?.toDouble() ?? 0,
    );
  }
}
