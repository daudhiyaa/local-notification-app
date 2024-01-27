import 'package:flutter/material.dart';
import 'package:local_notification_app/pages/home.dart';
import 'package:local_notification_app/theme/poppins_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: poppinsTheme(),
      home: const HomePage(),
    );
  }
}
