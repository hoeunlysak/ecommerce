import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_skincare/controllers/cart_controller.dart';
import 'package:mini_skincare/core/theme/app_theme.dart';
import 'home_screen.dart';
import 'category_screen.dart'; // <-- 1. Change import
import 'cart_screen.dart';
import 'profile_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  static const List<Widget> _screens = [
    HomeScreen(),
    CategoryScreen(), // <-- 2. Replace RoutineScreen with CategoryScreen
    CartScreen(),
    ProfileScreen(),
  ];

  final CartController _cartController = Get.find<CartController>();

  int _currentIndex = 0;

  void _onTabSelected(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: AppTheme.primaryPurple,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: _onTabSelected,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          // 3. Update icon & label to Category
          const BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_outlined),
            activeIcon: Icon(Icons.grid_view),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: _CartIcon(cartController: _cartController),
            activeIcon: const Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

/// Cart icon with a badge showing the number of items in the cart.
class _CartIcon extends StatelessWidget {
  const _CartIcon({required this.cartController});

  final CartController cartController;

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Badge(
        label: Text('${cartController.itemCount}'),
        isLabelVisible: cartController.itemCount > 0,
        child: const Icon(Icons.shopping_cart_outlined),
      ),
    );
  }
}