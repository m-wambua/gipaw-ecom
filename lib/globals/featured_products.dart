import 'package:flutter/material.dart';
import 'package:flutter_application_1/globals/products_card.dart';

class RowOfFeaturedProducts extends StatelessWidget {
  final ShoppingCart shoppingCart; // You need to provide a ShoppingCart instance

  RowOfFeaturedProducts({required this.shoppingCart});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 9, // Adjust this based on the number of FeaturedProducts per row
        itemBuilder: (context, index) {
          return ProductCard(
            product: Product(name: 'Product $index', price: 19.99),
            shoppingCart: shoppingCart,
             // Pass the ShoppingCart instance
          );
        },
      ),
    );
  }
}
