import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:ecommerce_app/app_styles.dart';
import 'change_password_page.dart';
import 'login_page.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    // PERUBAHAN: Jumlah tab diubah menjadi 2
    return DefaultTabController(
      length: 2, // Jumlah tab: Pengaturan, Wishlist
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: const Text('Akun Saya', style: AppTextStyles.headerTitle),
          backgroundColor: AppColors.background,
          elevation: 0,
          centerTitle: true,
        ),
        body: Column(
          children: [
            _buildUserProfileCard(),
            // PERUBAHAN: Tab 'Pesanan Saya' dihapus
            const TabBar(
              labelColor: AppColors.primary,
              unselectedLabelColor: AppColors.textSecondary,
              indicatorColor: AppColors.primary,
              tabs: [
                Tab(icon: Icon(Icons.settings), text: 'Pengaturan'),
                Tab(icon: Icon(Icons.favorite_border), text: 'Wishlist'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildSettingsList(context),
                  // PERUBAHAN: Konten 'Pesanan Saya' dihapus
                  _buildPlaceholder(icon: Icons.favorite, message: 'Wishlist Anda masih kosong.'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget untuk kartu profil (tidak berubah)
Widget _buildUserProfileCard() {
  return Container(
    margin: const EdgeInsets.all(16.0),
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
    child: Row(
      children: [
        const CircleAvatar(
          radius: 40,
          backgroundImage: AssetImage('assets/images/profile.jpeg'),
        ),
        const SizedBox(width: 20),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Wibowo Assariy', style: AppTextStyles.headerTitle),
              SizedBox(height: 4),
              Text('admin@example.com', style: TextStyle(color: AppColors.textSecondary)),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.edit_outlined, color: AppColors.textSecondary),
          onPressed: () {},
        ),
      ],
    ),
  );
}

// Widget daftar pengaturan (tidak berubah)
Widget _buildSettingsList(BuildContext context) {
  final settings = [
    {'icon': Icons.lock_outline, 'title': 'Ubah Password'},
    {'icon': Icons.notifications_outlined, 'title': 'Notifikasi'},
    {'icon': Icons.help_outline, 'title': 'Bantuan & Dukungan'},
    {'icon': Icons.logout, 'title': 'Logout'},
  ];

  void handleTap(String title, BuildContext context) {
    switch (title) {
      case 'Ubah Password':
        Navigator.push(context, MaterialPageRoute(builder: (context) => const ChangePasswordPage()));
        break;
      case 'Logout':
        _showLogoutDialog(context);
        break;
      default:
        break;
    }
  }

  return AnimationLimiter(
    child: ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: settings.length,
      itemBuilder: (context, index) {
        final item = settings[index];
        return AnimationConfiguration.staggeredList(
          position: index,
          duration: const Duration(milliseconds: 375),
          child: SlideAnimation(
            verticalOffset: 50.0,
            child: FadeInAnimation(
              child: SettingListItem(
                icon: item['icon'] as IconData,
                title: item['title'] as String,
                onTap: () => handleTap(item['title'] as String, context),
              ),
            ),
          ),
        );
      },
    ),
  );
}

// Widget placeholder (tidak berubah)
Widget _buildPlaceholder({required IconData icon, required String message}) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 60, color: Colors.grey.shade300),
        const SizedBox(height: 16),
        Text(message, style: const TextStyle(color: AppColors.textSecondary, fontSize: 16)),
      ],
    ),
  );
}

// Dialog logout (tidak berubah)
void _showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text('Konfirmasi Logout', style: AppTextStyles.headerTitle),
      content: const Text('Apakah Anda yakin ingin keluar?', style: TextStyle(color: AppColors.textSecondary)),
      actionsPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Batal', style: TextStyle(color: AppColors.textSecondary))),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Logout Berhasil'), backgroundColor: Colors.green, behavior: SnackBarBehavior.floating));
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const LoginPage()), (Route<dynamic> route) => false);
          },
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.danger, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          child: const Text('Logout', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ],
    ),
  );
}

// Widget SettingListItem (tidak berubah)
class SettingListItem extends StatefulWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  const SettingListItem({super.key, required this.icon, required this.title, required this.onTap});

  @override
  State<SettingListItem> createState() => _SettingListItemState();
}

class _SettingListItemState extends State<SettingListItem> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final transform = _isPressed ? (Matrix4.identity()..scale(0.96)) : (_isHovered ? (Matrix4.identity()..translate(0, -4, 0)) : Matrix4.identity());
    final decoration = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      boxShadow: [BoxShadow(color: _isHovered ? AppColors.primary.withOpacity(0.2) : Colors.blue.shade50.withOpacity(0.5), spreadRadius: _isHovered ? 3 : 1, blurRadius: _isHovered ? 12 : 10, offset: _isHovered ? const Offset(0, 8) : const Offset(0, 4))],
    );

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) {
          setState(() => _isPressed = false);
          widget.onTap();
        },
        onTapCancel: () => setState(() => _isPressed = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          transform: transform,
          decoration: decoration,
          child: Row(
            children: [
              Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(10)), child: Icon(widget.icon, color: AppColors.primary, size: 24)),
              const SizedBox(width: 16),
              Expanded(child: Text(widget.title, style: AppTextStyles.settingItem)),
              const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}