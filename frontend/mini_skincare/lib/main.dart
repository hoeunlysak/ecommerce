import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart'; // <-- Import GetStorage
import 'package:mini_skincare/controllers/auth_controller.dart';
import 'package:mini_skincare/controllers/product_controller.dart';
import 'package:mini_skincare/controllers/routine_controller.dart';
import 'package:mini_skincare/core/theme/app_theme.dart';
import 'package:mini_skincare/screens/splash_screen.dart';
import 'package:mini_skincare/controllers/cart_controller.dart';

// lib/main.dart

void main() async { // <-- Add 'async' here!
  WidgetsFlutterBinding.ensureInitialized();

  // Wait for storage to ready itself
  await GetStorage.init(); // <-- Add 'await' here!

  // Register Controllers
  Get.put(AuthController());
  Get.put(ProductController());
  Get.put(RoutineController());
  Get.put(CartController());

  runApp(const SkincareApp());
}

class SkincareApp extends StatelessWidget {
  const SkincareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Skincare App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}