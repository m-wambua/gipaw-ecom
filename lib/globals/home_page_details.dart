import 'package:flutter/material.dart';
import 'package:flutter_application_1/globals/featured_products.dart';
import 'package:flutter_application_1/globals/list_of_products/list_of_dresses.dart';
import 'package:flutter_application_1/globals/list_of_products/list_of_fleece.dart';
import 'package:flutter_application_1/globals/list_of_products/list_of_shirt.dart';
import 'package:flutter_application_1/globals/list_of_products/list_of_shorts.dart';
import 'package:flutter_application_1/globals/list_of_products/list_of_skirts.dart';
import 'package:flutter_application_1/globals/list_of_products/list_of_sweaters.dart';
import 'package:flutter_application_1/globals/list_of_products/list_of_ties.dart';
import 'package:flutter_application_1/globals/list_of_products/list_of_tracksuits.dart';
import 'package:flutter_application_1/globals/list_of_products/list_of_trouser.dart';
import 'package:flutter_application_1/globals/shopping_cart.dart';

class HomePageDetails extends StatelessWidget {
  final ShoppingCart shoppingCart;

  const HomePageDetails({Key? key, required this.shoppingCart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Featured Products',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  RowOfFeaturedProducts(
                    shoppingCart: shoppingCart,
                    products: shirtProducts,
                  ),
                  RowOfFeaturedProducts(
                    shoppingCart: shoppingCart,
                    products: trouserProducts,
                  ),
                  RowOfFeaturedProducts(
                    shoppingCart: shoppingCart,
                    products: shortsProducts,
                  ),
                  RowOfFeaturedProducts(
                    shoppingCart: shoppingCart,
                    products: tracksuitsProducts,
                  ),
                  RowOfFeaturedProducts(
                    shoppingCart: shoppingCart,
                    products: fleeceJacketsProducts,
                  ),
                  RowOfFeaturedProducts(
                    shoppingCart: shoppingCart,
                    products: sweatersProducts,
                  ),
                  RowOfFeaturedProducts(
                    shoppingCart: shoppingCart,
                    products: dressesProduct,
                  ),
                  RowOfFeaturedProducts(
                    shoppingCart: shoppingCart,
                    products: skirtsProducts,
                  ),
                  RowOfFeaturedProducts(
                    shoppingCart: shoppingCart,
                    products: tiesProducts,
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

