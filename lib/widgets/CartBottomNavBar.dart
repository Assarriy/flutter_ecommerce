import 'package:flutter/material.dart';
import 'package:ecommerce_app/app_styles.dart';

class CartBottomNavBar extends StatelessWidget {
  final String totalAmount;
  const CartBottomNavBar({super.key, this.totalAmount = "Rp0"});

  @override
  Widget build(BuildContext context) {
    // PERUBAHAN: Menggunakan Container dengan dekorasi baru
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      // Memberi tinggi yang lebih pas
      height: 100, 
      decoration: BoxDecoration(
        color: Colors.white,
        // PERUBAHAN: Sudut atas yang membulat
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      // PERUBAHAN: Menggunakan Row untuk layout horizontal
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // PERUBAHAN: Hierarki visual baru untuk total harga
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Total Price",
                style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 4),
              Text(
                totalAmount,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          // Tombol Check Out dengan lebar yang lebih pas
          SizedBox(
            width: 160, // Memberi lebar tetap pada tombol
            child: InteractiveButton(
              onTap: () {},
              text: "Check Out",
            ),
          )
        ],
      ),
    );
  }
}

// Widget tombol interaktif (pastikan sudah ada di proyek Anda)
class InteractiveButton extends StatefulWidget {
  final VoidCallback onTap;
  final String text;
  const InteractiveButton({super.key, required this.onTap, required this.text});

  @override
  State<InteractiveButton> createState() => _InteractiveButtonState();
}

class _InteractiveButtonState extends State<InteractiveButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 150),
        child: Container(
          width: double.infinity,
          height: 55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), // Sudut lebih membulat
            gradient: const LinearGradient(
              colors: [AppColors.primary, AppColors.lightBlue],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Center(
            child: Text(
              widget.text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}