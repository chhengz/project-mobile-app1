import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoes_app/controlllers/theme_controller.dart';
import 'package:shoes_app/utils/app_textstyles.dart';
import 'package:shoes_app/view/privacy%20policy/views/screens/privacy_policy_screen.dart';
import 'package:shoes_app/view/terms%20of%20service/view/screens/terms_of_Service_Screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return  Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: ()=>Get.back(), 
          icon: Icon(
            Icons.arrow_back_ios,
            color: isDark? Colors.white : Colors.black,
          ),
          ),
        title: Text(
          'Settings',
          style: AppTextstyles.withColor(
            AppTextstyles.h3, 
            isDark? Colors.white : Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              context,
              'Appearance',
              [
                _buildThemeToggle(context),
              ],
            ),

            _buildSection(
              context, 
              'Notification', 
              [
              _buildSwitchTitle(
                context,
                'Push Notification',
                'Receive push notification about order and promotions',
                true,
              ),
              _buildSwitchTitle(
                context,
                'Email Notification',
                'Receive email update about your order',
                false,
               ),
              ],
            ),
            _buildSection(context, 'Privacy', [
              _buildNavigationTitle(
                context,
                'Privacy Policy',
                'View our privacy policy',
                Icons.privacy_tip_outlined,
                onTap: () => Get.to(()=> PrivacyPolicyScreen()),
                ),
                _buildNavigationTitle(
                context,
                'Terms of Service',
                'Read our terms of service',
                Icons.description_outlined,
                onTap: () => Get.to(()=>TermsOfServiceScreen()),
                ),
              ],
            ),
            _buildSection(
            context, 
            'About', 
            [
              _buildNavigationTitle(
                context, 
                'App Version', 
                '1.0', 
                Icons.info_outline,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context,String title,List<Widget> children){
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24,24,24,8),
          child: Text(
            title,
            style: AppTextstyles.withColor(
            AppTextstyles.h3, 
            isDark? Colors.grey[400]! : Colors.grey[600]!,
           ),
          ),
        ),
        ...children
      ],
    );
  }
  Widget _buildThemeToggle(BuildContext context){
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GetBuilder<ThemeController>(
      builder: (controller)=> Container(
        margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
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
        child: ListTile(
          leading: Icon(
            controller.isDarkMode? Icons.dark_mode : Icons.light_mode,
            color: Theme.of(context).primaryColor,
          ),
          title: Text(
            'Dark mode',
            style: AppTextstyles.withColor(
            AppTextstyles.bodyMedium, 
            Theme.of(context).textTheme.bodyLarge!.color!,
           ),
          ),
          trailing: Switch.adaptive(
            value: controller.isDarkMode, 
            onChanged: (value)=> controller.toggleTheme(),
            activeColor: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }

  Widget _buildSwitchTitle(
    BuildContext context,
    String title,
    String subtitle,
    bool initialValue,
  ){
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
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
      child: ListTile(
        title: Text(
          title,
          style: AppTextstyles.withColor(
            AppTextstyles.bodyMedium, 
            Theme.of(context).textTheme.bodyLarge!.color!,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: AppTextstyles.withColor(
            AppTextstyles.bodySmall, 
            isDark? Colors.grey[400]! : Colors.grey[600]!,
          ),
        ),
        trailing: Switch.adaptive(
          value: initialValue, 
          onChanged: (value){},
          activeColor: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  Widget _buildNavigationTitle(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    {VoidCallback? onTap,}
  ){
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
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
      child: ListTile(
        leading: Icon(
          icon,
          color: Theme.of(context).primaryColor,
        ),
        title: Text(
          title,
          style: AppTextstyles.withColor(
            AppTextstyles.bodyMedium, 
            Theme.of(context).textTheme.bodyLarge!.color!,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: AppTextstyles.withColor(
            AppTextstyles.bodySmall, 
            isDark? Colors.grey[400]! : Colors.grey[600]!,
          ),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: isDark? Colors.grey[400]! : Colors.grey[600]!,
        ),
      ),
    ),
    ); 
  }
}