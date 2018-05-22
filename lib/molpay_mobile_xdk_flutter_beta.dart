import 'dart:async';

import 'package:flutter/services.dart';

class molpay {
  static const MethodChannel _channel =
      const MethodChannel('molpay_mobile_xdk_flutter_beta');

  static Future<String> startMolpay(Map<String, dynamic> args) async {
    final String result = await _channel.invokeMethod('startMolpay', args);
    return result;
  }
  
}
