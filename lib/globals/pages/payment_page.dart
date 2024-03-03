import 'package:flutter/material.dart';
import 'package:flutter_application_1/globals/pages/paymentsuccesspage.dart';

class PaymentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Payment Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            // Add payment details ui here
            ElevatedButton(
                onPressed: () {
                  //Add payment process logic here
                  // For Example , send Payment request to server
                  //Once payment is successfull , navigate to success payment page
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PaymentSuccessPage()));
                },
                child: Text('Process paymenr'))
          ],
        ),
      ),
    );
  }
}
