import 'package:flutter/material.dart';
import 'package:flutter_application_1/globals/structure/products_card.dart';

class CheckoutData extends ChangeNotifier {
  List<OrderedProduct> orderedProducts = [];
  String orderNumber = '';
  double grandTotal = 0.0;

  void updateData({
    required List<OrderedProduct> orderedProducts,
    required String orderNumber,
    required double grandTotal,
  }) {
    this.orderedProducts = orderedProducts;
    this.orderNumber = orderNumber;
    this.grandTotal = grandTotal;
    notifyListeners();
  }

  void addOrderedProduct(OrderedProduct product) {
    orderedProducts.add(product);
    notifyListeners();
  }

  void removeOrderedProduct(OrderedProduct product) {
    orderedProducts.remove(product);
    notifyListeners();
  }
}
