import 'dart:convert';
import 'dart:io';
import 'package:ezyo/Models/HideModel.dart';
import 'package:ezyo/Src/SignUp/ForgetPasswordScreen.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart'as Apple;
import 'package:ezyo/Config/Colors.dart';
import 'package:ezyo/Models/error_model.dart';
import 'package:ezyo/Models/login_model.dart';
import 'package:ezyo/Models/login_social_model.dart';
import 'package:ezyo/Src/Home/home.dart';
import 'package:ezyo/Src/SignUp/signUpScreen.dart';
import 'package:ezyo/Utils/helper.dart';
import 'package:ezyo/Widgets/customButton.dart';
import 'package:ezyo/Widgets/customSocialIcons.dart';
import 'package:ezyo/utilities/shared_prefs.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
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

class LoginScreen extends StatefulWidget {
  static String id = 'LoginScreen';
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _phoneController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  final TextEditingController _confirmpasswordController = new TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Future<HideModel> hide()async{
    EzyoServices ezyoServices = EzyoServices();
    HideModel hideModel = await ezyoServices.hide();
    return hideModel;

  }
  HideModel hideModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hide().then((value) {
      setState(() {
        hideModel = value;
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil screenUtil = ScreenUtil();
    return GestureDetector(
      onTap: (){


        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: ModalProgressHUD(
        inAsyncCall: Provider.of<ModelHud>(context).isLoading,
        child: Scaffold(
          key: _scaffoldKey,
          resizeToAvoidBottomInset: false,
          body: Container(
            child: hideModel == null?
            Container(
              child: CircularProgressIndicator(


              ),
              alignment: AlignmentDirectional.center,
            )
                :
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  "assets/images/bg.png",
                  height: Helper.setHeight(context),
                  width: Helper.setWidth(context),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  height: Helper.setHeight(context, height: 0.8),
                  width: Helper.setWidth(context, width: 0.8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30), color: Colors.white),
                  child: ClipRRect(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Center(
                            child: Text(
                          "WELCOME TO EZYO",
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

                            textInputAction: TextInputAction.done,
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
                          height: 20,
                        ),
                        CustomButton(
                          isColored: true,
                          onPressed: () {
                            validate(context);
                          },
                          child: Center(
                              child: Text(getTranslated(context, 'sign_in'),
                                  style: GoogleFonts.roboto(
                                      fontSize: 15, color: textColorWhite))),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomButton(
                          isColored: false,
                          onPressed: () {
                            guest();
                          },
                          child: Center(
                              child: Text(getTranslated(context, 'guest'),
                                  style: GoogleFonts.roboto(
                                      fontSize: 15, color: primaryColor))),
                        ),
                        Container(
                          child:hideModel.data.hide=="1"?
                          Container():Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: Text(
                                  getTranslated(context, 'social'),
                                  style:
                                      GoogleFonts.roboto(fontSize: 12, color: blackColor),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  CustomSocialIcons(
                                    assetName: "assets/icons/google.png",
                                    bgColor: googleColor,
                                    onPressed: () {
                                      googleLogin(context);
                                    },
                                  ),
                                  CustomSocialIcons(
                                    assetName: "assets/icons/fb.png",
                                    bgColor: fbColor,
                                    onPressed: () {
                                      facebookLogin(context);
                                    },
                                  ),


                                ],
                              ),
                              Container(
                                child: Platform.isIOS?
                                Column(
                                  children: [
                                    SizedBox(height: 20,),
                                    Container(         padding:  EdgeInsets.symmetric(horizontal: 20.h),
                                        child: Apple.AppleSignInButton(
                                          onPressed: logIn,
                                          style: Apple.ButtonStyle.black,
                                          type: Apple.ButtonType.signIn,
                                        )),
                                  ],
                                ):Container(),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              (MaterialPageRoute(
                                  builder: (context) => SignUpScreen(email: "",name: "",tokenId: "",loginType: "0",)))),
                          child: Center(
                            child: Text(
                             getTranslated(context, 'sign_up'),
                              style: GoogleFonts.roboto(
                                  fontSize: 15, color: primaryColor),
                            ),
                          ),
                        ), SizedBox(
                          height: 20,
                        ),GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              (MaterialPageRoute(
                                  builder: (context) => ForgetPasswordScreen()))),
                          child: Center(
                            child: Text(
                              getTranslated(context, 'forget_password'),
                              style: GoogleFonts.roboto(
                                  fontSize: 15, color: primaryColor),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
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

    if(!validateEmail(email)){
      _scaffoldKey.currentState.showSnackBar(
          SnackBar(content: Text(getTranslated(context, 'valid_email'))));
    }else if(!validateName(password)){
      _scaffoldKey.currentState.showSnackBar(
          SnackBar(content: Text(getTranslated(context, 'valid_password'))));
    }else{
      final modelHud = Provider.of<ModelHud>(context,listen: false);
      modelHud.changeIsLoading(true);
      EzyoServices ezyoServices = EzyoServices();
      Map<String, dynamic>   response = await ezyoServices.login( email, password);
      modelHud.changeIsLoading(false);
      bool  isOk  = response['ok'];
      if(isOk){
        LoginModel loginModel = LoginModel.fromJson(response);
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setString("id", loginModel.data.id);
        sharedPreferences.setBool("isLoggedIn", true);

        sharedPreferences.setString('email', _emailController.text);
        sharedPreferences.setString('password', _passwordController.text);
        sharedPreferences.setBool('isUser', true);
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
  void facebookLogin(BuildContext context) async {

    final result =  await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
      final userData = await FacebookAuth.instance.getUserData();
      if (userData.isNotEmpty) {
        String name = userData['name'];
        String email = userData['email'];
        String socialId = userData['id'];
        final modelHud = Provider.of<ModelHud>(context,listen: false);
        modelHud.changeIsLoading(true);
        modelHud.changeIsLoading(true);
        EzyoServices ezyoServices = EzyoServices();
        Map<String, dynamic>   response = await ezyoServices.loginSocial(socialId);
        modelHud.changeIsLoading(false);
        bool  isOk  = response['ok'];
        if(isOk){
          LoginSocialModel loginModel = LoginSocialModel.fromJson(response);
          SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          sharedPreferences.setString("id", loginModel.data.id);
          sharedPreferences.setBool("isLoggedIn", true);

          sharedPreferences.setString('email', email);
          sharedPreferences.setString('password', '');
          sharedPreferences.setBool('isUser', true);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Home()),
          );
        }else{
          ErrorModel errorModel = ErrorModel.fromJson(response);
          _scaffoldKey.currentState.showSnackBar(
              SnackBar(content: Text(errorModel.data.msg)));
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SignUpScreen(email: email,name: name,tokenId: socialId,loginType: "1",)),);
        }


      }
    }

  }



  void guest() async{
    final modelHud = Provider.of<ModelHud>(context,listen: false);
    modelHud.changeIsLoading(true);
    EzyoServices ezyoServices = EzyoServices();
    Map<String, dynamic>   response = await ezyoServices.guest();
    modelHud.changeIsLoading(false);
    bool  isOk  = response['ok'];
    if(isOk){
      LoginModel loginModel = LoginModel.fromJson(response);
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString("id", loginModel.data.id);
      sharedPreferences.setBool("isLoggedIn", true);
      sharedPreferences.setBool('isUser', false);
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
  void googleLogin(BuildContext context) async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      // Optional clientId
      // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
      scopes: <String>[
        'email'

      ],
    );
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
    String email = _googleSignIn.currentUser.email;
    String name = _googleSignIn.currentUser.displayName;

    String googleId = _googleSignIn.currentUser.id;
    final modelHud = Provider.of<ModelHud>(context, listen: false);
    modelHud.changeIsLoading(true);
    EzyoServices ezyoServices = EzyoServices();
    Map<String, dynamic> response = await ezyoServices.loginSocial(googleId);
    modelHud.changeIsLoading(false);
    bool isOk = response['ok'];
    if (isOk) {
      LoginSocialModel loginModel = LoginSocialModel.fromJson(response);
      SharedPreferences sharedPreferences = await SharedPreferences
          .getInstance();
      sharedPreferences.setString("id", loginModel.data.id);
      sharedPreferences.setBool("isLoggedIn", true);

      sharedPreferences.setString('email', email);
      sharedPreferences.setString('password', '');
      sharedPreferences.setBool('isUser', true);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    } else {
      ErrorModel errorModel = ErrorModel.fromJson(response);
      _scaffoldKey.currentState.showSnackBar(
          SnackBar(content: Text(errorModel.data.msg)));
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>
            SignUpScreen(
              email: email, name: name, tokenId: googleId, loginType: "1",)),);
    }



  }

  void logIn() async {
    final Apple.AuthorizationResult result = await Apple.TheAppleSignIn.performRequests([
      Apple.AppleIdRequest(requestedScopes: [Apple.Scope.email, Apple.Scope.fullName])
    ]);

    switch (result.status) {
      case Apple. AuthorizationStatus.authorized:
        String name =   result.credential.fullName.givenName;
        String email = result.credential.email;
        String id = result.credential.user;
        final modelHud = Provider.of<ModelHud>(context, listen: false);
        modelHud.changeIsLoading(true);
        EzyoServices ezyoServices = EzyoServices();
        Map<String, dynamic> response = await ezyoServices.loginSocial(id);
        modelHud.changeIsLoading(false);
        bool isOk = response['ok'];
        if (isOk) {
          LoginSocialModel loginModel = LoginSocialModel.fromJson(response);
          SharedPreferences sharedPreferences = await SharedPreferences
              .getInstance();
          sharedPreferences.setString("id", loginModel.data.id);
          sharedPreferences.setBool("isLoggedIn", true);

          sharedPreferences.setString('email', email);
          sharedPreferences.setString('password', '');
          sharedPreferences.setBool('isUser', true);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Home()),
          );
        } else {
          ErrorModel errorModel = ErrorModel.fromJson(response);
          _scaffoldKey.currentState.showSnackBar(
              SnackBar(content: Text(errorModel.data.msg)));
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>
                SignUpScreen(
                  email: email, name: name, tokenId: id, loginType: "1",)),);
        }


        break;

      case Apple.AuthorizationStatus.error:
        print("Sign in failed: ${result.error.localizedDescription}");

        break;

      case Apple.AuthorizationStatus.cancelled:
        print('User cancelled');
        break;
    }
  }

}
