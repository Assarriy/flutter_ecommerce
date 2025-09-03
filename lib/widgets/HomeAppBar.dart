import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:ecommerce_app/app_styles.dart'; // Pastikan file ini diimpor

// PERUBAHAN: Widget ini sekarang mengembalikan SliverAppBar
class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      // PERUBAHAN: Menggunakan warna dari tema
      backgroundColor: AppColors.background,
      elevation: 0, // Tampilan modern tanpa bayangan
      pinned: false,
      floating: true, // AppBar akan muncul kembali saat pengguna scroll ke atas
      
      // Ikon di sisi kiri (untuk membuka drawer, misalnya)
      leading: IconButton(
        icon: const Icon(Icons.sort, size: 30, color: AppColors.textPrimary),
        onPressed: () {
          // Aksi standar untuk ikon ini adalah membuka drawer
          Scaffold.of(context).openDrawer();
        },
      ),
      
      // Judul di tengah
      centerTitle: true,
      title: const Text(
        "Happy Shop", // Menggunakan nama aplikasi yang konsisten
        style: AppTextStyles.headerTitle,
      ),
      
      // Ikon aksi di sisi kanan
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: badges.Badge(
            // PERUBAHAN: Menggunakan warna dari tema
            badgeStyle: const badges.BadgeStyle(
              badgeColor: AppColors.danger, // Warna merah untuk notifikasi
              padding: EdgeInsets.all(6),
            ),
            badgeContent: const Text(
              '3', // Contoh jumlah notifikasi
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
            position: badges.BadgePosition.topEnd(top: -4, end: -4),
            child: InkWell(
              onTap: () {
                // Navigator.pushNamed(context, "ListChat");
              },
              borderRadius: BorderRadius.circular(50),
              child: const Icon(
                Icons.notifications_none,
                size: 30,
                color: AppColors.textPrimary, // Menggunakan warna dari tema
              ),
            ),
          ),
        ),
      ],
    );
  }
}