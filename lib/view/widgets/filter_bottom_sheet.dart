import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoes_app/controlllers/product_controller.dart';
import 'package:shoes_app/utils/app_textstyles.dart';

class FilterBottomSheet {
  static void show(BuildContext context){
    final productController = Get.find<ProductController>();
    final minController = TextEditingController();
    final maxController = TextEditingController();
    String selectedCategory = productController.selectedCategory;

    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context, 
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Container(
          padding: const EdgeInsets.all(24),
          child:  Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Filter Products',
                    style: AppTextstyles.withColor(
                      AppTextstyles.h3,
                      Theme.of(context).textTheme.bodyLarge!.color!,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Get.back(), 
                    icon: Icon(
                      Icons.close,
                      color: isDark? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                'Price Range',
                style: AppTextstyles.withColor(
                  AppTextstyles.bodyLarge,
                  Theme.of(context).textTheme.bodyLarge!.color!,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: minController,
                      decoration: InputDecoration(
                        hintText: 'Min',
                        prefixText: '\$',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: 
                              isDark? Colors.grey[700]! : Colors.grey[300]!,
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 16),
                   Expanded(
                    child: TextField(
                      controller: maxController,
                      decoration: InputDecoration(
                        hintText: 'Max',
                        prefixText: '\$',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: 
                              isDark? Colors.grey[700]! : Colors.grey[300]!,
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),              
              const SizedBox(height: 24),
              Text(
                'Categories',
                style: AppTextstyles.withColor(
                  AppTextstyles.bodyLarge,
                  Theme.of(context).textTheme.bodyLarge!.color!,
                ),
              ), 
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  'All',
                  'Nike',
                  'Adidas',
                  'Puma',
                ].map((category) => FilterChip(
                  label: Text(category),
                  selected: category == selectedCategory,
                  onSelected: (selected){
                    setState(() {
                      if (selected) {
                        selectedCategory = category;
                      }
                    });
                  },
                  // ignore: deprecated_member_use
                  backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),
                  labelStyle: AppTextstyles.withColor(
                    AppTextstyles.bodyMedium,
                    category == selectedCategory
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).textTheme.bodyLarge!.color!,
                    ),
                )).toList(),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final minPrice = double.tryParse(minController.text.trim()) ?? 0;
                    final maxPrice = double.tryParse(maxController.text.trim()) ?? 100000;

                    productController.setCategory(selectedCategory);
                    productController.applyPriceFilter(
                      minPrice: minPrice,
                      maxPrice: maxPrice,
                    );
                    Get.back();
                  }, 
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Apply Filters',
                    style: AppTextstyles.withColor(
                  AppTextstyles.bodyMedium,
                  Colors.white,
                ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}