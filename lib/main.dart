import 'package:flutter/material.dart';
import 'package:flutter_application_1/globals/structure/checkout_data.dart';
import 'package:flutter_application_1/globals/pages/login_page.dart';
import 'package:flutter_application_1/globals/structure/ordered_products_provider.dart';
import 'package:flutter_application_1/globals/structure/products_card.dart';
import 'package:flutter_application_1/globals/structure/shopping_cart.dart';
import 'package:flutter_application_1/globals/pages/home_page.dart';
import 'package:flutter_application_1/globals/pages/home_page_2.dart';
import 'package:provider/provider.dart';
  
  void main() {
  runApp(
    MyApp(),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ShoppingCart(),
        ),
        ChangeNotifierProvider(create: (context)=> OrderedProductsProvider(),
        
        ),
        ChangeNotifierProvider(create: (context)=>CheckoutData()),
      ],
      child: MaterialApp(
      title: 'Gipaw Designers',
debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
            //
            // TRY THIS: Try running your application with "flutter run". You'll see
            // the application has a purple toolbar. Then, without quitting the app,
            // try changing the seedColor in the colorScheme below to Colors.green
            // and then invoke "hot reload" (save your changes or press the "hot
            // reload" button in a Flutter-supported IDE, or press "r" if you used
            // the command line to start the app).
            //
            // Notice that the counter didn't reset back to zero; the application
            // state is not lost during the reload. To reset the state, use hot
            // restart instead.
            //
            // This works for code too, not just values: Most code changes can be
            // tested with just a hot reload.

            ),
            
        home:  HomePage(orderNumber: '',),
      ),
    );
  }
}
