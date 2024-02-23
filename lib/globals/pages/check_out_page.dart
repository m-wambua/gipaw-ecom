import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/globals/structure/products_card.dart';
import 'package:flutter_application_1/globals/structure/shopping_cart.dart';

class CheckoutPage extends StatefulWidget {
  final ShoppingCart shoppingCart;
  final VoidCallback onContinueShopping;

  const CheckoutPage({
    Key? key,
    required this.shoppingCart,
    required this.onContinueShopping,
  }) : super(key: key);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String orderNumber = '';
  double grandTotal = 0.0;

  @override
  void initState() {
    super.initState();
    // Generate order number and calculate grand total when the widget is initialized
    orderNumber = generateOrderNumber();
    grandTotal = calculateGrandTotal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.shoppingCart.getOrderedProducts().length,
              itemBuilder: (context, index) {
                final orderedProduct =
                    widget.shoppingCart.getOrderedProducts()[index];
                return ListTile(
                  title: Text(orderedProduct.product.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Quantity: ${orderedProduct.quantity}'),
                      Text('Size: ${orderedProduct.size}'),
                      Text(
                          'Price: \$${orderedProduct.totalPrice.toStringAsFixed(2)}'),
                      Text('Order Number: $orderNumber'),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // Remove the ordered product
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
          ),

          ElevatedButton(onPressed: widget.onContinueShopping, child: Text('Continue Shopping'))
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

  double calculateGrandTotal() {
    return widget.shoppingCart.getOrderedProducts().fold<double>(
        0,
        (previousValue, orderedProduct) =>
            previousValue + orderedProduct.totalPrice);
  }

  void removeProduct(OrderedProduct orderedProduct) {
    setState(() {
      widget.shoppingCart.removeOrderedProduct(orderedProduct);
      grandTotal = calculateGrandTotal();
    });

    // Show a SnackBar to indicate that the item has been deleted
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${orderedProduct.product.name} deleted'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
