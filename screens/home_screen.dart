import 'package:flutter/material.dart';
import '../models/product.dart';

class HomeScreen extends StatelessWidget {
  final List<Product> products;
  final List<String> categories;
  final String selectedCategory, searchText;
  final bool loading;
  final String? error;
  final int cartCount;
  final ValueChanged<String> onSearch, onCategory;
  final VoidCallback onRetry, onLogout, onCart;
  final ValueChanged<Product> onProduct, onAdd;
  const HomeScreen({super.key, required this.products, required this.categories, required this.selectedCategory, required this.searchText, required this.loading, required this.error, required this.cartCount, required this.onSearch, required this.onCategory, required this.onRetry, required this.onLogout, required this.onCart, required this.onProduct, required this.onAdd});
  Widget productImage(Product p) => p.image.startsWith('assets/') ? Image.asset(p.image, fit: BoxFit.contain, errorBuilder: (_, __, ___) => const Icon(Icons.shopping_bag, size: 55)) : Image.network(p.image, fit: BoxFit.contain, errorBuilder: (_, __, ___) => const Icon(Icons.shopping_bag, size: 55));
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('ShopEasy', style: TextStyle(fontWeight: FontWeight.bold)), actions: [Stack(alignment: Alignment.topRight, children: [IconButton(onPressed: onCart, icon: const Icon(Icons.shopping_cart_outlined)), if (cartCount > 0) Positioned(right: 3, top: 2, child: CircleAvatar(radius: 9, backgroundColor: Colors.deepOrange, child: Text('$cartCount', style: const TextStyle(fontSize: 10, color: Colors.white))))]), IconButton(onPressed: onLogout, icon: const Icon(Icons.logout), tooltip: 'Logout')]),
    body: Column(children: [
      Container(margin: const EdgeInsets.all(16), padding: const EdgeInsets.all(20), width: double.infinity, decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF6558F5), Color(0xFF9D72F5)]), borderRadius: BorderRadius.circular(22)), child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('BIG SALE!', style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)), SizedBox(height: 6), Text('Find something you will love.', style: TextStyle(color: Colors.white))])),
      Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: TextField(onChanged: onSearch, decoration: InputDecoration(hintText: 'Search products...', prefixIcon: const Icon(Icons.search), filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none)))),
      const SizedBox(height: 12), SizedBox(height: 42, child: ListView(scrollDirection: Axis.horizontal, children: [for (final c in categories) Padding(padding: const EdgeInsets.symmetric(horizontal: 5), child: ChoiceChip(label: Text(c), selected: c == selectedCategory, selectedColor: const Color(0xFF6558F5), labelStyle: TextStyle(color: c == selectedCategory ? Colors.white : Colors.black87), onSelected: (_) => onCategory(c)))])),
      const SizedBox(height: 8),
      Expanded(
        child: loading
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 12),
                    Text('Loading products...'),
                  ],
                ),
              )
            : error != null
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.wifi_off, size: 55),
                        const SizedBox(height: 10),
                        Text(error!, textAlign: TextAlign.center),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: onRetry,
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  )
                : products.isEmpty
                    ? const Center(
                        child: Text(
                          'No Products Found',
                          style: TextStyle(fontSize: 18),
                        ),
                      )
                    : GridView.builder(
                        padding: const EdgeInsets.all(12),
                        itemCount: products.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: .60,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                        itemBuilder: (context, index) {
                          final p = products[index];
                          return Card(
                            clipBehavior: Clip.antiAlias,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () => onProduct(p),
                                    child: Container(
                                      width: double.infinity,
                                      color: const Color(0xFFF0EEFF),
                                      padding: const EdgeInsets.all(8),
                                      child: productImage(p),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 8, 10, 2),
                                  child: Text(
                                    p.category,
                                    style: const TextStyle(
                                      color: Color(0xFF6558F5),
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  child: Text(
                                    p.name,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    '₹${(p.price * 85).toStringAsFixed(0)}',
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF6558F5),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 0, 8, 9),
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: 35,
                                    child: ElevatedButton(
                                      onPressed: () => onAdd(p),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFF6558F5),
                                        foregroundColor: Colors.white,
                                        padding: EdgeInsets.zero,
                                      ),
                                      child: const Text(
                                        'Add to Cart',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
      ),
    ]),
  );
}
