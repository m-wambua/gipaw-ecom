// checkout_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_application_1/globals/products_card.dart';

class CheckoutPage extends StatelessWidget {
  final double totalPrice;
  
  final List<Product> orderedItems;

  const CheckoutPage({Key? key, required this.totalPrice, required this.orderedItems})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Total Price: \$${totalPrice.toStringAsFixed(2)}'),
          const SizedBox(height: 16),
          const Text('Ordered Items:'),
          Expanded(
            child: ListView.builder(
              itemCount: orderedItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(orderedItems[index].name),
                  subtitle: Text(
                    '\$${orderedItems[index].price.start.toStringAsFixed(2)}',
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
