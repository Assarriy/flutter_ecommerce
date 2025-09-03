import 'package:flutter/material.dart';
import 'package:ecommerce_app/app_styles.dart';

class CartAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CartAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // PERUBAHAN: Dibuat transparan dan menyatu dengan body
      backgroundColor: AppColors.background,
      // PERUBAHAN: Menghilangkan shadow bawaan untuk tampilan yang flat
      elevation: 0,
      // PERUBAHAN: Menambahkan garis bawah tipis sebagai pemisah
      shape: Border(
        bottom: BorderSide(
          color: Colors.grey.withOpacity(0.2),
          width: 1,
        ),
      ),

      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.textPrimary),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),

      // PERUBAHAN: Memberi sedikit penyesuaian pada gaya judul
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.shopping_cart_outlined, color: AppColors.primary),
          const SizedBox(width: 12),
          Text('Keranjang Saya', style: AppTextStyles.headerTitle.copyWith(fontSize: 20)),
        ],
      ),
      centerTitle: true,

      actions: [
        // PERUBAHAN: Memberi sedikit sentuhan pada tombol aksi
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: PopupMenuButton<String>(
            onSelected: (value) {
              // Aksi
            },
            icon: const Icon(Icons.more_vert, color: AppColors.textPrimary, size: 26),
            // PERUBAHAN: Mendesain item di dalam popup menu
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'empty_cart',
                child: Row(
                  children: [
                    Icon(Icons.delete_sweep_outlined, color: AppColors.textSecondary),
                    SizedBox(width: 12),
                    Text('Kosongkan Keranjang'),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: 'help',
                child: Row(
                  children: [
                    Icon(Icons.help_outline, color: AppColors.textSecondary),
                    SizedBox(width: 12),
                    Text('Bantuan'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}