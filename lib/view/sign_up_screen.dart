import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoes_app/controlllers/auth_controller.dart';
import 'package:shoes_app/utils/app_textstyles.dart';
import 'package:shoes_app/view/main_screen.dart';
import 'package:shoes_app/view/signin_screen.dart';
import 'package:shoes_app/view/widgets/custom_textfield.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _ConfirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return  Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //back buttom
              IconButton(
                onPressed: () => Get.back(), 
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),

              const SizedBox(height: 20),
              Text(
                'Create Account',
                style: AppTextstyles.withColor(
                  AppTextstyles.h1, 
                  Theme.of(context).textTheme.bodyLarge!.color!,
                 ),
              ),
              const SizedBox(height: 8),
              Text(
                'Signup to get started',
                style: AppTextstyles.withColor(
                  AppTextstyles.bodyLarge, 
                  isDark ? Colors.grey[400]!: Colors.grey[600]!,
                 ),
              ),
              const SizedBox(height: 40),
              CustomTextfield(
                label: 'Full Name', 
                prefixIcon: Icons.person_2_outlined,
                keyboardType: TextInputType.name,
                controller: _nameController,
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextfield(
                label: 'Email', 
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'Please enter your email';
                  }
                  if(!GetUtils.isEmail(value)){
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ), 
              //Password
              const SizedBox(height: 16),
              CustomTextfield(
                label: 'Password', 
                prefixIcon: Icons.lock_outlined,
                keyboardType: TextInputType.visiblePassword,
                isPassword: true,
                controller: _passwordController,
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextfield(
                label: 'Confirm Password', 
                prefixIcon: Icons.lock_outlined,
                keyboardType: TextInputType.visiblePassword,
                isPassword: true,
                controller: _ConfirmPasswordController,
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'Please confirm your password';
                  }
                  if(value != _passwordController.text){
                    return 'Password do not match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: Obx(
                  () => ElevatedButton(
                    onPressed: authController.isLoading
                        ? null
                        : () => _handleSignUp(authController),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ), 
                    child: authController.isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            'Sign Up',
                            style: AppTextstyles.withColor(
                              AppTextstyles.buttonMedium,
                              Colors.white,
                            ),
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: AppTextstyles.withColor(
                      AppTextstyles.bodyMedium,
                      isDark ? Colors.grey[400]! : Colors.grey[600]!,
                    ), 
                  ),
                  TextButton(
                    onPressed: () => Get.off(() => SigninScreen(),), 
                    child: Text(
                      'Sign In',
                      style: AppTextstyles.withColor(
                        AppTextstyles.buttonMedium,
                        Theme.of(context).primaryColor,
                        ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleSignUp(AuthController authController) async {
    if (_passwordController.text != _ConfirmPasswordController.text) {
      Get.snackbar(
        'Sign Up Failed',
        'Password and Confirm Password do not match.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final ok = await authController.register(
      fullName: _nameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text,
      phone: '',
    );

    if (ok) {
      Get.off(()=> const MainScreen());
      return;
    }

    Get.snackbar(
      'Sign Up Failed',
      'Could not create account. Check backend and input values.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}