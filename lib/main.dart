import 'dart:convert';
import 'dart:io';
import 'package:eraser/eraser.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:ezyo/Config/Colors.dart';
import 'package:ezyo/Src/Login/loginScreen.dart';
import 'package:ezyo/Src/SignUp/signUpScreen.dart';
import 'package:ezyo/Src/Splash/splashScreen.dart';
import 'package:ezyo/providers/cart_notifier.dart';
import 'package:ezyo/providers/error_voucher.dart';
import 'package:ezyo/providers/model_hud.dart';
import 'package:ezyo/utilities/constants.dart';
import 'package:ezyo/utilities/service_locator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Src/Home/home.dart';
import 'localization/localization_methods.dart';
import 'localization/set_localization.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
// description
  importance: Importance.high,
);

/// Initialize the [FlutterLocalNotificationsPlugin] package.
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
void main() async{
  setupLocator();


  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );
  if (Platform.isAndroid) {
    AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
  }
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(MyApp());
  Eraser.clearAllAppNotifications();
}



class MyApp extends StatefulWidget {

  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(locale);
  }

  @override
  _MyAppState createState() {

    var f = new NumberFormat("###,###", "en_US");
    print(f.format(245315));

    return _MyAppState();
  }

}

int _messageCount = 0;

/// The API endpoint here accepts a raw FCM payload for demonstration purposes.
String constructFCMPayload(String token) {
  _messageCount++;
  return jsonEncode({
    'token': token,
    'data': {
      'via': 'FlutterFire Cloud Messaging!!!',
      'count': _messageCount.toString(),
    },
    'notification': {
      'title': 'Hello FlutterFire!',
      'body': 'This notification (#$_messageCount) was created via FCM!',
    },
  });
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver{
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      Eraser.clearAllAppNotifications();
    }
  }
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey(debugLabel: "Main Navigator");

  String messageTitle = "Empty";
  String notificationAlert = "alert";
  String _token;


   Locale _local;

  void setLocale(Locale locale) {
    setState(() {
      _local = locale;
    });
  }
  Future <void> getToken() async{
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String mToken =_preferences.getString("token")??"";
    print('token --> ${mToken}');
    if(mToken ==""){
      String toke = "";
    toke = await   FirebaseMessaging.instance.getToken();

      print('token --> ${toke}');
      SharedPreferences _preferences = await SharedPreferences.getInstance();


      String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;
      _preferences.setString("token", toke);




    }
    FlutterNativeSplash.remove();

  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {

        this._local = locale;
        print('LanguageCode = ${_local.languageCode}');
      });
    }).whenComplete((){
      setDefaultLang(_local.languageCode);
    });
    super.didChangeDependencies();
  }
  void setDefaultLang(String code) async{
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.setString(LANG_CODE, code);

  }

  String _messageText = "Waiting for message...";


  Future<void> init() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool isLoggedIn = sharedPreferences.getBool(kIsLogin)??false;


  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage message) {




    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,

                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                icon: 'launch_background',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      String remoteMessgae = message.data.toString();
      dynamic dataObject=  message.data;
      print('dataObject ---> ${dataObject.toString()}');


      // Navigator.pushNamed(context, '/message',
      //     arguments: MessageArguments(message, true));
    });

    getToken().then((value) {

    });


  }



  void setToken(String token) {
    print('FCM Token: $token');
    setState(() {
      _token = token;
    });
  }
  Future<void> sendPushMessage() async {
    if (_token == null) {
      print('Unable to send FCM message, no token exists.');
      return;
    }

    try {
      await http.post(
        Uri.parse('https://api.rnfirebase.io/messaging/send'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: constructFCMPayload(_token),
      );
      print('FCM request for device sent!');
    } catch (e) {
      print(e);
    }
  }



  @override
  Widget build(BuildContext context) {
    MaterialColor colorCustom = MaterialColor(0xFFFF8262, color);
    SystemChrome.setEnabledSystemUIOverlays([]);
    if (_local == null) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {



      return      ScreenUtilInit(


          builder:() =>

              MultiProvider(
                providers: [
                  ChangeNotifierProvider<ModelHud>(create: (context) => ModelHud()),
                  ChangeNotifierProvider<CartNotifier>(create: (context) => CartNotifier()),
                  ChangeNotifierProvider<VoucherError>(create: (context) => VoucherError()),
                ],
                child:

                OverlaySupport(

                  child: MaterialApp(

                    navigatorKey: navigatorKey ,


                    theme: ThemeData(


                        primarySwatch: colorCustom,
                        fontFamily: 'Cairo',
                        accentColor: Color(0xFFFF8262),
                        primaryColor: Color(0xFFFF8262)



                    ) ,
                    builder: (context, child) {
                      return MediaQuery(
                        child: child,
                        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                      );
                    },



                    locale: _local,

                    supportedLocales: [
                      Locale('en', 'US'),
                      Locale('ar', 'KW')
                    ],
                    localizationsDelegates: [
                      SetLocalization.localizationsDelegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    localeResolutionCallback: (deviceLocal, supportedLocales) {
                      for (var local in supportedLocales) {
                        if (local.languageCode == deviceLocal.languageCode &&
                            local.countryCode == deviceLocal.countryCode) {
                          return deviceLocal;
                        }
                      }
                      print(supportedLocales.first.countryCode);
                      return supportedLocales.first;
                    }
                    ,
                    debugShowCheckedModeBanner: false,
                    initialRoute: SplashScreen.id,
                    routes: {
                      SplashScreen.id: (context) => SplashScreen(),

                      LoginScreen.id: (context) => LoginScreen(),
                      SignUpScreen.id: (context) => SignUpScreen(),
                      Home.id: (context) => Home(),

                    },

                  ),
                ),
              )
      );
    }







  }
  Map<int, Color> color =
  {
    50:Color.fromRGBO(255,130,98, .1),
    100:Color.fromRGBO(255,130,98, .2),
    200:Color.fromRGBO(255,130,98, .3),
    300:Color.fromRGBO(255,130,98, .4),
    400:Color.fromRGBO(255,130,98, .5),
    500:Color.fromRGBO(255,130,98, .6),
    600:Color.fromRGBO(255,130,98, .7),
    700:Color.fromRGBO(255,130,98, .8),
    800:Color.fromRGBO(255,130,98, .9),
    900:Color.fromRGBO(255,130,98, 1),
  };

}
