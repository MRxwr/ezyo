

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:ezyo/Models/add_address_model.dart';
import 'package:ezyo/Models/guest_model.dart';
import 'package:ezyo/Models/home_model.dart';
import 'package:ezyo/Models/language_model.dart';
import 'package:ezyo/Models/login_social_model.dart';
import 'package:ezyo/Models/order_details_model.dart';
import 'package:ezyo/Models/orders_model.dart';
import 'package:ezyo/Models/payment_failed_model.dart';
import 'package:ezyo/Models/payment_model.dart';
import 'package:ezyo/Models/payment_success_model.dart';
import 'package:ezyo/Models/profile_model.dart';
import 'package:ezyo/Models/settings_model.dart';
import 'package:ezyo/Models/success_payment_model.dart';
import 'package:ezyo/Models/vendor_model.dart';
import 'package:ezyo/localization/localization_methods.dart';
import 'package:ezyo/utilities/shared_prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EzyoServices{
  static String TAG_BASE_URL= "https://createkwservers.com/ezyo/request/";
  Future<dynamic> guest() async{
    try {
      var resp;
      var dio = Dio();
      SharedPreferences sharedPreferences = await SharedPreferences
          .getInstance();
      String language = sharedPreferences.getString(LANG_CODE) ?? "en";

      String mToken = sharedPreferences.getString("token") ?? "";
      print('mToken --> ${mToken}');
      Map<String, String> map = Map();

      map['deviceToken'] = mToken;
      // dio.options.headers["ezyocreate"] = "CreateEZYo";
      String body = json.encode(map);
      FormData formData = FormData.fromMap(map);
      print(TAG_BASE_URL + "?action=user&type=guest");

      dio.options.headers['content-Type'] = 'multipart/form-data';
      dio.options.headers['ezyocreate'] = "CreateEZYo";
      var response = await dio.post(
          TAG_BASE_URL + "?action=user&type=guest&lang=${language}",

          data: formData);

      if (response.statusCode == 200) {
        print(response.data);


        resp =
            response.data;
      }

      return resp;
    }on DioError catch (e){
      print(e.error);
    }

  }
  Future<dynamic> forgetPassword(String email) async{
    var resp ;
    var dio = Dio();
    // dio.options.headers["ezyocreate"] = "CreateEZYo";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String language = sharedPreferences.getString(LANG_CODE)??"en";
    Map<String,String> map = Map();
    map['email'] = email;

    dio.options.headers['content-Type'] = 'multipart/form-data';
    dio.options.headers['ezyocreate'] = "CreateEZYo";
    FormData formData = FormData.fromMap(map);
    var response = await dio.post(TAG_BASE_URL + "?action=user&type=forgetPassword&lang=${language}",data: formData);

    if (response.statusCode == 200) {




      resp =
          response.data;
    }

    return resp;

  }

  Future<dynamic> register(String name,String email,String password,String userType,String tokenId) async{
    var resp ;
    var dio = Dio();
    dio.options.headers['content-Type'] = 'multipart/form-data';
    dio.options.headers['ezyocreate'] = "CreateEZYo";
    // dio.options.headers["ezyocreate"] = "CreateEZYo";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String language = sharedPreferences.getString(LANG_CODE)??"en";
    String mToken =sharedPreferences.getString("token")??"";
    Map<String,String> map = Map();
    map['email'] = email;
    map['password'] = password;
    map['confirmPassword'] = password;
    map['name'] = name;
    map['userType'] = userType;
    map['token'] = tokenId;

    map['deviceToken'] = mToken;
    FormData formData = FormData.fromMap(map);
    print(TAG_BASE_URL + "?action=user&type=register&email=${email}&password=${password}&confirmPassword=${password}&name=${name}&userType=${userType}&token=${tokenId}&lang=${language}&deviceToken=${mToken}");
    String body = json.encode(map);

    var response = await dio.post(TAG_BASE_URL + "?action=user&type=register&lang=${language}",data: formData);

    if (response.statusCode == 200) {
      print(response.data);




      resp =
          response.data;
    }

    return resp;

  }
  Future<dynamic> login(String email,String password) async{
    var resp ;
    var dio = Dio();
    dio.options.headers['content-Type'] = 'multipart/form-data';
    dio.options.headers['ezyocreate'] = "CreateEZYo";
    // dio.options.headers["ezyocreate"] = "CreateEZYo";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String language = sharedPreferences.getString(LANG_CODE)??"en";
    String mToken =sharedPreferences.getString("token")??"";
    print('mToken --> ${mToken}');
    Map<String,String> map = Map();
    map['email'] = email;
    map['password'] = password;

    map['deviceToken'] = mToken;
    FormData formData = FormData.fromMap(map);
    String body = json.encode(map);
    var response = await dio.post(TAG_BASE_URL + "?action=user&type=login&lang=${language}",data: formData);

    if (response.statusCode == 200) {




      resp =
          response.data;
      print(resp);
    }

    return resp;

  }
  Future<dynamic> updateProfile(String id,String name) async{
    var resp ;
    var dio = Dio();
    // dio.options.headers["ezyocreate"] = "CreateEZYo";

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String language = sharedPreferences.getString(LANG_CODE)??"en";

    var response = await dio.get(TAG_BASE_URL + "?action=settings&type=profile&customerId=${id}&update=1&name=${name}&lang=${language}");

    if (response.statusCode == 200) {




      resp =
          response.data;
      print(resp);
    }

    return resp;

  }
  Future<dynamic> voucher(String vendorId,String voucher) async{
    var resp ;
    var dio = Dio();
    // dio.options.headers["ezyocreate"] = "CreateEZYo";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String language = sharedPreferences.getString(LANG_CODE)??"en";


    var response = await dio.get(TAG_BASE_URL + "?action=voucher&code=${voucher}&vendorId=${vendorId}&lang=${language}");

    if (response.statusCode == 200) {




      resp =
          response.data;
      print(resp);
    }

    return resp;

  }

  Future<dynamic> updatePassword(String oldPassword,String newPassword,String userId) async{
    var resp ;
    var dio = Dio();
    // dio.options.headers["ezyocreate"] = "CreateEZYo";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String language = sharedPreferences.getString(LANG_CODE)??"en";


    var response = await dio.get(TAG_BASE_URL + "?action=settings&type=password&customerId=${userId}&update=1&oldPassword=${oldPassword}&newPassword=${newPassword}&lang=${language}");

    if (response.statusCode == 200) {




      resp =
          response.data;
      print(resp);
    }

    return resp;

  }
  Future<dynamic> getAddresses(String customerId) async{
    var resp ;
    var dio = Dio();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String language = sharedPreferences.getString(LANG_CODE)??"en";



    // dio.options.headers["ezyocreate"] = "CreateEZYo";


    var response = await dio.get(TAG_BASE_URL + "?action=address&type=list&customerId=${customerId}&lang=${language}");

    if (response.statusCode == 200) {




      resp =
          response.data;
      print(resp);
    }

    return resp;

  }
  Future<dynamic> checkOut(String url) async{
    var resp ;
    var dio = Dio();
    // dio.options.headers["ezyocreate"] = "CreateEZYo";


    var response = await dio.get(url);

    if (response.statusCode == 200) {




      resp =
          response.data;
      print(resp);
    }

    return resp;

  }
  Future<HomeModel> home(String lang,String tag,String filter) async{
    HomeModel homeModel;
    var dio = Dio();
    // dio.options.headers["ezyocreate"] = "CreateEZYo";

    print(TAG_BASE_URL + "?action=filter&filter=${filter}&tag=${tag}&lang=${lang}");
    var response = await dio.get(TAG_BASE_URL + "?action=filter&filter=${filter}&tag=${tag}&lang=${lang}");

    if (response.statusCode == 200) {




      homeModel =
          HomeModel.fromJson(Map<String, dynamic>.from(response.data));
    }

    return homeModel;

  }
  Future<dynamic> loginSocial(String token) async{
    var resp ;
    var dio = Dio();
    dio.options.headers['content-Type'] = 'multipart/form-data';
    dio.options.headers['ezyocreate'] = "CreateEZYo";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String language = sharedPreferences.getString(LANG_CODE)??"en";
    String mToken =sharedPreferences.getString("token")??"";
    Map<String,String>map = Map();
    map['token']= token;
    map['deviceToken']= mToken;

    FormData formData = FormData.fromMap(map);
    // dio.options.headers["ezyocreate"] = "CreateEZYo";

    print(TAG_BASE_URL + "?action=user&type=social&token=${token}&deviceToken=${mToken}");
    var response = await dio.post(TAG_BASE_URL + "?action=user&type=social&lang=${language}",data: formData);

    if (response.statusCode == 200) {




      resp= response.data;
    }

    return resp;

  }
  Future<ProfileModel> profile(String id) async{
    ProfileModel profileModel;
    var dio = Dio();
    // dio.options.headers["ezyocreate"] = "CreateEZYo";

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String language = sharedPreferences.getString(LANG_CODE)??"en";

    var response = await dio.get(TAG_BASE_URL + "?action=settings&type=profile&customerId=${id}&lang=${language}");

    if (response.statusCode == 200) {




      profileModel =
          ProfileModel.fromJson(Map<String, dynamic>.from(response.data));
    }

    return profileModel;

  }
  Future<dynamic> successPayment(String orderId) async{
    PaymentSuccessModel successPaymentModel;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String language = sharedPreferences.getString(LANG_CODE)??"en";

    var dio = Dio();
    // dio.options.headers["ezyocreate"] = "CreateEZYo";

    print(TAG_BASE_URL + "?action=success&orderId=${orderId}");

    var response = await dio.get(TAG_BASE_URL + "?action=success&orderId=${orderId}&lang=${language}");

    if (response.statusCode == 200) {
      print(response.data);





    }

    return response;

  }
  Future<PaymentFailedModel> failPayment(String orderId) async{
    PaymentFailedModel paymentFailedModel;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String language = sharedPreferences.getString(LANG_CODE)??"en";

    var dio = Dio();
    // dio.options.headers["ezyocreate"] = "CreateEZYo";


    var response = await dio.get(TAG_BASE_URL + "??action=failure&PaymentID=${orderId}&lang=${language}");

    if (response.statusCode == 200) {




      paymentFailedModel =
          PaymentFailedModel.fromJson(Map<String, dynamic>.from(response.data));
    }

    return paymentFailedModel;

  }
  Future<OrdersModel> orders(String id) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String language = sharedPreferences.getString(LANG_CODE)??"en";

    OrdersModel homeModel;
    var dio = Dio();
    // dio.options.headers["ezyocreate"] = "CreateEZYo";


    var response = await dio.get(TAG_BASE_URL + "?action=order&type=list&customerId=${id}&lang=${language}");

    if (response.statusCode == 200) {




      homeModel =
          OrdersModel.fromJson(Map<String, dynamic>.from(response.data));
    }

    return homeModel;

  }
  Future<OrderDetailsModel> orderDetails(String id) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String language = sharedPreferences.getString(LANG_CODE)??"en";

    OrderDetailsModel homeModel;
    var dio = Dio();
    // dio.options.headers["ezyocreate"] = "CreateEZYo";
    print(TAG_BASE_URL + "?action=order&type=details&orderId=${id}&lang=${language}");


    var response = await dio.get(TAG_BASE_URL + "?action=order&type=details&orderId=${id}&lang=${language}");

    if (response.statusCode == 200) {
      print(response.data);




      homeModel =
          OrderDetailsModel.fromJson(Map<String, dynamic>.from(response.data));
    }

    return homeModel;

  }
  Future<dynamic> search(String searchText) async{
    var resp ;
    var dio = Dio();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String language = sharedPreferences.getString(LANG_CODE)??"en";

    // dio.options.headers["ezyocreate"] = "CreateEZYo";
    var response = await dio.get(TAG_BASE_URL + "?action=search&key=${searchText}&lang=${language}");




    if (response.statusCode == 200) {




      resp =
          response.data;
      print(resp);
    }

    return resp;

  }
  Future<dynamic> payment(String url) async{
    var resp ;
    var dio = Dio();
    // dio.options.headers["ezyocreate"] = "CreateEZYo";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String language = sharedPreferences.getString(LANG_CODE)??"en";


    var response = await dio.get(url);

    if (response.statusCode == 200) {




      resp =
          response.data;
      print(resp);
    }

    return resp;

  }
  Future<AddAddressModel> addAddress(String id,String name,String country,
      String area,String block,String street,
      String house,String floor,String flat,String mobile,String avenue) async{
    AddAddressModel addressModel;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String language = sharedPreferences.getString(LANG_CODE)??"en";

    var dio = Dio();
    // dio.options.headers["ezyocreate"] = "CreateEZYo";


    var response = await dio.get(TAG_BASE_URL + "?action=address&type=add&customerId=${id}&name=${name}&country=${country}&area=${area}&block=${block}&street=${street}&house=${house}&floor=${floor}&flat=${flat}&mobile=${mobile}&avenue=${avenue}");

    if (response.statusCode == 200) {




      addressModel =
          AddAddressModel.fromJson(Map<String, dynamic>.from(response.data));
    }

    return addressModel;

  }
  Future<AddAddressModel> EditAddress(String id,String name,String country,
      String area,String block,String street,
      String house,String floor,String flat,String mobile,String avenue) async{
    AddAddressModel addressModel;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String language = sharedPreferences.getString(LANG_CODE)??"en";

    var dio = Dio();
    // dio.options.headers["ezyocreate"] = "CreateEZYo";


    var response = await dio.get(TAG_BASE_URL + "?action=address&type=edit&addressId=${id}&name=${name}&country=${country}&area=${area}&block=${block}&street=${street}&house=${house}&floor=${floor}&flat=${flat}&mobile=${mobile}&avenue=${avenue}");

    if (response.statusCode == 200) {




      addressModel =
          AddAddressModel.fromJson(Map<String, dynamic>.from(response.data));
    }

    return addressModel;

  }
  Future<SettingsModel> settings(String id) async{
    SettingsModel homeModel;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String language = sharedPreferences.getString(LANG_CODE)??"en";

    var dio = Dio();
    // dio.options.headers["ezyocreate"] = "CreateEZYo";


    var response = await dio.get(TAG_BASE_URL + "?action=settings&type=list&customerId=${id}&lang=${language}");

    if (response.statusCode == 200) {




      homeModel =
          SettingsModel.fromJson(Map<String, dynamic>.from(response.data));
    }

    return homeModel;

  }
  Future<LanguageModel> language(String lang) async{
    LanguageModel languageModel;

    // dio.options.headers["ezyocreate"] = "CreateEZYo";

      Dio dio = new Dio(BaseOptions(contentType: Headers.jsonContentType,responseType: ResponseType.json,validateStatus: (_)=>true,));





      print(TAG_BASE_URL + "?action=localization&lang=${lang}");
    var response = await dio.get(TAG_BASE_URL + "?action=localization&lang=${lang}");

    if (response.statusCode == 200) {
      print(response.data);




      languageModel =
          LanguageModel.fromJson(Map<String, dynamic>.from(response.data));
      SharedPref sharedPref = SharedPref();
      await sharedPref.save("languageModel", languageModel);

    }

    return languageModel;

  }
  Future<VendorModel> vendor(String id) async{
    VendorModel vendorModel;
    var dio = Dio();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String language = sharedPreferences.getString(LANG_CODE)??"en";

    // dio.options.headers["ezyocreate"] = "CreateEZYo";


    var response = await dio.get(TAG_BASE_URL + "?action=vendor&id=${id}&lang=${language}");

    print(TAG_BASE_URL + "?action=vendor&id=${id}&lang=${language}");

    if (response.statusCode == 200) {
      print(response.data);




      vendorModel =
          VendorModel.fromJson(Map<String, dynamic>.from(response.data));
    }

    return vendorModel;

  }
}