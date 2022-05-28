

import 'package:ezyo/Config/Colors.dart';
import 'package:ezyo/Models/error_model.dart';
import 'package:ezyo/Models/profile_model.dart';
import 'package:ezyo/Models/update_profile_model.dart';
import 'package:ezyo/Widgets/customAppBar.dart';
import 'package:ezyo/Widgets/customButton.dart';
import 'package:ezyo/Widgets/titleandTextfield.dart';
import 'package:ezyo/apis/ezyo_services.dart';
import 'package:ezyo/localization/localization_methods.dart';
import 'package:ezyo/providers/model_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
   ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ScreenUtil screenUtil = ScreenUtil();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _phoneController = new TextEditingController();
  ProfileModel profileModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserInfo().then((value){
      setState(() {
        profileModel = value;
        _nameController.text = value.data.name;
        _phoneController.text = phone;
        _emailController.text = value.data.email;
      });
    });
  }

  String name="";
  String email ="";
  String phone ="";
  String userId ="";

  Future<ProfileModel> getUserInfo() async{

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
     name = sharedPreferences.getString("name")??"";
     email = sharedPreferences.getString("email")??"";
     phone = sharedPreferences.getString("phone")??"";
     userId = sharedPreferences.getString("id")??"";
     print('userId == ${userId}');
    EzyoServices ezyoServices = EzyoServices();
    ProfileModel profileModel = await ezyoServices.profile(userId);
     return profileModel;

  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: ModalProgressHUD(
        inAsyncCall: Provider.of<ModelHud>(context).isLoading,
        child: Scaffold(
          key: _scaffoldKey,
          appBar: customAppBar(
              appBarTitle: getTranslated(context, 'profile'), isLeading: true, context: context),
          body: Form(
            key: widget._globalKey,
            child: Container(
              margin: EdgeInsets.all(40),
              child: profileModel == null?
                  Container(
                    child: CircularProgressIndicator(


                    ),
                    alignment: AlignmentDirectional.center,
                  )
                  :

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getTranslated(context, 'name'),
                    style: TextStyle(color: textColorGrey,
                    fontSize: screenUtil.setSp(12),
                    ),
                    textAlign: TextAlign.start,
                  ),
                  TextFormField(
                    validator: validateName,
                    textAlign: TextAlign.start,
                    textCapitalization: TextCapitalization.words,
                    keyboardType: TextInputType.emailAddress ,

                    textInputAction: TextInputAction.next,
                    maxLines: 1,
                    minLines: 1,
                    controller: this._nameController,
                    decoration: new InputDecoration(
                      hintText: getTranslated(context, 'enter_ur_name'),
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
                  ),
                  SizedBox(height: 10.h,),
                  Text(
                    getTranslated(context, 'email_st'),
                    style: TextStyle(color: textColorGrey,
                      fontSize: screenUtil.setSp(12),
                    ),
                    textAlign: TextAlign.start,
                  ),
                  TextFormField(
                    textAlign: TextAlign.start,
                    textCapitalization: TextCapitalization.words,
                    keyboardType: TextInputType.emailAddress ,
                    enabled: false,

                    textInputAction: TextInputAction.next,
                    maxLines: 1,
                    minLines: 1,
                    controller: this._emailController,
                    decoration: new InputDecoration(
                      hintText: getTranslated(context, 'enter_email'),
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
                  ),
                  SizedBox(height: 10.h,),
                  Text(
                    getTranslated(context, 'mobile_no'),
                    style: TextStyle(color: textColorGrey,
                      fontSize: screenUtil.setSp(12),
                    ),
                    textAlign: TextAlign.start,
                  ),
                  TextFormField(
                    validator: validatePhone,
                    textAlign: TextAlign.start,
                    textCapitalization: TextCapitalization.words,
                    keyboardType: TextInputType.phone ,

                    textInputAction: TextInputAction.done,
                    maxLines: 1,
                    minLines: 1,
                    controller: this._phoneController,
                    decoration: new InputDecoration(
                      hintText: getTranslated(context, 'enter_ur_mobile'),
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
                  ),

                  SizedBox(
                    height: 20.h,
                  ),
                  CustomButton(
                    child: Center(
                      child: Text(
                        getTranslated(context, 'update'),
                        style: GoogleFonts.roboto(fontSize: 12, color: whiteColor),
                      ),
                    ),
                    onPressed: () {
                      validate(context,userId);

                    },
                    isColored: true,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void validate(BuildContext context,String id) async {

    if(widget._globalKey.currentState.validate()) {

      String userName = _nameController.text;
      if(userName != name){
        widget._globalKey.currentState.save();
        final modelHud = Provider.of<ModelHud>(context, listen: false);
        modelHud.changeIsLoading(true);
        EzyoServices ezyoServices = EzyoServices();
        Map<String, dynamic>   response = await ezyoServices.updateProfile( id, userName);
        modelHud.changeIsLoading(false);
        bool  isOk  = response['ok'];
        if(isOk){
          UpdateProfileModel updateProfileModel = UpdateProfileModel.fromJson(response);
          String name = updateProfileModel.data.name;
          String email = updateProfileModel.data.email;
          SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          sharedPreferences.setString("name", name);
          sharedPreferences.setString("email", email);
          sharedPreferences.setString("phone", _phoneController.text);
          _scaffoldKey.currentState.showSnackBar(
              SnackBar(content: Text(updateProfileModel.status)));



        }else{
          ErrorModel errorModel = ErrorModel.fromJson(response);
          _scaffoldKey.currentState.showSnackBar(
              SnackBar(content: Text(errorModel.data.msg)));
        }


      }else{
        Scaffold.of(context).showSnackBar(SnackBar(content: Text("No Data Changed")));
      }


    }


  }
  bool validateEmail(String value) {
    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);

    if (!emailValid) {
      return false;
    }else{
      return true;
    }


  }

  String validateName(String value) {

    if (value.trim().length < 5) {
      return getTranslated(context, 'enter_ur_name');
    }

    return null;
  }
  String validatePhone(String value) {
    String patttern = r'(^[0-9]{8}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return getTranslated(context,'enter_ur_mobile');
    }
    else if (!regExp.hasMatch(value)) {
      return getTranslated(context,'enter_ur_mobile');
    }
    return null;





  }
}
