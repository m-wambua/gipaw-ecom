import 'package:flutter/material.dart';
import 'package:flutter_application_1/globals/structure/featured_products.dart';
import 'package:flutter_application_1/globals/list_of_products/list_of_dresses.dart';
import 'package:flutter_application_1/globals/list_of_products/list_of_fleece.dart';
import 'package:flutter_application_1/globals/list_of_products/list_of_shirt.dart';
import 'package:flutter_application_1/globals/list_of_products/list_of_shorts.dart';
import 'package:flutter_application_1/globals/list_of_products/list_of_skirts.dart';
import 'package:flutter_application_1/globals/list_of_products/list_of_sweaters.dart';
import 'package:flutter_application_1/globals/list_of_products/list_of_ties.dart';
import 'package:flutter_application_1/globals/list_of_products/list_of_tracksuits.dart';
import 'package:flutter_application_1/globals/list_of_products/list_of_trouser.dart';
import 'package:flutter_application_1/globals/structure/shopping_cart.dart';

class HomePageDetails extends StatelessWidget {
  final ShoppingCart shoppingCart;
  final String orderNummber;

  const HomePageDetails({Key? key, required this.shoppingCart, required this.orderNummber})
      : super(key: key);

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
                    orderNumber: orderNummber,
                  ),
                  RowOfFeaturedProducts(
                    shoppingCart: shoppingCart,
                    products: trouserProducts,
                    orderNumber: orderNummber,
                  ),
                  RowOfFeaturedProducts(
                    shoppingCart: shoppingCart,
                    products: shortsProducts,
                    orderNumber: orderNummber,
                  ),
                  RowOfFeaturedProducts(
                    shoppingCart: shoppingCart,
                    products: tracksuitsProducts,
                    orderNumber: orderNummber,
                  ),
                  RowOfFeaturedProducts(
                    shoppingCart: shoppingCart,
                    products: fleeceJacketsProducts,
                    orderNumber: orderNummber,
                  ),
                  RowOfFeaturedProducts(
                    shoppingCart: shoppingCart,
                    products: sweatersProducts,
                    orderNumber: orderNummber,
                  ),
                  RowOfFeaturedProducts(
                    shoppingCart: shoppingCart,
                    products: dressesProduct,
                    orderNumber: orderNummber,
                  ),
                  RowOfFeaturedProducts(
                    shoppingCart: shoppingCart,
                    products: skirtsProducts,
                    orderNumber: orderNummber,
                  ),
                  RowOfFeaturedProducts(
                    shoppingCart: shoppingCart,
                    products: tiesProducts,
                    orderNumber: orderNummber,
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
