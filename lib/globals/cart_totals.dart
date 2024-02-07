
import 'package:flutter/material.dart';
import 'package:flutter_application_1/globals/products_card.dart';

class CartTotals extends StatelessWidget {
  final ShoppingCart shoppingCart;

  const CartTotals({Key? key, required this.shoppingCart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double totalMin = shoppingCart.items.fold(0, (sum, product) => sum + product.price.start);
    double totalMax = shoppingCart.items.fold(0, (sum, product) => sum + product.price.end);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Total: \$${totalMin.toStringAsFixed(2)}- \$${totalMax.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
