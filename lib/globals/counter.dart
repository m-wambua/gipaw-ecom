import 'package:flutter/material.dart';
import 'package:flutter_application_1/globals/products_card.dart';
import 'package:provider/provider.dart';
 // Adjust the import path

class CounterDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Use Provider to get the ShoppingCart instance
    final shoppingCart = Provider.of<ShoppingCart>(context);

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        'Cart Count: ${shoppingCart.itemCount}',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
