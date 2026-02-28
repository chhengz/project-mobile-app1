import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoes_app/controlllers/auth_controller.dart';
import 'package:shoes_app/utils/app_textstyles.dart';
import 'package:shoes_app/view/signin_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingItem> _items = [
    OnboardingItem(
        title: 'Discover Trend',
        description: 'Explore the newest shoes',
        image: 'lib/images/1.png'),
    OnboardingItem(
        title: 'Stay Updated',
        description: 'Check out the latest arrivals',
        image: 'lib/images/jd.png'),
    OnboardingItem(
        title: 'Just Do It',
        description: 'Step up your shoe game today',
        image: 'lib/images/justdo.png'),
  ];

  void _handleGetStarted(){
    final AuthController authController = Get.find<AuthController>();
    authController.setFirstTimeDone();
    Get.off(() =>  SigninScreen());
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final defaultTextColor =
        isDark ? Colors.grey[400]! : Colors.grey[600]!; // fallback color

    return Scaffold(
      body: Stack(
        children: [
          // PageView for onboarding screens
          PageView.builder(
            controller: _pageController,
            itemCount: _items.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              final item = _items[index];
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    item.image,
                    height: MediaQuery.of(context).size.height * 0.4,
                  ),
                  const SizedBox(height: 40),
                  Text(
                    item.title,
                    textAlign: TextAlign.center,
                    style: AppTextstyles.withColor(
                      AppTextstyles.h1,
                      Theme.of(context).textTheme.bodyLarge?.color ??
                          defaultTextColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      item.description,
                      textAlign: TextAlign.center,
                      style: AppTextstyles.withColor(
                        AppTextstyles.bodyLarge,
                        defaultTextColor,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          // Page indicator
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _items.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: 8,
                  width: _currentPage == index ? 24 : 8,
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? Theme.of(context).primaryColor
                        : (isDark ? Colors.grey[700] : Colors.grey[300]),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => _handleGetStarted(), 
                  child: Text(
                    "Skip",
                    style: AppTextstyles.withColor(AppTextstyles.buttonMedium,
                      isDark ? Colors.grey[400]! : Colors.grey[600]!
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: (){
                    if (_currentPage < _items.length -1 ){
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 300), 
                        curve: Curves.easeInOut,
                      );
                    } else {
                      _handleGetStarted();
                    }
                  }, 
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(12),
                    ),
                  ),
                  child: Text(
                    _currentPage < _items.length - 1 ? 'Next': "Get Started",
                    style: AppTextstyles.withColor(
                      AppTextstyles.buttonMedium,
                    Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingItem {
  final String image;
  final String title;
  final String description;

  OnboardingItem({
    required this.title,
    required this.description,
    required this.image,
  });
}
