import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoes_app/utils/app_textstyles.dart';
import 'package:shoes_app/view/widgets/custom_textfield.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Get.back(), 
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 20),  
              Text(
                'Reset Password',
                style: AppTextstyles.withColor(
                  AppTextstyles.h1,
                  Theme.of(context).textTheme.bodyLarge!.color!,
                  ),  
              ),
              const SizedBox(height: 8),
              Text(
                'Enter your email to reset your password',
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
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (){
                    showSuccessDialog(context);
                  },
                   style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ), 
                  child: Text(
                    'Send Reset Link',
                     style: AppTextstyles.withColor(
                      AppTextstyles.buttonMedium, 
                      Colors.white
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
  // show success dialog
  void showSuccessDialog(BuildContext context){
    Get.dialog(
      AlertDialog(
        title: Text(
          'Check Your Email',
          style: AppTextstyles.h3,
        ),
        content: Text(
          'We have sent password recovery instructions to your email',
          style: AppTextstyles.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(), 
            child: Text(
              'OK',
              style: AppTextstyles.withColor(
                AppTextstyles.buttonMedium,
                Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}