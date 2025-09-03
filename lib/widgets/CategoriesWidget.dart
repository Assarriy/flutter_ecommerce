import 'package:flutter/material.dart';
import 'package:ecommerce_app/app_styles.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // PERUBAHAN: Struktur data yang lebih baik, menggabungkan label dengan ikon
    final List<Map<String, dynamic>> categories = [
      {'icon': Icons.style_rounded, 'label': 'Outfit'},
      {'icon': Icons.fastfood_outlined, 'label': 'Makanan'},
      {'icon': Icons.spa_outlined, 'label': 'Skincare'},
      {'icon': Icons.phone_android, 'label': 'Elektronik'},
      {'icon': Icons.chair_outlined, 'label': 'Furniture'},
      {'icon': Icons.sports_esports_outlined, 'label': 'Gaming'},
    ];

    // PERUBAHAN: Menggunakan ListView.builder untuk performa yang lebih baik
    return SizedBox(
      height: 100, // Tinggi tetap untuk list horizontal
      child: AnimationLimiter(
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          itemBuilder: (context, index) {
            final category = categories[index];
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 375),
              child: SlideAnimation(
                horizontalOffset: 50.0,
                child: FadeInAnimation(
                  // Widget untuk setiap item kategori
                  child: _buildCategoryItem(
                    icon: category['icon'] as IconData,
                    label: category['label'] as String,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // WIDGET BARU: Desain untuk setiap item kategori
  Widget _buildCategoryItem({required IconData icon, required String label}) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Ikon melingkar
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              // PERUBAHAN: Menggunakan warna dari tema
              color: AppColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.primary, size: 30),
          ),
          const SizedBox(height: 8),
          // Label teks
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}