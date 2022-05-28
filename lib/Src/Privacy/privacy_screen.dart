import 'package:ezyo/Config/Colors.dart';
import 'package:ezyo/Widgets/customAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
class PrivacyScreen extends StatefulWidget {
  String title;
  String description;
   PrivacyScreen({Key key,@required this.title,@required this.description}) : super(key: key);

  @override
  _PrivacyScreenState createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  ScreenUtil screenUtil = ScreenUtil();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: customAppBar( context: context,appBarTitle: widget.title, isLeading: true),
        body: Container(

          child:  SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(10.w),
                child: HtmlWidget(


                  widget.description,
                  textStyle: TextStyle(
                      color: Color(0xFF000000),
                      fontWeight: FontWeight.w500,
                      fontSize: screenUtil.setSp(
                          12)

                  ),
                )


            ),
          ),

        ),
      ),
    );
  }
}
