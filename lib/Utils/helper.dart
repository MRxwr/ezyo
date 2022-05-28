import 'package:flutter/material.dart';

class Helper {
  static setHeight(BuildContext context, {height: 1}) {
    return MediaQuery.of(context).size.height * height;
  }

  static setWidth(BuildContext context, {width: 1}) {
    return MediaQuery.of(context).size.width * width;
  }

  static toScreen(context, screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }
}
