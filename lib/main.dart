import 'package:ecommerce_app/pages/login_page.dart';
import 'package:ecommerce_app/pages/register_page.dart';
import 'package:flutter/material.dart'; // <-- Pastikan import file login_page.dart

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Happy Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins', // Opsional: gunakan font yang lebih modern
      ),
      initialRoute: 'LoginPage',
      routes: {
        'LoginPage': (context) => const LoginPage(),
        'RegisterPage': (context) => const RegisterPage(),
        'AccountPage': (context) => const AccountPage(),
      },
    );
  }
}