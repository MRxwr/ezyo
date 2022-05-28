import 'package:flutter/material.dart';

class CustomSocialIcons extends StatelessWidget {
  final String assetName;
  final Color bgColor;
  final Function onPressed;
  const CustomSocialIcons({
    Key key,
    this.assetName,
    this.bgColor,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            color: bgColor, borderRadius: BorderRadius.circular(10)),
        child: Image.asset(assetName),
      ),
    );
  }
}
