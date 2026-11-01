import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_skincare/controllers/product_controller.dart';
import 'package:mini_skincare/core/theme/app_theme.dart';
import 'main_navigation_screen.dart';

class _Category {
  const _Category({
    required this.name,
    required this.icon,
    required this.count,
  });

  final String name;
  final IconData icon;
  final String count;
}

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  static const List<_Category> _categories = [
    _Category(
      name: 'Cleanser',
      icon: Icons.water_drop_outlined,
      count: '12 products',
    ),
    _Category(
      name: 'Toner',
      icon: Icons.opacity_outlined,
      count: '8 products',
    ),
    _Category(
      name: 'Serum',
      icon: Icons.science_outlined,
      count: '15 products',
    ),
    _Category(
      name: 'Sunscreen',
      icon: Icons.wb_sunny_outlined,
      count: '10 products',
    ),
    _Category(
      name: 'Moisturizer',
      icon: Icons.spa_outlined,
      count: '9 products',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final productController = Get.find<ProductController>();

    return Scaffold(

      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Categories'),
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: GridView.builder(
            itemCount: _categories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.1,
            ),
            itemBuilder: (context, index) {
              final category = _categories[index];
              return _CategoryCard(
                category: category,
                onTap: () {
                  productController.filterByCategory(category.name);
                  Get.offAll(() => const MainNavigationScreen());
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Categories',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        onPressed: () => Get.to(() => const CategoryScreen()),
                        child: const Text('See All'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({required this.category, required this.onTap});

  final _Category category;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 2,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: AppTheme.primaryPurple.withOpacity(0.12),
                child: Icon(
                  category.icon,
                  color: AppTheme.primaryPurple,
                  size: 28,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                category.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                category.count,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}