import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_skincare/core/theme/app_theme.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static const _splashDuration = Duration(seconds: 3);

  @override
  void initState() {
    super.initState();
    Future.delayed(_splashDuration, _goToLogin);
  }

  void _goToLogin() {
    if (!mounted) return;
    Get.off(() => const LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const _LogoPlaceholder(),
            const SizedBox(height: 24),
            Text(
              'Marvel Store',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryPurple,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'skincare Product',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

/// Temporary logo until the real asset is ready.
class _LogoPlaceholder extends StatelessWidget {
  const _LogoPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.primaryPurple.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.spa,
        size: 80,
        color: AppTheme.primaryPurple,
      ),
    );
  }
}