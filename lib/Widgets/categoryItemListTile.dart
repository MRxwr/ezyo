import 'package:ezyo/Config/Colors.dart';
import 'package:ezyo/localization/localization_methods.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryItemListTileWidget extends StatelessWidget {
  final String imagePath;
  final String itemTitle;
  final String specialNotes;
  final String price;
  final Function onDelete;

  const CategoryItemListTileWidget({
    Key key,
    this.imagePath,
    this.itemTitle,
    this.specialNotes,
    this.price,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      isThreeLine: true,
      leading: ClipRRect(
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: Image.asset(
            imagePath,
            height: 100,
            width: 60,
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(itemTitle,
          style: GoogleFonts.roboto(fontSize: 15, color: blackColor)),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            specialNotes,
            style: GoogleFonts.roboto(
                fontSize: 12, color: blackColor.withOpacity(0.4)),
          ),
          Text(
            price + " ${getTranslated(context, 'kwd')}",
            style: GoogleFonts.roboto(fontSize: 12, color: primaryColor),
          ),
        ],
      ),
    );
  }
}
