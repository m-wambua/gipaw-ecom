import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_bars.dart';
import 'package:flutter_application_1/globals/pages/check_out_page.dart';
import 'package:flutter_application_1/globals/pages/checkoutpage_2.dart';
import 'package:flutter_application_1/globals/structure/featured_products.dart';
import 'package:flutter_application_1/globals/structure/home_page_details.dart';
import 'package:flutter_application_1/globals/list_of_products/list_of_dresses.dart';
import 'package:flutter_application_1/globals/list_of_products/list_of_fleece.dart';
import 'package:flutter_application_1/globals/list_of_products/list_of_shirt.dart';
import 'package:flutter_application_1/globals/list_of_products/list_of_shorts.dart';
import 'package:flutter_application_1/globals/list_of_products/list_of_skirts.dart';
import 'package:flutter_application_1/globals/list_of_products/list_of_sweaters.dart';
import 'package:flutter_application_1/globals/list_of_products/list_of_ties.dart';
import 'package:flutter_application_1/globals/list_of_products/list_of_tracksuits.dart';
import 'package:flutter_application_1/globals/list_of_products/list_of_trouser.dart';
import 'package:flutter_application_1/globals/pages/my_cart.dart';
import 'package:flutter_application_1/globals/structure/products_card.dart';
import 'package:flutter_application_1/globals/structure/shopping_cart.dart';
import 'package:flutter_application_1/globals/pages/wishlist.dart';

class HomePage2 extends StatefulWidget {
  final ShoppingCart myShoppingCart;
  final String orderNumber;

  const HomePage2({
    Key? key,
    required this.myShoppingCart,
    required this.orderNumber,
  });
  @override
  _HomePage2State createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  //Method to navigate to MyCartPage
  int _selectedIndex =
      0; // 0 for HomePageDetails, 1 for MyCartPage, 2 for Checkoutpage

  void _navigateToHomePage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                HomePageDetails(shoppingCart: widget.myShoppingCart,orderNummber:  widget.orderNumber,)));
  }

  void _navigateToMyCartPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                MyCartPage(shoppingCart: widget.myShoppingCart,
                
                orderNumber: widget.orderNumber,)));
  }

//Mehtod to Navigate to CheckoutPage
  void _navigateToCheckoutPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CheckoutPage(
                  shoppingCart: widget.myShoppingCart,
                  onContinueShopping: () {
                    Navigator.pop(context);
                  },
                )));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          FirstSilverAppBar(
            onListButtonPressed: _navigateToMyCartPage,
            onCartButtonPressed: _navigateToCheckoutPage,
          ),
          SecondSliverAppBar(
            onHomeButtonPressed: _navigateToHomePage,
          ),

          if (_selectedIndex == 0)
            HomePageDetails(shoppingCart: widget.myShoppingCart, orderNummber: widget.orderNumber,),
          // HomePageDetails(shoppingCart: widget.myShoppingCart),

          if (_selectedIndex == 1)
            WishList(
              shoppingCart: widget.myShoppingCart,
              orderNumber: widget.orderNumber,
            ),
          if (_selectedIndex == 2)
            NewCheckOutPage(shoppingCart: widget.myShoppingCart),

          //CheckoutPage(shoppingCart: myShoppingCart)
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'My Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.check), label: 'Checkout')
        ],
      ),
    );
  }
}
