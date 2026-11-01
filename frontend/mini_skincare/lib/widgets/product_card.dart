import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_skincare/controllers/product_controller.dart';
import 'package:mini_skincare/core/theme/app_theme.dart';
import 'package:mini_skincare/data/models/product_model.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  final ProductModel product;
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
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ImagePlaceholder(productId: product.id),
              const SizedBox(height: 8),
              Text(
                product.category,
                style: const TextStyle(
                  fontSize: 10,
                  color: AppTheme.primaryPurple,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                product.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const Spacer(),
              _RatingAndPrice(product: product),
            ],
          ),
        ),
      ),
    );
  }
}

/// Product image placeholder with the favorite button in its top-right corner.
class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder({required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 100,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppTheme.primaryPurple.withOpacity(0.08),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            Icons.spa,
            size: 48,
            color: AppTheme.primaryPurple.withOpacity(0.6),
          ),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: _FavoriteButton(productId: productId),
        ),
      ],
    );
  }
}

class _FavoriteButton extends StatelessWidget {
  const _FavoriteButton({required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context) {
    final productController = Get.find<ProductController>();

    return Obx(() {
      final isFavorite = productController.isFavorite(productId);
      return IconButton(
        icon: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          color: isFavorite ? Colors.red : Colors.grey,
          size: 20,
        ),
        onPressed: () => productController.toggleFavorite(productId),
      );
    });
  }
}

class _RatingAndPrice extends StatelessWidget {
  const _RatingAndPrice({required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(Icons.star, size: 14, color: Colors.amber),
            const SizedBox(width: 2),
            Text(
              '${product.rating}',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        Text(
          '\$${product.price.toStringAsFixed(2)}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: AppTheme.primaryPurple,
          ),
        ),
      ],
    );
  }
}