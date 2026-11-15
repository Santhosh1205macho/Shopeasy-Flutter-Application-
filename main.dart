import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/product.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/product_details_screen.dart';
import 'screens/cart_screen.dart';
import 'services/api_service.dart';

void main() => runApp(const ShopEasyApp());

class ShopEasyApp extends StatelessWidget {
  const ShopEasyApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ShopEasy',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6558F5)),
          scaffoldBackgroundColor: const Color(0xFFF7F7FC),
        ),
        home: const ShopController(),
      );
}

class ShopController extends StatefulWidget {
  const ShopController({super.key});
  @override
  State<ShopController> createState() => _ShopControllerState();
}

class _ShopControllerState extends State<ShopController> {
  bool checkingLogin = true;
  bool isLoggedIn = false;
  bool loadingProducts = false;
  bool loginLoading = false;
  String page = 'login';
  String selectedCategory = 'All';
  String searchText = '';
  String? loadError;
  Product? selectedProduct;
  List<Product> products = [];
  final Map<int, int> cart = {};
  final categories = const ['All', 'Electronics', 'Clothing', 'Shoes', 'Books'];

  @override
  void initState() { super.initState(); _checkLogin(); }

  Future<void> _checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getBool('isLoggedIn') ?? false;
    if (!mounted) return;
    setState(() { isLoggedIn = saved; page = saved ? 'home' : 'login'; checkingLogin = false; });
    if (saved) _loadProducts();
  }

  Future<bool> _login(String email, String password) async {
    if (email.trim().isEmpty || password.trim().isEmpty) {
      _message('Please fill in your email and password'); return false;
    }
    if (!email.contains('@') || !email.contains('.')) {
      _message('Please enter a valid email address'); return false;
    }
    setState(() => loginLoading = true);
    await Future.delayed(const Duration(milliseconds: 500));
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    if (!mounted) return false;
    setState(() { loginLoading = false; isLoggedIn = true; page = 'home'; });
    await _loadProducts();
    return true;
  }

  Future<void> _loadProducts() async {
    setState(() { loadingProducts = true; loadError = null; });
    try {
      final result = await ApiService.fetchProducts();
      if (!mounted) return;
      setState(() { products = result; loadingProducts = false; });
    } catch (_) {
      if (!mounted) return;
      setState(() { loadingProducts = false; loadError = 'Something went wrong. Check your internet and retry.'; });
    }
  }

  List<Product> get filteredProducts => products.where((p) =>
      (selectedCategory == 'All' || p.category == selectedCategory) &&
      p.name.toLowerCase().contains(searchText.toLowerCase())).toList();

  void _add(Product product) { setState(() => cart[product.id] = (cart[product.id] ?? 0) + 1); _message('Added to cart'); }
  void _increase(int id) => setState(() => cart[id] = (cart[id] ?? 0) + 1);
  void _decrease(int id) => setState(() { if ((cart[id] ?? 0) > 1) { cart[id] = cart[id]! - 1; } else { cart.remove(id); } });
  void _delete(int id) => setState(() => cart.remove(id));
  int get itemCount => cart.values.fold(0, (sum, quantity) => sum + quantity);
  double get total => products.fold(0, (sum, p) => sum + p.price * (cart[p.id] ?? 0) * 85);
  void _message(String message) { if (!mounted) return; ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(SnackBar(content: Text(message), behavior: SnackBarBehavior.floating)); }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    if (!mounted) return;
    setState(() { isLoggedIn = false; page = 'login'; cart.clear(); products.clear(); searchText = ''; selectedCategory = 'All'; });
  }

  @override
  Widget build(BuildContext context) {
    if (checkingLogin) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    if (page == 'login') return LoginScreen(loading: loginLoading, onLogin: _login);
    if (page == 'details' && selectedProduct != null) {
      return ProductDetailsScreen(product: selectedProduct!, onBack: () => setState(() => page = 'home'), onAdd: _add, onCart: () => setState(() => page = 'cart'));
    }
    if (page == 'cart') {
      return CartScreen(products: products, quantities: cart, total: total, onBack: () => setState(() => page = 'home'), onIncrease: _increase, onDecrease: _decrease, onDelete: _delete, onCheckout: _checkout);
    }
    return HomeScreen(
      products: filteredProducts, categories: categories, selectedCategory: selectedCategory,
      searchText: searchText, loading: loadingProducts, error: loadError, cartCount: itemCount,
      onSearch: (v) => setState(() => searchText = v),
      onCategory: (v) => setState(() => selectedCategory = v),
      onRetry: _loadProducts, onLogout: _logout, onCart: () => setState(() => page = 'cart'),
      onProduct: (p) => setState(() { selectedProduct = p; page = 'details'; }), onAdd: _add,
    );
  }

  void _checkout() {
    if (cart.isEmpty) return;
    showDialog<void>(context: context, builder: (dialogContext) => AlertDialog(
      icon: const Icon(Icons.check_circle, color: Colors.green, size: 60),
      title: const Text('Order Confirmed!'),
      content: Text('Your order total is ₹${total.toStringAsFixed(0)}.\n\nThank you for shopping with ShopEasy!', textAlign: TextAlign.center),
      actions: [TextButton(onPressed: () { Navigator.pop(dialogContext); setState(() { cart.clear(); page = 'home'; }); }, child: const Text('Continue Shopping'))],
    ));
  }
}
