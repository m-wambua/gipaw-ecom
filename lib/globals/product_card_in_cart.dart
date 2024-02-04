import 'package:flutter/material.dart';
import 'package:flutter_application_1/globals/products_card.dart';


class ProductCardInCart extends StatelessWidget {
  final Product product;
  final ShoppingCart shoppingCart;

  const ProductCardInCart({
    Key? key,
    required this.product,
    required this.shoppingCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                color: Colors.grey, // Placeholder for product image
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
                    style: const TextStyle(fontSize: 14, color: Colors.green),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Remove the product from the shopping cart
                      shoppingCart.removeProduct(product);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: const Text('Product removed from the cart'),
                        duration: const Duration(seconds: 2),
                      ));
                    },
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [Text('Remove from cart')],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
