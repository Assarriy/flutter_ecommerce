import 'package:flutter/material.dart';
import 'package:ecommerce_app/app_styles.dart';

class CartBottomNavBar extends StatelessWidget {
  final String totalAmount;
  const CartBottomNavBar({super.key, this.totalAmount = "Rp0"});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 3, blurRadius: 10, offset: const Offset(0, -5))],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
              Text("Rp2.950.000", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primary)),
            ],
          ),
          // TUGAS 3.3.7: Tombol ini sudah memiliki efek klik/animasi
          InteractiveButton(
            onTap: () {},
            text: "Check Out",
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
            borderRadius: BorderRadius.circular(12),
            gradient: const LinearGradient(
              colors: [AppColors.primary, AppColors.lightBlue],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            boxShadow: [BoxShadow(color: AppColors.primary.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 5))],
          ),
          child: Center(child: Text(widget.text, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))),
        ),
      ),
    );
  }
}