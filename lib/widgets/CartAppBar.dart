import 'package:flutter/material.dart';
import 'package:ecommerce_app/app_styles.dart';

class CartAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CartAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 2, // TUGAS 3.3.4: Menambahkan efek shadow pada AppBar
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
        onPressed: () {
          // TUGAS 3.3.2: Menggunakan Navigator.pop untuk kembali
          Navigator.of(context).pop();
        },
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // TUGAS 3.3.1: Menambahkan ikon pada judul
          const Icon(Icons.shopping_cart_outlined, color: AppColors.primary),
          const SizedBox(width: 8),
          const Text('My Cart', style: AppTextStyles.headerTitle),
        ],
      ),
      centerTitle: true,
      actions: [
        // TUGAS 3.3.3: Menambahkan PopupMenuButton
        PopupMenuButton<String>(
          onSelected: (value) {
            // Aksi saat item menu dipilih
          },
          icon: const Icon(Icons.more_vert, color: AppColors.textPrimary),
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'empty_cart',
              child: Text('Empty Cart'),
            ),
            const PopupMenuItem<String>(
              value: 'help',
              child: Text('Help'),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}