import 'package:flutter_test/flutter_test.dart';
import 'package:razorpay_web_totalxsoftware/razorpay_web_totalxsoftware.dart';
import 'package:razorpay_web_totalxsoftware/razorpay_web_totalxsoftware_platform_interface.dart';
import 'package:razorpay_web_totalxsoftware/razorpay_web_totalxsoftware_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockRazorpayWebTotalxsoftwarePlatform
    with MockPlatformInterfaceMixin
    implements RazorpayWebTotalxsoftwarePlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final RazorpayWebTotalxsoftwarePlatform initialPlatform = RazorpayWebTotalxsoftwarePlatform.instance;

  test('$MethodChannelRazorpayWebTotalxsoftware is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelRazorpayWebTotalxsoftware>());
  });

  test('getPlatformVersion', () async {
    RazorpayWebTotalxsoftware razorpayWebTotalxsoftwarePlugin = RazorpayWebTotalxsoftware();
    MockRazorpayWebTotalxsoftwarePlatform fakePlatform = MockRazorpayWebTotalxsoftwarePlatform();
    RazorpayWebTotalxsoftwarePlatform.instance = fakePlatform;

    expect(await razorpayWebTotalxsoftwarePlugin.getPlatformVersion(), '42');
  });
}
