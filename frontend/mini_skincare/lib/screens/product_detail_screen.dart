import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_skincare/controllers/cart_controller.dart';
import 'package:mini_skincare/core/theme/app_theme.dart';
import 'package:mini_skincare/data/models/product_model.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Text(product.name),
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: _ProductInfo(product: product),
              ),
            ),
            _AddToCartBar(
              onPressed: () => cartController.addToCart(product),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductInfo extends StatelessWidget {
  const _ProductInfo({required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Center(child: _ProductImage()),
        const SizedBox(height: 24),
        Text(
          product.name,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          '${product.category} • ⭐ ${product.rating}',
          style: const TextStyle(color: Colors.grey, fontSize: 16),
        ),
        const SizedBox(height: 16),
        Text(
          '\$${product.price.toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryPurple,
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Description',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          product.description,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black54,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}

class _ProductImage extends StatelessWidget {
  const _ProductImage();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 140,
      decoration: BoxDecoration(
        color: AppTheme.primaryPurple.withOpacity(0.15),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.sanitizer,
        size: 80,
        color: AppTheme.primaryPurple,
      ),
    );
  }
}

class _AddToCartBar extends StatelessWidget {
  const _AddToCartBar({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primaryPurple,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          icon: const Icon(Icons.shopping_bag_outlined, color: Colors.white),
          label: const Text(
            'Add to Cart',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}