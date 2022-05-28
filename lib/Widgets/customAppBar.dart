import 'package:ezyo/Config/Colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

AppBar customAppBar(
    {BuildContext context, String appBarTitle, bool isLeading = false}) {
  return

    AppBar(
    toolbarHeight: 66,
    backgroundColor: whiteColor,
    centerTitle: true,
    elevation: 5,
    title: Text(
      appBarTitle,
      style: GoogleFonts.roboto(fontSize: 15, color: blackColor),
    ),
    leading: isLeading
        ? GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: blackColor,
              size: 18,
            ),
          )
        : Container(),
  );
}
