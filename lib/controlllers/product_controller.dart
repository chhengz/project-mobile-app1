import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shoes_app/models/product.dart';
import 'package:shoes_app/services/product_service.dart';

class ProductController extends GetxController {
  final ProductService _productService = ProductService();
  final GetStorage _storage = GetStorage();

  final RxList<Product> _products = <Product>[].obs;
  final RxSet<String> _favoriteIds = <String>{}.obs;
  final RxMap<String, int> _cartQuantities = <String, int>{}.obs;
  final RxBool _isLoading = false.obs;
  final RxString _searchQuery = ''.obs;
  final RxString _selectedCategory = 'All'.obs;
  final RxDouble _minPrice = 0.0.obs;
  final RxDouble _maxPrice = 100000.0.obs;

  List<Product> get products => _products;
  List<Product> get filteredProducts {
    return _products.where((item) {
      final query = _searchQuery.value.trim().toLowerCase();
      final matchesQuery = query.isEmpty ||
          item.name.toLowerCase().contains(query) ||
          item.brand.toLowerCase().contains(query) ||
          item.description.toLowerCase().contains(query);

      final category = _selectedCategory.value.trim().toLowerCase();
      final matchesCategory = category == 'all' ||
          item.brand.toLowerCase() == category ||
          item.category.toLowerCase() == category;

      final matchesPrice = item.price >= _minPrice.value && item.price <= _maxPrice.value;
      return matchesQuery && matchesCategory && matchesPrice;
    }).toList();
  }

  List<Product> get favoriteProducts =>
      filteredProducts.where((item) => _favoriteIds.contains(item.id)).toList();

  List<Product> get cartProducts {
    return _products.where((item) => (_cartQuantities[item.id] ?? 0) > 0).toList();
  }

  int get cartItemCount {
    return _cartQuantities.values.fold(0, (sum, item) => sum + item);
  }

  double get cartSubtotal {
    return cartProducts.fold(0, (sum, item) {
      return sum + (item.price * (_cartQuantities[item.id] ?? 0));
    });
  }

  double get cartShipping => cartProducts.isEmpty ? 0 : 10;
  double get cartTax => cartSubtotal * 0.08;
  double get cartTotal => cartSubtotal + cartShipping + cartTax;

  String get selectedCategory => _selectedCategory.value;
  String get searchQuery => _searchQuery.value;
  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    super.onInit();
    _loadFavoriteIds();
    _loadCart();
    fetchProducts();
  }

  Future<void> fetchProducts({String? search}) async {
    _isLoading.value = true;

    try {
      final response = await _productService.list(search: search);
      final list = (response["products"] as List<dynamic>? ?? [])
          .map((item) => Product.fromJson(item as Map<String, dynamic>))
          .map((item) => item.copyWith(isFavorite: _favoriteIds.contains(item.id)))
          .toList();

      _products.assignAll(list);
    } catch (_) {
      _products.clear();
    } finally {
      _isLoading.value = false;
    }
  }

  void toggleFavorite(String productId) {
    if (_favoriteIds.contains(productId)) {
      _favoriteIds.remove(productId);
    } else {
      _favoriteIds.add(productId);
    }

    _storage.write("favoriteIds", _favoriteIds.toList());

    _products.assignAll(
      _products
          .map((item) => item.copyWith(isFavorite: _favoriteIds.contains(item.id)))
          .toList(),
    );
  }

  int quantityFor(String productId) {
    return _cartQuantities[productId] ?? 0;
  }

  void addToCart(String productId, {int quantity = 1}) {
    final current = _cartQuantities[productId] ?? 0;
    _cartQuantities[productId] = current + quantity;
    _persistCart();
  }

  void increaseQty(String productId) {
    addToCart(productId, quantity: 1);
  }

  void decreaseQty(String productId) {
    final current = _cartQuantities[productId] ?? 0;
    if (current <= 1) {
      _cartQuantities.remove(productId);
    } else {
      _cartQuantities[productId] = current - 1;
    }
    _persistCart();
  }

  void removeFromCart(String productId) {
    _cartQuantities.remove(productId);
    _persistCart();
  }

  void clearCart() {
    _cartQuantities.clear();
    _persistCart();
  }

  void setSearchQuery(String value) {
    _searchQuery.value = value;
  }

  void setCategory(String value) {
    _selectedCategory.value = value;
  }

  void applyPriceFilter({required double minPrice, required double maxPrice}) {
    _minPrice.value = minPrice;
    _maxPrice.value = maxPrice;
  }

  void _loadFavoriteIds() {
    final ids = (_storage.read("favoriteIds") as List<dynamic>? ?? [])
        .map((item) => item.toString())
        .toSet();
    _favoriteIds.addAll(ids);
  }

  void _loadCart() {
    final raw = _storage.read('cartQuantities');
    if (raw is Map) {
      final map = Map<String, dynamic>.from(raw);
      map.forEach((key, value) {
        _cartQuantities[key] = int.tryParse(value.toString()) ?? 0;
      });
    }
  }

  void _persistCart() {
    _storage.write('cartQuantities', _cartQuantities);
  }
}
