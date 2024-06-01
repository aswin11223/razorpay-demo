import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  late Razorpay razorpay;

  @override
  void initState() {
    super.initState();
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void getfun() {
    var options = {
      'key': 'rzp_test_VzSMZ0uUpAgbqc',// Corrected key value
      'amount': 1000, // Amount is in the smallest currency unit. E.g., 1000 paise = 10 INR
      'name': 'pappaya corners.',
      'description': 'android course',
      'prefill': {
        'contact': 7025466178, // Contact should be a string
        'email': 'aswinkannan1122@gmail.com'
      }
    };

    try {
      razorpay.open(options);
    } catch (e) {
      Fluttertoast.showToast(msg: "Error: ${e.toString()}");
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("DEMO UPI")),
      body: Center(
        child: OutlinedButton(
          onPressed: () {
            getfun();
          },
          child: Text("Pay 10 INR"),
        ),
      ),
    );
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(msg: "Payment success");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(msg: "Payment failed");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(msg: "External wallet selected");
  }

  @override
  void dispose() {
    try {
      razorpay.clear();
    } catch (e) {
      print(e);
    }
    super.dispose();
  }
}
