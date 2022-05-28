import 'package:ezyo/Config/Colors.dart';
import 'package:ezyo/Src/Cart/cart-screen.dart';
import 'package:ezyo/Src/Home/home-screen.dart';
import 'package:ezyo/Src/Settings/settingsScreen.dart';
import 'package:ezyo/Src/TrackOrder/trackOrderScreen.dart';
import 'package:ezyo/Widgets/customNavigationItem.dart';
import 'package:ezyo/providers/cart_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  static String id = 'HomeScreen';
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;

  void onTabTabbed(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  final List<Widget> _children = [
    HomeScreen(),
    CartScreen(),
    TrackOrderScreen(),
    SettingsScreen()
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil screenUtil = ScreenUtil();
    return Scaffold(
      bottomNavigationBar:
      Consumer<CartNotifier>(

        builder: (context, cart, child){
          return CupertinoTabBar(
            currentIndex: currentIndex,
            onTap: onTabTabbed,
            activeColor: primaryColor,
            items: [
              navigationitem(
                  assetActive: "assets/icons/home.png",
                  assetinActive: "assets/icons/home.png",height: 19.h,width:21.w ,isCart: false,context: context,notificationCount: 0),

              navigationitem(
                  assetActive: "assets/icons/cart.png",
                  assetinActive: "assets/icons/cart.png",height: 17.h,width:20.w,isCart: true,context: context,notificationCount: cart.cartModelList.length),
              navigationitem(
                  assetActive: "assets/icons/truck.png",
                  assetinActive: "assets/icons/truck.png",height: 17.h,width:29.w,isCart: false,context: context,notificationCount: 0),
              navigationitem(
                  assetActive: "assets/icons/settings.png",
                  assetinActive: "assets/icons/settings.png",height: 19.w,width:19.w,isCart: false,context: context,notificationCount: 0)
            ],
          );
        })
      ,
      body: _children[currentIndex],
    );
  }
}
