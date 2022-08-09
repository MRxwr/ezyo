import 'package:ezyo/Models/cart_model.dart';
import 'package:ezyo/Models/checkout_model.dart';
import 'package:ezyo/Src/Payment/paymentFailureScreen.dart';
import 'package:ezyo/Src/Payment/paymentSuccessScreen.dart';
import 'package:ezyo/Widgets/customAppBar.dart';
import 'package:ezyo/localization/localization_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:ezyo/Models/address_model.dart' as Model;
class PaymentScreen extends StatefulWidget {
  String url;
  String discount;
  Model.Address address;
  String instructions;
  String vocherId;
  List<CartModel> cartModelList;
  String orderId;
  int paymentMethod;
  CheckoutModel checkoutModel;
  String service;
  String selectedTime;
  String selectedDate;
   PaymentScreen({Key key,this.discount,this.instructions,this.address,this.vocherId,this.cartModelList,@required this.url,this.orderId,this.paymentMethod,this.checkoutModel,this.service,this.selectedTime,this.selectedDate}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  InAppWebViewController webView;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: customAppBar(
            context: context, appBarTitle: getTranslated(context, 'payment'), isLeading: true),
        body: Container(
          child:     Stack(
            children: <Widget>[
              InAppWebView(


                initialUrlRequest:
                URLRequest(url: Uri.parse(widget.url)),


                initialOptions: InAppWebViewGroupOptions(
                    crossPlatform: InAppWebViewOptions(
                      mediaPlaybackRequiresUserGesture: false,
                      preferredContentMode: UserPreferredContentMode.MOBILE,
                    ),
                    android: AndroidInAppWebViewOptions(
                      useHybridComposition: true,
                    ),
                    ios: IOSInAppWebViewOptions(
                      allowsInlineMediaPlayback: true,
                    )),
                onWebViewCreated: (InAppWebViewController controller) {
                  webView = controller;

                },


                onLoadStart: (InAppWebViewController controller, Uri url) {
                  print("initial Request ---> ${url}");

                },
                onLoadStop: (InAppWebViewController controller, Uri url) async {
                  String mUrl = url.toString();
                  print(url);
                  if(mUrl.contains('success')){
Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PaymentSuccessScreen(discount: widget.discount,instructions: widget.instructions,
                                address: widget.address,vocherId: widget.vocherId,cartModelList: widget.cartModelList,paymentMethod: widget.paymentMethod
                              ,checkoutModel: widget.checkoutModel,orderId: widget.orderId,service: widget.service,selectedTime:widget.selectedTime,selectedDate:widget.selectedDate)));
                    // ShowPostAlertDialog(context,getTranslated(context, 'payment_success'),false);

                  }else if(mUrl.contains('fail')){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PaymentFailureScreen()));
                    // ShowPostAlertDialog(context,getTranslated(context, 'payment_fail'),false);

                  }




                },
              ),

            ],
          ) ,
        ),
      ),
    );
  }
}
