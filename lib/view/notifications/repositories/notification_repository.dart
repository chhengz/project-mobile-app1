import 'package:shoes_app/view/notifications/models/notification_type.dart';

class NotificationRepository {
  List<NotificationItem> getNotifications(){
    return const[
      NotificationItem(
        title: 'Order Confirmed', 
        message: 
        'Your order #1234 has been confirmed and is begin processed', 
        time: '3 minutes ago', 
        type: NotificationType.order,
        isRead: true,
      ),
      NotificationItem(
        title: 'Special Offer!', 
        message: 
        'Get 20% off', 
        time: '30 minutes ago', 
        type: NotificationType.promo,
        isRead: true,
      ),
      NotificationItem(
        title: 'Out for Delivery', 
        message: 
        'Your order #1234 is out for delivery', 
        time: '3 minutes ago', 
        type: NotificationType.delivery,
        isRead: true,
      ),
      NotificationItem(
        title: 'Payment Successful', 
        message: 
        'Payment for order #1234 was successful', 
        time: '3 minutes ago', 
        type: NotificationType.payment,
        isRead: true,
      ),
    ];
  }
}