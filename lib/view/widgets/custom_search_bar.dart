import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoes_app/controlllers/product_controller.dart';
import 'package:shoes_app/utils/app_textstyles.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.find<ProductController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: EdgeInsets.all(16),
      child: TextField(
        onChanged: productController.setSearchQuery,
        style: AppTextstyles.withColor(
          AppTextstyles.buttonMedium, 
          Theme.of(context).textTheme.bodyLarge?.color?? Colors.black,
        ),
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle:  AppTextstyles.withColor(
          AppTextstyles.buttonMedium,
          isDark? Colors.grey[400]! : Colors.grey[600]!,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: isDark? Colors.grey[400] : Colors.grey[600],
          ),
          suffixIcon: Icon(
            Icons.tune,
            color: isDark? Colors.grey[400] : Colors.grey[600],
          ),
          filled: true,
          fillColor: isDark? Colors.grey[800] : Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: isDark? Colors.grey[400]! : Colors.grey[600]!,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}