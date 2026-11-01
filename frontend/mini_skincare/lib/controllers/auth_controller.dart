import 'package:get/get.dart';

class AuthController extends GetxController {
  var isLoggedIn = false.obs;
  var userName = ''.obs;

  void login(String email, String password) {
    // Simulated authentication success
    isLoggedIn.value = true;
    userName.value = email.split('@').first;
  }

  void register(String name, String email, String password) {
    isLoggedIn.value = true;
    userName.value = name;
  }

  void logout() {
    isLoggedIn.value = false;
    userName.value = '';
  }
}