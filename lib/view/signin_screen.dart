import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoes_app/controlllers/auth_controller.dart';
import 'package:shoes_app/utils/app_textstyles.dart';
import 'package:shoes_app/view/forgot_password_screen.dart';
import 'package:shoes_app/view/main_screen.dart';
import 'package:shoes_app/view/sign_up_screen.dart';
import 'package:shoes_app/view/widgets/custom_textfield.dart';

class SigninScreen extends StatelessWidget {
  SigninScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Text(
                'Welcome Back!!!',
                style: AppTextstyles.withColor(
                  AppTextstyles.h1, 
                  Theme.of(context).textTheme.bodyLarge!.color!
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Sign in to continue shopping',
                style: AppTextstyles.withColor(
                  AppTextstyles.bodyLarge,
                  isDark ? Colors.grey[400]! : Colors.grey[600]!,
                ),
              ),
              const SizedBox(height: 40),
              CustomTextfield(
                label: 'Email', 
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'Please enter your email';
                  }
                  if (!GetUtils.isEmail(value)){
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextfield(
                label: 'Password', 
                prefixIcon: Icons.lock_outline,
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

              const SizedBox(height: 8),
              //forget password btn
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Get.to(()=> ForgotPasswordScreen()), 
                  child: Text(
                    'Forgot Password?',
                    style: AppTextstyles.withColor(
                      AppTextstyles.buttonMedium,
                      Theme.of(context).primaryColor,
                    ),      
                  ),
                ),
              ), 
              const SizedBox(height:24),   
              SizedBox(
                width: double.infinity,
                child: Obx(
                  () => ElevatedButton(
                    onPressed: authController.isLoading
                        ? null
                        : () => _handleSignIn(authController),
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
                            'Sign In',
                            style: AppTextstyles.withColor(
                              AppTextstyles.buttonMedium,
                              Colors.white,
                            ),
                          ),
                  ),
                ),
              ),       
              // sign up txt btn
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: AppTextstyles.withColor(
                        AppTextstyles.bodyMedium,
                        isDark ? Colors.grey[400]! : Colors.grey[600]!,
                        ),
                      ),
                      TextButton(
                        onPressed: () => Get.to(()=> SignUpScreen(),), 
                        child: Text(
                          'Sign Up',
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
  // sign in button
  Future<void> _handleSignIn(AuthController authController) async {
    final ok = await authController.login(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );

    if (ok) {
      Get.offAll(()=> const MainScreen());
      return;
    }

    Get.snackbar(
      'Login Failed',
      'Invalid credentials or backend not reachable.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}