import 'package:ezyo/Config/Colors.dart';
import 'package:ezyo/Src/Home/home-screen.dart';
import 'package:ezyo/Src/Home/home.dart';
import 'package:ezyo/Widgets/customAppBar.dart';
import 'package:ezyo/Widgets/customDivider.dart';
import 'package:ezyo/localization/localization_methods.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({Key key}) : super(key: key);

  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  bool checkedValue = true;

  Future<String> getLanguage() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String language = sharedPreferences.getString(LANG_CODE)??"en";
    return language;
  }
  bool isArabicSelected = false;
  bool isEnglishSelected = false;
  String mLanguage = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLanguage().then((value){
      if(value == 'en'){

        isEnglishSelected = true;
        isArabicSelected = false;
      }else{
        isEnglishSelected = false;
        isArabicSelected = true;
      }
      mLanguage = value;
      setState(() {

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
        appBar: customAppBar(
            context: context, appBarTitle: getTranslated(context, 'language'), isLeading: true),
        body: Container(
          child:mLanguage ==""?
          Container(
            child: CircularProgressIndicator(


            ),
            alignment: AlignmentDirectional.center,
          )
              :

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              ListTile(
                onTap: () {
                  if(!isArabicSelected){
                    isArabicSelected = true;
                    isEnglishSelected = false;
                    _changeLanguage('ar').then((value) {
                      setState(() {

                      });
                      Navigator.of(context).pushReplacementNamed( Home.id);
                    });

                  }
                },
                leading: !isArabicSelected
                    ? Container(
                        width: 10,
                      )
                    : Icon(
                        Icons.check,
                      ),
                title: Text(
                  "العربية",
                  style: GoogleFonts.roboto(fontSize: 14),
                ),
              ),
              CustomDivider(),
              ListTile(
                onTap: () {
                  if(!isEnglishSelected){
                    isArabicSelected = false;
                    isEnglishSelected = true;
                    _changeLanguage('en').then((value) {
                      setState(() {

                      });
                      Navigator.of(context).pushReplacementNamed( Home.id);
                    });
                  }

                },
                leading:isEnglishSelected
                    ? Icon(
                        Icons.check,
                      )
                    : Container(
                        width: 10,
                      ),
                title: Text(
                  "English",
                  style: GoogleFonts.roboto(fontSize: 14),
                ),
              ),
              CustomDivider(),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> _changeLanguage(String language) async {
    Locale _temp = await setLocale( language);
    MyApp.setLocale(context, _temp);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("selectLanguage", true);
    sharedPreferences.setString(LANG_CODE, language);



  }
}
