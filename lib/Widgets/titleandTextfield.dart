import 'package:ezyo/Config/Colors.dart';
import 'package:flutter/material.dart';

class TitleAndTextField extends StatelessWidget {
  final Function onChanged;
  final isObsecure;
  final String title;
  final String hinttext;
  const TitleAndTextField({
    Key key,
    this.isObsecure,
    this.onChanged,
    this.title,
    this.hinttext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(color: textColorGrey),
        ),
        TextField(
          decoration: InputDecoration(hintText: hinttext),
          obscureText: isObsecure,
          onChanged: onChanged,
        ),
        SizedBox(
          height: 35,
        )
      ],
    );
  }
}
