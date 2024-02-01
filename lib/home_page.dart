import 'package:flutter/material.dart';
import 'package:flutter_application_1/globals/counter.dart';
import 'package:flutter_application_1/globals/my_cart.dart';
import 'package:flutter_application_1/globals/products_card.dart';
import 'package:flutter_application_1/globals/side_bar.dart';
import 'package:provider/provider.dart';
import 'package:sidebarx/sidebarx.dart';
import 'globals/featured_products.dart';

class CounterDisplay extends StatelessWidget {
  final int itemCount;

  const CounterDisplay({Key? key, required this.itemCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        'Cart Count: $itemCount',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  final SidebarXController _sidebarXController =
      SidebarXController(selectedIndex: 0);
  final ShoppingCart myShoppingCart = ShoppingCart();
  //_HomePageState createState()
  Widget build(BuildContext context) {
    ;
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
                  const Icon(Icons.shopping_cart),
                  Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            color: Colors.red, shape: BoxShape.circle),
                        child: Consumer<CounterNotifier>(
                            builder: (context, counter, child) {
                          return Text(
                            myShoppingCart.getItemCount().toString(),
                            style: const TextStyle(
                                fontSize: 12, color: Colors.white),
                          );
                        }),
                      ))
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
            ],
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

                    const Spacer(),
                    IconButton(icon: const Icon(Icons.person), onPressed: () {}
                        // TODO: Add functionality for sign-in
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
                        ),
                        RowOfFeaturedProducts(
                          shoppingCart: myShoppingCart,
                        ),
                        RowOfFeaturedProducts(
                          shoppingCart: myShoppingCart,
                        ),
                        RowOfFeaturedProducts(
                          shoppingCart: myShoppingCart,
                        ),
                        RowOfFeaturedProducts(
                          shoppingCart: myShoppingCart,
                        ),
                        RowOfFeaturedProducts(
                          shoppingCart: myShoppingCart,
                        ),
                        RowOfFeaturedProducts(
                          shoppingCart: myShoppingCart,
                        ),
                        RowOfFeaturedProducts(
                          shoppingCart: myShoppingCart,
                        ),
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
