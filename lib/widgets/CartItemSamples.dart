import 'package:flutter/material.dart';
import 'package:ecommerce_app/app_styles.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class CartItem {
  final String image;
  final String name;
  final String price;
  int quantity;
  bool isVisible;

  CartItem({
    required this.image,
    required this.name,
    required this.price,
    this.quantity = 1,
    this.isVisible = true,
  });
}

class CartItemSamples extends StatefulWidget {
  const CartItemSamples({super.key});

  @override
  State<CartItemSamples> createState() => _CartItemSamplesState();
}

class _CartItemSamplesState extends State<CartItemSamples> {
  final List<CartItem> items = [
    CartItem(image: 'images/items/1.jpeg', name: 'Product Title 1', price: 'Rp 850.000', quantity: 1),
    CartItem(image: 'images/items/2.jpeg', name: 'Product Title 2', price: 'Rp 950.000', quantity: 2),
    CartItem(image: 'images/items/3.jpeg', name: 'Product Title 3', price: 'Rp 750.000', quantity: 1),
  ];

  @override
  Widget build(BuildContext context) {
    // PERUBAHAN: Menambahkan AnimationLimiter untuk animasi entri
    return AnimationLimiter(
      child: Column(
        children: [
          for (int i = 0; i < items.length; i++)
            // PERUBAHAN: Membungkus item dengan widget animasi
            AnimationConfiguration.staggeredList(
              position: i,
              duration: const Duration(milliseconds: 375),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: Visibility(
                    visible: items[i].isVisible,
                    child: _buildItemCard(items[i]),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // PERUBAHAN: Desain ulang kartu item menjadi vertikal
  Widget _buildItemCard(CartItem item) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.1),
      child: Column(
        children: [
          // Bagian Gambar dengan Tombol Hapus di atasnya
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                child: Image.asset(
                  item.image,
                  height: 150, // Memberi tinggi lebih pada gambar
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              // Tombol Hapus di pojok kanan atas
              Positioned(
                top: 8,
                right: 8,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      item.isVisible = false;
                    });
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.white.withOpacity(0.8),
                    child: const Icon(Icons.delete_outline, color: AppColors.danger, size: 24),
                  ),
                ),
              ),
            ],
          ),
          // Bagian Detail Produk
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name, style: AppTextStyles.headerTitle.copyWith(fontSize: 18)),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(item.price, style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 20)),
                    _buildQuantityControl(
                      quantity: item.quantity,
                      onRemove: () {
                        if (item.quantity > 1) {
                          setState(() => item.quantity--);
                        }
                      },
                      onAdd: () {
                        setState(() => item.quantity++);
                      },
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQuantityControl({
    required int quantity,
    required VoidCallback onRemove,
    required VoidCallback onAdd,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          IconButton(icon: const Icon(Icons.remove, size: 18, color: AppColors.textSecondary), onPressed: onRemove),
          Text(
            quantity.toString().padLeft(2, '0'),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
          ),
          IconButton(icon: const Icon(Icons.add, size: 18, color: AppColors.primary), onPressed: onAdd),
        ],
      ),
    );
  }
}