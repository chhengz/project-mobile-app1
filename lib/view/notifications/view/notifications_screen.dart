import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoes_app/utils/app_textstyles.dart';
import 'package:shoes_app/view/notifications/models/notification_type.dart';
import 'package:shoes_app/view/notifications/repositories/notification_repository.dart';
import 'package:shoes_app/view/notifications/utils/notification_utils.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final NotificationRepository _repository = NotificationRepository();
  late List<NotificationItem> notifications;

  @override
  void initState() {
    super.initState();
    notifications = _repository.getNotifications();
  }

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
          'Notification',
          style: AppTextstyles.withColor(
            AppTextstyles.h3,
            isDark? Colors.white : Colors.black,
          ),
        ),
        actions: [
          TextButton(
            onPressed: _markAllAsRead,
            child: Text(
              'Mark all as read',
              style: AppTextstyles.withColor(
                AppTextstyles.bodyMedium,
                Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        itemBuilder: (context,index)=>_buildNotificationCard(
          context,
          notifications[index],
        ),
      ),
    );
  }
  Widget _buildNotificationCard(BuildContext context,NotificationItem notification){
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: notification.isRead
          ? Theme.of(context).cardColor
          :Theme.of(context).primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: isDark? Colors.black.withOpacity(0.2):  Colors.grey.withOpacity(0.1),
            ),
          ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: NotificationUtils.getIconBackgroundColor(
              context, notification.type
            ),
            shape: BoxShape.circle,
          ),
          child: Icon(
            NotificationUtils.getNotificationIcon(notification.type),
            color: NotificationUtils.getIconColor(context,notification.type),
          ),
        ),
        title: Text(
          notification.title,
          style: AppTextstyles.withColor(
            AppTextstyles.bodyLarge, 
            Theme.of(context).textTheme.bodyLarge!.color!
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              notification.message,
              style: AppTextstyles.withColor(
                AppTextstyles.bodySmall, 
                isDark? Colors.grey[400]! : Colors.grey[600]!,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              notification.time,
              style: AppTextstyles.withColor(
                AppTextstyles.bodySmall,
                isDark? Colors.grey[500]! : Colors.grey[500]!,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _markAllAsRead() {
    setState(() {
      notifications = notifications
          .map(
            (item) => NotificationItem(
              title: item.title,
              message: item.message,
              time: item.time,
              type: item.type,
              isRead: true,
            ),
          )
          .toList();
    });

    Get.snackbar(
      'Done',
      'All notifications marked as read.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}