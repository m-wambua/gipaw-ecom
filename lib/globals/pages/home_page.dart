import 'package:flutter/material.dart';
import 'package:flutter_application_1/globals/pages/check_out_page.dart';
import 'package:flutter_application_1/globals/list_of_products/list_of_dresses.dart';
import 'package:flutter_application_1/globals/list_of_products/list_of_fleece.dart';
import 'package:flutter_application_1/globals/list_of_products/list_of_shirt.dart';
import 'package:flutter_application_1/globals/list_of_products/list_of_shorts.dart';
import 'package:flutter_application_1/globals/list_of_products/list_of_skirts.dart';
import 'package:flutter_application_1/globals/list_of_products/list_of_sweaters.dart';
import 'package:flutter_application_1/globals/list_of_products/list_of_ties.dart';
import 'package:flutter_application_1/globals/list_of_products/list_of_tracksuits.dart';
import 'package:flutter_application_1/globals/list_of_products/list_of_trouser.dart';
import 'package:flutter_application_1/globals/pages/login_page.dart';
import 'package:flutter_application_1/globals/pages/my_cart.dart';
import 'package:flutter_application_1/globals/structure/ordered_products_provider.dart';
import 'package:flutter_application_1/globals/structure/products_card.dart';
import 'package:flutter_application_1/globals/pages/profile_page.dart';
import 'package:flutter_application_1/globals/pages/search_page.dart';
import 'package:flutter_application_1/globals/structure/shopping_cart.dart';
import 'package:flutter_application_1/globals/pages/signup_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sidebarx/sidebarx.dart';
import '../structure/featured_products.dart';

List<Product> productList = productList;

class HomePage extends StatefulWidget {
  final String orderNumber;
  const HomePage({
    Key? key,
    required this.orderNumber,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  final SidebarXController _sidebarXController =
      SidebarXController(selectedIndex: 0);

  final ShoppingCart myShoppingCart = ShoppingCart();
  
  @override
  void initState() {
    super.initState();
    var orderedProducts = myShoppingCart.orderedProducts;
    Future.delayed(Duration.zero, () {
      var orderedProductsProvider =
          Provider.of<OrderedProductsProvider>(context, listen: false);
      orderedProductsProvider.updateOrderedProducts(orderedProducts);
    });
  }

  TextEditingController searchController = TextEditingController();
  String searchText = '';
  List<Product> searchResults = [];

  //_HomePageState createState()
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final userLastName = userProvider.userLastName;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 30.0, // Set the height of the first AppBar
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.purple],
                ),
              ),
              child: const FlexibleSpaceBar(
                title: Text('Gipaw'),
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
                                orderNumber: widget.orderNumber,
                              )));
                },
              ),
              IconButton(
                icon: Stack(children: [
                  const Icon(Icons.add_shopping_cart),
                ]),
                onPressed: () {
                  // Navigate to MyCartPage
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CheckoutPage(
                                shoppingCart: myShoppingCart,
                                onContinueShopping: () {
                                  Navigator.pop(context);
                                },
                              )));
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Add your buttons here
                    IconButton(onPressed: () {}, icon: const Icon(Icons.home)),
                    const SizedBox(
                      width: 5,
                    ),
                    IconButton(
                        onPressed: () {
                          SidebarX(
                            controller: _sidebarXController,
                            items: const [SidebarXItem(icon: Icons.build)],
                          );
                        },
                        icon: const Icon(Icons.add_circle_outline)),
                    IconButton(
                      icon: const Icon(Icons.more_vert),
                      onPressed: () {
                        // TODO: Add functionality for more
                        _showMenuBar(context);
                      },
                    ),

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
            automaticallyImplyLeading: false,
            floating: false,
            pinned: true,
          ),
          SliverToBoxAdapter(
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
                  // Wrap only the section that contains multiple rows of FeaturedProducts
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        RowOfFeaturedProducts(
                            shoppingCart: myShoppingCart,
                            products: shirtProducts,
                            orderNumber: widget.orderNumber,),
                        RowOfFeaturedProducts(
                            shoppingCart: myShoppingCart,
                            products: trouserProducts,
                            orderNumber: widget.orderNumber,),
                        RowOfFeaturedProducts(
                            shoppingCart: myShoppingCart,
                            products: shortsProducts,
                            orderNumber: widget.orderNumber,),
                        RowOfFeaturedProducts(
                            shoppingCart: myShoppingCart,
                            products: tracksuitsProducts,
                            orderNumber: widget.orderNumber,),
                        RowOfFeaturedProducts(
                            shoppingCart: myShoppingCart,
                            products: fleeceJacketsProducts,
                            orderNumber: widget.orderNumber,),
                        RowOfFeaturedProducts(
                            shoppingCart: myShoppingCart,
                            products: sweatersProducts,
                            orderNumber: widget.orderNumber,),
                        RowOfFeaturedProducts(
                            shoppingCart: myShoppingCart,
                            products: dressesProduct,
                            orderNumber: widget.orderNumber,),
                        RowOfFeaturedProducts(
                            shoppingCart: myShoppingCart,
                            products: skirtsProducts,
                            orderNumber: widget.orderNumber,),

                        RowOfFeaturedProducts(
                            shoppingCart: myShoppingCart,
                            products: tiesProducts, orderNumber: widget.orderNumber,),
                        // Add more RowOfFeaturedProducts as needed
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
}
