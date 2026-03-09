import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shoes_app/models/product.dart';
import 'package:shoes_app/services/product_service.dart';

class ProductController extends GetxController {
  final ProductService _productService = ProductService();
  final GetStorage _storage = GetStorage();

  final RxList<Product> _products = <Product>[].obs;
  final RxSet<String> _favoriteIds = <String>{}.obs;
  final RxBool _isLoading = false.obs;

  List<Product> get products => _products;
  List<Product> get favoriteProducts =>
      _products.where((item) => _favoriteIds.contains(item.id)).toList();
  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    super.onInit();
    _loadFavoriteIds();
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

  void _loadFavoriteIds() {
    final ids = (_storage.read("favoriteIds") as List<dynamic>? ?? [])
        .map((item) => item.toString())
        .toSet();
    _favoriteIds.addAll(ids);
  }
}
