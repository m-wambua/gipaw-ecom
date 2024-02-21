import 'package:flutter/material.dart';
import 'package:flutter_application_1/globals/cart_totals.dart';
import 'package:flutter_application_1/globals/check_out_page.dart';
import 'package:flutter_application_1/globals/product_details-page.dart';
import 'package:flutter_application_1/globals/products_card.dart';
import 'package:flutter_application_1/globals/shopping_cart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyCartPage extends StatelessWidget {
  final ShoppingCart shoppingCart;
  

  const MyCartPage({Key? key, required this.shoppingCart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('My WishList'),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: shoppingCart.items.length,
                itemBuilder: (context, index) {
                  final product = shoppingCart.items[index];
                  return ProductCardInCart(
                    product: product,
                    shoppingCart: shoppingCart,
                    
                  );
                },
              ),
            ),
            CartTotals(shoppingCart: shoppingCart),
          ],
        ));
  }
}

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
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductDetailsPage(
                        product: product,
                        shoppingCart: shoppingCart,
                        
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
                  aspectRatio: 16 / 9,
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
                          children: [Text('Remove from WishList')],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
