import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_skincare/controllers/product_controller.dart';
import 'package:mini_skincare/core/theme/app_theme.dart';
import 'package:mini_skincare/data/models/product_model.dart';
import 'product_detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productController = Get.find<ProductController>();

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Saved Products'),
      ),
      body: Obx(() {
        final savedProducts = productController.products
            .where((p) => productController.favoriteIds.contains(p.id.toString()))
            .toList();

        if (savedProducts.isEmpty) {
          return const _EmptyState();
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: savedProducts.length,
          itemBuilder: (context, index) {
            final product = savedProducts[index];
            return _SavedProductCard(
              product: product,
              onTap: () => Get.to(() => ProductDetailScreen(product: product)),
              onUnfavorite: () => productController.toggleFavorite(product.id.toString()),
            );
          },
        );
      }),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'No saved products yet.\nTap the heart icon on any product to save it here!',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.grey, fontSize: 16),
      ),
    );
  }
}

class _SavedProductCard extends StatelessWidget {
  const _SavedProductCard({
    required this.product,
    required this.onTap,
    required this.onUnfavorite,
  });

  final ProductModel product;
  final VoidCallback onTap;
  final VoidCallback onUnfavorite;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        onTap: onTap,
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
        trailing: IconButton(
          icon: const Icon(Icons.favorite, color: Colors.red),
          onPressed: onUnfavorite,
        ),
      ),
    );
  }
}