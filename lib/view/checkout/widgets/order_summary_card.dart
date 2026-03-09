import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoes_app/controlllers/product_controller.dart';
import 'package:shoes_app/utils/app_textstyles.dart';

class OrderSummaryCard extends StatelessWidget {
  const OrderSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    final productController = Get.find<ProductController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
       padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isDark? Colors.black.withOpacity(0.2): Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildSummaryRow( context, 'Subtotal','\$${productController.cartSubtotal.toStringAsFixed(2)}',),
          const SizedBox(height: 8),
          _buildSummaryRow( context, 'Shipping','\$${productController.cartShipping.toStringAsFixed(2)}',),
          const SizedBox(height: 8),
          _buildSummaryRow( context, 'Tax','\$${productController.cartTax.toStringAsFixed(2)}',),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(),
          ),
          _buildSummaryRow(context, 'Total', '\$${productController.cartTotal.toStringAsFixed(2)}',isTotal: true),
        ],
      ),
    );
  }
  Widget _buildSummaryRow(BuildContext context,String label,String value,{bool isTotal =false}){
    final textStyle = isTotal? AppTextstyles.h3 : AppTextstyles.bodyLarge;
    final color = isTotal?
    Theme.of(context).primaryColor :
    Theme.of(context).textTheme.bodyLarge!.color!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextstyles.withColor(textStyle,color),
        ),
        Text(
          value,
          style: AppTextstyles.withColor(textStyle,color),
        ),
      ],
    );
  }
}