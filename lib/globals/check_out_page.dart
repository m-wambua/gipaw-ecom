import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/globals/products_card.dart';
import 'package:flutter_application_1/globals/shopping_cart.dart';

class CheckoutPage extends StatelessWidget {
  final ShoppingCart shoppingCart;

  const CheckoutPage({
    Key? key,
    required this.shoppingCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the list of ordered products from the shopping cart
    final List<OrderedProduct> orderedProducts =
        shoppingCart.getOrderedProducts();
    //Generate a random alphanumeric order number
    String orderNumber = generateOrderNumber();

    // Calculate the grand total by summing up the total Prices of all ordered products
    double grandTotal = orderedProducts.fold<double>(
      0,
      (previousValue, orderedProduct) =>
          previousValue + orderedProduct.totalPrice,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: orderedProducts.length,
              itemBuilder: (context, index) {
                final orderedProduct = orderedProducts[index];
                return ListTile(
                  title: Text(orderedProduct.product.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Quantity: ${orderedProduct.quantity}'),
                      Text('Size: ${orderedProduct.size}'),
                      Text(
                          'Price: \$${orderedProduct.totalPrice.toStringAsFixed(2)}'),
                      Text(
                        'Order Number: $orderNumber',
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // Implement the logic to remove the ordered product
                      removeProduct(orderedProduct);
                    },
                  ),
                );
              },
            ),
          ),
          // Add other widgets like total price here
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Total Price: \$${grandTotal.toStringAsFixed(2)}'),
              ],
            ),
          )
        ],
      ),
    );
  }

  String generateOrderNumber() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    return String.fromCharCodes(Iterable.generate(
        10, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
  }

  void removeProduct(OrderedProduct orderedProduct) {
    shoppingCart.removeOrderedProduct(orderedProduct);
  }
}
