import 'package:ezyo/Config/Colors.dart';
import 'package:ezyo/Models/error_model.dart';
import 'package:ezyo/Models/profile_model.dart';
import 'package:ezyo/Models/update_password_model.dart';
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

class ChangePassScreen extends StatefulWidget {
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
   ChangePassScreen({Key key}) : super(key: key);

  @override
  _ChangePassScreenState createState() => _ChangePassScreenState();
}

class _ChangePassScreenState extends State<ChangePassScreen> {
  ScreenUtil screenUtil = ScreenUtil();
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
    EzyoServices ezyoServices = EzyoServices();
    ProfileModel profileModel = await ezyoServices.profile(userId);
    return profileModel;

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserInfo().then((value){
      setState(() {

      });

    });
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final TextEditingController _oldPassworController = new TextEditingController();
  final TextEditingController _newPasswordController = new TextEditingController();
  final TextEditingController _confirmPasswordController = new TextEditingController();
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
              appBarTitle: getTranslated(context, 'change_password'), context: context, isLeading: true),
          body: Form(
            key: widget._globalKey,
            child: Container(
              margin: EdgeInsets.all(40),
              child: userId == ""?
              Container(
                child: CircularProgressIndicator(


                ),
                alignment: AlignmentDirectional.center,
              ):
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getTranslated(context, 'current_password'),
                    style: TextStyle(color: textColorGrey,
                      fontSize: screenUtil.setSp(12),
                    ),
                    textAlign: TextAlign.start,
                  ),
                  TextFormField(
                    validator: validateName,
                    textAlign: TextAlign.start,
                    textCapitalization: TextCapitalization.words,
                    keyboardType: TextInputType.text ,
                    obscureText: true,

                    textInputAction: TextInputAction.next,
                    maxLines: 1,
                    minLines: 1,
                    controller: this._oldPassworController,
                    decoration: new InputDecoration(
                      hintText: getTranslated(context, 'enter_current_password'),
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
                    height: 10.h,
                  ),
                  Text(
                    getTranslated(context, 'new_password'),
                    style: TextStyle(color: textColorGrey,
                      fontSize: screenUtil.setSp(12),
                    ),
                    textAlign: TextAlign.start,
                  ),
                  TextFormField(
                    validator: validateName,
                    textAlign: TextAlign.start,
                    textCapitalization: TextCapitalization.words,
                    keyboardType: TextInputType.text ,
                    obscureText: true,

                    textInputAction: TextInputAction.next,
                    maxLines: 1,
                    minLines: 1,
                    controller: this._newPasswordController,
                    decoration: new InputDecoration(
                      hintText: getTranslated(context, 'enter_new_password'),
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
                    height: 10.h,
                  ),
                  Text(
                    getTranslated(context, 'confirm_password'),
                    style: TextStyle(color: textColorGrey,
                      fontSize: screenUtil.setSp(12),
                    ),
                    textAlign: TextAlign.start,
                  ),
                  TextFormField(
                    validator: validateName,
                    textAlign: TextAlign.start,
                    textCapitalization: TextCapitalization.words,
                    keyboardType: TextInputType.text ,
                    obscureText: true,

                    textInputAction: TextInputAction.done,
                    maxLines: 1,
                    minLines: 1,
                    controller: this._confirmPasswordController,
                    decoration: new InputDecoration(
                      hintText: getTranslated(context, 'repeat_password'),
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
  String validateName(String value) {

    if (value.trim().length < 5) {
      return getTranslated(context, 'enter_password');
    }

    return null;
  }
  void validate(BuildContext context,String id) async {

    if(widget._globalKey.currentState.validate()) {

      String oldPassword = _oldPassworController.text;
      String   newPassword = _newPasswordController.text;
      String confirmPassword = _confirmPasswordController.text;

      if(newPassword == confirmPassword){
        widget._globalKey.currentState.save();
        final modelHud = Provider.of<ModelHud>(context, listen: false);
        modelHud.changeIsLoading(true);
        EzyoServices ezyoServices = EzyoServices();
        Map<String, dynamic>   response = await ezyoServices.updatePassword( oldPassword, newPassword,id);
        modelHud.changeIsLoading(false);
        bool  isOk  = response['ok'];
        if(isOk){
          UpdatePasswordModel updateProfileModel = UpdatePasswordModel.fromJson(response);

          SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          sharedPreferences.setString("password", _newPasswordController.text);

          _scaffoldKey.currentState.showSnackBar(
              SnackBar(content: Text(updateProfileModel.data.msg)));



        }else{
          ErrorModel errorModel = ErrorModel.fromJson(response);
          _scaffoldKey.currentState.showSnackBar(
              SnackBar(content: Text(errorModel.data.msg)));
        }


      }else{
        Scaffold.of(context).showSnackBar(SnackBar(content: Text(getTranslated(context, 'no_data_changed'))));
      }


    }


  }
}
