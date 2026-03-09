import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoes_app/controlllers/product_controller.dart';
import 'package:shoes_app/models/product.dart';
import 'package:shoes_app/view/product_details_screen.dart';
import 'package:shoes_app/view/widgets/product_card.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.find<ProductController>();

    return Obx(() {
      if (productController.isLoading) {
        return const Center(child: CircularProgressIndicator());
      }

      if (productController.filteredProducts.isEmpty) {
        return const Center(child: Text('No products found'));
      }

      return GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: productController.filteredProducts.length,
        itemBuilder: (context,index){
          final Product product = productController.filteredProducts[index];
          return GestureDetector(
            onTap: ()=> Navigator.push(context,
            MaterialPageRoute(
              builder: (context)=> ProductDetailsScreen(
                product: product,
              ),),
            ),
            child: ProductCard(product: product),
          );
        },
      );
    });
  }
}