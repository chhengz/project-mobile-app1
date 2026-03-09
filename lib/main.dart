import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shoes_app/controlllers/auth_controller.dart';
import 'package:shoes_app/controlllers/navigation_controller.dart';
import 'package:shoes_app/controlllers/product_controller.dart';
import 'package:shoes_app/controlllers/theme_controller.dart';
import 'package:shoes_app/utils/app_themes.dart';
import 'package:shoes_app/view/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required for async

  await GetStorage.init();
  Get.put(ThemeController());
  Get.put(AuthController());
  Get.put(NavigationController());
  Get.put(ProductController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shoes App',
      theme: AppThemes.light,
      darkTheme: AppThemes.dark,
      themeMode: themeController.theme,
      defaultTransition: Transition.fade,
      home:  SplashScreen(),
    );
  }
}
