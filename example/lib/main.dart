// import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_web_totalxsoftware/razorpay_web_totalxsoftware.dart';
// import 'package:razorpay_totalxsoftware_example/firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Razorpay Web Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PaymentScreen(),
    );
  }
}

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Razorpay Web Payment"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final HttpsCallable callable =
                FirebaseFunctions.instance.httpsCallable('createRazorpayOrder');
            final result = await callable.call({'amount': 100});
            final orderId = result.data['orderId'];

            RazorpayWebTotalxsoftware.pay(
              context,
              amount: 100,
              saveInFirebase: true,
              rzpOrderId: orderId,
              rzpKey: 'your_rzp_key',
              // itemName: , // optional
              razorpayKeySecret: 'your_rzp_secret',
              appName: 'razorpay_web_totalxsoftware',
              userProfile: RzpUserProfile(
                uid: 'unique_user_id',
                name: 'John Doe',
                email: 'john.doe@example.com',
                phoneNumber: '1234567890',
              ),
              success: (response) {
                print('Payment Success: $response');
              },
              failure: (response) {
                print('Payment Failed: $response');
              },
              error: (response) {
                print('Payment Error: $response');
              },
            );
          },
          child: const Text("Make Payment"),
        ),
      ),
    );
  }
}
