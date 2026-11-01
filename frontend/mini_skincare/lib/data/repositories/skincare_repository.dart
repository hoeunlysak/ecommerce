import 'package:mini_skincare/data/models/product_model.dart';

class SkincareRepository {
  List<ProductModel> getMockProducts() {
    return [
      ProductModel(
        id: '1',
        name: 'Gentle Hydrating Cleanser',
        category: 'Cleanser',
        price: 18.50,
        rating: 4.8,
        description: 'A soothing gel cleanser infused with hyaluronic acid and ceramides.',
      ),
      ProductModel(
        id: '2',
        name: 'Niacinamide 10% Serum',
        category: 'Serum',
        price: 24.00,
        rating: 4.9,
        description: 'Reduces dark spots, balances sebum, and tightens pores.',
      ),
      ProductModel(
        id: '3',
        name: 'Daily Barrier Defense Sunscreen SPF 50',
        category: 'Sunscreen',
        price: 22.00,
        rating: 4.7,
        description: 'Lightweight, non-greasy mineral broad-spectrum protection.',
      ),
    ];
  }
}