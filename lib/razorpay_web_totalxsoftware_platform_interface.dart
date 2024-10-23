import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'razorpay_web_totalxsoftware_method_channel.dart';

abstract class RazorpayWebTotalxsoftwarePlatform extends PlatformInterface {
  /// Constructs a RazorpayWebTotalxsoftwarePlatform.
  RazorpayWebTotalxsoftwarePlatform() : super(token: _token);

  static final Object _token = Object();

  static RazorpayWebTotalxsoftwarePlatform _instance = MethodChannelRazorpayWebTotalxsoftware();

  /// The default instance of [RazorpayWebTotalxsoftwarePlatform] to use.
  ///
  /// Defaults to [MethodChannelRazorpayWebTotalxsoftware].
  static RazorpayWebTotalxsoftwarePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [RazorpayWebTotalxsoftwarePlatform] when
  /// they register themselves.
  static set instance(RazorpayWebTotalxsoftwarePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
