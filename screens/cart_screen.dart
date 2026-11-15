import 'package:flutter/material.dart';
import '../models/product.dart';

class CartScreen extends StatelessWidget {
  final List<Product> products;
  final Map<int, int> quantities;
  final double total;
  final VoidCallback onBack, onCheckout;
  final ValueChanged<int> onIncrease, onDecrease, onDelete;
  const CartScreen({super.key, required this.products, required this.quantities, required this.total, required this.onBack, required this.onCheckout, required this.onIncrease, required this.onDecrease, required this.onDelete});
  Widget _image(Product p) => p.image.startsWith('assets/') ? Image.asset(p.image, fit: BoxFit.contain, errorBuilder: (_, __, ___) => const Icon(Icons.shopping_bag)) : Image.network(p.image, fit: BoxFit.contain, errorBuilder: (_, __, ___) => const Icon(Icons.shopping_bag));
  @override
  Widget build(BuildContext context) {
    final items = products.where((p) => quantities.containsKey(p.id)).toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Cart',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: onBack,
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: items.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.shopping_cart_outlined,
                    size: 80,
                    color: Color(0xFFB7B3D8),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'Your cart is empty',
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: onBack,
                    child: const Text('Start Shopping'),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final p = items[index];
                      final quantity = quantities[p.id] ?? 1;
                      final price = p.price * 85;

                      return Card(
                        color: Colors.white,
                        margin: const EdgeInsets.only(bottom: 12),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Container(
                                height: 85,
                                width: 78,
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF0EEFF),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: _image(p),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      p.name,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      '₹${price.toStringAsFixed(0)}',
                                      style: const TextStyle(
                                        color: Color(0xFF6558F5),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () => onDecrease(p.id),
                                          icon: const Icon(
                                            Icons.remove_circle_outline,
                                          ),
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                          ),
                                          child: Text('$quantity'),
                                        ),
                                        IconButton(
                                          onPressed: () => onIncrease(p.id),
                                          icon: const Icon(
                                            Icons.add_circle_outline,
                                          ),
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: () => onDelete(p.id),
                                icon: const Icon(
                                  Icons.delete_outline,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Subtotal'),
                          Text('₹${total.toStringAsFixed(0)}'),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text('Delivery'), Text('FREE')],
                      ),
                      const Divider(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total',
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '₹${total.toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF6558F5),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: onCheckout,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF6558F5),
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Proceed to Checkout'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
