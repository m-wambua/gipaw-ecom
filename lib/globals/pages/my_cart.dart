import 'package:flutter/material.dart';
import 'package:flutter_application_1/globals/structure/cart_totals.dart';
import 'package:flutter_application_1/globals/pages/check_out_page.dart';
import 'package:flutter_application_1/globals/pages/product_details-page.dart';
import 'package:flutter_application_1/globals/structure/products_card.dart';
import 'package:flutter_application_1/globals/structure/shopping_cart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyCartPage extends StatelessWidget {
  final ShoppingCart shoppingCart;
  final String orderNumber;
  final int userId;

  const MyCartPage(
      {Key? key, required this.shoppingCart, required this.orderNumber, required this.userId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('My WishList'),
        ),
        body: Column(
          children: [
            for (var product in shoppingCart.items)
              ProductCardInWishList(
                product: product,
                onRemovePressed: () {
                  // Implement logic to remove the product from the wishlist
                  shoppingCart.removeProduct(product);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Product removed from the cart'),
                    duration: Duration(seconds: 2),
                  ));
                },
                onDetailsPressed: () {
                  // Navigate directly to the ProductConfigurator widget
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailsPage(
                        userId: userId,
                        shoppingCart: shoppingCart,
                        product: product,
                        orderNumber: orderNumber,
                      ),
                      //builder: (context) => ProductConfigurator(shoppingCart: shoppingCart),
                    ),
                  );
                },
              ),
            CartTotals(shoppingCart: shoppingCart),
          ],
        ));
  }
}

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
    required this.userId,
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

class ProductCardInWishList extends StatelessWidget {
  final Product product;
  final VoidCallback onRemovePressed;
  final VoidCallback onDetailsPressed;

  const ProductCardInWishList({
    Key? key,
    required this.product,
    required this.onRemovePressed,
    required this.onDetailsPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onDetailsPressed,
      child: Card(
          elevation: 5,
          margin: EdgeInsets.symmetric(vertical: 8),
          child: Column(
            children: [
              ListTile(
                leading: AspectRatio(
                  aspectRatio: 1.5,
                  child: Image.asset('assets/shirts/image-1.jpeg'),
                ),
                title: Text(product.name),
                subtitle: Text(
                  '\$${product.price.start.toStringAsFixed(2)}-\$${product.price.end.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 14, color: Colors.green),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: onRemovePressed,
                ),
              ),
            ],
          )),
    );
  }
}
