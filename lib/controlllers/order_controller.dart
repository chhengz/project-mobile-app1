import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shoes_app/view/my%20orders/model/order.dart';

class OrderController extends GetxController {
  final GetStorage _storage = GetStorage();
  final RxList<Order> _orders = <Order>[].obs;

  List<Order> get orders => _orders;

  @override
  void onInit() {
    super.onInit();
    _loadOrders();
  }

  List<Order> ordersByStatus(OrderStatus status) {
    return _orders.where((item) => item.status == status).toList();
  }

  void placeOrder({
    required int itemCount,
    required double totalAmount,
    required String imageUrl,
  }) {
    final orderNumber = 'ORD${DateTime.now().microsecondsSinceEpoch.toString().substring(7)}';
    final order = Order(
      OrderNumber: orderNumber,
      itemCount: itemCount,
      totalAmount: totalAmount,
      status: OrderStatus.active,
      imageUrl: imageUrl,
      orderDate: DateTime.now(),
    );

    _orders.insert(0, order);
    _persistOrders();
  }

  void markAllActiveAsCompleted() {
    final mapped = _orders.map((item) {
      if (item.status == OrderStatus.active) {
        return item.copyWith(status: OrderStatus.completed);
      }
      return item;
    }).toList();

    _orders.assignAll(mapped);
    _persistOrders();
  }

  void _loadOrders() {
    final raw = (_storage.read('orders') as List<dynamic>? ?? []);
    if (raw.isEmpty) {
      _orders.assignAll(_seedOrders());
      _persistOrders();
      return;
    }

    _orders.assignAll(
      raw
          .map((item) => Order.fromJson(Map<String, dynamic>.from(item as Map)))
          .toList(),
    );
  }

  void _persistOrders() {
    _storage.write('orders', _orders.map((item) => item.toJson()).toList());
  }

  List<Order> _seedOrders() {
    return [
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
        OrderNumber: '1134',
        itemCount: 2,
        totalAmount: 168,
        status: OrderStatus.completed,
        imageUrl: 'lib/images/nike1.jpg',
        orderDate: DateTime.now().subtract(const Duration(days: 2)),
      ),
      Order(
        OrderNumber: '1374',
        itemCount: 7,
        totalAmount: 138,
        status: OrderStatus.cancelled,
        imageUrl: 'lib/images/nike1.jpg',
        orderDate: DateTime.now().subtract(const Duration(days: 6)),
      ),
    ];
  }
}
