import 'package:flutter/material.dart';
import 'package:flutter_application_1/globals/my_cart.dart';
import 'package:flutter_application_1/globals/products_card.dart';
import 'package:flutter_application_1/globals/search_page.dart';
import 'package:provider/provider.dart';
import 'package:sidebarx/sidebarx.dart';
import 'globals/featured_products.dart';

List<Product> productList = productList;

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
        style: const TextStyle(color: Colors.white),
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

  TextEditingController searchController = TextEditingController();
  String searchText = '';
  List<Product> searchResults = [];

  //_HomePageState createState()
  @override
  Widget build(BuildContext context) {
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
                          products: [
                            Product(
                                name: 'Blue shirt',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'White shirt',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Cream White shirt',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Cream-yellow shirt',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Blue-checked shirt',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Red-checked shirt',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Pink-Checked shirt',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Green-Checked shirt',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Blue shirt',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                          ],
                        ),
                        RowOfFeaturedProducts(
                          shoppingCart: myShoppingCart,
                          products: [
                            Product(
                                name: 'Black Trousers',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Black Trousers',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Grey Trousers',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Green Trousers',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Red Trousers',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Blue Trousers',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Navi-Blue Trousers',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Khaki Trousers',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Maroon Trousers',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Black Trousers',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                          ],
                        ),
                        RowOfFeaturedProducts(
                          shoppingCart: myShoppingCart,
                          products: [
                            Product(
                                name: 'Grey Short',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Green Short',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Black Short',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Ash-Grey Short',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Blue Short',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Red Short',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Maroon Short',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Khaki Short',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Grey Short',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                          ],
                        ),
                        RowOfFeaturedProducts(
                          shoppingCart: myShoppingCart,
                          products: [
                            Product(
                                name: 'Blue Tracksuit',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Black Tracksuit',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Navi-Blue Tracksuit',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Sky-Blue Tracksuit',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Maroon Tracksuit',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Purple Tracksuit',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'White Tracksuit',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Yellow Tracksuit',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Red Tracksuit',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Green Tracksuit',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Blue Tracksuit',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Blue Tracksuit',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                          ],
                        ),
                        RowOfFeaturedProducts(
                          shoppingCart: myShoppingCart,
                          products: [
                            Product(
                                name: 'Purple-Fleece Jacket',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Green-Fleece Jacket',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Blue-Fleece Jacket',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Red-Fleece Jacket',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Brown-Fleece Jacket',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Fleece Jacket',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Fleece Jacket',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Fleece Jacket',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Fleece Jacket',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Fleece Jacket',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                          ],
                        ),
                        RowOfFeaturedProducts(
                          shoppingCart: myShoppingCart,
                          products: [
                            Product(
                                name: 'Grey Sweater',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Grey Sweater',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Blue Sweater',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Black Sweater',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Red Sweater',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Maroon Sweater',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Ash-Grey Sweater',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Sky-Blue Sweater',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Brown Sweater',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Grey Sweater',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                          ],
                        ),
                        RowOfFeaturedProducts(
                          shoppingCart: myShoppingCart,
                          products: [
                            Product(
                                name: 'Red Dress',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Red Dress',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Blue Dress',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Black Dress',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Checked Pink Dress',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Checked Red Dress',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Green Dress',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Purple Dress',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Maroon Dress',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'White Dress',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Checked Blue Dress',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                          ],
                        ),
                        RowOfFeaturedProducts(
                          shoppingCart: myShoppingCart,
                          products: [
                            Product(
                                name: 'Red Skirt',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Red Skirt',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Red Skirt',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Red Skirt',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Red Skirt',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Red Skirt',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Red Skirt',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Red Skirt',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Red Skirt',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                          ],
                        ),

                        RowOfFeaturedProducts(
                          shoppingCart: myShoppingCart,
                          products: [
                            Product(
                                name: 'Red Tie',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Red Tie',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Red Tie',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Red Tie',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Red Tie',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Red Tie',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Red Tie',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Red Tie',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                            Product(
                                name: 'Red Tie',
                                price: Range(start: 12.30, end: 16.30),
                                imageUrl: ''),
                          ],
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

  void _performSearch(String searchQuery) {
    // Perform search
   

    
    // Navigate to the SearchPage with the list of search results
    Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => SearchPage(query: searchText,),
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
