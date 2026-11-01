import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_skincare/controllers/auth_controller.dart';
import 'package:mini_skincare/controllers/product_controller.dart';
import 'package:mini_skincare/core/theme/app_theme.dart';
import 'login_screen.dart';
import 'product_detail_screen.dart';
import 'routine_screen.dart';
import 'category_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final productController = Get.find<ProductController>();

    final categories = ['All', 'Cleanser', 'Toner', 'Serum', 'Sunscreen'];

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
        appBar: AppBar(
          title: Obx(() => Text(
            'Welcome, ${authController.userName.value.isEmpty ? "Skincare Fan" : authController.userName.value} ✨',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          )),
          actions: [
            IconButton(
              icon: const Icon(Icons.checklist_rtl),
              onPressed: () => Get.to(() => const RoutineScreen()),
            ),
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                authController.logout();
                Get.offAll(() => const LoginScreen());
              },
            ),
          ],
        ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search products or routines...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Categories Horizontal List
              const Text(
                'Categories',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final cat = categories[index];
                    return Obx(() {
                      final isSelected =
                          productController.selectedCategory.value == cat;
                      return GestureDetector(
                        onTap: () => productController.filterByCategory(cat),
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppTheme.primaryPurple
                                : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            cat,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black87,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      );
                    });
                  },
                ),
              ),
              const SizedBox(height: 24),

              // Product Cards List
              const Text(
                'Recommended for You',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Obx(() {
                final items = productController.selectedCategory.value == 'All'
                    ? productController.products
                    : productController.products
                    .where((p) =>
                p.category ==
                    productController.selectedCategory.value)
                    .toList();

                if (items.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(32.0),
                      child: Text('No products found in this category.'),
                    ),
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final product = items[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        onTap: () {
                          Get.to(() => ProductDetailScreen(product: product));
                        },
                        contentPadding: const EdgeInsets.all(12),
                        leading: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppTheme.primaryPurple.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.sanitizer, color: AppTheme.primaryPurple),
                        ),
                        title: Text(
                          product.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text('${product.category} • ⭐ ${product.rating}'),
                        trailing: Text(
                          '\$${product.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryPurple,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}