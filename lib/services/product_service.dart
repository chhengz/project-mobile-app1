import 'package:shoes_app/services/api_client.dart';

class ProductService {
  Future<Map<String, dynamic>> list({
    String? search,
    String? category,
    String? sort,
  }) async {
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

    try {
      return await ApiClient.get("/api/products", query: query.isEmpty ? null : query);
    } catch (_) {
      return {
        "products": _localSeedProducts(),
        "total": _localSeedProducts().length,
      };
    }
  }

  List<Map<String, dynamic>> _localSeedProducts() {
    return [
      {
        "id": "p-1",
        "name": "Adidas Samba OG",
        "brand": "Adidas",
        "category": "Lifestyle",
        "price": 120,
        "oldPrice": 140,
        "imageUrl": "lib/images/addidas1.png",
        "description": "Classic Adidas Samba with everyday comfort.",
        "stock": 20,
      },
      {
        "id": "p-2",
        "name": "Adidas Spezial",
        "brand": "Adidas",
        "category": "Lifestyle",
        "price": 110,
        "oldPrice": 130,
        "imageUrl": "lib/images/addidas2.png",
        "description": "Retro Adidas Spezial with premium suede upper.",
        "stock": 18,
      },
      {
        "id": "p-3",
        "name": "Nike Air Jordan 1",
        "brand": "Nike",
        "category": "Basketball",
        "price": 170,
        "oldPrice": 190,
        "imageUrl": "lib/images/Jordan.jpg",
        "description": "Iconic Jordan high-top with premium leather feel.",
        "stock": 10,
      },
      {
        "id": "p-4",
        "name": "Nike Revolution",
        "brand": "Nike",
        "category": "Running",
        "price": 85,
        "oldPrice": 99,
        "imageUrl": "lib/images/nike2.jpg",
        "description": "Breathable Nike running shoe for all-day movement.",
        "stock": 24,
      },
      {
        "id": "p-5",
        "name": "Puma Smash v2",
        "brand": "Puma",
        "category": "Lifestyle",
        "price": 75,
        "oldPrice": 90,
        "imageUrl": "lib/images/puma1.jpg",
        "description": "Clean Puma court style with durable outsole.",
        "stock": 28,
      },
      {
        "id": "p-6",
        "name": "Puma Velocity",
        "brand": "Puma",
        "category": "Running",
        "price": 95,
        "oldPrice": 112,
        "imageUrl": "lib/images/puma2.jpg",
        "description": "Soft-ride Puma trainer made for long sessions.",
        "stock": 22,
      },
    ];
  }
}
