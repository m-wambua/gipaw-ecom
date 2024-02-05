import 'package:flutter/material.dart';
import 'package:flutter_application_1/globals/check_out_page.dart';
import 'package:flutter_application_1/globals/products_card.dart';

class ProductDetailsPage extends StatefulWidget {
  final Product product;
  final ShoppingCart shoppingCart;

  const ProductDetailsPage(
      {Key? key, required this.product, required this.shoppingCart})
      : super(key: key);

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int? selectedSize; // Variable to hold the selected size
  bool? logoNologo = false;
  var shoppingCart = ShoppingCart();
  int selectedQuantity = 1;
  TextEditingController logoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Row(
              children: [
                // Product image on the right
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 4 / 3,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(widget.product.ImageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                    width: 16), // Add some spacing between image and details
                // Product details on the left
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.name,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '\$${widget.product.price.start.toStringAsFixed(2)}-\$${widget.product.price.end.toStringAsFixed(2)}',
                        style:
                            const TextStyle(fontSize: 14, color: Colors.green),
                      ),
                      SizedBox(height: 10),
                      Row(mainAxisAlignment: MainAxisAlignment.start,
                      children: [Text('Quantity:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                      
                      ),
                      SizedBox(width: 20,),
                      buildQuantitySelector(),
                      ],
                      ),
                      SizedBox(height: 10,),

                      Text(
                        'The price per product is dependent on size',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.normal),
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Sizes:',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          buildSizeRadioButton(18),
                          buildSizeRadioButton(20),
                          buildSizeRadioButton(22),
                          buildSizeRadioButton(24),
                          buildSizeRadioButton(26),
                          buildSizeRadioButton(28),
                          buildSizeRadioButton(30),
                          buildSizeRadioButton(32),
                          // Add more sizes as needed
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                       mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Logo:',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          buildlogoRadioButton(true, 'Yes'),
                          buildlogoRadioButton(false, 'No'),
                        ],
                      ),
                      SizedBox(height: 15),
                      ElevatedButton(
                        onPressed: () {
                          // Handle the onPressed event for the "Add to Cart" button

                          shoppingCart.addToCart(Product(
                              name: widget.product.name,
                              price: (widget.product.price),
                              ImageUrl: widget.product.ImageUrl));
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Product added to the cart'),
                            duration: Duration(seconds: 2),
                          ));
                        },
                        child: Text('Add to Cart'),
                      ),
                      SizedBox(height: 15),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CheckoutPage(
                                      totalPrice: widget.product.price,
                                      orderedItems: shoppingCart.items)));
                          // Handle the onPressed event for the "Add to Cart" button
                        },
                        child: Text('Buy Now'),
                      ),
                      SizedBox(height: 25),
                      Text(
                        'Sizes relate to age as follows:\n'
                        '18: 2-3 years\n'
                        '20: 3-4 years\n'
                        '22: 4-5 years\n'
                        '24: 5-6 years\n'
                        '26: 6-7 years\n'
                        '28: 7-8 years\n'
                        '30: 8-9 years\n'
                        '32: 9-10 years',
                        style: TextStyle(fontSize: 16),
                      ),

                      SizedBox(height: 40,),
                      Text('Your Total will be: ')
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSizeRadioButton(int size) {
    return Row(
      children: [
        Radio(
          value: size,
          groupValue: selectedSize,
          onChanged: (value) {
            setState(() {
              selectedSize = value as int?;
            });
          },
        ),
        Text(size.toString()),
      ],
    );
  }

  Widget buildlogoRadioButton(bool value, String label) {
    return Row(
      children: [
        Radio(
          value: value,
          groupValue: logoNologo,
          onChanged: (newvalue) {
            setState(() {
              logoNologo = newvalue as bool?;
            });
          },
        ),
        Text(label),
      ],
    );
  }

  Widget buildLogoNameTextField() {
    return TextField(
      controller: logoController,
      decoration: InputDecoration(
          labelText: 'Enter Logo Name', border: OutlineInputBorder()),
    );
  }

  Widget buildQuantitySelector() {
  return Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0),
  border: Border.all( color: Colors.grey,
  ) ),child: DropdownButton<int>(
    value: selectedQuantity,
    onChanged: (value) {
      setState(() {
        selectedQuantity = value!;
      });
    },
    items: List.generate(
      10,
      (index) => DropdownMenuItem<int>(
        value: index + 1,
        child: Text((index + 1).toString()),
      ),
    ).toList(), // Ensure the list is converted to a List
  ));
} 
  
  

}
