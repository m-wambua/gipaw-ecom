import 'package:flutter/material.dart';
import 'package:flutter_application_1/globals/product_configurator.dart';
import 'package:flutter_application_1/globals/product_details-page.dart';
import 'package:flutter_application_1/globals/products_card.dart';
import 'package:flutter_application_1/globals/shopping_cart.dart';

class WishList extends StatelessWidget {
  final ShoppingCart shoppingCart;

  const WishList({Key? key, required this.shoppingCart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'My Wishlist',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16,),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  // Generate product cards for each product in the wishlist
                  for (var product in shoppingCart.items)
                    ProductCardInWishList(
                      product: product,
                      onRemovePressed: () {

                        // Implement logic to remove the product from the wishlist
                         shoppingCart.removeProduct(product);
                      },
                      onDetailsPressed: () {
  // Navigate directly to the ProductConfigurator widget
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ProductDetailsPage(shoppingCart: shoppingCart,product: product,),
      //builder: (context) => ProductConfigurator(shoppingCart: shoppingCart),



    ),
  );
},

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
            leading: AspectRatio(aspectRatio: 1.5,child: Image.asset('assets/shirts/image-1.jpeg'),),
          title: Text(product.name),
          subtitle: Text(
                        '\$${product.price.start.toStringAsFixed(2)}-\$${product.price.end.toStringAsFixed(2)}',
                        style:
                            const TextStyle(fontSize: 14, color: Colors.green),
                      ),
                      
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: onRemovePressed,
          ),
        ),
        ],)
        
      ),
    );
  }
}
