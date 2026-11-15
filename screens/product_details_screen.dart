import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;
  final VoidCallback onBack, onCart;
  final ValueChanged<Product> onAdd;
  const ProductDetailsScreen(
      {super.key,
      required this.product,
      required this.onBack,
      required this.onCart,
      required this.onAdd});
  Widget _image() => product.image.startsWith('assets/')
      ? Image.asset(product.image,
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) =>
              const Icon(Icons.shopping_bag, size: 90))
      : Image.network(product.image,
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) =>
              const Icon(Icons.shopping_bag, size: 90));
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
          title: const Text('Product Details'),
          leading:
              IconButton(onPressed: onBack, icon: const Icon(Icons.arrow_back)),
          actions: [
            IconButton(
                onPressed: onCart,
                icon: const Icon(Icons.shopping_cart_outlined))
          ]),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
                height: 300,
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: const Color(0xFFEEEBFF),
                    borderRadius: BorderRadius.circular(24)),
                child: _image()),
            const SizedBox(height: 20),
            Text(product.category,
                style: const TextStyle(
                    color: Color(0xFF6558F5), fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(product.name,
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text('₹${(product.price * 85).toStringAsFixed(0)}',
                style: const TextStyle(
                    fontSize: 28,
                    color: Color(0xFF6558F5),
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            const Text('Product Description',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(product.description,
                style: const TextStyle(height: 1.6, color: Colors.black54)),
            const SizedBox(height: 25),
            SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                    onPressed: () => onAdd(product),
                    icon: const Icon(Icons.shopping_cart),
                    label: const Text('Add to Cart'),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6558F5),
                        foregroundColor: Colors.white))),
            const SizedBox(height: 10),
            SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                    onPressed: onBack, child: const Text('Continue Shopping')))
          ])));
}
