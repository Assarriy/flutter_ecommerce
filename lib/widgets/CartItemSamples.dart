import 'package:flutter/material.dart';
import 'package:ecommerce_app/app_styles.dart';

// Model data untuk setiap item di keranjang
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
  // Data sampel yang sekarang memiliki state (kuantitas & visibilitas)
  final List<CartItem> items = [
    CartItem(image: "assets/images/logo.jpeg", name: "Stylish Watch", price: "Rp750.000"),
    CartItem(image: "assets/images/logo.jpeg", name: "Leather Bag", price: "Rp1.250.000"),
    CartItem(image: "assets/images/logo.jpeg", name: "Running Shoes", price: "Rp950.000", quantity: 2),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(items.length, (index) {
        final item = items[index];
        // Menggunakan AnimatedSize dan Opacity untuk efek menghilang
        return AnimatedSize(
          duration: const Duration(milliseconds: 300),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: item.isVisible ? 1.0 : 0.0,
            child: item.isVisible ? _buildCartItemCard(item, index) : const SizedBox.shrink(),
          ),
        );
      }),
    );
  }

  Widget _buildCartItemCard(CartItem item, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        // TUGAS 3.3.4: Menambahkan efek shadow pada kartu item
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
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(item.name, style: AppTextStyles.settingItem, overflow: TextOverflow.ellipsis),
                    ),
                    // TUGAS 3.3.6: Mengaktifkan tombol delete
                    IconButton(
                      icon: const Icon(Icons.delete_outline, color: AppColors.danger, size: 24),
                      onPressed: () {
                        setState(() {
                          item.isVisible = false;
                        });
                        // Menampilkan Snackbar dengan tombol Undo
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${item.name} removed from cart.'),
                            action: SnackBarAction(
                              label: 'UNDO',
                              onPressed: () {
                                setState(() {
                                  item.isVisible = true;
                                });
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(item.price, style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 18)),
                    // TUGAS 3.3.5: Mengaktifkan kontrol kuantitas
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
          IconButton(
            icon: const Icon(Icons.remove, size: 18, color: AppColors.textSecondary),
            onPressed: onRemove,
            constraints: const BoxConstraints(),
            padding: const EdgeInsets.all(8),
          ),
          Text(
            quantity.toString().padLeft(2, '0'),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
          ),
          IconButton(
            icon: const Icon(Icons.add, size: 18, color: AppColors.primary),
            onPressed: onAdd,
            constraints: const BoxConstraints(),
            padding: const EdgeInsets.all(8),
          ),
        ],
      ),
    );
  }
}