import 'package:ezyo/Config/Colors.dart';
import 'package:ezyo/Utils/helper.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Widget child;
  final Function onPressed;
  final bool isColored;
  const CustomButton({
    Key key,
    this.child,
    this.onPressed,
    this.isColored,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          height: 50,
          width: Helper.setWidth(context),
          decoration: isColored
              ? BoxDecoration(
                  color: primaryColor, borderRadius: BorderRadius.circular(10))
              : BoxDecoration(
                  border: Border.all(color: primaryColor),
                  borderRadius: BorderRadius.circular(10)),
          child: child),
    );
  }
}
