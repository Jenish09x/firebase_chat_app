import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CommonFunc {
  static void closeKeyboard() => FocusManager.instance.primaryFocus?.unfocus();

  static Future<int> getAndroidVersion() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return androidInfo.version.sdkInt;
  }

  static String maskEmail(String email) {
    final parts = email.split('@');
    if (parts.length != 2) {
      throw ArgumentError('Invalid email format');
    }

    String username = parts[0];
    String domain = parts[1];

    String maskedUsername = username.isNotEmpty ? username[0].toUpperCase() + '*' * (username.length - 1) : '';

    String reversedDomain = domain.split('').join();

    return '$maskedUsername@$reversedDomain';
  }

  static Future<void> openUrl({required String url}) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
}
