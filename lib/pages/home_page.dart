import 'package:ecommerce_app/app_styles.dart';
import 'package:ecommerce_app/pages/account_page.dart';
import 'package:ecommerce_app/pages/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ecommerce_app/app_styles.dart';
import 'package:ecommerce_app/widgets/CategoriesWidget.dart';
import 'package:ecommerce_app/widgets/HomeAppBar.dart';
import 'package:ecommerce_app/widgets/ItemsWidget.dart';

// === HALAMAN UTAMA DENGAN NAVIGASI (TIDAK BERUBAH) ===
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: const [
          HomePageContent(),
          CartPage(),
          AccountPage(),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        height: 70,
        color: AppColors.primary,
        buttonBackgroundColor: Colors.white,
        items: [
          Icon(Icons.home, size: 30, color: _currentIndex == 0 ? AppColors.primary : Colors.white),
          Icon(Icons.shopping_cart, size: 30, color: _currentIndex == 1 ? AppColors.primary : Colors.white),
          Icon(Icons.account_circle_sharp, size: 30, color: _currentIndex == 2 ? AppColors.primary : Colors.white),
        ],
        index: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _pageController.jumpToPage(index);
          });
        },
      ),
    );
  }
}

// === KONTEN UNTUK HALAMAN HOME (DIROMBAK TOTAL) ===
class HomePageContent extends StatelessWidget {
  const HomePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // HomeAppBar Anda yang sudah ada
        const HomeAppBar(),

        // Search Bar yang lebih menyatu dengan background
        SliverToBoxAdapter(
          child: Container(
            color: AppColors.background,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Cari produk impianmu...",
                fillColor: Colors.white,
                filled: true,
                prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
        ),

        // Konten utama
        SliverToBoxAdapter(
          child: Column(
            children: [
              // Widget baru untuk promo banner
              const _PromoBannerWidget(),
              // Seksi Kategori
              SectionHeader(title: 'Kategori', onSeeAll: () {}),
              const CategoriesWidget(),
              const SizedBox(height: 20,),
              // Seksi Produk Terlaris
              SectionHeader(title: 'Produk Terlaris', onSeeAll: () {}),
              ItemsWidget(),
              // const SizedBox(height: 5),
            ],
          ),
        ),
      ],
    );
  }
}

// === WIDGET-WIDGET BARU & YANG DIPERBARUI ===

// WIDGET BARU: Promo Banner yang interaktif
class _PromoBannerWidget extends StatelessWidget {
  const _PromoBannerWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: const EdgeInsets.symmetric(vertical: 24),
      child: PageView.builder(
        itemCount: 3, // Jumlah banner promo
        controller: PageController(viewportFraction: 0.9), // Agar banner di samping terlihat sedikit
        itemBuilder: (context, index) {
          return Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            margin: const EdgeInsets.symmetric(horizontal: 8),
            elevation: 8,
            shadowColor: Colors.black.withOpacity(0.2),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset('images/items/${index + 1}.jpeg', fit: BoxFit.cover),
                Container(decoration: BoxDecoration(color: Colors.black.withOpacity(0.4))),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Diskon Akhir Tahun\nHingga 50%',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          shadows: [Shadow(blurRadius: 10, color: Colors.black)],
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          foregroundColor: AppColors.primary, backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        ),
                        child: const Text('Belanja Sekarang'),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

// WIDGET DIPERBARUI: SectionHeader dengan tombol "See All"
class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onSeeAll;

  const SectionHeader({super.key, required this.title, required this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 16, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTextStyles.headerTitle),
          TextButton(
            onPressed: onSeeAll,
            child: const Text('Lihat Semua', style: TextStyle(color: AppColors.primary)),
          ),
        ],
      ),
    );
  }
}