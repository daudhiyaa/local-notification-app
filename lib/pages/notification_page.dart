import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  final String? payload;
  const NotificationPage({super.key, required this.payload});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Page'),
        centerTitle: true,
      ),
      body: Center(child: Text(payload ?? '')),
    );
  }
}
