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
              expandedHeight: kToolbarHeight, // Tinggi standar AppBar
            ),
          ];
        },
        body: Container(
          decoration: const BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35),
              topRight: Radius.circular(35),
            ),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Column(
              children: [
                const CartItemSamples(),
                const SizedBox(height: 24),
                // PERUBAHAN: Menambahkan widget baru untuk ringkasan pesanan
                _buildOrderSummary(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
      // Mengirim total harga yang sebenarnya ke BottomNavBar
      bottomNavigationBar: const CartBottomNavBar(totalAmount: "Rp 2.965.000"),
    );
  }

  // WIDGET BARU: Kartu untuk Ringkasan Pesanan
  Widget _buildOrderSummary() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildCouponSection(), // Area kupon sekarang ada di dalam kartu ini
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
          _buildSummaryRow("Subtotal", "Rp 2.950.000"),
          const SizedBox(height: 12),
          _buildSummaryRow("Biaya Pengiriman", "Rp 15.000"),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
          _buildSummaryRow("Total", "Rp 2.965.000", isTotal: true),
        ],
      ),
    );
  }

  // Widget bantuan untuk menampilkan baris di ringkasan (misal: Subtotal ... Rp)
  Widget _buildSummaryRow(String title, String amount, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: isTotal
              ? AppTextStyles.headerTitle.copyWith(fontSize: 18)
              : const TextStyle(fontSize: 16, color: AppColors.textSecondary),
        ),
        Text(
          amount,
          style: isTotal
              ? AppTextStyles.headerTitle.copyWith(fontSize: 20, color: AppColors.primary)
              : const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
        ),
      ],
    );
  }

  // Widget untuk area kupon (desain disempurnakan)
  Widget _buildCouponSection() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: _isCouponFieldVisible ? _buildCouponInput() : _buildCouponButton(),
    );
  }

  Widget _buildCouponButton() {
    return InkWell(
      key: const ValueKey('button'),
      onTap: () => setState(() => _isCouponFieldVisible = true),
      borderRadius: BorderRadius.circular(12),
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          children: [
            Icon(Icons.local_offer_outlined, color: AppColors.primary),
            SizedBox(width: 12),
            Expanded(child: Text('Add Coupon Code', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: AppColors.textPrimary))),
            Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }

  Widget _buildCouponInput() {
    return Container(
      key: const ValueKey('input'),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Enter coupon code',
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Coupon applied! (visual only)')),
              );
              setState(() => _isCouponFieldVisible = false);
            },
            child: const Text('Apply', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}