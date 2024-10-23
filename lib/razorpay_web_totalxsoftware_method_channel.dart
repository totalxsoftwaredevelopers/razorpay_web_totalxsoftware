import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'razorpay_web_totalxsoftware_platform_interface.dart';

/// An implementation of [RazorpayWebTotalxsoftwarePlatform] that uses method channels.
class MethodChannelRazorpayWebTotalxsoftware extends RazorpayWebTotalxsoftwarePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('razorpay_web_totalxsoftware');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
