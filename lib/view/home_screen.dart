import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoes_app/controlllers/theme_controller.dart';
import 'package:shoes_app/view/all_products_screen.dart';
import 'package:shoes_app/view/cart_screen.dart';
import 'package:shoes_app/view/notifications/view/notifications_screen.dart';
import 'package:shoes_app/view/widgets/category_chips.dart';
import 'package:shoes_app/view/widgets/custom_search_bar.dart';
import 'package:shoes_app/view/widgets/product_grid.dart';  
import 'package:shoes_app/view/widgets/sale_banner.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body:  SafeArea(
        child: Column(
          children: [
            // heading section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage('lib/images/narith.png'),
                  ),
                  SizedBox(width:12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello Narith',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                       Text(
                        'Good Morning',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  // notify icon
                  IconButton(
                    onPressed: ()=> Get.to(()=> NotificationsScreen()), 
                    icon: Icon(Icons.notifications_outlined),
                  ),
                  // cart button
                   IconButton(
                    onPressed: ()=> Get.to(()=> CartScreen()), 
                    icon: Icon(Icons.shopping_bag_outlined),
                  ),
                  GetBuilder<ThemeController>(
                    builder: (controller) => IconButton(
                      onPressed: () => controller.toggleTheme(), 
                      icon: Icon(
                        controller.isDarkMode
                          ? Icons.light_mode
                          : Icons.dark_mode,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // search bar
            const CustomSearchBar(),
            // cart 
            const CategoryChips(),
            // sale
            const SaleBanner(),
            //popular shoes
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Popular Shoes',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.to(()=> const AllProductsScreen()),
                    child: Text(
                      'See All',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //product gird
            const Expanded(child: ProductGrid()),
          ],
        ),
      ),
    );
  }
}