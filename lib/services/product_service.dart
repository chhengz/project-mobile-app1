import 'package:shoes_app/services/api_client.dart';

class ProductService {
  Future<Map<String, dynamic>> list({
    String? search,
    String? category,
    String? sort,
  }) {
    final query = <String, String>{};

    if (search != null && search.trim().isNotEmpty) {
      query["search"] = search.trim();
    }

    if (category != null && category.trim().isNotEmpty) {
      query["category"] = category.trim();
    }

    if (sort != null && sort.trim().isNotEmpty) {
      query["sort"] = sort.trim();
    }

    return ApiClient.get("/api/products", query: query.isEmpty ? null : query);
  }
}
