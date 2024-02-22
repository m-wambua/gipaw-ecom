import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/globals/products_card.dart';
import 'package:flutter_application_1/globals/shopping_cart.dart';

class NewCheckOutPage extends StatelessWidget {
  final ShoppingCart shoppingCart;
  const NewCheckOutPage({Key? key, required this.shoppingCart})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<OrderedProduct> orderedProducts =
        shoppingCart.getOrderedProducts();
    String orderNumber = generateOrderNumber();
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'CheckOut',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Container( // Wrap with a Container to provide bounded height
              height: 400, // Example height, adjust according to your needs
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true, // Ensure ListView doesn't try to expand
                      itemCount: orderedProducts.length,
                      itemBuilder: (context, index) {
                        final orderedProduct = orderedProducts[index];
                        return ListTile(
                          /*
                          leading: orderedProduct.product.imageUrl != null ?Image.network(orderedProduct.product.imageUrl,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,): const Icon(Icons.image),
                         */
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
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String generateOrderNumber() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    return String.fromCharCodes(Iterable.generate(
        10, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
  }
}
