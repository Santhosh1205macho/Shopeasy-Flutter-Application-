import 'dart:convert';
import '../models/product.dart';

class ApiService {
  // Local product data (replaces the dummyjson API call)
  static const String _productsJson = '''
{
  "products": [
    {
      "id": 1,
      "title": "Samsung Galaxy Book Laptop",
      "description": "15.6-inch slim laptop with a vivid display, fast performance and all-day battery life. Perfect for work and study.",
      "price": 62999,
      "category": "Electronics",
      "image": "assets/images/laptop.jpg"
    },
    {
      "id": 2,
      "title": "Smart Watch Series",
      "description": "Bluetooth calling smartwatch with a bright touch display, fitness tracking and a comfortable silicone strap.",
      "price": 2499,
      "category": "Electronics",
      "image": "assets/images/smartwatch.jpg"
    },
    {
      "id": 3,
      "title": "AI Camera Smartphone",
      "description": "Sleek smartphone with a triple AI camera setup, vibrant full-screen display and smooth everyday performance.",
      "price": 12999,
      "category": "Electronics",
      "image": "assets/images/smartphone.jpg"
    },
    {
      "id": 4,
      "title": "Maroon Round Neck T-Shirt",
      "description": "Soft premium cotton t-shirt in a rich maroon shade. Regular fit, breathable and perfect for daily wear.",
      "price": 499,
      "category": "Clothing",
      "image": "assets/images/tshirt.jpg"
    },
    {
      "id": 5,
      "title": "Black Leather Jacket",
      "description": "Classic genuine-style leather jacket with a zip front and collar. A timeless layer for any season.",
      "price": 4999,
      "category": "Clothing",
      "image": "assets/images/leather_jacket.jpg"
    },
    {
      "id": 6,
      "title": "Grey Running Shoes",
      "description": "Lightweight breathable mesh running shoes with a cushioned sole for all-day comfort and grip.",
      "price": 1799,
      "category": "Shoes",
      "image": "assets/images/running_shoes.jpg"
    },
    {
      "id": 7,
      "title": "Green & White Casual Sneakers",
      "description": "Trendy colour-block sneakers with a chunky sole and stylish laces. Great for casual outings.",
      "price": 1499,
      "category": "Shoes",
      "image": "assets/images/sneakers.jpg"
    },
    {
      "id": 8,
      "title": "Flutter for Beginners",
      "description": "An introductory guide to building cross-platform mobile applications with Flutter and Dart 2.",
      "price": 899,
      "category": "Books",
      "image": "assets/images/flutter_book.jpg"
    },
    {
      "id": 9,
      "title": "Dart Programming for Beginners",
      "description": "Learn Dart programming with easy tutorials and hands-on examples. Ideal for first-time coders.",
      "price": 699,
      "category": "Books",
      "image": "assets/images/dart_book.jpg"
    },
    {
      "id": 10,
      "title": "Wireless Noise-Cancelling Headphones",
      "description": "Over-ear Bluetooth headphones with active noise cancellation, deep bass and soft cushioned ear pads.",
      "price": 2999,
      "category": "Electronics",
      "image": "assets/images/headphones.jpg"
    }
  ]
}
''';

  static Future<List<Product>> fetchProducts() async {
    // Small delay to simulate loading (optional, remove if not needed)
    await Future.delayed(const Duration(milliseconds: 500));

    final data = jsonDecode(_productsJson) as Map<String, dynamic>;
    final List items = data['products'] as List;
    return items
        .map((item) => Product.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}