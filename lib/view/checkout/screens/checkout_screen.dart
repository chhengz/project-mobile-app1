import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoes_app/controlllers/order_controller.dart';
import 'package:shoes_app/controlllers/product_controller.dart';
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
    final productController = Get.find<ProductController>();
    final orderController = Get.find<OrderController>();
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
        totalAmount: productController.cartTotal,
        onPlaceOrder: (){
          if (productController.cartProducts.isEmpty) {
            Get.snackbar(
              'Cart Empty',
              'Add products before placing an order.',
              snackPosition: SnackPosition.BOTTOM,
            );
            return;
          }

          orderController.placeOrder(
            itemCount: productController.cartItemCount,
            totalAmount: productController.cartTotal,
            imageUrl: productController.cartProducts.first.imageUrl,
          );

          final createdOrder = orderController.orders.first;
          productController.clearCart();

          Get.to(()=> OrderConfirmationScreen(
            orderNumber: createdOrder.OrderNumber,
            totalAmount: createdOrder.totalAmount,
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