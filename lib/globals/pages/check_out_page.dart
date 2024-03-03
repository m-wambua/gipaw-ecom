import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/globals/pages/login_page.dart';
import 'package:flutter_application_1/globals/pages/payment_page.dart';
import 'package:flutter_application_1/globals/pages/signup_page.dart';
import 'package:flutter_application_1/globals/services/send_order_data.dart';
import 'package:flutter_application_1/globals/structure/products_card.dart';
import 'package:flutter_application_1/globals/structure/shopping_cart.dart';

class CheckoutPage extends StatefulWidget {
  final ShoppingCart shoppingCart;
  final VoidCallback onContinueShopping;
   final int userId;
  const CheckoutPage({
    Key? key,
    required this.shoppingCart,
    required this.onContinueShopping,
    required this.userId,
  }) : super(key: key);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String orderNumber = '';
  double grandTotal = 0.0;
  int userId = 0;

  @override
  void initState() {
    super.initState();
    // Generate order number and calculate grand total when the widget is initialized
    orderNumber = generateOrderNumber();
    grandTotal = calculateGrandTotal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.shoppingCart.getOrderedProducts().length,
              itemBuilder: (context, index) {
                final orderedProduct =
                    widget.shoppingCart.getOrderedProducts()[index];
                return ListTile(
                  title: Text(orderedProduct.product.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Quantity: ${orderedProduct.quantity}'),
                      Text('Size: ${orderedProduct.size}'),
                      Text(
                          'Price: \$${orderedProduct.totalPrice.toStringAsFixed(2)}'),
                      Text('Order Number: $orderNumber'),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // Remove the ordered product
                      removeProduct(orderedProduct);
                    },
                  ),
                );
              },
            ),
          ),
          // Add other widgets like total price here
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Total Price: \$${grandTotal.toStringAsFixed(2)}'),
              ],
            ),
          ),

          ElevatedButton(
              onPressed: widget.onContinueShopping,
              child: Text('Continue Shopping')),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {
                //Send order data when the checkout button is pressed
                sendOrderData(widget.shoppingCart.orderedProducts, orderNumber,
                    grandTotal, widget.userId);
              },
              child: Text('Checkout')),
          SizedBox(
            height: 20,
          ),
          /*
          ElevatedButton(
              onPressed: () {
                if (widget.userId = 0) {
                  //navigate to authentication page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoginPage()),
                  ).then((result) {
                    //Handle result after authentication(e.g, update userId)
                    if (result != null && result is int && result !=0) {
                      setState(() {
                        widget.userId = result;
                      });
                      //Proceed with checkout
                      proceedWithCheckout();
                    }
                  });
                } else {
                  //Proceed with checkout
                  proceedWithCheckout();
                }
              },
              child: Text('Checkout'))
*/

ElevatedButton(onPressed: (){

  if(widget.userId!=0){
    //If  userId is not 0, proceed to payment
    Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentPage()));
  }else{
    // if userId is 0 , show popup to login or sign up

    showDialog(context: context, builder: (BuildContext 

      context) {
      return AlertDialog(
        title: Text('login or sign up'),
        content: Text('Please login or sign up to proceed  with payment'),
        actions: <Widget>[
          TextButton(onPressed: (){
            //Navigate to the login page
            Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()),).then((result){
              //Handle result after login(e.g update userId)
              if (result!=null && result is int){
                setState(() {
                  userId=result;
                });
                //Proceed to payment if login is successful
                if (userId!=0){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>PaymentPage()),);

                }
              }
            });
          }, child: Text('Login')),

          TextButton(onPressed: (){
            //Navigate to the sign-up page
            Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpPage()),).then((result){
              //Handle result after sign up (e.g updte userId)
              if (result!=null && result is int){
                setState(() {
                  userId=result;
                });
                //Proceed to payment if sign up was successful
                if(userId!=0){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentPage()),);
                }
              }
            });
          }, child: Text('Sign Up'))
        ],
      );
    });
  }
}, child: Text('Proceed to Payment'))

        ],
      ),
    );
  }

  String generateOrderNumber() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    return String.fromCharCodes(Iterable.generate(
        10, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
  }

  double calculateGrandTotal() {
    return widget.shoppingCart.getOrderedProducts().fold<double>(
        0,
        (previousValue, orderedProduct) =>
            previousValue + orderedProduct.totalPrice);
  }

  void removeProduct(OrderedProduct orderedProduct) {
    setState(() {
      widget.shoppingCart.removeOrderedProduct(orderedProduct);
      grandTotal = calculateGrandTotal();
    });

    // Show a SnackBar to indicate that the item has been deleted
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${orderedProduct.product.name} deleted'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void proceedWithCheckout() {
    // Send order data
    sendOrderData(
      widget.shoppingCart.orderedProducts,
      orderNumber,
      grandTotal,
      widget.userId,
    ).then((success) {
      if (success) {
        // Navigate to confirmation page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      }
    });
  }
}
