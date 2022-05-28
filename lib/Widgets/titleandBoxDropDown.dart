import 'package:ezyo/Config/Colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleandBoxedDropDown extends StatelessWidget {
  final List list;
  final String selectedItem;
  final String title;
  final Function onChanged;
  const TitleandBoxedDropDown(
      {Key key, this.list, this.selectedItem, this.title, this.onChanged})
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
          padding: EdgeInsets.only(left: 10, right: 10),
          decoration: BoxDecoration(
              border: Border.all(color: greyColor.withOpacity(0.5))),
          child: DropdownButton(
            underline: Container(),
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: primaryColor,
              size: 25,
            ),
            isExpanded: true,
            value: selectedItem,
            onChanged: onChanged,
            items: list.map((e) {
              return DropdownMenuItem(
                value: e,
                child: Text(
                  e,
                  style: GoogleFonts.roboto(),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
