import 'package:ezyo/Config/Colors.dart';
import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: blackColor.withOpacity(0.2),
      height: 1,
      thickness: 0.5,
    );
  }
}
