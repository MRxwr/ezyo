import 'package:ezyo/Config/Colors.dart';
import 'package:ezyo/Models/cart_model.dart';
import 'package:ezyo/Models/checkout_model.dart';
import 'package:ezyo/Models/error_model.dart';
import 'package:ezyo/Models/payment_model.dart';
import 'package:ezyo/Src/Cart/payment_screen.dart';
import 'package:ezyo/Src/Payment/paymentFailureScreen.dart';
import 'package:ezyo/Src/Payment/paymentSuccessScreen.dart';
import 'package:ezyo/Widgets/customAppBar.dart';
import 'package:ezyo/Widgets/customButton.dart';
import 'package:ezyo/apis/ezyo_services.dart';
import 'package:ezyo/localization/localization_methods.dart';
import 'package:ezyo/providers/cart_notifier.dart';
import 'package:ezyo/providers/model_hud.dart';
import 'package:ezyo/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ezyo/Models/address_model.dart' as Model;
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
class CheckoutScreen extends StatefulWidget {
  String discount;
  Model.Address address;
  String instructions;
  String vocherId;
  List<CartModel> cartModelList;
  String selectedTime;
  String selectedDate;
   CheckoutScreen({Key key,this.discount,this.instructions,this.address,this.vocherId,this.cartModelList,this.selectedTime,this.selectedDate}) : super(key: key);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int groupValue = 1;
  bool isWalletExists = false;
  Map<String, dynamic>   response = null;
  CheckoutModel  checkoutModel = null;
  ScreenUtil screenUtil = ScreenUtil();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    checkOut();
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
          appBar: customAppBar(
              context: context, isLeading: true, appBarTitle: getTranslated(context, 'checkout')),
          body: Container(
            child: Container(
              child: response == null?
              Container(
                child: CircularProgressIndicator(


                ),
                alignment: AlignmentDirectional.center,
              ):
                  checkoutModel == null?
              Container():


              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10, left: 20),
                          child: Text(
                            getTranslated(context, 'select_payment'),
                            style: GoogleFonts.roboto(fontSize: 20),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Radio(
                              toggleable: true,
                              value: 1,
                              groupValue: groupValue,
                              activeColor: primaryColor,
                              onChanged: (int val) {
                                setState(() {
                                  groupValue = val;
                                });
                              },
                            ),
                            Container(
                                child: Text("K-net",
                                    style: GoogleFonts.roboto(
                                        color: blackColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal))),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              toggleable: true,
                              value: 2,
                              groupValue: groupValue,
                              activeColor: primaryColor,
                              onChanged: (int val) {
                                setState(() {
                                  groupValue = val;
                                });
                              },
                            ),
                            Container(
                                child: Text("Visa/Master Card",
                                    style: GoogleFonts.roboto(
                                        color: blackColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal))),
                          ],
                        ),
                        Container(
                          child: !isWalletExists?Row(
                            children: [
                              Radio(
                                toggleable: true,
                                value: 3,
                                groupValue: groupValue,
                                activeColor: primaryColor,

                              ),
                              Container(
                                child: RichText(
                                  text: TextSpan(
                                      text: "Wallet ",
                                      style: GoogleFonts.roboto(
                                          color: Color(0xFFAAAAAA),
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal),
                                      children: [
                                        TextSpan(
                                          text: ' ${checkoutModel.data.wallet} ${getTranslated(context, 'kwd')}',
                                          style: GoogleFonts.roboto(
                                              color: Color(0xFFAAAAAA),
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal),
                                        )
                                      ]),
                                ),
                              ),
                            ],
                          ):Row(
                            children: [
                              Radio(
                                toggleable: true,
                                value: 3,
                                groupValue: groupValue,
                                activeColor: primaryColor,
                                onChanged: (int val) {
                                  setState(() {
                                    groupValue = val;
                                  });
                                },
                              ),
                              Container(
                                child: RichText(
                                  text: TextSpan(
                                      text: "Wallet ",
                                      style: GoogleFonts.roboto(
                                          color: blackColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal),
                                      children: [
                                        TextSpan(
                                          text: ' ${checkoutModel.data.wallet} ${getTranslated(context, 'kwd')}',
                                          style: GoogleFonts.roboto(
                                              color: primaryColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal),
                                        )
                                      ]),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                getTranslated(context, 'delivery_charge'),
                                style: GoogleFonts.roboto(fontSize: 15),
                              ),
                              Text(
                                "${checkoutModel.data.delivery} ${getTranslated(context, 'kwd')}",
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                getTranslated(context, 'service_charge'),
                                style: GoogleFonts.roboto(fontSize: 15),
                              ),
                              Text(
                                "${checkoutModel.data.service} ${getTranslated(context, 'kwd')}",
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                getTranslated(context, 'voucher'),
                                style: GoogleFonts.roboto(
                                    fontSize: 15),
                              ),
                              Text( "${widget.discount}",
                                  style: GoogleFonts.roboto(fontSize: 17,color: kSecondaryColor))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                getTranslated(context, 'total_amount'),
                                style: GoogleFonts.roboto(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              Text( "${checkoutModel.data.total} ${getTranslated(context, 'kwd')}",
                                  style: GoogleFonts.roboto(fontSize: 17))
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 40,
                        ),
                        CustomButton(
                          onPressed: () {
                            payment();
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => PaymentSuccessScreen()));
                          },
                          isColored: true,
                          child: Center(
                              child: Text(
                            getTranslated(context, 'checkout'),
                            style:
                                GoogleFonts.poppins(fontSize: 12, color: whiteColor),
                          )),
                        ),
                        SizedBox(
                          height: 30,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> checkOut() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String userId = sharedPreferences.getString("id");
    EzyoServices ezyoServices = EzyoServices();
    String url = "https://createkwservers.com/ezyo/request/?action=checkout&customerId=${userId}&voucherId=${widget.vocherId}&";
     for(int i =0;i<widget.cartModelList.length;i++){
       url+="items[${i}][id]=${widget.cartModelList[i].id}&items[${i}][quantity]=${widget.cartModelList[i].quantity}&";
     }
    url = url.substring(0, url.length - 1);
     print(url);


    response = await ezyoServices.checkOut(url);

    bool  isOk  = response['ok'];
    if(isOk){
      checkoutModel  = CheckoutModel.fromJson(response);
      String wallet = checkoutModel.data.wallet;
      double walletValue = double.parse(wallet);
      String totalAmount = checkoutModel.data.total;
      double totalValue = double.parse(totalAmount);
      if(walletValue>= totalValue){
        isWalletExists = true;
      }else{
        isWalletExists = false;
      }
    }else{
      ErrorModel errorModel = ErrorModel();
      ShowPostAlertDialog(context,errorModel.error);

    }

setState(() {

});


  }
  Future<void> payment() async{
    final modelHud = Provider.of<ModelHud>(context,listen: false);
    modelHud.changeIsLoading(true);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String userId = sharedPreferences.getString("id");
    EzyoServices ezyoServices = EzyoServices();
    String url = "https://createkwservers.com/ezyo/request/?action=order&type=submit&customerId=${userId}&addressId=${widget.address.id}&vendorId=${widget.cartModelList[0].vendorId}&voucherId=${widget.vocherId}&orderNote=${widget.instructions}&paymentMethod=${groupValue}&time=${widget.selectedTime}&deliveryDate=${widget.selectedDate}&";
    for(int i =0;i<widget.cartModelList.length;i++){
      url+="items[${i}][id]=${widget.cartModelList[i].id}&items[${i}][quantity]=${widget.cartModelList[i].quantity}&items[${i}][orderNotes]=${widget.cartModelList[i].orderNote}&";
    }
    url = url.substring(0, url.length-1);
    print("url --> ${url}");

    Map<String, dynamic>   response  = await ezyoServices.payment(url);
    modelHud.changeIsLoading(false);
    bool  isOk  = response['ok'];
    PaymentModel paymentModel;
    if(isOk){
      paymentModel  = PaymentModel.fromJson(response);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PaymentScreen(discount: widget.discount,instructions: widget.instructions,
                address: widget.address,vocherId: widget.vocherId,cartModelList: widget.cartModelList,url: paymentModel.data.url,orderId: paymentModel.data.orderId.toString(),paymentMethod: groupValue,checkoutModel: checkoutModel,service: checkoutModel.data.service,selectedTime:widget.selectedTime,selectedDate :widget.selectedDate)));

    }else{
      ErrorModel errorModel = ErrorModel();
      ShowPostAlertDialog(context,errorModel.error);

    }




  }
  Future<void> ShowPostAlertDialog(BuildContext context ,String title) async{

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
            getTranslated(context, 'ok_string'),
            style: TextStyle(color: Color(0xFFFFFFFF), fontSize: screenUtil.setSp(18)),
          ),
          onPressed: ()async {
            await alert.dismiss();


          },
          color:kMainColor,
          radius: BorderRadius.circular(6.w),
        )
      ],
    );
    alert.show();

  }

}
