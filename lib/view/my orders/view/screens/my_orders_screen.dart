import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoes_app/controlllers/order_controller.dart';
import 'package:shoes_app/utils/app_textstyles.dart';
import 'package:shoes_app/view/my%20orders/model/order.dart';
import 'package:shoes_app/view/my%20orders/view/widgets/order_card.dart';

class MyOrdersScreen extends StatelessWidget {
  final OrderController _orderController = Get.find<OrderController>();
  MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return DefaultTabController(
      length: 3, 
      child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: ()=>Get.back(), 
          icon: Icon(
            Icons.arrow_back_ios,
            color: isDark? Colors.white: Colors.black,
          )
          ),
        title: Text(
          'My Orders',
          style: AppTextstyles.withColor(
            AppTextstyles.h3,
            isDark? Colors.white : Colors.black,
            ),
          ),
          bottom: TabBar(
            labelColor: Theme.of(context).primaryColor,
            unselectedLabelColor: isDark? Colors.grey[400]: Colors.grey[600],
            indicatorColor: Theme.of(context).primaryColor,
            tabs: const[
              Tab(text: 'Active'),
              Tab(text: 'Completed'),
              Tab(text: 'Cancelled'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildOrderList(context, OrderStatus.active),
            _buildOrderList(context, OrderStatus.completed),
            _buildOrderList(context, OrderStatus.cancelled),
          ],
        ),
      ),
    );
  }
  Widget _buildOrderList(BuildContext context,OrderStatus status){
    final orders = _orderController.ordersByStatus(status);

    if (orders.isEmpty) {
      return const Center(child: Text('No orders found'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      itemBuilder: (context,index)=> OrderCard(
        order: orders[index],
        onViewDetails: () {
          Get.snackbar(
            'Order #${orders[index].OrderNumber}',
            'Status: ${orders[index].statusString}',
            snackPosition: SnackPosition.BOTTOM,
          );
        },
      ),
    );
  }
}