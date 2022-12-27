import 'dart:math';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Function That Converts Hex Code To Flutter Recognized Color
///
/// [params]
/// [hexCode]: The Hex Code To Be Converted
///
/// Example
///
/// fromHex('#5265ff')
Color fromHex(String hexString) {
  final buffer = StringBuffer();
  if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
  buffer.write(hexString.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}

///This Validate if an email address is correct
extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
        .hasMatch(this);
  }
}

///Lunching URl
Future<void> launchUrlStart({required String url}) async {
  if (!await launchUrl(Uri.parse(url))) {
    throw 'Could not launch $url';
  }
}

String randomPictureUrl() {
  final random = Random();
  final randomInt = random.nextInt(1000);
  return 'https://picsum.photos/seed/$randomInt/300/300';
}

DateTime randomDate() {
  final random = Random();
  final currentDate = DateTime.now();
  return currentDate.subtract(Duration(seconds: random.nextInt(200000)));
}
