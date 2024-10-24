import 'dart:developer';

// import 'package:firebase_core/firebase_core.dart';
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
          onPressed: () {
            RazorpayWebTotalxsoftware.pay(
              context,
              amount: 100,
              saveInFirebase: false,
              rzpOrderId: '',
              rzpKey: 'rzp_test_8mYCq4efvCCyu0',
              razorpayKeySecret: 'gVTrlrkzbMn0SGWZYLLoKyeW',
              appName: 'razorpay_web_totalxsoftware',
              // itemName: , // optional
              userProfile: RzpUserProfile(
                uid: 'unique_user_id',
                name: 'John Doe',
                email: 'qYqgK@example.com',
                phoneNumber: '1234567890',
              ),
              success: (response) {
                log(response.toString());
                log('payment success');
              },
              failure: (response) {
                log(response.toString());
              },
              error: (response) {
                log(response.toString());
              },
            );
          },
          child: const Text("Make Payment"),
        ),
      ),
    );
  }
}
