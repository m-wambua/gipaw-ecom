

import 'package:flutter/material.dart';
import 'package:flutter_application_1/globals/structure/products_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShoppingCart extends ChangeNotifier {
  List<Product> items = [];
  List<OrderedProduct> _orderedProducts = [];
  
  
  List<OrderedProduct> get orderedProducts => _orderedProducts;

  int _itemCount = 0;
  int get itemCount =>
      _itemCount; // COunter for the number of items in the cart
  void setOrderedProduct(List<OrderedProduct> orderedProducts) {
    _orderedProducts = orderedProducts;
    notifyListeners();
  }

  void addProduct(OrderedProduct orderedProduct) {
    _orderedProducts.add(orderedProduct);
    notifyListeners();
  }

  // Add a method to get the ordered products
  List<OrderedProduct> getOrderedProducts() {
    return _orderedProducts;
  }

  void addToCart(Product product) {
    items.add(product);
    _itemCount++;
    notifyListeners();
    print('Item added to the cart. Updated itemcount: $_itemCount');
    print('the counter is here: ');
    // Increamnet the count when adding a product
  }

  int getItemCount() {
    return _itemCount;
  }

  void removeProduct(Product product) {
    items.remove(product);
    _itemCount--;
    notifyListeners();
    print('Item removed from the cart. Updated item count: $_itemCount');
  }

  Range calculatedTotalPrice() {
    double mintotalPrice = 0.0;
    double maxtotalPrice = 0.0;
    for (var product in items) {
      mintotalPrice += product.price.start;
      maxtotalPrice += product.price.end;
    }
    return Range(start: mintotalPrice, end: maxtotalPrice);
  }

  void removeOrderedProduct(OrderedProduct orderedProduct) {
    _orderedProducts.remove(orderedProduct);
  }

  // Or if you want to remove by product
  void removeProductAsProduct(Product product) {
    _orderedProducts.removeWhere((orderedProduct) => orderedProduct.product == product);
  }



  

 
}
