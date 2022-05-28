import 'dart:math';

import 'package:ezyo/Models/cart_model.dart';
import 'package:ezyo/Models/error_model.dart';
import 'package:ezyo/Models/vendor_model.dart';
import 'package:ezyo/Models/voucher_model.dart';
import 'package:ezyo/Src/Address/address-screen.dart';
import 'package:ezyo/Src/Address/addresses_screen.dart';
import 'package:ezyo/Src/Home/home.dart';
import 'package:ezyo/Utils/helper.dart';
import 'package:ezyo/Widgets/cartItemWidget.dart';
import 'package:ezyo/Widgets/customAppBar.dart';
import 'package:ezyo/Widgets/customButton.dart';
import 'package:ezyo/Widgets/customDivider.dart';
import 'package:ezyo/apis/ezyo_services.dart';

import 'package:ezyo/localization/localization_methods.dart';
import 'package:ezyo/providers/cart_notifier.dart';
import 'package:ezyo/providers/error_voucher.dart';
import 'package:ezyo/providers/model_hud.dart';
import 'package:ezyo/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ezyo/Config/Colors.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
extension Ex on double {
  double toPrecision(int n) => double.parse(toStringAsFixed(n));
}
class CartScreen extends StatefulWidget {
  const CartScreen({Key key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _instructionController = new TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String discount ="0.0";
  String disc ='';
  String vocherId ="";
  String selectedTime ="";
  String selectDate ="";
  DateTime selectedDate;
  DateTime startDate;
  DateTime endDate;

  Future<String> language()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String language = sharedPreferences.getString(LANG_CODE)??"en";
    if(Provider.of<CartNotifier>(context,listen: false).cartModelList.isNotEmpty){
      String date = Provider.of<CartNotifier>(context,listen: false).cartModelList[0].startDate;

      if(date.trim()!=''){
        selectedDate =  new DateFormat("yyyy-MM-dd").parse(date);
        startDate =  new DateFormat("yyyy-MM-dd").parse(date);
        endDate = DateTime(startDate.year, startDate.month , startDate.day+6);
        selectDate = new DateFormat("yyyy-MM-dd").format(selectedDate);
      }
      for(int i =0;i< Provider.of<CartNotifier>(context,listen: false).cartModelList[0].times.length;i++){
        if(i == 0){

          selectedTime = Provider.of<CartNotifier>(context,listen: false).cartModelList[0].times[0];
          selectedTimes.add(true);
        }else{
          selectedTimes.add(false);
        }

      }

    }
    return language;
  }
  String mLanguage ="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    language().then((value){
      setState(() {
        mLanguage = value;
      });

    });
  }

  @override
  List<bool> selectedTimes = List();

  Widget build(BuildContext context) {
    ScreenUtil screenUtil = ScreenUtil();
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        appBar: customAppBar(appBarTitle: getTranslated(context, 'cart_string'), context: context),
        body:   Container(
          child: mLanguage == ""?
          Container(
            child: CircularProgressIndicator(


            ),
            alignment: AlignmentDirectional.center,
          )
              :
          Consumer<CartNotifier>(

           builder: (context, cart, child){

             return  Container(
               child: cart.cartModelList.isEmpty?
                   Container(

                     child: Center(
                       child:
                       Column(
                         crossAxisAlignment: CrossAxisAlignment.center,
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Text(getTranslated(context, 'no_items_available'),
                           style: TextStyle(
                             color: Color(0xFF000000),
                             fontSize: screenUtil.setSp(15),
                             fontWeight: FontWeight.normal
                           ),),
                           SizedBox(height: 20.h,),
                           Container(
                             margin: EdgeInsets.symmetric(horizontal: 20.w),
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
                                     style: GoogleFonts.poppins(
                                         fontSize: 12, color: whiteColor),
                                   )),
                             ),
                           ),

                         ],
                       ),
                     ),
                   ):
               ListView(
                 padding: EdgeInsets.zero,
                 shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                 children: [
                   // All Order Details Column
                   SizedBox(
                     height: 20.h,
                   ),
                   Container(
                     margin: EdgeInsets.only(left: 20.w, right: 20.w),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Text(
                           mLanguage == "en"?cart.cartModelList[0].vendorTitleEn:cart.cartModelList[0].vendorTitleAr, // here you will have the name of the restaurant
                           style: GoogleFonts.roboto(
                               fontSize: screenUtil.setSp(17), color: blackColor),
                         ),
                         Text(
                           getPrice(cart.cartModelList), // Here you will have the price of food
                           style: GoogleFonts.roboto(
                               fontSize: screenUtil.setSp(17), color: blackColor),
                         )
                       ],
                     ),
                   ),
                   SizedBox(
                     height: 20.h,
                   ),
                   CustomDivider(),
                   ListView.separated(
                     padding: EdgeInsets.zero,
                       shrinkWrap: true,
                       physics: NeverScrollableScrollPhysics(),
                       itemBuilder: (context,index){
                     return  Padding(
                       padding: EdgeInsets.symmetric(vertical: 10.h),
                       child: CartItemWidget(
                         cartModel: cart.cartModelList[index],

                         orderQuantity: "2",
                         imagePath: "assets/images/burger.png",
                         itemTitle: "Italian Burger",
                         specialNotes: "here will be the special order notes",
                         price: "8.000",

                         onDelete: () {
                           DeleteAlertDialog(context,"Are You Want To Delete this Item",index);

                         },
                         mLanguage: mLanguage,
                       ),
                     );
                   }, separatorBuilder: (context,index){
                     return  CustomDivider();
                   }, itemCount: cart.cartModelList.length),
                   CustomDivider(),
                   Container(
                     child:
                     cart.cartModelList[0].startDate == ""?
                     Container():
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             SizedBox(
                               height: 20.h,
                             ),
                             Container(
                               margin: EdgeInsets.only(left: 20.w, right: 20.w),
                               child: Text(
                                 getTranslated(context, 'pick_date'),
                                 style: GoogleFonts.roboto(
                                     fontSize: screenUtil.setSp(17), fontWeight: FontWeight.w700),
                               ),
                             ),
                             SizedBox(
                               height: 10.h,
                             ),
                       Container(

                         alignment: AlignmentDirectional.center,
                         height: 50.w,
                         margin: EdgeInsets.symmetric(horizontal: 20.w),

                         decoration:
                         BoxDecoration(
                           border:Border.all(
                               color: Color(0xFF000000),
                               width: 1.w

                           ),
                           color: Color(0xFFFFFFFF),
                           borderRadius: BorderRadius.all(Radius.circular(5.w)),




                         ),
                       child: Container(
                         margin: EdgeInsets.symmetric(horizontal: 10.w),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Text('${DateFormat('yyyy-MM-dd').format(selectedDate)}',
                               style: TextStyle(color:
                                   Color(0xFF000000),
                                   fontWeight: FontWeight.normal,
                                   fontSize: screenUtil.setSp(18)),),
                             GestureDetector(
                               onTap: (){
                                 _selectDate(context);
                               },
                               child: Icon(Icons.calendar_today_outlined,color: kMainColor,
                               size: 30.w,),
                             )

                           ],
                         ),
                       ),)


                           ],
                         )
                   ),
                   Container(
                     child: selectedTimes.isNotEmpty?
                     Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [

                         SizedBox(
                           height: 20.h,
                         ),
                         Container(
                           margin: EdgeInsets.only(left: 20.w, right: 20.w),
                           child: Text(
                             getTranslated(context, 'pick_time'),
                             style: GoogleFonts.roboto(
                                 fontSize: screenUtil.setSp(17), fontWeight: FontWeight.w700),
                           ),
                         ),
                         SizedBox(
                           height: 10.h,
                         ),
                         Container(
                           height: 50.h,
                           margin: EdgeInsets.only(left: 20.w, right: 20.w),
                           child: ListView.separated(
                             scrollDirection: Axis.horizontal,
                               itemBuilder: (context,index){
                             return GestureDetector(
                               onTap: (){
                                 for(int i =0;i<selectedTimes.length;i++){
                                   if(i == index){
                                     selectedTimes[i]= true;
                                     selectedTime = cart.cartModelList[0].times[index];
                                   }else{
                                     selectedTimes[i]= false;
                                   }
                                 }
                                 setState(() {

                                 });
                               },
                               child: Container(
                                 alignment: AlignmentDirectional.center,
                                 padding: EdgeInsets.symmetric(horizontal: 10.w),

                                 decoration: selectedTimes[index]?
                                 BoxDecoration(

                                   color: kMainColor,
                                   borderRadius: BorderRadius.all(Radius.circular(5.w)),




                                 )
                                 :
                                 BoxDecoration(
                                   border:Border.all(
                                     color: Color(0xFF000000),
                                     width: 1.w

                                   ),
                                   color: Color(0xFFFFFFFF),
                                   borderRadius: BorderRadius.all(Radius.circular(5.w)),




                                 ),
                                 child: Text(cart.cartModelList[0].times[index],
                                 style: TextStyle(color: selectedTimes[index]?
                                 Color(0xFFFFFFFF)
                                 :Color(0xFF000000),
                                 fontWeight: FontWeight.normal,
                                 fontSize: screenUtil.setSp(12)),),

                               ),
                             );
                           }, separatorBuilder: (context,index){
                             return Container(width: 20.w,);
                           }, itemCount: cart.cartModelList[0].times.length),
                         ),
                       ],
                     ): Container(),
                   ),
                   SizedBox(
                     height: 20.h,
                   ),
                   Container(
                     margin: EdgeInsets.only(left: 20.w, right: 20.w),
                     child: Text(
                       getTranslated(context, 'special_request'),
                       style: GoogleFonts.roboto(
                           fontSize: screenUtil.setSp(17), fontWeight: FontWeight.w700),
                     ),
                   ),
                   SizedBox(
                     height: 30.h,
                   ),
                   //Add Instructions text and container
                   Container(
                     margin: EdgeInsets.only(left: 30.w, right: 30.w),
                     child: Row(
                       children: [
                         Image.asset("assets/icons/instructions.png"),
                         SizedBox(
                           width: 10.w,
                         ),
                         Text(getTranslated(context, 'add_instruction'),
                             style: GoogleFonts.roboto(fontSize: screenUtil.setSp(12))),
                       ],
                     ),
                   ),
                   SizedBox(
                     height: 15.h,
                   ),
                   Container(
                     padding: EdgeInsets.only(left: 10.w, right: 10.w),
                     margin: EdgeInsets.only(left: 50.w, right: 50.w),
                     height: MediaQuery.of(context).size.height * 0.15,
                     width: MediaQuery.of(context).size.width,
                     decoration: BoxDecoration(
                         border: Border.all(color: greyColor.withOpacity(0.4)),
                         borderRadius: BorderRadius.circular(10.w)),
                     child: TextField(
                       keyboardType: TextInputType.multiline,
                       minLines: 2,
                       maxLines: 5,
                       controller: _instructionController,
                       decoration: InputDecoration(
                         border: InputBorder.none,
                       ),
                       cursorColor: primaryColor,
                     ),
                   ),
                   Container(height: 20.h,),
                   //Bottom Part Column
                   Container(
                     margin: EdgeInsets.only(left: 10.w, right: 10.w),
                     child: Column(
                       children: [
                         //Voucher Row
                         Container(
                           margin: EdgeInsetsDirectional.only(end: 20.w),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Text(
                                 getTranslated(context, 'have_voucher'),
                                 style: GoogleFonts.roboto(fontSize: screenUtil.setSp(20)),
                               ),
                               GestureDetector(
                                 onTap: () {
                                   if(discount == "0.0"){
                                     showModalBottomSheet(

                                         shape: RoundedRectangleBorder(

                                             borderRadius: BorderRadius.only(
                                                 topLeft: Radius.circular(20.w),
                                                 topRight: Radius.circular(20.w))),
                                         context: context,
                                         isScrollControlled: true,
                                         isDismissible: true,
                                         builder: (context) =>  Consumer<VoucherError>(

                                           builder: (context, error, child){

                                             textError = "";
                                             ScreenUtil screenUtil = ScreenUtil();
                                             double height = MediaQuery.of(context).size.height;
                                             // print(height);
                                             GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
                                             double statusBar = screenUtil.statusBarHeight;
                                             double toolBarHeight = AppBar().preferredSize.height;
                                             print(toolBarHeight);
                                             double containerHeight = toolBarHeight+statusBar+10.h;
                                             double requiredHeight = height-toolBarHeight-statusBar-10.h;
                                             print(requiredHeight);
                                             return Container(
                                               height: requiredHeight,
                                               child: ModalProgressHUD(

                                                 inAsyncCall: Provider.of<ModelHud>(context).isLoading,
                                                 child: Container(
                                                     height: requiredHeight,

                                                     padding: EdgeInsets.all(10.w),
                                                     child: Stack(
                                                       children: [
                                                         Column(
                                                           mainAxisSize: MainAxisSize.min,
                                                           crossAxisAlignment: CrossAxisAlignment.start,
                                                           children: [
                                                             GestureDetector(
                                                               onTap: () => Navigator.pop(context),
                                                               child: Container(
                                                                   alignment: AlignmentDirectional.topEnd,
                                                                   child: Icon(
                                                                     Icons.close,
                                                                     size: 30.w,
                                                                   )),
                                                             ),
                                                             SizedBox(
                                                               height: 40.h,
                                                             ),
                                                             Container(
                                                               margin: EdgeInsets.only(left: 25.w, right: 25.w),
                                                               child: Text(
                                                                 getTranslated(context, 'have_voucher_string'),
                                                                 style: GoogleFonts.roboto(fontSize: screenUtil.setSp(20)),
                                                               ),
                                                             ),
                                                             SizedBox(
                                                               height: 20.h,
                                                             ),
                                                             Container(
                                                               height: 100.h,
                                                               margin: EdgeInsets.only(
                                                                 left: 25.w,
                                                                 right: 25.w,
                                                               ),
                                                               child:    Column(
                                                                 crossAxisAlignment: CrossAxisAlignment.start,
                                                                 children: [
                                                                   TextFormField(


                                                                     validator: validateName,
                                                                     textAlign: TextAlign.start,
                                                                     textCapitalization: TextCapitalization.words,
                                                                     keyboardType: TextInputType.name ,

                                                                     textInputAction: TextInputAction.done,
                                                                     maxLines: 1,
                                                                     minLines: 1,
                                                                     controller: _nameController,
                                                                     decoration: new InputDecoration(
                                                                       contentPadding: EdgeInsets.zero,
                                                                       hintText: getTranslated(context, 'enter_code'),
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
                                                                   SizedBox(height: 20.w,),
                                                                   Container(
                                                                     child:
                                                                     Text(error.Error,style: TextStyle(color: Color(0xFFC20202),
                                                                         fontSize: screenUtil.setSp(12),
                                                                         fontWeight: FontWeight.normal),),
                                                                   )
                                                                 ],
                                                               ),),


                                                           ],
                                                         ),
                                                         Positioned.directional(
                                                           bottom: 10.h,
                                                           start: 0,
                                                           end: 0,
                                                           textDirection:  Directionality.of(context),

                                                           child: Container(
                                                             margin: EdgeInsets.only(
                                                               left: 25.w,
                                                               right: 25.w,
                                                             ),
                                                             child: CustomButton(
                                                               onPressed: () async{
                                                                 String voucher = _nameController.text;
                                                                 if(voucher ==""){
                                                                   textError = getTranslated(context, 'enter_valid_code');
                                                                   Provider.of<VoucherError>(context,listen: false).addError(textError);

                                                                   print(textError);



                                                                 }else{
                                                                   final modelHud = Provider.of<ModelHud>(context, listen: false);
                                                                   modelHud.changeIsLoading(true);
                                                                   EzyoServices ezyoServices = EzyoServices();
                                                                   Map<String, dynamic>   response = await ezyoServices.voucher( cart.cartModelList[0].id, voucher);
                                                                   modelHud.changeIsLoading(false);
                                                                   bool  isOk  = response['ok'];
                                                                   _nameController.text = '';
                                                                   if(isOk){
                                                                     VoucherModel voucherModel = VoucherModel.fromJson(response);
                                                                     discount = voucherModel.data.voucher.discount;
                                                                     vocherId = voucherModel.data.voucher.id;
                                                                     disc =     voucherModel.data.voucher.code;
                                                                     print('disc === ${disc}');
                                                                     Navigator.pop(context);
                                                                     Provider.of<VoucherError>(context,listen: false).addError('');
                                                                     setState(() {

                                                                     });



                                                                   }else{
                                                                     ErrorModel errorModel = ErrorModel.fromJson(response);
                                                                     textError = errorModel.data.msg;
                                                                     Provider.of<VoucherError>(context,listen: false).addError(textError);



                                                                   }
                                                                 }



                                                               },
                                                               isColored: true,
                                                               child: Center(
                                                                   child: Text(
                                                                     getTranslated(context, 'use_voucher'),
                                                                     style: GoogleFonts.poppins(
                                                                         fontSize: screenUtil.setSp(12), color: whiteColor),
                                                                   )),
                                                             ),
                                                           ),
                                                         ),
                                                       ],
                                                     )),
                                               ),
                                             );
                                             // return buildModelSheet(
                                             //     context,cart.cartModelList[0].vendorId,state
                                             // );
                                           },

                                         ));
                                   }

                                 },
                                 child: Text( discount == "0.0"?
                                   getTranslated(context, 'add_voucher'):" ${getDiscount(cart.cartModelList)} ${getTranslated(context, 'discount')}" ,
                                   style: GoogleFonts.roboto(
                                       fontSize: screenUtil.setSp(15), color: primaryColor),
                                 ),
                               )
                             ],
                           ),
                         ),
                         SizedBox(
                           height: 30.h,
                         ),
                         // Container(
                         //   margin: EdgeInsetsDirectional.only(start: 10.w, end: 20.w),
                         //   child:
                         //   Row(
                         //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         //     children: [
                         //       Text(
                         //         "Service Charge",
                         //         style: GoogleFonts.roboto(fontSize: screenUtil.setSp(15)),
                         //       ),
                         //       Text(
                         //         "0.000 KD",
                         //       )
                         //     ],
                         //   ),
                         // ),
                         // SizedBox(
                         //   height: 10.h,
                         // ),
                         Container(
                           margin: EdgeInsetsDirectional.only(start: 10.w, end: 20.w),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Text(
                                 getTranslated(context, 'total_amount'),
                                 style: GoogleFonts.roboto(
                                     fontSize: screenUtil.setSp(17), fontWeight: FontWeight.bold),
                               ),
                               Text(getPriceAfterDiscount(cart.cartModelList),
                                   style: GoogleFonts.roboto(fontSize: screenUtil.setSp(17)))
                             ],
                           ),
                         ),
                         SizedBox(
                           height: 40.h,
                         ),
                         CustomButton(
                           onPressed: () {

                             Navigator.push(
                                 context,
                                 MaterialPageRoute(
                                     builder: (context) => AdressesScreen(discount: disc,instructions: _instructionController.text,vocherId: vocherId,cartModelList: cart.cartModelList,selectedTime: selectedTime,selectedDate :selectDate)));
                           },
                           isColored: true,
                           child: Center(
                               child: Text(
                                 getTranslated(context, 'address_string'),
                                 style: GoogleFonts.poppins(
                                     fontSize: screenUtil.setSp(12), color: whiteColor),
                               )),
                         ),
                         SizedBox(
                           height: 30.h,
                         )
                       ],
                     ),
                   ),
                 ],
               ),
             );
           },
          ),
        ),
      ),
    );
  }
  String getPrice(List<CartModel> cartModelList){
    double totalPrice = 0.0;

    for(int i =0;i<cartModelList.length;i++){
      CartModel cartModel = cartModelList[i];
      double price = double.parse(cartModel.finalPrice)*cartModel.quantity;
      totalPrice +=price;

    }
    return '${totalPrice} ${getTranslated(context, 'kwd')}';

  }
  String getPriceAfterDiscount(List<CartModel> cartModelList){
    double totalPrice = 0.0;

    for(int i =0;i<cartModelList.length;i++){
      CartModel cartModel = cartModelList[i];
      double price = double.parse(cartModel.finalPrice)*cartModel.quantity ;
      totalPrice +=price;

    }

    return '${roundDouble(totalPrice-(totalPrice*(double.parse(discount)/100)),3)} ${getTranslated(context, 'kwd')}';

  }
  double roundDouble(double value, int places){
    double mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }
  String getDiscount(List<CartModel> cartModelList){
    double totalPrice = 0.0;

    for(int i =0;i<cartModelList.length;i++){
      CartModel cartModel = cartModelList[i];
      double price = double.parse(cartModel.finalPrice)*cartModel.quantity ;
      totalPrice +=price;

    }
// disc = '${(totalPrice*(double.parse(discount)/100)).toPrecision(3)}';

    return '${(totalPrice*(double.parse(discount)/100)).toPrecision(3)} ${getTranslated(context, 'kwd')}';

  }
  Future<void> DeleteAlertDialog(BuildContext context ,String title,int index) async{
    ScreenUtil screenUtil = ScreenUtil();
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
            Provider.of<CartNotifier>(context,listen: false).removeItemCart(index);



          },
          color:kMainColor,
          radius: BorderRadius.circular(6.w),
        ),
        DialogButton(
          child: Text(
            getTranslated(context, 'no'),
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

  String textError="";
  // Widget buildModelSheet(BuildContext context,String vendorId,StateSetter mystate) {
  //   textError = "";
  //   ScreenUtil screenUtil = ScreenUtil();
  //   double height = MediaQuery.of(context).size.height;
  //   // print(height);
  //    GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  //   double statusBar = screenUtil.statusBarHeight;
  //   double toolBarHeight = AppBar().preferredSize.height;
  //   print(toolBarHeight);
  //   double containerHeight = toolBarHeight+statusBar+10.h;
  //   double requiredHeight = height-toolBarHeight-statusBar-10.h;
  //   print(requiredHeight);
  //   return Container(
  //     height: requiredHeight,
  //     child: ModalProgressHUD(
  //
  //       inAsyncCall: Provider.of<ModelHud>(context).isLoading,
  //       child: Container(
  //         height: requiredHeight,
  //
  //           padding: EdgeInsets.all(10.w),
  //           child: Stack(
  //             children: [
  //               Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   GestureDetector(
  //                     onTap: () => Navigator.pop(context),
  //                     child: Container(
  //                         alignment: AlignmentDirectional.topEnd,
  //                         child: Icon(
  //                           Icons.close,
  //                           size: 30.w,
  //                         )),
  //                   ),
  //                   SizedBox(
  //                     height: 40.h,
  //                   ),
  //                   Container(
  //                     margin: EdgeInsets.only(left: 25.w, right: 25.w),
  //                     child: Text(
  //                       getTranslated(context, 'have_voucher_string'),
  //                       style: GoogleFonts.roboto(fontSize: screenUtil.setSp(20)),
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     height: 20.h,
  //                   ),
  //                   Container(
  //                     height: 100.h,
  //                     margin: EdgeInsets.only(
  //                       left: 25.w,
  //                       right: 25.w,
  //                     ),
  //                     child:    Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         TextFormField(
  //
  //                            validator: validateName,
  //                           textAlign: TextAlign.start,
  //                           textCapitalization: TextCapitalization.words,
  //                           keyboardType: TextInputType.name ,
  //
  //                           textInputAction: TextInputAction.done,
  //                           maxLines: 1,
  //                           minLines: 1,
  //                           controller: _nameController,
  //                           decoration: new InputDecoration(
  //                             contentPadding: EdgeInsets.zero,
  //                             hintText: getTranslated(context, 'enter_code'),
  //                             hintStyle: TextStyle(
  //                                 color: Color(0xFF747474),
  //                                 fontSize: screenUtil.setSp(12),
  //                                 fontWeight: FontWeight.normal
  //                             ),
  //
  //                             labelStyle: new TextStyle(color: const Color(0xFF424242)),
  //                             enabledBorder:  UnderlineInputBorder(
  //                                 borderSide: BorderSide(
  //                                     color: Color(0x88707070)
  //                                     ,width: 1
  //                                 )
  //                             )
  //                             ,
  //                             focusedBorder: UnderlineInputBorder(
  //                                 borderSide: BorderSide(
  //                                     color: Color(0x88707070)
  //                                     ,width: 1
  //                                 )
  //                             ),
  //                             border: UnderlineInputBorder(
  //
  //                                 borderSide: BorderSide(
  //                                     color: Color(0xFFFF0000)
  //                                     ,width: 1.w
  //                                 )
  //                             ),
  //                           ),
  //                         ),
  //                         SizedBox(height: 20.w,),
  //                         Container(
  //                           child:
  //                           Text('${textError}',style: TextStyle(color: Color(0xFFC20202),
  //                               fontSize: screenUtil.setSp(12),
  //                               fontWeight: FontWeight.normal),),
  //                         )
  //                       ],
  //                     ),),
  //
  //
  //                 ],
  //               ),
  //               Positioned.directional(
  //                 bottom: 10.h,
  //                 start: 0,
  //                 end: 0,
  //                 textDirection:  Directionality.of(context),
  //
  //                 child: Container(
  //                   margin: EdgeInsets.only(
  //                     left: 25.w,
  //                     right: 25.w,
  //                   ),
  //                   child: CustomButton(
  //                     onPressed: () {
  //                       validatevoucher(context,_globalKey,vendorId, mystate);
  //                     },
  //                     isColored: true,
  //                     child: Center(
  //                         child: Text(
  //                           getTranslated(context, 'use_voucher'),
  //                           style: GoogleFonts.poppins(
  //                               fontSize: screenUtil.setSp(12), color: whiteColor),
  //                         )),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           )),
  //     ),
  //   );
  //
  //
  // }

  // void validatevoucher(BuildContext context,GlobalKey<FormState> _globalKey,String vendorId,StateSetter mystate)  async{
  //
  //     String voucher = _nameController.text;
  //     if(voucher ==""){
  //       mystate(() {
  //         textError = getTranslated(context, 'enter_valid_code');
  //       });
  //
  //     }else{
  //       final modelHud = Provider.of<ModelHud>(context, listen: false);
  //       modelHud.changeIsLoading(true);
  //       EzyoServices ezyoServices = EzyoServices();
  //       Map<String, dynamic>   response = await ezyoServices.voucher( vendorId, voucher);
  //       modelHud.changeIsLoading(false);
  //       bool  isOk  = response['ok'];
  //       _nameController.text = "";
  //       if(isOk){
  //         VoucherModel voucherModel = VoucherModel.fromJson(response);
  //         discount = voucherModel.data.voucher.discount;
  //         vocherId = voucherModel.data.voucher.id;
  //         disc = voucher;
  //         Navigator.pop(context);
  //         mystate(() {
  //           textError = '';
  //         });
  //         setState(() {
  //
  //         });
  //
  //
  //
  //       }else{
  //         ErrorModel errorModel = ErrorModel.fromJson(response);
  //         print(errorModel.data.msg);
  //         mystate(() {
  //           textError = errorModel.data.msg;
  //         });
  //         setState(() {
  //
  //         });
  //
  //
  //       }
  //     }
  //
  //
  //
  //
  // }
  String validateName(String value) {

    if (value.trim().length == 0) {
      return getTranslated(context, 'plz_enter_valid_voucher');
    }

    return null;
  }
  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(

      context: context,

      initialDate: selectedDate, // Refer step 1
      firstDate: startDate,

      lastDate: endDate,
    );
    if (picked != null && picked != selectedDate)
      setState(() {



        selectedDate = picked;
        selectDate = new DateFormat("yyyy-MM-dd").format(selectedDate);
      });
  }

}
