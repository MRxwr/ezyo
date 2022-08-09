import 'dart:async';

import 'package:ezyo/Config/Colors.dart';
import 'package:ezyo/Models/language_model.dart';
import 'package:ezyo/Src/Home/home-screen.dart';
import 'package:ezyo/Src/Login/loginScreen.dart';
import 'package:ezyo/Utils/helper.dart';
import 'package:ezyo/apis/ezyo_services.dart';
import 'package:ezyo/localization/localization_methods.dart';
import 'package:ezyo/utilities/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ezyo/Src/Home/home.dart' as home;
class SplashScreen extends StatefulWidget {
  static String id = 'SplashScreen';
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    language().then((value) {
      if(isLoggedIn){
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => home.Home()));
      }else{
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      }


    });
    // Timer(
    //     Duration(seconds: 3),
    //     () => Navigator.pushReplacement(
    //         context, MaterialPageRoute(builder: (context) => LoginScreen())));
  }
  String ex ="";
  bool isLoggedIn;
  Future<LanguageModel> language() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String language = sharedPreferences.getString(LANG_CODE)??"en";
    isLoggedIn = sharedPreferences.getBool("isLoggedIn")??false;
        EzyoServices ezyoServices = EzyoServices();
    LanguageModel languageModel = await ezyoServices.language(language);

      SharedPreferences _preferences = await SharedPreferences.getInstance();
      String mToken =_preferences.getString("token")??"";
      print('token --> ${mToken}');
      if(mToken == ""){
        String toke = "";

          toke = await FirebaseMessaging.instance.getAPNSToken();









        print('token --> ${toke}');
        SharedPreferences _preferences = await SharedPreferences.getInstance();



        String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;
        _preferences.setString("token", toke);
      }







    return languageModel;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: Container(
          height: Helper.setHeight(context),
          width: Helper.setWidth(context),
          child: ex
            ==""?

          Container(
            height: Helper.setHeight(context),
            width: Helper.setWidth(context),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/splash.png"),
                fit: BoxFit.fill,
              ),
            ),
          ):
          Container(
            child: Text(ex,style: TextStyle(
              color: Colors.black,
              fontSize: 18
            ),),
          ),
        ),
      ),
    );
  }
  Future<void> ShowPostAlertDialog(BuildContext context ,String title,bool isSuccess) async{
    var alert;
    ScreenUtil screenUtil = ScreenUtil();
    var alertStyle = AlertStyle(

      animationType: AnimationType.fromBottom,
      isCloseButton: true,
      isOverlayTapDismiss: true,
      descStyle: TextStyle(fontWeight: FontWeight.normal,
          color: Color(0xFF0000000),
          fontSize: screenUtil.setSp(18)),
      descTextAlign: TextAlign.start,
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
      titleStyle: TextStyle(
          color: Color(0xFF000000),
          fontWeight: FontWeight.normal,
          fontSize: screenUtil.setSp(16)
      ),
      alertAlignment: AlignmentDirectional.center,
    );
    alert =   Alert(
      context: context,
      style: alertStyle,

      title: title,


      buttons: [

        DialogButton(
          child: Text(
            getTranslated(context, 'yes'),
            style: TextStyle(color: Color(0xFFFFFFFF), fontSize: screenUtil.setSp(18)),
          ),
          onPressed: ()async {
            await alert.dismiss();
            if(isSuccess){
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            }


          },
          color:kMainColor,
          radius: BorderRadius.circular(6.w),
        ),

      ],
    );
    alert.show();

  }

}
