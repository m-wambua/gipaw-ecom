import 'package:flutter/material.dart';
import 'package:flutter_application_1/globals/check_out_page.dart';
import 'package:flutter_application_1/globals/checkoutpage_2.dart';
import 'package:flutter_application_1/globals/products_card.dart';
import 'package:flutter_application_1/globals/shopping_cart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductDetailsPage extends StatefulWidget {
  final Product product;
  final ShoppingCart shoppingCart;
  

  const ProductDetailsPage(
      {Key? key, required this.product, required this.shoppingCart, })
      : super(key: key);

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  double? selectedSize; // Variable to hold the selected size
  bool? logoNologo = false;

  int selectedQuantity = 1;
  TextEditingController logoController = TextEditingController();

  double calculatedFinalPrice() {
    double basePrice = widget.product.price.start;
    double priceIncreament = 0.5;

    if (widget.product.size.range != null && selectedSize != null) {
      //Determine the start size
      double startSize = widget.product.size.range!.start;

      //Calulate the number of size increaments from the start size
      int sizeIncreamentCount = (selectedSize! - startSize).toInt();

      // Adjust the base price based on the size increaments
      double adjustedPrice =
          basePrice + (priceIncreament * sizeIncreamentCount);

      //Adjust the base price based on the size increaments
      double additionalPrice = logoNologo! ? 0.5 : 0.0;

      //calculate total price based on adjusted price, quantity and additional factirs
      double totalPrice = (adjustedPrice + additionalPrice) * selectedQuantity;

      return totalPrice;
    } else {
      return basePrice;
    }
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = calculatedFinalPrice(); //Calulate final price
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
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
                          image: NetworkImage(widget.product.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                    width: 16), // Add some spacing between image and details
                // Product details on the left
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.name,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '\$${widget.product.price.start.toStringAsFixed(2)}-\$${widget.product.price.end.toStringAsFixed(2)}',
                        style:
                            const TextStyle(fontSize: 14, color: Colors.green),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'Quantity:',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          buildQuantitySelector(),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'The price per product is dependent on size',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.normal),
                      ),
                      const SizedBox(height: 15),
                      if (widget.product.size.range != null)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _buildNumericSizeRadioButtons(
                              widget.product.size.range!),
                        ),
                      if (widget.product.size.sizes != null)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _buildStringSizedButtons(
                              widget.product.size.sizes!),
                        ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'Logo:',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          buildlogoRadioButton(true, 'Yes'),
                          buildlogoRadioButton(false, 'No'),
                        ],
                      ),
                      if (logoNologo ==
                          true) // Conditionally display text field
                        buildLogoNameTextField(),
                      const SizedBox(height: 15),
                      const SizedBox(height: 15),
                      ElevatedButton(
                        onPressed: () {
                          //Creaye an instance of OrderdProduct with configured values
                          final orderedProduct = OrderedProduct(
                            product: widget.product,
                            quantity: selectedQuantity,
                            size: selectedSize != null
                                ? selectedSize.toString()
                                : 'N/A',
                            totalPrice: calculatedFinalPrice(),
                          );
                          widget.shoppingCart.addProduct(orderedProduct);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CheckoutPage(shoppingCart: widget.shoppingCart)),
                          );
                          // Handle the onPressed event for the "Add to Cart" button
                        },
                        child: const Text('Proceed to Checkout'),
                      ),
                      const SizedBox(height: 25),
                      const Text(
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
                      const SizedBox(
                        height: 40,
                      ),
                      Text(
                          'Your Total will be: \$${totalPrice.toStringAsFixed(2)}'),
                      const SizedBox(
                        height: 20,
                      )
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

  Widget buildlogoRadioButton(bool value, String label) {
    return Row(
      children: [
        Radio(
          value: value,
          groupValue: logoNologo,
          onChanged: (newvalue) {
            setState(() {
              logoNologo = newvalue;
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
      decoration: const InputDecoration(
          labelText: 'Enter Logo Name', border: OutlineInputBorder()),
    );
  }

  Widget buildQuantitySelector() {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(
              color: Colors.grey,
            )),
        child: DropdownButton<int>(
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

  List<Widget> _buildNumericSizeRadioButtons(Range sizeRange) {
    List<Widget> buttons = [];
    for (double size = sizeRange.start; size <= sizeRange.end; size += 2) {
      buttons.add(Row(
        children: [
          Radio<double>(
            value: size,
            groupValue: selectedSize, //Set group value as needed
            onChanged: (value) {
              setState(() {
                selectedSize = value;
              });
              //Handle radio button selection
            },
          ),
          Text(size.toString())
        ],
      ));
    }
    return buttons;
  }

  List<Widget> _buildStringSizedButtons(List<String> sizes) {
    List<Widget> buttons = [];
    for (String size in sizes) {
      buttons.add(Row(
        children: [
          Radio<String>(
            value: size,
            groupValue: null,
            onChanged: (value) {
              //Handle radio button selection
            },
          ),
          Text(size),
        ],
      ));
    }
    return buttons;
  }
}
