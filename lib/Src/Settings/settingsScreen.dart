import 'dart:io';

import 'package:ezyo/Config/Colors.dart';
import 'package:ezyo/Models/settings_model.dart';
import 'package:ezyo/Src/ChangePassword/changePassScreen.dart';
import 'package:ezyo/Src/Language/languageScreen.dart';
import 'package:ezyo/Src/Login/loginScreen.dart';
import 'package:ezyo/Src/Privacy/privacy_screen.dart';
import 'package:ezyo/Src/Profile/profileScreen.dart';
import 'package:ezyo/Widgets/customAppBar.dart';
import 'package:ezyo/Widgets/customDivider.dart';
import 'package:ezyo/apis/ezyo_services.dart';
import 'package:ezyo/localization/localization_methods.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  SettingsModel settingsModel;
  String language;
  bool isLoggedIn= false;
  Future<SettingsModel> settings() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
     language = sharedPreferences.getString(LANG_CODE)??"en";
    isLoggedIn = sharedPreferences.getBool("isLoggedIn")??false;
   String userId = sharedPreferences.getString("id")??"";
    EzyoServices ezyoServices = EzyoServices();
    SettingsModel languageModel = await ezyoServices.settings(userId);
    return languageModel;

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    settings().then((value) {
      setState(() {
        settingsModel = value;
      });

    });
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: customAppBar(appBarTitle: getTranslated(context, 'settings')),
        body: Container(
          margin: EdgeInsets.only(top: 10),
          child: settingsModel == null?
          Container(
            child: CircularProgressIndicator(


            ),
            alignment: AlignmentDirectional.center,
          )
              :

          Column(
            children: [
              SettingsListTile(
                imagePath: "assets/icons/user.png",
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfileScreen()));
                },
                title: getTranslated(context, 'profile'),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: primaryColor,
                  size: 20,
                ),
              ),
              SettingsListTile(
                imagePath: "assets/icons/wallet.png",
                onTap: () {},
                title: getTranslated(context, 'wallet'),
                trailing: Text(
                  settingsModel.data.wallet.toString(),
                  style: GoogleFonts.roboto(fontSize: 12, color: primaryColor),
                ),
              ),
              SettingsListTile(
                imagePath: "assets/icons/lock.png",
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChangePassScreen()));
                },
                title: getTranslated(context,'change_password'),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: primaryColor,
                  size: 20,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SettingsListTile(
                imagePath: "assets/icons/language.png",
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LanguageScreen()));
                },
                title: getTranslated(context, 'language'),
                trailing: Text(
                  language=="en"?"English":"عربي",
                  style: GoogleFonts.roboto(fontSize: 12, color: primaryColor),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SettingsListTile(
                imagePath: "assets/icons/tc.png",
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PrivacyScreen(title: 'Terms & Conditions', description: language=="en"? settingsModel.data.enTerms:settingsModel.data.arTerms)));
                },
                title: getTranslated(context, 'terms'),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: primaryColor,
                  size: 20,
                ),
              ),
              SettingsListTile(
                imagePath: "assets/icons/pp.png",
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PrivacyScreen(title: 'Privacy Policy', description: language=="en"? settingsModel.data.enPolicy:settingsModel.data.arPolicy)));

                },
                title: getTranslated(context, 'privacy'),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: primaryColor,
                  size: 20,
                ),
              ),

              SettingsListTile(
                imagePath: "assets/images/whatsapp.png",
                onTap: () {
                  openwhatsapp(context,settingsModel.data.whatsapp);


                },
                title: getTranslated(context,'complain'),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: primaryColor,
                  size: 20,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SettingsListTile(
                imagePath: "assets/icons/logout.png",
                onTap: () {
                  logout(context).then((value) {
                    Navigator.pushReplacementNamed(context, LoginScreen.id);
                  });


                },
                title: getTranslated(context,'logout'),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: primaryColor,
                  size: 20,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
openwhatsapp(BuildContext context,String phone) async{
  var whatsapp ="+"+phone;
  var whatsappURl_android = "whatsapp://send?phone="+whatsapp+"&text=";
  var whatappURL_ios ="https://wa.me/$whatsapp?text=";
  if(Platform.isIOS){
    // for iOS phone only
    if( await canLaunch(whatappURL_ios)){
      await launch(whatappURL_ios, forceSafariVC: false);
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: new Text("whatsapp no installed")));

    }

  }else{
    // android , web
    if( await canLaunch(whatsappURl_android)){
      await launch(whatsappURl_android);
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: new Text("whatsapp no installed")));

    }


  }

}
Future<bool> logout(BuildContext context) async{
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setBool("isLoggedIn", false);



  return sharedPreferences.getBool("isLoggedIn");

}
class SettingsListTile extends StatelessWidget {
  final String imagePath, title;
  final Widget trailing;
  final Function onTap;
  const SettingsListTile(
      {Key key, this.imagePath, this.title, this.trailing, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ListTile(
            onTap: onTap,
            contentPadding: EdgeInsets.only(left: 20, right: 20),
            minLeadingWidth: 10,
            tileColor: Colors.white,
            leading: Image.asset(
              imagePath,
              height: 20,
              width: 20,
              fit: BoxFit.fill,
            ),
            title: Text(title),
            trailing: trailing,
          ),
          CustomDivider(),
        ],
      ),
    );
  }
}
