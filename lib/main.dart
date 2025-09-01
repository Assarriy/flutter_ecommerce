import 'package:ecommerce_app/pages/login_page.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'LoginPage',
      routes: {'LoginPage': (context) => const LoginPage()},
    );
  }
}

void main() {
  runApp(const MyApp());
}
