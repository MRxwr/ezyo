import 'package:cached_network_image/cached_network_image.dart';
import 'package:ezyo/Config/Colors.dart';
import 'package:ezyo/Models/cart_model.dart';
import 'package:ezyo/Models/checkout_model.dart';
import 'package:ezyo/Models/order_details_model.dart';
import 'package:ezyo/Models/payment_success_model.dart';
import 'package:ezyo/Src/Home/home-screen.dart';
import 'package:ezyo/Src/Home/home.dart';
import 'package:ezyo/Widgets/cartItemWidget.dart';
import 'package:ezyo/Widgets/customAppBar.dart';
import 'package:ezyo/Widgets/customButton.dart';
import 'package:ezyo/Widgets/customDivider.dart';
import 'package:ezyo/apis/ezyo_services.dart';
import 'package:ezyo/localization/localization_methods.dart';
import 'package:ezyo/providers/cart_notifier.dart';
import 'package:ezyo/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ezyo/Models/address_model.dart' as Model;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
class PaymentSuccessScreen extends StatefulWidget {
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


   PaymentSuccessScreen({Key key,this.discount,this.instructions,this.address,this.vocherId,this.cartModelList,this.orderId,this.paymentMethod,this.checkoutModel,this.service,this.selectedTime,this.selectedDate}) : super(key: key);

  @override
  _PaymentSuccessScreenState createState() => _PaymentSuccessScreenState();
}

class _PaymentSuccessScreenState extends State<PaymentSuccessScreen> {
  PaymentSuccessModel paymentSuccessModel;
  OrderDetailsModel orderDetailsModel = null;
  Future<OrderDetailsModel> getLanguage() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    language = sharedPreferences.getString(LANG_CODE)??"en";
    EzyoServices ezyoServices = EzyoServices();
    dynamic paymentSuccessModel = await ezyoServices.successPayment(widget.orderId);
OrderDetailsModel    orderDetails = await ezyoServices.orderDetails(widget.orderId);
   return orderDetails;
  }
  String language="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLanguage().then((value) {
      setState(() {
        orderDetailsModel = value;

      });


    });
  }
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy kk:mm').format(now);
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: WillPopScope(
        onWillPop: () async{
          Provider.of<CartNotifier>(context,listen: false).clearCart();
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => Home()));
          return false;
        },
        child: Scaffold(
          appBar: customAppBar(
              context: context, appBarTitle: getTranslated(context, 'success'), isLeading: false),
          body:
          Container(
            child:orderDetailsModel == null?
            Container(
              child: CircularProgressIndicator(


              ),
              alignment: AlignmentDirectional.center,
            )
                :
            SingleChildScrollView(
              child: Column(
                children: [
                  //Restaurant Name Part
                  PaymentOrderItem(
                    imagePath: widget.cartModelList[0].vendorImage,
                    itemTitle: language == "en"?widget.cartModelList[0].vendorTitleEn:widget.cartModelList[0].vendorTitleAr,
                    delieveryStatus: orderDetailsModel.data.status.toString(),
                    orderId: widget.orderId,
                    dateTime: formattedDate,
                  ),
                  //Delivery Address Part
                  AddressWidget(
                    imagePath: "assets/icons/address.png",
                    name: "",
                    country: widget.address.country,
                    area: widget.address.area,
                    block: "${getTranslated(context, 'block_string')} ${widget.address.block}",
                    street: "${getTranslated(context, 'street_string')} ${widget.address.street}",
                    house: "${getTranslated(context, 'house_string')} ${widget.address.house}",
                    mobileNo: "${widget.address.mobile}",
                    selectedTime: widget.selectedTime,
                    selectedDate: widget.selectedDate,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CustomDivider(),
                  //Order Details
                  Container(
                    margin: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/icons/order-details.png",
                                height: 25,
                                width: 20,
                                fit: BoxFit.fitHeight,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                getTranslated(context, 'order_details'),
                                style: GoogleFonts.roboto(fontSize: 17),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: widget.cartModelList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                PaymentItemWidget(
                                  orderQuantity: widget.cartModelList[index].quantity.toString(),
                                  imagePath: widget.cartModelList[index].imageUrl,
                                  itemTitle: language=="en"?widget.cartModelList[index].titleEn:widget.cartModelList[index].tileAr,
                                  specialNotes:
                                  widget.cartModelList[index].orderNote,
                                  price: "${widget.cartModelList[index].finalPrice }",
                                ),
                                SizedBox(
                                  height: 10,
                                )
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  //Bottom part
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
                                getTranslated(context, 'payment_method'),
                                style: GoogleFonts.roboto(fontSize: 15),
                              ),
                              Text(
                                widget.paymentMethod==1?' KNET':
                                widget.paymentMethod == 2?' Visa/Master Card':
                                ' Wallet',
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
                                "${widget.service} ${getTranslated(context, 'kwd')}",
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
                                getTranslated(context, 'delivery_charge'),
                                style: GoogleFonts.roboto(fontSize: 15),
                              ),
                              Text(
                                "${widget.checkoutModel.data.delivery} ${getTranslated(context, 'kwd')}",
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
                                style: GoogleFonts.roboto(fontSize: 15),
                              ),
                              Text(
                                "${widget.discount} ",
                                  style: GoogleFonts.roboto(fontSize: 17,color: kSecondaryColor)
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
                            getTranslated(context, 'total_amount'),
                                style: GoogleFonts.roboto(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              Text("${widget.checkoutModel.data.total} ${getTranslated(context, 'kwd')}",
                                  style: GoogleFonts.roboto(fontSize: 17))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        CustomButton(
                          onPressed: () {
                            Provider.of<CartNotifier>(context,listen: false).clearCart();
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
                        SizedBox(
                          height: 20,
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
}

class PaymentItemWidget extends StatelessWidget {
  final String orderQuantity;
  final String imagePath;
  final String itemTitle;
  final String specialNotes;
  final String price;
  final Function onDelete;

  const PaymentItemWidget({
    Key key,
    this.orderQuantity,
    this.imagePath,
    this.itemTitle,
    this.specialNotes,
    this.price,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //item quantity and item Row
          Row(
            children: [
              //Quantity of Item
              Container(
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                    border: Border.all(color: greyColor.withOpacity(0.4)),
                    borderRadius: BorderRadius.circular(3)),
                child: Text(
                  orderQuantity,
                  style: GoogleFonts.roboto(fontSize: 12),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              //Image of the item
              CachedNetworkImage(
                height: 50,
                width: 50,
                imageUrl:TAG_IMAGE_URL+imagePath,
                imageBuilder: (context, imageProvider) => Stack(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      child: ClipRRect(

                          borderRadius: BorderRadius.circular(4),
                          child:Container(
                              width: double.infinity,

                              decoration: BoxDecoration(

                                shape: BoxShape.rectangle,

                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: imageProvider),
                              )
                          )


                      ),
                    )

                  ],
                ),
                placeholder: (context, url) =>
                    Center(
                      child: SizedBox(
                          height: 20,
                          width: 20,
                          child: new CircularProgressIndicator()),
                    ),


                errorWidget: (context, url, error) => ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.asset('assets/images/logo.png',
                      fit: BoxFit.fill,)),

              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Name of the item
                  Text(itemTitle,
                      style:
                          GoogleFonts.roboto(fontSize: 11, color: blackColor)),
                  SizedBox(
                    height: 5,
                  ),
                  //Special Notes of the item
                  Text(specialNotes,
                      style: GoogleFonts.roboto(
                          fontSize: 11, color: blackColor.withOpacity(0.4))),
                ],
              ),
            ],
          ),
          // Price and Cross Row
          Row(
            children: [
              //Price of the item
              Text(
                price + " ${getTranslated(context, 'kwd')}",
                style: GoogleFonts.roboto(fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AddressWidget extends StatelessWidget {
  final String imagePath;
  final String name, country, area, block, street, house, mobileNo,selectedTime,selectedDate;
  const AddressWidget({
    Key key,
    this.imagePath,
    this.name,
    this.country,
    this.area,
    this.block,
    this.street,
    this.house,
    this.mobileNo,
    this.selectedTime,
    this.selectedDate
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                imagePath,
                height: 25,
                width: 20,
                fit: BoxFit.fitHeight,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                getTranslated(context, 'delivery_address'),
                style: GoogleFonts.roboto(fontSize: 17),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: 40),
            child: Text(
                "$name\n$country\n$area\n$block,$street, $house\n${getTranslated(context, 'mobile_s')} $mobileNo"),
          ),
          Container(
            child: selectedDate != ""?
            Column(
              children: [
                Container(height: 30,),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        getTranslated(context, 'pick_date'),
                        style: GoogleFonts.roboto(fontSize: 17),
                      ),
                      Text(
                          selectedDate
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ):Container(),
          ),
          Container(
            child: selectedTime != ""?
            Column(
              children: [
                Container(height: 30,),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        getTranslated(context, 'pick'),
                        style: GoogleFonts.roboto(fontSize: 17),
                      ),
                      Text(
                         selectedTime
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ):Container(),
          ),
        ],
      ),
    );
  }
}

class PaymentOrderItem extends StatelessWidget {
  final String imagePath;
  final String itemTitle;
  final String delieveryStatus;
  final String orderId;

  final String dateTime;
  const PaymentOrderItem(
      {Key key,
      this.imagePath,
      this.itemTitle,
      this.delieveryStatus,
      this.orderId,
      this.dateTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
        ),
        Container(
          margin: EdgeInsets.only(left: 30, right: 30),
          child:
              //item quantity and item Row
              Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Quantity of Item

              //Image of the item
              CachedNetworkImage(
                height: 50,
                width: 50,
                imageUrl:TAG_IMAGE_URL+imagePath,
                imageBuilder: (context, imageProvider) => Stack(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      child: ClipRRect(

                          borderRadius: BorderRadius.circular(4),
                          child:Container(
                              width: double.infinity,

                              decoration: BoxDecoration(

                                shape: BoxShape.rectangle,

                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: imageProvider),
                              )
                          )


                      ),
                    )

                  ],
                ),
                placeholder: (context, url) =>
                    Center(
                      child: SizedBox(
                          height: 20,
                          width: 20,
                          child: new CircularProgressIndicator()),
                    ),


                errorWidget: (context, url, error) => ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.asset('assets/images/logo.png',
                      fit: BoxFit.fill,)),

              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Name of the item
                  Text(itemTitle,
                      style:
                          GoogleFonts.roboto(fontSize: 20, color: blackColor)),
                  SizedBox(
                    height: 5,
                  ),
                  //Special Notes of the item
                  Text(delieveryStatus,
                      style: GoogleFonts.roboto(
                          fontSize: 12, color: deliveredColor)),
                  SizedBox(
                    height: 5,
                  ),
                  Text(dateTime,
                      style: GoogleFonts.roboto(
                          fontSize: 13, color: blackColor.withOpacity(0.4))),
                  SizedBox(
                    height: 5,
                  ),
                  //Special Notes of the item
                  Text("${getTranslated(context, 'order_id')} $orderId",
                      style: GoogleFonts.roboto(
                          fontSize: 13, color: blackColor.withOpacity(0.4))),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        CustomDivider()
      ],
    );
  }
}
