import 'package:flutter/material.dart';
import 'package:flutter_application_1/globals/structure/products_card.dart';

class OrderedProductsProvider extends ChangeNotifier {
  List<OrderedProduct> _orderedProducts = [];

  List<OrderedProduct> get orderedProducts => _orderedProducts;

  void updateOrderedProducts(List<OrderedProduct> products) {
    _orderedProducts = products;
    notifyListeners();
  }
}
