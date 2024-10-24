// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:razorpay_web/razorpay_web.dart';
import 'package:razorpay_web_totalxsoftware/models/rzp_user_profile_model.dart';
import 'package:razorpay_web_totalxsoftware/service/save_firebase.dart';
import 'package:razorpay_web_totalxsoftware/widget/payment_alert.dart';
import 'package:razorpay_web_totalxsoftware/widget/show_progress.dart';
import 'package:uuid/uuid.dart';

export 'package:razorpay_web_totalxsoftware/models/rzp_user_profile_model.dart';
export 'package:razorpay_web_totalxsoftware/razorpay_web_totalxsoftware.dart';

class RazorpayWebTotalxsoftware {
  static bool _isLoading = false;
  static Future<void> pay(
    BuildContext context, {
    required bool saveInFirebase,
    required num amount,
    required String rzpKey,
    required String rzpOrderId,
    required String razorpayKeySecret,
    required String appName,
    String? itemName,
    required RzpUserProfile userProfile,
    required Function(PaymentSuccessResponse response) success,
    required Function(PaymentFailureResponse response) failure,
    required Function(String response) error,
  }) async {
    try {
      if (razorpayKeySecret.trim().isEmpty || rzpKey.trim().isEmpty) {
        error.call('Razorpay Key Secret or Razorpay Key cannot be empty');
        return;
      }

      //Payment Alert
      final isAgree = await showPaymentAlert(context);

      if (!isAgree) return;

      if (_isLoading) return;
      _isLoading = true;
      showProgress(context);
      final orderId = rzpOrderId;
      String id;
      if (saveInFirebase) {
        id = SaveFirebase.createFirebasePaymentID();
      } else {
        id = const Uuid().v4();
      }

      if (saveInFirebase) {
        await SaveFirebase.createProcessingTransaction(
          orderId: orderId,
          amount: amount,
          appName: appName,
          rzpKey: rzpKey,
          transaction: id,
          userProfile: userProfile,
          itemName: itemName,
        );
      }
      //
      final razorpay = Razorpay();
      razorpay.on(
        Razorpay.EVENT_PAYMENT_SUCCESS,
        (PaymentSuccessResponse response) {
          Navigator.pop(context);
          success.call(response);
          if (saveInFirebase) {
            SaveFirebase.updateSuccessTransaction(transaction: id);
          }
          _isLoading = false;
        },
      );
      razorpay.on(
        Razorpay.EVENT_PAYMENT_ERROR,
        (PaymentFailureResponse response) {
          Navigator.pop(context);
          failure.call(response);
          if (saveInFirebase) {
            SaveFirebase.updateFailureTransaction(transaction: id);
          }
          _isLoading = false;
        },
      );
      var options = {
        'id': id,
        'key': rzpKey,
        'amount': (amount * 100),
        'name': appName,
        'description': itemName,
        'order_id': orderId,
        'retry': {'enabled': true, 'max_count': 1},
        'send_sms_hash': true,
        'prefill': {
          'name': userProfile.name,
          'contact': userProfile.phoneNumber,
          'email': userProfile.email,
        },
      };
      razorpay.open(options);
    } on Exception catch (e) {
      error.call(e.toString());
      _isLoading = false;
      Navigator.pop(context);
    }
  }
}
