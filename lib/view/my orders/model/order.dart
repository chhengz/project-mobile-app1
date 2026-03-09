enum OrderStatus {active,completed,cancelled}

class Order {
  final String OrderNumber;
  final int itemCount;
  final double totalAmount;
  final OrderStatus status;
  final String imageUrl;
  final DateTime orderDate;

  Order({
    required this.OrderNumber,
    required this.itemCount,
    required this.totalAmount,
    required this.status,
    required this.imageUrl,
    required this.orderDate,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    final statusRaw = json['status']?.toString() ?? 'active';
    final status = OrderStatus.values.firstWhere(
      (value) => value.name == statusRaw,
      orElse: () => OrderStatus.active,
    );

    return Order(
      OrderNumber: json['orderNumber']?.toString() ?? '',
      itemCount: (json['itemCount'] as num?)?.toInt() ?? 0,
      totalAmount: (json['totalAmount'] as num?)?.toDouble() ?? 0,
      status: status,
      imageUrl: json['imageUrl']?.toString() ?? '',
      orderDate: DateTime.tryParse(json['orderDate']?.toString() ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderNumber': OrderNumber,
      'itemCount': itemCount,
      'totalAmount': totalAmount,
      'status': status.name,
      'imageUrl': imageUrl,
      'orderDate': orderDate.toIso8601String(),
    };
  }

  Order copyWith({
    String? orderNumber,
    int? itemCount,
    double? totalAmount,
    OrderStatus? status,
    String? imageUrl,
    DateTime? orderDate,
  }) {
    return Order(
      OrderNumber: orderNumber ?? OrderNumber,
      itemCount: itemCount ?? this.itemCount,
      totalAmount: totalAmount ?? this.totalAmount,
      status: status ?? this.status,
      imageUrl: imageUrl ?? this.imageUrl,
      orderDate: orderDate ?? this.orderDate,
    );
  }

  String get statusString => status.name;
}