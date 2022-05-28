import 'package:ezyo/Config/Colors.dart';
import 'package:ezyo/localization/localization_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'customButton.dart';


Widget buildModelSheet({BuildContext context, Function onChanged}) {
  ScreenUtil screenUtil = ScreenUtil();
  double height = MediaQuery.of(context).size.height;
  print(height);
  final TextEditingController _nameController = new TextEditingController();

  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  double statusBar = screenUtil.statusBarHeight;
  double toolBarHeight = AppBar().preferredSize.height;
  print(toolBarHeight);
  double requiredHeight = height-toolBarHeight-statusBar-10.h;
  print(requiredHeight);
 return Form(
   key: _globalKey,
   child: Container(
       height: requiredHeight,
       padding: EdgeInsets.all(10.w),
       child: Stack(
         children: [
           Column(
             mainAxisSize: MainAxisSize.min,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               GestureDetector(
                 onTap: () => Navigator.pop(context),
                 child: Container(
                     alignment: AlignmentDirectional.topEnd,
                     child: Icon(
                       Icons.close,
                       size: 30.w,
                     )),
               ),
               SizedBox(
                 height: 40.h,
               ),
               Container(
                 margin: EdgeInsets.only(left: 25.w, right: 25.w),
                 child: Text(
                  getTranslated(context, 'have_voucher'),
                   style: GoogleFonts.roboto(fontSize: screenUtil.setSp(20)),
                 ),
               ),
               SizedBox(
                 height: 20.h,
               ),
               Container(
                   height: 100.h,
                   margin: EdgeInsets.only(
                     left: 25.w,
                     right: 25.w,
                   ),
                   child:    TextFormField(
                     validator: validateName,
                     textAlign: TextAlign.start,
                     textCapitalization: TextCapitalization.words,
                     keyboardType: TextInputType.name ,

                     textInputAction: TextInputAction.done,
                     maxLines: 1,
                     minLines: 1,
                     controller: _nameController,
                     decoration: new InputDecoration(
                       hintText: getTranslated(context, 'enter_code'),
                       hintStyle: TextStyle(
                           color: Color(0xFF747474),
                           fontSize: screenUtil.setSp(12),
                           fontWeight: FontWeight.normal
                       ),

                       labelStyle: new TextStyle(color: const Color(0xFF424242)),
                       enabledBorder:  UnderlineInputBorder(
                           borderSide: BorderSide(
                               color: Color(0x88707070)
                               ,width: 1
                           )
                       )
                       ,
                       focusedBorder: UnderlineInputBorder(
                           borderSide: BorderSide(
                               color: Color(0x88707070)
                               ,width: 1
                           )
                       ),
                       border: UnderlineInputBorder(

                           borderSide: BorderSide(
                               color: Color(0xFFFF0000)
                               ,width: 1.w
                           )
                       ),
                     ),
                   ),),

             ],
           ),
           Positioned.directional(
             bottom: 10.h,
             start: 0,
             end: 0,
             textDirection:  Directionality.of(context),

             child: Container(
               margin: EdgeInsets.only(
                 left: 25.w,
                 right: 25.w,
               ),
               child: CustomButton(
                 onPressed: () {
validatevoucher(context,_globalKey);
                 },
                 isColored: true,
                 child: Center(
                     child: Text(
                       getTranslated(context, 'use_voucher'),
                       style: GoogleFonts.poppins(
                           fontSize: screenUtil.setSp(12), color: whiteColor),
                     )),
               ),
             ),
           ),
         ],
       )),
 );


}

void validatevoucher(BuildContext context,GlobalKey<FormState> _globalKey) {
  if(_globalKey.currentState.validate()) {



  }
}
String validateName(String value) {

  if (value.trim().length == 0) {
    return "Please use a valid voucher";
  }

  return null;
}


