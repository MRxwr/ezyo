import 'package:ezyo/Config/Colors.dart';
import 'package:ezyo/Models/address_model.dart' as Model;
import 'package:ezyo/Models/cart_model.dart';
import 'package:ezyo/Models/error_model.dart';
import 'package:ezyo/Src/Address/address-screen.dart';
import 'package:ezyo/Src/Address/edit_address_screen.dart';
import 'package:ezyo/Src/Cart/cart-screen.dart';
import 'package:ezyo/Src/Checkout/checkout-screen.dart';
import 'package:ezyo/Widgets/customAppBar.dart';
import 'package:ezyo/Widgets/customButton.dart';
import 'package:ezyo/apis/ezyo_services.dart';
import 'package:ezyo/localization/localization_methods.dart';
import 'package:ezyo/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
class AdressesScreen extends StatefulWidget {
  String discount;
  String instructions;
String vocherId;
List<CartModel> cartModelList;
String selectedTime;
String selectedDate;
   AdressesScreen({Key key,this.discount,this.instructions,this.vocherId,this.cartModelList,this.selectedTime,this.selectedDate}) : super(key: key);

  @override
  _AdressesScreenState createState() => _AdressesScreenState();
}

class _AdressesScreenState extends State<AdressesScreen> {
  ScreenUtil screenUtil = ScreenUtil();
  Model.AddressModel addressModel;
  ErrorModel errorModel;
  Map<String, dynamic>   response = null;
  List<bool> addresses = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAddresses().then((value){
      response = value;
      bool  isOk  = response['ok'];
      if(isOk){
         addressModel = Model.AddressModel.fromJson(response);
         for(int i =0;i<addressModel.data.address.length;i++){
           addresses.add(false);
         }

      }else{
        addressModel = null;

      }
      setState(() {

      });

    });
  }
  Future<dynamic> getAddresses()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String userId = sharedPreferences.getString("id");
    EzyoServices ezyoServices = EzyoServices();
    Map<String, dynamic>   response = await ezyoServices.getAddresses(userId);
    return response;

  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        appBar: AppBar(
          toolbarHeight: 66,
          backgroundColor: whiteColor,
          centerTitle: true,
          elevation: 5,
          title: Text(
            getTranslated(context, 'addresses'),
            style: GoogleFonts.roboto(fontSize: 15, color: blackColor),
          ),
          leading:
               GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: blackColor,
              size: 18,
            ),
          ),
          actions: [

            GestureDetector(
              onTap: (){
                AddNewAddress(context);
              },
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 10.w),
                child: Icon(Icons.add,
                color: kSecondaryColor,
                size: 30.w,),
              ),
            )
          ],

        ),
        body: Container(
          margin: EdgeInsets.all(10.w),
          child:  response == null?
          Container(
            child: CircularProgressIndicator(


            ),
            alignment: AlignmentDirectional.center,
          ):
              addressModel == null?
                  Center(
                    child:
                    CustomButton(
                      isColored: true,
                      onPressed: () {
AddNewAddress(context);

                      },
                      child: Center(
                          child: Text(
                            getTranslated(context, 'add_new_address'),
                            style: GoogleFonts.roboto(
                                fontSize: screenUtil.setSp(12), color: whiteColor),
                          )),
                    ),
                  )
                  :Container(
                width: screenUtil.screenWidth,
                height: screenUtil.screenHeight,

                child: Stack(
                  children: [
                    ListView(
                      scrollDirection: Axis.vertical,


                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      children: [
                        ListView.separated(
                            scrollDirection: Axis.vertical,


                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemBuilder: (context,index){
                              return Container(
                                width: width,
                                height: 400.h,
                                child: Card(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  color: Color(0xFFFFFFFF),
                                  elevation: 2.w,
                                  shape: RoundedRectangleBorder(

                                    borderRadius: BorderRadius.circular(10),


                                  ),
                                  child: Container(
                                    child: Container(
                                      margin: EdgeInsets.all(10.w),
                                      child: Stack(
                                        children: [
                                          Column(
                                            children: [

                                              Expanded(
                                                flex:1,
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      flex:2,
                                                      child: Text(getTranslated(context, 'mobile_s'),
                                                        textAlign: TextAlign.start,
                                                        style: TextStyle(
                                                            color:kSecondaryColor,
                                                            fontWeight: FontWeight.w500,

                                                            fontSize: screenUtil.setSp(17)
                                                        ),),
                                                    ),
                                                    Expanded(
                                                      flex: 3,
                                                      child: Text(addressModel.data.address[index].mobile.toString(),
                                                        textAlign: TextAlign.start,
                                                        style: TextStyle(
                                                            color: Color(0xFF000000),
                                                            fontWeight: FontWeight.normal,

                                                            fontSize: screenUtil.setSp(14)
                                                        ),),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      flex:2,
                                                      child: Text(getTranslated(context, 'country_s'),
                                                        textAlign: TextAlign.start,
                                                        style: TextStyle(
                                                            color: kSecondaryColor,
                                                            fontWeight: FontWeight.w500,

                                                            fontSize: screenUtil.setSp(17)
                                                        ),),
                                                    ),
                                                    Expanded(
                                                      flex: 3,
                                                      child: Text(addressModel.data.address[index].country,
                                                        textAlign: TextAlign.start,
                                                        style: TextStyle(
                                                            color: Color(0xFF000000),
                                                            fontWeight: FontWeight.normal,

                                                            fontSize: screenUtil.setSp(14)
                                                        ),),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      flex:2,
                                                      child: Text(getTranslated(context, 'area_s'),
                                                        textAlign: TextAlign.start,
                                                        style: TextStyle(
                                                            color: kSecondaryColor,
                                                            fontWeight: FontWeight.w500,

                                                            fontSize: screenUtil.setSp(17)
                                                        ),),
                                                    ),
                                                    Expanded(
                                                      flex: 3,
                                                      child: Text(addressModel.data.address[index].area,
                                                        textAlign: TextAlign.start,
                                                        style: TextStyle(
                                                            color: Color(0xFF000000),
                                                            fontWeight: FontWeight.normal,

                                                            fontSize: screenUtil.setSp(14)
                                                        ),),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      flex:2,
                                                      child: Text(getTranslated(context, 'block_s'),
                                                        textAlign: TextAlign.start,
                                                        style: TextStyle(
                                                            color: kSecondaryColor,
                                                            fontWeight: FontWeight.w500,

                                                            fontSize: screenUtil.setSp(17)
                                                        ),),
                                                    ),
                                                    Expanded(
                                                      flex: 3,
                                                      child: Text(addressModel.data.address[index].block,
                                                        textAlign: TextAlign.start,
                                                        style: TextStyle(
                                                            color: Color(0xFF000000),
                                                            fontWeight: FontWeight.normal,

                                                            fontSize: screenUtil.setSp(14)
                                                        ),),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      flex:2,
                                                      child: Text(getTranslated(context, 'street_s'),
                                                        textAlign: TextAlign.start,
                                                        style: TextStyle(
                                                            color: kSecondaryColor,
                                                            fontWeight: FontWeight.w500,

                                                            fontSize: screenUtil.setSp(17)
                                                        ),),
                                                    ),
                                                    Expanded(
                                                      flex: 3,
                                                      child: Text(addressModel.data.address[index].street,
                                                        textAlign: TextAlign.start,
                                                        style: TextStyle(
                                                            color: Color(0xFF000000),
                                                            fontWeight: FontWeight.normal,

                                                            fontSize: screenUtil.setSp(14)
                                                        ),),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      flex:2,
                                                      child: Text(getTranslated(context, 'house_s'),
                                                        textAlign: TextAlign.start,
                                                        style: TextStyle(
                                                            color: kSecondaryColor,
                                                            fontWeight: FontWeight.w500,

                                                            fontSize: screenUtil.setSp(17)
                                                        ),),
                                                    ),
                                                    Expanded(
                                                      flex: 3,
                                                      child: Text(addressModel.data.address[index].house.toString(),
                                                        textAlign: TextAlign.start,
                                                        style: TextStyle(
                                                            color: Color(0xFF000000),
                                                            fontWeight: FontWeight.normal,

                                                            fontSize: screenUtil.setSp(14)
                                                        ),),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      flex:2,
                                                      child: Text(getTranslated(context, 'floor_s'),
                                                        textAlign: TextAlign.start,
                                                        style: TextStyle(
                                                            color: kSecondaryColor,
                                                            fontWeight: FontWeight.w500,

                                                            fontSize: screenUtil.setSp(17)
                                                        ),),
                                                    ),
                                                    Expanded(
                                                      flex: 3,
                                                      child: Text(addressModel.data.address[index].floor.toString(),
                                                        textAlign: TextAlign.start,
                                                        style: TextStyle(
                                                            color: Color(0xFF000000),
                                                            fontWeight: FontWeight.normal,

                                                            fontSize: screenUtil.setSp(14)
                                                        ),),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      flex:2,
                                                      child: Text(getTranslated(context, 'flat_s'),
                                                        textAlign: TextAlign.start,
                                                        style: TextStyle(
                                                            color: kSecondaryColor,
                                                            fontWeight: FontWeight.w500,

                                                            fontSize: screenUtil.setSp(17)
                                                        ),),
                                                    ),
                                                    Expanded(
                                                      flex: 3,
                                                      child: Text(addressModel.data.address[index].flat.toString(),
                                                        textAlign: TextAlign.start,
                                                        style: TextStyle(
                                                            color: Color(0xFF000000),
                                                            fontWeight: FontWeight.normal,

                                                            fontSize: screenUtil.setSp(14)
                                                        ),),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                  child: EditAddress(getTranslated(context, 'edit_address'),context,addressModel.data.address[0]))





                                            ],
                                          ),
                                          Positioned.directional( textDirection:  Directionality.of(context),
                                              top: 0,
                                              end: 0,
                                              child:
                                              GestureDetector(
                                                onTap: (){
                                                  for(int i =0;i<addresses.length;i++){
                                                    if(i == index){
                                                      addresses[i]= true;
                                                    }else{
                                                      addresses[i]= false;

                                                    }
                                                  }
                                                  setState(() {

                                                  });

                                                },
                                                child:

                                                Container(

                                                  child:
                                                      SizedBox(
                                                      height: 20.h,
                                                      width: 20.w, // fixed width and height
                                                      child:addresses[index]?
                                                      Icon(Icons.radio_button_checked_outlined,color: kSecondaryColor)
                                                          :

                                                      Icon(Icons.radio_button_off,color:kSecondaryColor)
                                                  ),
                                                ),
                                              )
                                          )

                                        ],
                                      ),
                                    ),
                                  ),

                                ),
                              );
                            }, separatorBuilder: (context,index){
                          return Container(width: width,
                            height: 10.h,);
                        }, itemCount: addressModel.data.address.length),
                        Container(
                          width: width,
                          height: 50.h,
                        )
                      ],
                    ),
                    Positioned.directional(textDirection:  Directionality.of(context),
                        bottom: 10.h,

                        child: isChecked()?
                        shopButton(getTranslated(context, 'check_out'), context):Container())
                  ],
                ),

              ),
        ),

      ),
    );
  }
  bool isChecked(){
    bool isChecked = false;
    for(int i =0;i<addresses.length;i++){
      bool isSelect =  addresses[i];
      if(isSelect ){
        isChecked = true;
        break;
      }
    }
    return isChecked;
  }

  TextButton shopButton(String text,BuildContext context){
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      primary: Color(0xFF000000),
      minimumSize: Size(width, 40.h ),

      shape:  RoundedRectangleBorder(

        borderRadius: BorderRadius.all(Radius.circular(5.0.w)),
      ),
      backgroundColor: kSecondaryColor,
    );

    return TextButton(
      style: flatButtonStyle,
      onPressed: () {
        int selectedIndex = 0;
        for(int i =0;i<addresses.length;i++){
          bool isSelect =  addresses[i];
          if(isSelect ){
            selectedIndex = i;
            break;
          }
        }

        Model.Address address = addressModel.data.address[selectedIndex];


Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CheckoutScreen(discount: widget.discount,instructions: widget.instructions,
                address: address,vocherId: widget.vocherId,cartModelList: widget.cartModelList,selectedTime:widget.selectedTime,selectedDate :widget.selectedDate)));
      },
      child:
      Center(
        child: Text(text,style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: screenUtil.setSp(15),
            fontWeight: FontWeight.bold
        ),),
      ),
    );
  }
  TextButton EditAddress(String text,BuildContext context,Model.Address data){
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      primary: Color(0xFF000000),
      minimumSize: Size(width, 30.h ),
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      shape:  RoundedRectangleBorder(

        borderRadius: BorderRadius.all(Radius.circular(5.0.w)),
      ),
      backgroundColor: kSecondaryColor,
    );

    return TextButton(
      style: flatButtonStyle,
      onPressed: () {
        EditAddresss( context,data);

      },
      child: Text(text,style: TextStyle(
          color: Color(0xFFFFFFFF),
          fontSize: screenUtil.setSp(14),
          fontWeight: FontWeight.normal
      ),),
    );
  }

  void AddNewAddress(BuildContext context) async{
    Map results =  await Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context){
      return new AddressScreen();
    }));
    if (results != null && results.containsKey('selection')) {
      response = null;
      addressModel = null;
      addresses.clear();
      setState(() {

      });
      getAddresses().then((value){
        response = value;
        bool  isOk  = response['ok'];
        if(isOk){
          addressModel = Model.AddressModel.fromJson(response);
          for(int i =0;i<addressModel.data.address.length;i++){
            addresses.add(false);
          }

        }else{
          addressModel = null;

        }
        setState(() {

        });

      });
      // setState(() {
      //
      // });

    }
  }
  void EditAddresss(BuildContext context,Model.Address data) async{
    Map results =  await Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context){
      return new EditAddressScreen(address: data,);
    }));
    if (results != null && results.containsKey('selection')) {
      response = null;
      addressModel = null;
      addresses.clear();
      setState(() {

      });
      getAddresses().then((value){
        response = value;
        bool  isOk  = response['ok'];
        if(isOk){
          addressModel = Model.AddressModel.fromJson(response);
          for(int i =0;i<addressModel.data.address.length;i++){
            addresses.add(false);
          }

        }else{
          addressModel = null;

        }
        setState(() {

        });

      });
      // setState(() {
      //
      // });

    }
  }
}
