import 'package:flutter/material.dart';
import 'register_page.dart'; // <-- IMPORT HALAMAN REGISTER

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Variabel state untuk kontrol visibilitas password
  bool _isPasswordVisible = false;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Warna utama dari logo Happy Shop
  final Color primaryColor = const Color(0xFF0D6EFD);
  final Color secondaryColor = const Color(0xFFA6C7FF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLogo(),
                const SizedBox(height: 20),
                _buildHeader(),
                const SizedBox(height: 40),
                _buildEmailField(),
                const SizedBox(height: 20),
                _buildPasswordField(),
                const SizedBox(height: 30),
                _buildLoginButton(context),
                const SizedBox(height: 20),
                _buildSignupLink(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Image.asset(
      'assets/images/logo.jpeg', // Pastikan path ini benar
      height: 100,
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Text(
          'Welcome Back!',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: primaryColor, // <-- WARNA BARU
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Login to your happy place',
          style: TextStyle(fontSize: 18, color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      decoration: InputDecoration(
        labelText: 'Email',
        prefixIcon: Icon(Icons.email, color: primaryColor), // <-- WARNA BARU
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: primaryColor), // <-- WARNA BARU
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
          return 'Please enter a valid email';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: !_isPasswordVisible, // <-- KONTROL VISIBILITAS
      decoration: InputDecoration(
        labelText: 'Password',
        prefixIcon: Icon(Icons.lock, color: primaryColor), // <-- WARNA BARU
        // Icon untuk show/hide password
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
            color: primaryColor,
          ),
          onPressed: () {
            // Gunakan setState untuk mengubah state dan rebuild UI
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: primaryColor), // <-- WARNA BARU
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        if (value.length < 6) {
          return 'Password must be at least 6 characters';
        }
        return null;
      },
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Ini adalah cara validasi form bekerja
        if (_formKey.currentState!.validate()) {
          // Jika semua validator mengembalikan null (valid), maka lanjutkan
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Logging in...')),
          );
          // Navigator.pushReplacementNamed(context, 'AccountPage');
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor, // <-- WARNA BARU
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      child: const Text(
        'Login',
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }

  Widget _buildSignupLink(BuildContext context) {
    return TextButton(
      onPressed: () {
        // Navigasi ke halaman Register
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RegisterPage()),
        );
      },
      child: Text.rich(
        TextSpan(
          text: 'Don\'t have an account? ',
          style: TextStyle(color: Colors.grey[600]),
          children: [
            TextSpan(
              text: 'Sign Up',
              style: TextStyle(
                color: primaryColor, // <-- WARNA BARU
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}