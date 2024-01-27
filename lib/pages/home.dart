import 'package:flutter/material.dart';
import 'package:local_notification_app/api/notification_api.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 100),
            const Text(
              'Flutter Local Notification',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => NotificationApi.showNotification(
                id: 1,
                title: 'Hello Daud',
                body: 'This is Local Notification',
                payload: 'hello.daud',
              ),
              icon: const Icon(Icons.notifications_outlined),
              label: const Text('Simple Notification'),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => NotificationApi.showPeriodicNotification(
                id: 2,
                title: 'Hello Daud',
                body: 'This is Periodic Notification',
                payload: 'hello.daud',
              ),
              icon: const Icon(Icons.timer_outlined),
              label: const Text('Periodic Notification'),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => NotificationApi.showPeriodicNotification(
                id: 3,
                title: 'Hello Daud',
                body: 'This is Scheduled Notification',
                payload: 'hello.daud',
              ),
              icon: const Icon(Icons.notifications_active_outlined),
              label: const Text('Scheduled Notification'),
            )
          ],
        ),
      ),
    );
  }
}
