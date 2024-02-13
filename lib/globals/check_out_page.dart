import 'package:flutter/material.dart';
import 'package:flutter_application_1/globals/products_card.dart';

class CheckoutPage extends StatelessWidget {
  final ShoppingCart shoppingCart;

  const CheckoutPage({
    Key? key,
    required this.shoppingCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the list of ordered products from the shopping cart
    final List<OrderedProduct> orderedProducts = shoppingCart.getOrderedProducts();

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
                      Text('Price: \$${orderedProduct.totalPrice.toStringAsFixed(2)}'),
                    ],
                  ),
                );
              },
            ),
          ),
          // Add other widgets like total price here
        ],
      ),
    );
  }
}

/*
class CheckoutPage extends StatelessWidget {
  final List<OrderedProduct> orderedProducts;

  const CheckoutPage({Key? key, required this.orderedProducts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                      Text('Price: \$${orderedProduct.totalPrice.toStringAsFixed(2)}'),
                    ],
                  ),
                );
              },
            ),
          ),
          Divider(), // Add a divider between items and total price
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Total Price: \$${_calculateTotalPrice().toStringAsFixed(2)}'),
          ),
        ],
      ),
    );
  }

  double _calculateTotalPrice() {
    return orderedProducts.fold(0, (total, product) => total + product.totalPrice);
  }
}
*/
