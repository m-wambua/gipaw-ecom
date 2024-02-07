import 'package:flutter/material.dart';
import 'package:flutter_application_1/globals/products_card.dart';

class RowOfFeaturedProducts extends StatelessWidget {
  final ShoppingCart
      shoppingCart; // You need to provide a ShoppingCart instance

  // List of indivudual products for this row
  final List<Product> products;

  const RowOfFeaturedProducts({super.key, required this.shoppingCart, required this.products});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount:
            products.length, // Adjust this based on the number of FeaturedProducts per row
        itemBuilder: (context, index) {
          return ProductCard(
            product: products[index],
            shoppingCart: shoppingCart,
            // Pass the ShoppingCart instance
          );
        },
      ),
    );
  }
}
