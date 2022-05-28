import 'package:cached_network_image/cached_network_image.dart';
import 'package:ezyo/Config/Colors.dart';
import 'package:ezyo/Models/order_details_model.dart';
import 'package:ezyo/Widgets/customAppBar.dart';
import 'package:ezyo/Widgets/customDivider.dart';
import 'package:ezyo/apis/ezyo_services.dart';
import 'package:ezyo/localization/localization_methods.dart';
import 'package:ezyo/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
class OrderDetailsScreen extends StatefulWidget {
  String id;
   OrderDetailsScreen({Key key,this.id}) : super(key: key);

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  String language;
  OrderDetailsModel orderDetailsModel;
  Future<OrderDetailsModel> orders() async{

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String userId = sharedPreferences.getString("id");
     language = sharedPreferences.getString(LANG_CODE)??"en";
    EzyoServices ezyoServices = EzyoServices();
    OrderDetailsModel ordersModel = await ezyoServices.orderDetails(widget.id);
    return ordersModel;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    orders().then((value) {
      setState(() {
        orderDetailsModel = value;
      });

    });
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: customAppBar(
            context: context, appBarTitle: getTranslated(context, 'order_details'), isLeading: true),
        body: Container(

          child: orderDetailsModel == null?
          Container(
            child: CircularProgressIndicator(


            ),
            alignment: AlignmentDirectional.center,
          ):
          ListView(
            children: [
              //Restaurant Name Part
              PaymentOrderItem(
                imagePath: orderDetailsModel.data.vendor.logo.toString(),
                itemTitle: language == "en"?orderDetailsModel.data.vendor.enTitle.toString():orderDetailsModel.data.vendor.arTitle.toString(),
                delieveryStatus: getTranslated(context, 'successful'),
                orderId: orderDetailsModel.data.orderId.toString(),
                dateTime: orderDetailsModel.data.date.toString(),
              ),
              //Delivery Address Part
              AddressWidget(
                imagePath: "assets/icons/address.png",
                name: orderDetailsModel.data.address.name.toString(),
                country: orderDetailsModel.data.address.country.toString(),
                area: orderDetailsModel.data.address.area.toString(),
                block: "${getTranslated(context, 'block_string')} ${orderDetailsModel.data.address.block.toString()}",
                street: "${getTranslated(context, 'street_string')}  ${orderDetailsModel.data.address.street.toString()}",
                house: "${getTranslated(context, 'house_string')}  ${orderDetailsModel.data.address.house.toString()}",
                mobileNo: "${orderDetailsModel.data.address.mobile.toString()}",
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
                      itemCount: orderDetailsModel.data.items.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            PaymentItemWidget(
                              orderQuantity: orderDetailsModel.data.items[index].quantity.toString(),
                              imagePath: orderDetailsModel.data.items[index].logo.toString(),
                              itemTitle: language=="en"?orderDetailsModel.data.items[index].enTitle.toString():orderDetailsModel.data.items[index].arTitle.toString(),
                              specialNotes:
                             orderDetailsModel.data.items[index].note.toString(),
                              price: "${orderDetailsModel.data.items[index].price.toString()} ${getTranslated(context, 'kwd')}",
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
                              orderDetailsModel.data.payment.toString()
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
                            "${orderDetailsModel.data.delivery.toString()} ${getTranslated(context, 'kwd')}",
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
                            "${orderDetailsModel.data.service.toString()} ${getTranslated(context, 'kwd')}",
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
                            "${orderDetailsModel.data.voucher.code.toString() == "null"?"":orderDetailsModel.data.voucher.code.toString()}",
                            style: GoogleFonts.roboto(fontSize: 17,
                                color: kSecondaryColor),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
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
                          Text("${orderDetailsModel.data.price.toString()} ${getTranslated(context, 'kwd')}",
                              style: GoogleFonts.roboto(fontSize: 17))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),

                  ],
                ),
              ),
            ],
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
                  orderQuantity.toString(),
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
                imageUrl:TAG_IMAGE_URL+imagePath.toString(),
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
                  Text(itemTitle.toString(),
                      style:
                      GoogleFonts.roboto(fontSize: 11, color: blackColor)),
                  SizedBox(
                    height: 5,
                  ),
                  //Special Notes of the item
                  Text(specialNotes.toString(),
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
                price.toString()+ " KD",
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
  final String name, country, area, block, street, house, mobileNo;
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
                getTranslated(context,'delivery_address'),
                style: GoogleFonts.roboto(fontSize: 17),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: 40),
            child: Text(
                "$name\n$country\n$area\n$block,$street, $house\n${getTranslated(context, 'mobile_string')} : $mobileNo"),
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
