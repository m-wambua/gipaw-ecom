import 'package:flutter/material.dart';
import 'package:flutter_application_1/globals/pages/product_details-page.dart';
import 'package:flutter_application_1/globals/structure/products_card.dart';
import 'package:flutter_application_1/globals/structure/shopping_cart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductCardInCart extends StatelessWidget {
  final Product product;
  final ShoppingCart shoppingCart;
  final String orderNumber;
  final int userId;

  const ProductCardInCart({
    Key? key,
    required this.product,
    required this.shoppingCart,
    required this.orderNumber,
    required this.userId
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductDetailsPage(
                    userId: userId,
                        product: product,
                        shoppingCart: shoppingCart,
                        orderNumber: orderNumber,
                      )));
        },
        child: Container(
          margin: const EdgeInsets.all(8),
          width: 150,
          child: Card(
            elevation: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 4 / 3,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            product.imageUrl), // Use imageUrl from Product
                        fit: BoxFit.cover,
                      ),
                    ), // Placeholder for product image
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '\$${product.price.start.toStringAsFixed(2)}-\$${product.price.end.toStringAsFixed(2)}',
                        style:
                            const TextStyle(fontSize: 14, color: Colors.green),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Remove the product from the shopping cart
                          shoppingCart.removeProduct(product);
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Product removed from the cart'),
                            duration: Duration(seconds: 2),
                          ));
                        },
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [Text('Remove from cart ==')],
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductDetailsPage(
                                      userId: userId,
                                          product: product,
                                          shoppingCart: shoppingCart,
                                          orderNumber: orderNumber,
                                        )));
                          },
                          child: const Text('Congigure your item'))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
