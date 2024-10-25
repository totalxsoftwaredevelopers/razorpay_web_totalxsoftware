# Razorpay Web Integration for TotalXSoftware

![www.totalx.in](https://totalx.in/assets/logo-k3HH3X3v.png)

## Explore more about TotalX at www.totalx.in - Your trusted software development company!

`razorpay_web_totalxsoftware` is a Flutter web package for integrating Razorpay payments using Firebase Cloud Functions. This guide will walk you through setting up a Firebase Cloud Function to create Razorpay orders and integrating it with a Flutter web application.

## Features

- Secure Razorpay payment processing via Firebase Cloud Functions.
- Handles payment success, failure, and error callbacks.
- Supports customizable user profiles and data.

## Prerequisites

Ensure you have:

- A Razorpay account with API credentials (Key ID and Key Secret).
- A Firebase project with Cloud Functions enabled.
- A Flutter web project ready for integration.

## Firebase Cloud Function Setup

### 1. Initialize Firebase Functions in your project

First, open a terminal, navigate to your Firebase project directory, and initialize Firebase Functions:

```bash
firebase init functions
```

## Firebase Cloud Function Setup

You need to set up Firebase Cloud Functions to securely create Razorpay orders. Here’s an example function:

```typescript
import * as dayjs from "dayjs";
import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import { v4 as uuidv4 } from "uuid";
import Razorpay = require("razorpay");

// Initialize Firebase Admin SDK
admin.initializeApp();

const firestore = admin.firestore();

export const createRazorpayOrder = functions.https.onCall(
  async (data, context) => {
    try {
      const amount = data.amount;

      // Fetch Razorpay credentials from Firestore
      const razorpayDoc = await firestore
        .collection("general")
        .doc("payment")
        .get();
      if (!razorpayDoc.exists) {
        throw new Error("Razorpay credentials not found in Firestore");
      }

      const RZP_KEY = razorpayDoc.data()?.razorpay;
      const RZP_SECRET = razorpayDoc.data()?.keysecret;

      // Create a unique receipt
      const receipt = `rcpt_${dayjs().format(
        "YYYYMMDDHHmmss"
      )}_${uuidv4().substring(0, 8)}`;

      // Initialize Razorpay instance
      const razorpayInstance = new Razorpay({
        key_id: RZP_KEY,
        key_secret: RZP_SECRET,
      });

      // Prepare order data
      const orderData = {
        amount: amount * 100, // Convert to paise
        currency: "INR",
        receipt: receipt,
      };

      // Create order
      const response = await razorpayInstance.orders.create(orderData);

      return { orderId: response.id };
    } catch (error) {
      throw new functions.https.HttpsError(
        "unknown",
        `Error creating order: ${error}`
      );
    }
  }
);
```

## Usage

Here’s an example of how to use razorpay_web_totalxsoftware in your Flutter app:

```dart
final HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('createRazorpayOrder');
final result = await callable.call({'amount': 100});
final orderId = result.data['orderId'];

RazorpayWebTotalxsoftware.pay(
  context,
  amount: 100,
  saveInFirebase: false,
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

```
