import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoes_app/controlllers/product_controller.dart';
import 'package:shoes_app/utils/app_textstyles.dart';
import 'package:shoes_app/view/widgets/filter_bottom_sheet.dart';
import 'package:shoes_app/view/widgets/product_grid.dart';

class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productController = Get.find<ProductController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: ()=> Get.back(), 
          icon: Icon(
            Icons.arrow_back_ios,
            color: isDark? Colors.white : Colors.black,
          ),
        ),
        title: Text(
          'All Products',
          style: AppTextstyles.withColor(
            AppTextstyles.h3, 
            isDark? Colors.white : Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              productController.setSearchQuery('');
              productController.setCategory('All');
              productController.applyPriceFilter(minPrice: 0, maxPrice: 100000);
              Get.snackbar(
                'Filters Reset',
                'All products are visible now.',
                snackPosition: SnackPosition.BOTTOM,
              );
            }, 
            icon: Icon(
              Icons.search,
              color:  isDark? Colors.white : Colors.black,
            ),
          ),

          IconButton(
            onPressed: () => FilterBottomSheet.show(context), 
            icon: Icon(
              Icons.filter_list,
              color:  isDark? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
      body: const ProductGrid(),
    );
  }
}