import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/globals/login_page.dart';
import 'package:flutter_application_1/globals/my_cart.dart';
import 'package:flutter_application_1/globals/ordered_products_provider.dart';
import 'package:flutter_application_1/globals/products_card.dart';
import 'package:flutter_application_1/globals/profile_page.dart';
import 'package:flutter_application_1/globals/search_page.dart';
import 'package:flutter_application_1/globals/shopping_cart.dart';
import 'package:flutter_application_1/home_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sidebarx/sidebarx.dart';

class CheckoutPage extends StatefulWidget {
  final ShoppingCart shoppingCart;

  const CheckoutPage({
    Key? key,
    required this.shoppingCart,
  }) : super(key: key);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  List<OrderedProduct> orderedProducts = [];

  final SidebarXController _sidebarXController =
      SidebarXController(selectedIndex: 0);
  final ShoppingCart myShoppingCart = ShoppingCart();

  @override
  void initState() {
    super.initState();
    orderedProducts = widget.shoppingCart.getOrderedProducts();
    Future.delayed(Duration.zero, () {
      var orderedProductsProvider =
          Provider.of<OrderedProductsProvider>(context, listen: false);
      orderedProductsProvider.updateOrderedProducts(orderedProducts);
    });
  }

  void removeFromCart(OrderedProduct product) {
    setState(() {
      orderedProducts.remove(product);
    });
  }

  TextEditingController searchController = TextEditingController();
  String searchText = '';
  List<Product> searchResults = [];

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final userLastName = userProvider.userLastName;
    //Generate a random alphanumeric order number
    String orderNumber = generateOrderNumber();
    var storedListOfProducts = Provider.of<ShoppingCart>(context);
    var orderedProductsProvider = Provider.of<OrderedProductsProvider>(context);

    // Calculate the grand total by summing up the total Prices of all ordered products
    double grandTotal = orderedProductsProvider.orderedProducts.fold<double>(
      0,
      (previousValue, orderedProduct) =>
          previousValue + orderedProduct.totalPrice,
    );
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 30.0,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [Colors.blue, Colors.purple],
              )),
              child: const FlexibleSpaceBar(
                title: const Text('Checkout'),
              ),
            ),
            actions: [
              IconButton(
                icon: Stack(children: [
                  const Icon(Icons.list),
                ]),
                onPressed: () {
                  // Navigate to MyCartPage
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyCartPage(
                                shoppingCart: myShoppingCart,
                              )));
                },
              ),
              IconButton(
                icon: Stack(children: [
                  const Icon(Icons.add_shopping_cart),
                ]),
                onPressed: () {
                  // Navigate to MyCartPage
                  setState(() {});
                },
              ),
            ],
            automaticallyImplyLeading: false,
            floating: true,
            pinned: true,
          ),
          SliverAppBar(
            expandedHeight: 50.0, // Set the height of the second AppBar
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green, Colors.blue],
                ),
              ),
              child: FlexibleSpaceBar(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Add your buttons here

                    const SizedBox(
                      width: 50,
                    ),

                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 5.0),
                      child: TextField(
                        controller: searchController,
                        onChanged: (value) {
                          setState(() {
                            searchText = value;
                          });
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Search...',
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: () {
                              _performSearch(searchText);
                            },
                          ),
                          border: const OutlineInputBorder(),
                        ),
                      ),
                    )),

                    const Spacer(),
                    IconButton(
                        icon: const Icon(Icons.person),
                        onPressed: () {
                          if (userProvider.isAuthenticated) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProfilePage()));
                          } else {
                            //Navigate to login page if not authenticated
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          }
                        }
                        // TODO: Add functionality for sign-in

                        ),
                    if (userProvider.isAuthenticated)
                      Text(userProvider.userLastName),
                    const SizedBox(
                      width: 5,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        //TODO: implement functionality for 'About' button
                        showAboutDialog(
                          context: context,
                          applicationName: 'Dexter Labs App',
                          applicationVersion: '1.0.0',
                          applicationLegalese: '@ 2023 Dxter Labs',
                        );
                      },
                      child: const Text(
                        'About',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            automaticallyImplyLeading: true,
            floating: false,
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: orderedProducts.length,
                    itemBuilder: (context, index) {
                      final orderedProduct = orderedProducts[index];
                      return ListTile(
                        title: Text(orderedProduct.product.name),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Quantity: ${orderedProduct.quantity}'),
                            Text('Size: ${orderedProduct.size}'),
                            Text(
                                'Price: \$${orderedProduct.totalPrice.toStringAsFixed(2)}'),
                            Text(
                              'Order Number: $orderNumber',
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            removeFromCart(orderedProduct);
                          },
                        ),
                      );
                    },
                  ),
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _performSearch(String searchQuery) {
    // Perform search

    // Navigate to the SearchPage with the list of search results
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchPage(
          query: searchText,
        ),
      ),
    );

    //print(searchResults);
  }

// FUnction to show the menu bar
  void _showMenuBar(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Settings'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.help),
                    title: const Text('Help'),
                    onTap: () {
                      // Handle help action
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.build),
                    title: const Text('Build your uniform'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ));
        });
  }

  void _sidebarNavigation(BuildContext context) {
    SidebarX(
      controller: SidebarXController(selectedIndex: 0),
      items: const [SidebarXItem(icon: Icons.build, label: 'Build')],
    );
  }

  String generateOrderNumber() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    return String.fromCharCodes(Iterable.generate(
        10, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
  }
}
