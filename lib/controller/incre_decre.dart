import 'package:get/get.dart';

class ProductController extends GetxController {
  RxDouble productPrice = 100.0.obs; // Initial product price, wrapped in Rx for reactive updates

  void incrementPrice(double amount) {
    productPrice.value += amount;
  }

  void decrementPrice(double amount) {
    if (productPrice.value - amount > 0) {
      productPrice.value -= amount;
    }
  }
}
