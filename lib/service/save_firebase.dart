import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:razorpay_web_totalxsoftware/models/rzp_user_profile_model.dart';

class SaveFirebase {
  static String createFirebasePaymentID() {
    final id = _firestore.collection('razorpayPaymentTransaction').doc().id;
    return id;
  }

  static final _firestore = FirebaseFirestore.instance;
  static Future<void> createProcessingTransaction({
    required num amount,
    required String rzpKey,
    required String appName,
    String? itemName,
    required RzpUserProfile userProfile,
    required String transaction,
    required String orderId,
  }) async {
    _firestore.collection('razorpayPaymentTransaction').doc(transaction).set(
      {
        'status': 'processing',
        'gateway': 'razorpay',
        'platform': 'web',
        'amount': amount,
        'rzpKey': rzpKey,
        'appName': appName,
        'itemName': itemName,
        'user': userProfile.toMap(),
        'id': transaction,
        'createdAt': FieldValue.serverTimestamp(),
        'orderId': orderId,
      },
    );
  }

  static Future<void> updateSuccessTransaction({
    required String transaction,
  }) async {
    _firestore.collection('razorpayPaymentTransaction').doc(transaction).update(
      {
        'status': 'success',
        'successTime': FieldValue.serverTimestamp(),
      },
    );
  }

  static Future<void> updateFailureTransaction({
    required String transaction,
  }) async {
    _firestore.collection('razorpayPaymentTransaction').doc(transaction).update(
      {
        'status': 'failure',
        'failureTime': FieldValue.serverTimestamp(),
      },
    );
  }
}
