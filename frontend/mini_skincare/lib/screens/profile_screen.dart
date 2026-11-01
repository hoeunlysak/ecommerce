import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_skincare/controllers/auth_controller.dart';
import 'package:mini_skincare/core/theme/app_theme.dart';
import 'login_screen.dart';
import 'favorites_screen.dart';
import 'add_product_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthController _authController = Get.find<AuthController>();

  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;

  void _onNotificationsChanged(bool value) {
    setState(() => _notificationsEnabled = value);
    Get.snackbar(
      'Notifications',
      value ? 'Reminders enabled' : 'Reminders disabled',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  void _onDarkModeChanged(bool value) {
    setState(() => _darkModeEnabled = value);
    Get.changeTheme(value ? ThemeData.dark() : AppTheme.lightTheme);
  }

  void _onLogout() {
    _authController.logout();
    Get.offAll(() => const LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('My Profile'),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              _ProfileHeader(authController: _authController),
              const SizedBox(height: 32),
              const _SectionTitle('Preferences'),
              const SizedBox(height: 12),
              _SettingsCard(
                children: [
                  SwitchListTile(
                    activeColor: AppTheme.primaryPurple,
                    secondary: const Icon(
                      Icons.notifications_none,
                      color: AppTheme.primaryPurple,
                    ),
                    title: const Text('Routine Reminders'),
                    subtitle: const Text('Daily AM/PM push notifications'),
                    value: _notificationsEnabled,
                    onChanged: _onNotificationsChanged,
                  ),
                  SwitchListTile(
                    activeColor: AppTheme.primaryPurple,
                    secondary: const Icon(
                      Icons.dark_mode_outlined,
                      color: AppTheme.primaryPurple,
                    ),
                    title: const Text('Dark Theme'),
                    subtitle: const Text('Switch app display theme'),
                    value: _darkModeEnabled,
                    onChanged: _onDarkModeChanged,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const _SectionTitle('Account'),
              const SizedBox(height: 12),
              _SettingsCard(
                children: [
                  _AccountTile(
                    icon: Icons.favorite_outline,
                    title: 'Saved Products',
                    onTap: () => Get.to(() => const FavoritesScreen()),
                  ),
                  _AccountTile(
                    icon: Icons.shield_outlined,
                    title: 'Privacy Policy',
                    onTap: () {},
                  ),
                  _AccountTile(
                    icon: Icons.add_box_outlined,
                    title: 'Add New Product (Admin)',
                    onTap: () => Get.to(() => const AddProductScreen()),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              _LogoutButton(onPressed: _onLogout),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.authController});

  final AuthController authController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: AppTheme.primaryPurple.withOpacity(0.15),
          child: const Icon(
            Icons.person,
            size: 60,
            color: AppTheme.primaryPurple,
          ),
        ),
        const SizedBox(height: 16),
        Obx(
              () => Text(
            authController.userName.value.isEmpty
                ? 'Skincare Enthusiast'
                : authController.userName.value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'user@example.com',
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  const _SettingsCard({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          for (int i = 0; i < children.length; i++) ...[
            if (i > 0) const Divider(height: 1),
            children[i],
          ],
        ],
      ),
    );
  }
}

class _AccountTile extends StatelessWidget {
  const _AccountTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.primaryPurple),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          side: const BorderSide(color: Colors.redAccent),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        icon: const Icon(Icons.logout, color: Colors.redAccent),
        label: const Text(
          'Log Out',
          style: TextStyle(
            color: Colors.redAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}