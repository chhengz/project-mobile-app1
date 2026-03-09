import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoes_app/controlllers/product_controller.dart';
import 'package:shoes_app/models/product.dart';
import 'package:shoes_app/utils/app_textstyles.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.find<ProductController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Obx(
      () => Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          title: Text(
            'My Wistlist',
            style: AppTextstyles.withColor(
              AppTextstyles.h3,
              isDark? Colors.white : Colors.black,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Get.snackbar(
                  'Search',
                  'Use Home or Shopping search to filter products.',
                  snackPosition: SnackPosition.BOTTOM,
                );
              },
              icon: Icon(
                Icons.search,
                color: isDark? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
        body: productController.favoriteProducts.isEmpty
            ? const Center(child: Text('No favorite products yet'))
            : CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: _buildSummarySection(context),
                  ),

                  SliverPadding(
                    padding: const EdgeInsets.all(16),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => _buildWishlistItem(
                          context,
                          productController.favoriteProducts[index],
                        ),
                        childCount: productController.favoriteProducts.length,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
  Widget _buildSummarySection(BuildContext context){
    final ProductController productController = Get.find<ProductController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final favoriteProducts = productController.favoriteProducts.length;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark? Colors.grey[850] : Colors.grey[100],
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16),),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
            '$favoriteProducts Items',
            style: AppTextstyles.withColor(
              AppTextstyles.h2,
              Theme.of(context).textTheme.bodyLarge!.color!,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'in your wishlist',
            style: AppTextstyles.withColor(
              AppTextstyles.bodyMedium ,
              isDark? Colors.grey[400]! : Colors.grey[600]!,
               ),
             ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              for (final product in productController.favoriteProducts) {
                productController.addToCart(product.id);
              }
              Get.snackbar(
                'Added',
                'All wishlist items added to cart.',
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
            ),
            child: Text(
              'Add All to Cart',
              style: AppTextstyles.withColor(
                AppTextstyles.buttonMedium, 
                Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildWishlistItem(BuildContext context,Product product){
    final ProductController productController = Get.find<ProductController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: isDark? Colors.black.withOpacity(0.2): Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(left: Radius.circular(12),),
            child: Image.asset(
              product.imageUrl,
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: AppTextstyles.withColor(
                       AppTextstyles.bodyLarge, 
                       Theme.of(context).textTheme.bodyLarge!.color!,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.category,
                    style: AppTextstyles.withColor(
                       AppTextstyles.bodySmall, 
                       isDark? Colors.grey[400]! : Colors.grey[600]!,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: AppTextstyles.withColor(
                       AppTextstyles.h3, 
                       Theme.of(context).textTheme.bodyLarge!.color!,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              productController.addToCart(product.id);
                              Get.snackbar(
                                'Added to Cart',
                                product.name,
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            }, 
                            icon: Icon(
                              Icons.shopping_cart_outlined,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          IconButton(
                            onPressed: () => productController.toggleFavorite(product.id),
                            icon: Icon(
                              Icons.delete_outline,
                              color: isDark? Colors.grey[400]: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}