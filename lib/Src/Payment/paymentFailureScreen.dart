import 'package:ezyo/Config/Colors.dart';
import 'package:ezyo/Config/delivery-Statuses.dart';
import 'package:ezyo/Src/Cart/cart-screen.dart';
import 'package:ezyo/Src/Home/home-screen.dart';
import 'package:ezyo/Src/Home/home.dart';
import 'package:ezyo/Widgets/customAppBar.dart';
import 'package:ezyo/Widgets/customButton.dart';
import 'package:ezyo/Widgets/customDivider.dart';
import 'package:ezyo/localization/localization_methods.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentFailureScreen extends StatefulWidget {
  const PaymentFailureScreen({Key key}) : super(key: key);

  @override
  _PaymentFailureScreenState createState() => _PaymentFailureScreenState();
}

class _PaymentFailureScreenState extends State<PaymentFailureScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: WillPopScope(
        onWillPop: () async{
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => Home()));
          return false;
      },
        child: Scaffold(
          appBar: customAppBar(
              context: context, appBarTitle: getTranslated(context, 'fail'), isLeading: false),
          body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 80,
                    ),
                    Center(
                      child: Image.asset(
                        "assets/images/failure.png",
                        height: 120,
                        width: 120,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    Text(
                      getTranslated(context, 'decline'),
                      style: GoogleFonts.roboto(fontSize: 15),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 100, right: 100),
                      child: CustomButton(
                        isColored: true,
                        child: Center(
                          child: Text(
                            getTranslated(context, 'try_again'),
                            style: GoogleFonts.roboto(
                                fontSize: 15, color: Colors.white),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CartScreen()));
                        },
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: CustomButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Home()));
                    },
                    isColored: true,
                    child: Center(
                        child: Text(
                      getTranslated(context, 'home'),
                      style: GoogleFonts.roboto(fontSize: 12, color: Colors.white),
                    )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
