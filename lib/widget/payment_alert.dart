

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

Future<bool> showPaymentAlert(BuildContext context) async {
  return await showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        backgroundColor: Colors.white,
        contentPadding: const EdgeInsets.all(20), // Adjust padding if needed
        title: const Text(
          'Payment Alert',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 17,
          ),
        ),
        content: const SizedBox(
          width: 300, // Set your desired width here
          child: Text(
            'To ensure your payment is successfully processed, please return to the app after completing the payment. '
            'Failure to do so may result in a failed transaction. '
            'If you experience any issues, feel free to try again or contact support.',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.black54,
              fontSize: 14,
            ),
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MaterialButton(
                elevation: 0,
                minWidth: 20,
                height: 38,
                splashColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                color: const Color(0xFFD8D8D8),
                onPressed: () {
                  Navigator.pop(context, false); // Return false on Close
                },
                child: const Text(
                  "Close",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Gap(12),
              MaterialButton(
                elevation: 0,
                minWidth: 20,
                height: 38,
                splashColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                color: Colors.green,
                onPressed: () {
                  Navigator.pop(context, true); // Return true on Agree
                },
                child: const Text(
                  "Agree",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          )
        ],
      );
    },
  ) ?? false; // Ensure it returns false if dialog is dismissed without any action.
}
