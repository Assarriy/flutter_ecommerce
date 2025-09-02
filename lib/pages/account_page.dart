import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:ecommerce_app/app_styles.dart';
import 'change_password_page.dart';
import 'login_page.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          _buildElegantAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              child: _buildSettingsList(context),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildElegantAppBar() {
  return SliverAppBar(
    expandedHeight: 250.0,
    backgroundColor: AppColors.primary,
    elevation: 0,
    pinned: true,
    stretch: true,
    flexibleSpace: FlexibleSpaceBar(
      centerTitle: true,
      titlePadding: const EdgeInsets.only(bottom: 16),
      // title: const Text('My Account', style: TextStyle(fontWeight: FontWeight.bold)),
      background: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primary, AppColors.lightBlue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Align(
          alignment: Alignment.center,
          child: _buildProfileHeader(),
        ),
      ),
    ),
  );
}

Widget _buildProfileHeader() {
  return Padding(
    padding: const EdgeInsets.only(top: 50.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 3),
            boxShadow: const [
              BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 4)),
            ],
          ),
          child: ClipOval(
            child: Image.asset(
              'assets/images/profile.jpeg',
              width: 90,
              height: 90,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 12),
        const Text('Wibowo Assariy', style: AppTextStyles.profileName),
        const SizedBox(height: 4),
        const Text('admin@example.com', style: AppTextStyles.profileEmail),
      ],
    ),
  );
}

Widget _buildSettingsList(BuildContext context) {
  final settings = [
    {'icon': Icons.person_outline, 'title': 'Edit Profile'},
    {'icon': Icons.lock_outline, 'title': 'Change Password'},
    {'icon': Icons.notifications_outlined, 'title': 'Notifications'},
    {'icon': Icons.help_outline, 'title': 'Help & Support'},
    {'icon': Icons.logout, 'title': 'Logout'},
  ];

  void handleTap(String title) {
    switch (title) {
      case 'Change Password':
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
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Settings", style: AppTextStyles.headerTitle),
        const SizedBox(height: 10),
        ...List.generate(settings.length, (index) {
          final item = settings[index];
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 400),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: SettingListItem(
                  icon: item['icon'] as IconData,
                  title: item['title'] as String,
                  onTap: () => handleTap(item['title'] as String),
                ),
              ),
            ),
          );
        }),
      ],
    ),
  );
}

void _showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Confirm Logout', style: AppTextStyles.headerTitle),
        content: const Text('Are you sure you want to log out?', style: TextStyle(color: AppColors.textSecondary)),
        actionsPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel', style: TextStyle(color: AppColors.textSecondary)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Logout Successful'),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                ),
              );
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginPage()),
                (Route<dynamic> route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.danger,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            child: const Text('Logout', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      );
    },
  );
}

// -- Widget Interaktif untuk Item Menu --
class SettingListItem extends StatefulWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const SettingListItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  State<SettingListItem> createState() => _SettingListItemState();
}

class _SettingListItemState extends State<SettingListItem> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final transform = _isPressed
        ? (Matrix4.identity()..scale(0.96))
        : (_isHovered
            ? (Matrix4.identity()..translate(0, -4, 0))
            : Matrix4.identity());

    final decoration = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: _isHovered
              ? AppColors.primary.withOpacity(0.2)
              : Colors.blue.shade50.withOpacity(0.5),
          spreadRadius: _isHovered ? 3 : 1,
          blurRadius: _isHovered ? 12 : 10,
          offset: _isHovered ? const Offset(0, 8) : const Offset(0, 4),
        ),
      ],
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
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(widget.icon, color: AppColors.primary, size: 24),
              ),
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