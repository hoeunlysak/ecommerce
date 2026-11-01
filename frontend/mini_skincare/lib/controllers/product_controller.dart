import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mini_skincare/data/models/product_model.dart';

class ProductController extends GetxController {
  static const String _favoritesKey = 'favorite_products';
  static const double _defaultRating = 5.0; // Default rating for new items

  final GetStorage _box = GetStorage();

  final products = <ProductModel>[].obs;
  final selectedCategory = 'All'.obs;
  final searchQuery = ''.obs;
  final favoriteIds = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadProducts();
    _loadFavorites();
  }

  void _loadProducts() {
    products.value = [
      ProductModel(
        id: '1',
        name: 'Gentle Hydrating Cleanser',
        category: 'Cleanser',
        price: 18.99,
        rating: 4.8,
        description:
        'A soothing gel cleanser with hyaluronic acid and ceramides.',
      ),
      ProductModel(
        id: '2',
        name: 'Niacinamide 10% Serum',
        category: 'Serum',
        price: 24.50,
        rating: 4.6,
        description:
        'Targeted serum to minimize pores and even out skin tone.',
      ),
      ProductModel(
        id: '3',
        name: 'Daily Barrier Defense Sunscreen SPF 50',
        category: 'Sunscreen',
        price: 22.00,
        rating: 4.9,
        description: 'Broad-spectrum UV protection with zero white cast.',
      ),
      ProductModel(
        id: '4',
        name: 'Refreshing Hydrating Toner',
        category: 'Toner',
        price: 16.00,
        rating: 4.5,
        description: 'Alcohol-free face toner enriched with green tea extract.',
      ),
    ];
  }

  void _loadFavorites() {
    final List<dynamic>? stored = _box.read(_favoritesKey);
    if (stored != null) {
      favoriteIds.value = List<String>.from(stored);
    }
  }

  void filterByCategory(String category) {
    selectedCategory.value = category;
  }

  void setSearchQuery(String query) {
    searchQuery.value = query;
  }

  /// Toggles favorite status by product ID and persists the change.
  void toggleFavorite(String productId) {
    if (!favoriteIds.remove(productId)) {
      favoriteIds.add(productId);
    }
    _box.write(_favoritesKey, favoriteIds.toList());
  }

  bool isFavorite(String productId) => favoriteIds.contains(productId);

  /// Adds a new product to the list and shows a confirmation snackbar.
  void addProduct({
    required String name,
    required String category,
    required double price,
    required String description,
  }) {
    products.add(
      ProductModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        category: category,
        price: price,
        rating: _defaultRating,
        description: description,
      ),
    );

    Get.snackbar(
      'Success',
      'Product "$name" added successfully!',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  List<ProductModel> get filteredProducts {
    final category = selectedCategory.value;
    final query = searchQuery.value.toLowerCase();

    return products.where((product) {
      final matchesCategory = category == 'All' || product.category == category;
      final matchesSearch = product.name.toLowerCase().contains(query);
      return matchesCategory && matchesSearch;
    }).toList();
  }
}