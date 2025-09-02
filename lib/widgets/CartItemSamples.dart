import 'package:flutter/material.dart';
import 'package:ecommerce_app/app_styles.dart';

// Model data sederhana untuk setiap item
class CartItem {
  final String image;
  final String name;
  final String price;
  int quantity;
  bool isVisible; // Untuk menyembunyikan item (Tugas 3.3.6)

  CartItem({
    required this.image,
    required this.name,
    required this.price,
    this.quantity = 1,
    this.isVisible = true,
  });
}

// PERUBAHAN: Diubah menjadi StatefulWidget
class CartItemSamples extends StatefulWidget {
  const CartItemSamples({super.key});

  @override
  State<CartItemSamples> createState() => _CartItemSamplesState();
}

class _CartItemSamplesState extends State<CartItemSamples> {
  // Data item sekarang menjadi bagian dari state
  final List<CartItem> items = [
    CartItem(image: 'images/carts/1.jpeg', name: 'Product Title 1', price: 'Rp 850.000', quantity: 1),
    CartItem(image: 'images/carts/2.jpeg', name: 'Product Title 2', price: 'Rp 950.000', quantity: 2),
    CartItem(image: 'images/carts/3.jpeg', name: 'Product Title 3', price: 'Rp 750.000', quantity: 1),
    CartItem(image: 'images/carts/4.jpeg', name: 'Product Title 4', price: 'Rp 1.250.000', quantity: 1),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // STRUKTUR FOR LOOP TETAP DIPERTAHANKAN
        for (int i = 0; i < items.length; i++)
          // TUGAS 3.3.6: Widget Visibility untuk menyembunyikan item
          Visibility(
            visible: items[i].isVisible,
            child: _buildItemCard(items[i]),
          ),
      ],
    );
  }

  Widget _buildItemCard(CartItem item) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        // TUGAS 3.3.4: Menambahkan efek shadow
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(item.image, width: 80, height: 80, fit: BoxFit.cover),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(item.name, style: AppTextStyles.settingItem, overflow: TextOverflow.ellipsis),
                    ),
                    // TUGAS 3.3.6: Tombol Delete diaktifkan
                    IconButton(
                      icon: const Icon(Icons.delete_outline, color: AppColors.danger, size: 24),
                      onPressed: () {
                        setState(() {
                          item.isVisible = false;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(item.price, style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 18)),
                    // TUGAS 3.3.5: Kontrol kuantitas diaktifkan
                    _buildQuantityControl(
                      quantity: item.quantity,
                      onRemove: () {
                        if (item.quantity > 1) {
                          setState(() {
                            item.quantity--;
                          });
                        }
                      },
                      onAdd: () {
                        setState(() {
                          item.quantity++;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
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