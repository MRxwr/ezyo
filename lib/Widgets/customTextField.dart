import 'package:ezyo/Config/Colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final Function onChanged;
  final bool isObsecure;
  const CustomTextField({
    Key key,
    this.hintText,
    this.onChanged,
    this.isObsecure,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(border: Border.all(color: textFieldBorderColor)),
      child: TextField(
        obscureText: isObsecure == null ? false : isObsecure,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 10, right: 10),
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: TextStyle(color: textColorGrey)),
        onChanged: onChanged,
      ),
    );
  }
}
