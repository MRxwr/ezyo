import 'package:ezyo/Config/Colors.dart';
import 'package:ezyo/Models/error_model.dart';
import 'package:ezyo/Models/login_model.dart';
import 'package:ezyo/Src/Home/home-screen.dart';
import 'package:ezyo/Src/Home/home.dart';
import 'package:ezyo/Src/Login/loginScreen.dart';
import 'package:ezyo/Utils/helper.dart';
import 'package:ezyo/Widgets/customButton.dart';
import 'package:ezyo/Widgets/customTextField.dart';
import 'package:ezyo/apis/ezyo_services.dart';
import 'package:ezyo/localization/localization_methods.dart';
import 'package:ezyo/providers/model_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  static String id = 'RegisterScreen';
  String email ="";
  String name ="";
  String tokenId ="";
  String loginType = "0";
   SignUpScreen({Key key,@required this.email,@required this.name,@required this.tokenId,@required this.loginType}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
    _nameController.text = widget.name;
    _emailController.text = widget.email;

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
                height: Helper.setHeight(context, height: 0.6),
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
                        getTranslated(context, 'sign_up'),
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

                      textInputAction: TextInputAction.next,
                      maxLines: 1,
                      minLines: 1,
                      controller: this._nameController,
                      decoration: new InputDecoration(
                        hintText: getTranslated(context, 'name'),
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
                        height: 10,
                      ),
                      SizedBox(
                        height: 40.h,
                        child: TextField(
                          textAlign: TextAlign.start,
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.emailAddress ,

                          textInputAction: TextInputAction.next,
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
                        height: 10,
                      ),
                  SizedBox(
                    height: 40.h,
                    child: TextField(
                      obscureText: true,
                      textAlign: TextAlign.start,
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.visiblePassword ,

                      textInputAction: TextInputAction.next,
                      maxLines: 1,
                      minLines: 1,
                      controller: this._passwordController,
                      decoration: new InputDecoration(
                        hintText: getTranslated(context, 'password'),
                        hintStyle: TextStyle(
                            color: Color(0xFF747474),
                            fontSize: screenUtil.setSp(12),
                            fontWeight: FontWeight.normal
                        ),

                        labelStyle: new TextStyle(color: const Color(0xFF424242)),
                        enabledBorder:      OutlineInputBorder(

                            borderSide: BorderSide(
                                color: Color(0x22707070)
                                ,width: 1.w
                            )
                        ),
                        focusedBorder: OutlineInputBorder(

                            borderSide: BorderSide(
                                color: Color(0x22707070)
                                ,width: 1.w
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
                        height: 10,
                      ),
                  SizedBox(
                    height: 40.h,
                    child: TextField(
                      obscureText: true,
                      textAlign: TextAlign.start,
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.visiblePassword ,

                      textInputAction: TextInputAction.done,
                      maxLines: 1,
                      minLines: 1,
                      controller: this._confirmpasswordController,
                      decoration: new InputDecoration(
                        hintText: getTranslated(context, 'confirm_password'),
                        hintStyle: TextStyle(
                            color: Color(0xFF747474),
                            fontSize: screenUtil.setSp(12),
                            fontWeight: FontWeight.normal
                        ),

                        labelStyle: new TextStyle(color: const Color(0xFF424242)),
                        enabledBorder:      OutlineInputBorder(

                            borderSide: BorderSide(
                                color: Color(0x22707070)
                                ,width: 1.w
                            )
                        ),
                        focusedBorder: OutlineInputBorder(

                            borderSide: BorderSide(
                                color: Color(0x22707070)
                                ,width: 1.w
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
                            child: Text(getTranslated(context, 'sign_up'),
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
    String password  = _passwordController.text;
    String userName = _nameController.text;
    String confirmPassword  = _confirmpasswordController.text;
    if(!validateEmail(email)){
      _scaffoldKey.currentState.showSnackBar(
          SnackBar(content: Text(getTranslated(context, 'valid_email'))));
    }else if(!validateName(password)){
      _scaffoldKey.currentState.showSnackBar(
          SnackBar(content: Text(getTranslated(context, 'valid_password'))));
    }else if(!validateName(userName)){
      _scaffoldKey.currentState.showSnackBar(
          SnackBar(content: Text(getTranslated(context, 'enter_user_name'))));
    }
    else if(!validateName(confirmPassword)){
      _scaffoldKey.currentState.showSnackBar(
          SnackBar(content: Text(getTranslated(context, 'valid_password'))));
    }else if(confirmPassword !=password){
      _scaffoldKey.currentState.showSnackBar(
          SnackBar(content: Text(getTranslated(context, 'password_not_equal'))));
    }else{
      final modelHud = Provider.of<ModelHud>(context,listen: false);
      modelHud.changeIsLoading(true);
      EzyoServices ezyoServices = EzyoServices();
      Map<String, dynamic>   response = await ezyoServices.register(userName, email, password, widget.loginType,widget.tokenId);
      modelHud.changeIsLoading(false);
      bool  isOk  = response['ok'];
      if(isOk){

        LoginModel loginModel = LoginModel.fromJson(response);
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setString("id", loginModel.data.id);
        sharedPreferences.setString('name', _nameController.text);
        sharedPreferences.setString('email', _emailController.text);
        sharedPreferences.setString('password', _passwordController.text);
        sharedPreferences.setBool('isUser', true);
        sharedPreferences.setBool("isLoggedIn", true);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );

      }else{
        ErrorModel errorModel = ErrorModel.fromJson(response);
        _scaffoldKey.currentState.showSnackBar(
            SnackBar(content: Text(errorModel.data.msg)));
      }
    }
  }
}
