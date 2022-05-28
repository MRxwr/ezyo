import 'package:ezyo/Config/Colors.dart';
import 'package:ezyo/Models/error_model.dart';
import 'package:ezyo/Models/forget_password_model.dart';
import 'package:ezyo/Models/login_model.dart';
import 'package:ezyo/Src/Home/home.dart';
import 'package:ezyo/Src/Login/loginScreen.dart';
import 'package:ezyo/Utils/helper.dart';
import 'package:ezyo/Widgets/customButton.dart';
import 'package:ezyo/Widgets/customTextField.dart';
import 'package:ezyo/apis/ezyo_services.dart';
import 'package:ezyo/localization/localization_methods.dart';
import 'package:ezyo/providers/model_hud.dart';
import 'package:ezyo/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key key}) : super(key: key);

  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  ScreenUtil screenUtil=ScreenUtil();
  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _phoneController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  final TextEditingController _confirmpasswordController = new TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

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
          body: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                "assets/images/bg.png",
                height: Helper.setHeight(context),
                width: Helper.setWidth(context),
              ),
              Container(
                padding: EdgeInsets.all(20),
                height: Helper.setHeight(context, height: 0.4),
                width: Helper.setWidth(context, width: 0.8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30), color: Colors.white),
                child: ClipRRect(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: blackColor,
                          size: 20,
                        ),
                      ),
                      SizedBox(height: 20),
                      Center(
                          child: Text(
                            getTranslated(context, 'forget_password'),
                            style: GoogleFonts.roboto(
                                color: blackColor,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          )),
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: 40.h,
                        child:
                        TextField(
                          textAlign: TextAlign.start,
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.emailAddress ,

                          textInputAction: TextInputAction.done,
                          maxLines: 1,
                          minLines: 1,
                          controller: this._emailController,
                          decoration: new InputDecoration(
                            hintText: getTranslated(context, 'email'),
                            hintStyle: TextStyle(
                                color: Color(0xFF747474),
                                fontSize: screenUtil.setSp(12),
                                fontWeight: FontWeight.normal
                            ),

                            labelStyle: new TextStyle(color: const Color(0xFF424242)),
                            enabledBorder:      OutlineInputBorder(

                                borderSide: BorderSide(
                                    color: Color(0x22707070)
                                    ,width: 1
                                )
                            ),
                            focusedBorder: OutlineInputBorder(

                                borderSide: BorderSide(
                                    color: Color(0x22707070)
                                    ,width: 1
                                )
                            ),
                            border: OutlineInputBorder(

                                borderSide: BorderSide(
                                    color: Color(0xFFFF0000)
                                    ,width: 1.w
                                )
                            ),
                          ),
                        ),
                      ),


                      SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                        isColored: true,
                        onPressed: () {
                          validate(context);
                        },
                        child: Center(
                            child: Text(getTranslated(context, 'forget_password'),
                                style: GoogleFonts.roboto(
                                    fontSize: 15, color: textColorWhite))),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  bool validateEmail(String value) {
    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);

    if (!emailValid) {
      return false;
    }else{
      return true;
    }


  }
  bool validateName(String value) {
    bool errorMessage ;

    if(value.trim().length < 5){
      errorMessage = false;
    }else{
      errorMessage = true;
    }




    return errorMessage;
  }
  void validate(BuildContext context) async{
    String email = _emailController.text;

    if(!validateEmail(email)){
      _scaffoldKey.currentState.showSnackBar(
          SnackBar(content: Text(getTranslated(context, 'valid_email'))));
    }
    else{
      final modelHud = Provider.of<ModelHud>(context,listen: false);
      modelHud.changeIsLoading(true);
      EzyoServices ezyoServices = EzyoServices();
      Map<String, dynamic>   response = await ezyoServices.forgetPassword(email);
      modelHud.changeIsLoading(false);
      bool  isOk  = response['ok'];
      if(isOk){

        ForgetPasswordModel loginModel = ForgetPasswordModel.fromJson(response);

    ShowPostAlertDialog(context,loginModel.data.msg,true);

      }else{
        ErrorModel errorModel = ErrorModel.fromJson(response);
        ShowPostAlertDialog(context,errorModel.data.msg,false);
      }
    }
  }
  Future<void> ShowPostAlertDialog(BuildContext context ,String title,bool isSuccess) async{
    var alert;
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
