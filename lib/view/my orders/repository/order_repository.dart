import 'package:shoes_app/view/my%20orders/model/order.dart';

class OrderRepository {
  List<Order> getOrders(){
    return[
      Order(
        OrderNumber: '1234', 
        itemCount: 2, 
        totalAmount: 168, 
        status: OrderStatus.active, 
        imageUrl: 'lib/images/nike1.jpg', 
        orderDate: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      Order(
        OrderNumber: '1239', 
        itemCount: 1, 
        totalAmount: 868, 
        status: OrderStatus.active, 
        imageUrl: 'lib/images/addidas3.jpg', 
        orderDate: DateTime.now().subtract(const Duration(hours: 1)),
      ),
      Order(
        OrderNumber: '1234', 
        itemCount: 2, 
        totalAmount: 168, 
        status: OrderStatus.completed, 
        imageUrl: 'lib/images/nike1.jpg', 
        orderDate: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      Order(
        OrderNumber: '1374', 
        itemCount: 7, 
        totalAmount: 138, 
        status: OrderStatus.cancelled, 
        imageUrl: 'lib/images/nike1.jpg', 
        orderDate: DateTime.now().subtract(const Duration(hours: 2)),
      ),
    ];
  }

  List<Order> getOrdersByStatus(OrderStatus status){
    return getOrders().where((order)=> order.status == status).toList();
  }
}