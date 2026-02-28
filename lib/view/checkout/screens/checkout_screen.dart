import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';
import 'package:shoes_app/utils/app_textstyles.dart';
import 'package:shoes_app/view/checkout/widgets/address_card.dart';
import 'package:shoes_app/view/checkout/widgets/checkout_bottom_bar.dart';
import 'package:shoes_app/view/checkout/widgets/order_summary_card.dart';
import 'package:shoes_app/view/checkout/widgets/payment_method_card.dart';
import 'package:shoes_app/view/order%20confirmation/screens/order_confirmation_screen.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: ()=> Get.back(), 
          icon: Icon(
            Icons.arrow_back_ios,
            color: isDark? Colors.white : Colors.black,
          ),
        ),
        title: Text(
          'Checkout',
          style: AppTextstyles.withColor(
            AppTextstyles.h3,
            isDark? Colors.white : Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle(context,'Shipping Address'),
            const SizedBox(height: 16),
            AddressCard(),
            const SizedBox(height: 16),
            _buildSectionTitle(context, 'Payment Method'),
            const SizedBox(height: 16),
            const PaymentMethodCard(),
            const SizedBox(height: 24),
            _buildSectionTitle(context, 'Order Summary'),
            const SizedBox(height: 16),
            OrderSummaryCard(),
          ],
        ),
      ),
      bottomNavigationBar: CheckoutBottomBar(
        totalAmount: 300,
        onPlaceOrder: (){
          final orderNumber = 'ORD${DateTime.now().microsecondsSinceEpoch.toString().substring(7)}';
          Get.to(()=> OrderConfirmationScreen(
            orderNumber: orderNumber,
            totalAmount: 300,
           ),);
        },
      ),
    );
  }
Widget _buildSectionTitle(BuildContext context,String title){
  return Text(
    title,
    style: AppTextstyles.withColor(
      AppTextstyles.h3,
      Theme.of(context).textTheme.bodyLarge!.color!,
    ),
  );
}
}