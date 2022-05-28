import 'package:ezyo/Config/Colors.dart';
import 'package:ezyo/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

BottomNavigationBarItem navigationitem(

    {String assetinActive, String assetActive,double height,double width,bool isCart,BuildContext context,int notificationCount}) {
  ScreenUtil screenUtil = ScreenUtil();

  return BottomNavigationBarItem(
      icon: Container(
        padding: EdgeInsets.all(6.w),



        child:
        Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  assetinActive,
                  color: Color(0xFFD5D5D5),
                  width: width,
                  height: height,
                  fit: BoxFit.fill,

                )

              ],
            ),
            Positioned.directional(
              textDirection: Directionality.of(context),
              start: 0,
              top: 0,
              end: 0,
              bottom: 0,


              child: Opacity(
                opacity: (notificationCount >0) ? 1.0 : 0.0,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('$notificationCount',style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: ScreenUtil().setSp(10)
                    ),),
                  ),
                ),
              ),
            )
          ],
        ),

      )
      ,
      activeIcon: Container(
        padding: EdgeInsets.all(6.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.w),
            color: primaryColor.withOpacity(0.3),
          ),


          child:
          Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(assetActive,color: kSecondaryColor,
                    width: width,
                    height: height,
                    fit: BoxFit.fill,
                  )

                ],
              ),
              Positioned.directional(
                textDirection: Directionality.of(context),
                start: 0,
                top: 0,
                end: 0,
                bottom: 0,


                child: Opacity(
                  opacity: (notificationCount >0) ? 1.0 : 0.0,
                  child: Center(
                    child: Text('$notificationCount',style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: ScreenUtil().setSp(10)
                    ),),
                  ),
                ),
              )
            ],
          ),

          ));
}
