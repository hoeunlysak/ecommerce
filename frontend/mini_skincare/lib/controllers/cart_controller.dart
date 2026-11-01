import 'package:get/get.dart';
import 'package:mini_skincare/data/models/product_model.dart';

class CartItem {
  CartItem({required this.product, int quantity = 1})
      : quantity = quantity.obs;

  final ProductModel product;
  final RxInt quantity;
}

class CartController extends GetxController {
  final cartItems = <CartItem>[].obs;

  void addToCart(ProductModel product) {
    final index = cartItems.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      cartItems[index].quantity.value++;
    } else {
      cartItems.add(CartItem(product: product));
    }
    Get.snackbar(
      'Cart',
      '${product.name} added to cart!',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  void removeFromCart(CartItem item) => cartItems.remove(item);

  void incrementQuantity(CartItem item) => item.quantity.value++;

  void decrementQuantity(CartItem item) {
    if (item.quantity.value > 1) {
      item.quantity.value--;
    } else {
      removeFromCart(item);
    }
  }

  double get totalPrice => cartItems.fold(
    0.0,
        (sum, item) => sum + item.product.price * item.quantity.value,
  );

  int get itemCount =>
      cartItems.fold(0, (sum, item) => sum + item.quantity.value);
}