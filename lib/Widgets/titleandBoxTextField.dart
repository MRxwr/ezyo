import 'package:ezyo/Config/Colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleandBoxTextField extends StatelessWidget {
  final Function onChanged;
  final isObsecure;
  final String title;
  final String hinttext;
  const TitleandBoxTextField(
      {Key key, this.onChanged, this.isObsecure, this.title, this.hinttext})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(color: blackColor, fontSize: 17),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: greyColor.withOpacity(0.5))),
          child: TextField(
            decoration: InputDecoration(
                hintText: hinttext,
                contentPadding: EdgeInsets.only(left: 10),
                hintStyle:
                    GoogleFonts.roboto(color: greyColor.withOpacity(0.5)),
                border: InputBorder.none),
            obscureText: isObsecure,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
