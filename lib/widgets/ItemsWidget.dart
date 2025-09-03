import 'package:flutter/material.dart';
import 'package:ecommerce_app/app_styles.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'dart:ui'; // Diperlukan untuk ImageFilter.blur

// Model data untuk produk
class Product {
  final String image;
  final String name;
  final String price;
  bool isFavorite;

  Product({
    required this.image,
    required this.name,
    required this.price,
    this.isFavorite = false,
  });
}

class ItemsWidget extends StatelessWidget {
  ItemsWidget({super.key});

  final List<Product> products = [
    Product(image: 'images/items/1.jpeg', name: 'Jam Tangan Elegan', price: 'Rp 750.000', isFavorite: true),
    Product(image: 'images/items/2.jpeg', name: 'Tas Kulit Premium', price: 'Rp 1.250.000'),
    Product(image: 'images/items/3.jpeg', name: 'Sepatu Lari', price: 'Rp 950.000'),
    Product(image: 'images/items/4.jpeg', name: 'Kaos Modern', price: 'Rp 350.000'),
  ];

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 3 / 4, // Rasio aspek kartu (lebar banding tinggi)
          ),
          itemBuilder: (context, index) {
            return AnimationConfiguration.staggeredGrid(
              position: index,
              columnCount: 2,
              duration: const Duration(milliseconds: 500),
              child: ScaleAnimation(
                child: FadeInAnimation(
                  child: _ProductCard(product: products[index]),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// Widget kartu produk yang interaktif dan stateful
class _ProductCard extends StatefulWidget {
  final Product product;
  const _ProductCard({required this.product});

  @override
  State<_ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<_ProductCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        // Efek mengangkat saat di-hover
        transform: _isHovered ? (Matrix4.identity()..translate(0, -8, 0)) : Matrix4.identity(),
        child: Card(
          clipBehavior: Clip.antiAlias, // Memastikan semua konten mengikuti bentuk kartu
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: _isHovered ? 12 : 4,
          shadowColor: Colors.black.withOpacity(0.15),
          child: Stack(
            fit: StackFit.expand, // Membuat Stack mengisi seluruh kartu
            children: [
              // 1. Gambar sebagai lapisan paling bawah, mengisi penuh
              Image.asset(
                widget.product.image,
                fit: BoxFit.cover,
              ),
              // 2. Lapisan gradasi agar teks terbaca
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black.withOpacity(0.7), Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.center,
                  ),
                ),
              ),
              // 3. Tombol Favorit di pojok kanan atas
              Positioned(
                top: 8,
                right: 8,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(
                          widget.product.isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: widget.product.isFavorite ? AppColors.danger : Colors.white,
                        ),
                        onPressed: () => setState(() => widget.product.isFavorite = !widget.product.isFavorite),
                      ),
                    ),
                  ),
                ),
              ),
              // 4. Informasi Produk di bagian bawah
              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        shadows: [Shadow(blurRadius: 2, color: Colors.black54)],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.product.price,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: const CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.white,
                            child: Icon(Icons.add_shopping_cart, color: AppColors.primary, size: 22),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}