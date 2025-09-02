import 'package:flutter/material.dart';
import 'package:ecommerce_app/widgets/CartAppBar.dart';
import 'package:ecommerce_app/widgets/CartBottomNavBar.dart';
import 'package:ecommerce_app/widgets/CartItemSamples.dart';
import 'package:ecommerce_app/app_styles.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // State untuk menampilkan/menyembunyikan field kupon
  bool _isCouponFieldVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            const SliverAppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              floating: true,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(background: CartAppBar()),
              expandedHeight: kToolbarHeight,
            ),
          ];
        },
        body: Container(
          decoration: const BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(35), topRight: Radius.circular(35)),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 24.0),
            child: Column(
              children: [
                const CartItemSamples(),
                const SizedBox(height: 20),
                // TUGAS 3.3.8: Area kupon yang interaktif
                _buildCouponSection(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const CartBottomNavBar(),
    );
  }

  Widget _buildCouponSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      // AnimatedSwitcher untuk transisi halus antara tombol dan field input
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _isCouponFieldVisible ? _buildCouponInput() : _buildCouponButton(),
      ),
    );
  }

  Widget _buildCouponButton() {
    return GestureDetector(
      onTap: () => setState(() => _isCouponFieldVisible = true),
      child: Container(
        key: const ValueKey('button'), // Key untuk AnimatedSwitcher
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: const Row(
          children: [
            Icon(Icons.local_offer_outlined, color: AppColors.primary),
            SizedBox(width: 12),
            Expanded(child: Text('Add Coupon Code', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.textPrimary))),
            Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }

  Widget _buildCouponInput() {
    return Container(
      key: const ValueKey('input'), // Key untuk AnimatedSwitcher
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Enter coupon code',
                border: InputBorder.none,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              // Aksi saat tombol apply ditekan
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Coupon applied! (visual only)')),
              );
              setState(() => _isCouponFieldVisible = false); // Kembali ke tombol
            },
            child: const Text('Apply', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}