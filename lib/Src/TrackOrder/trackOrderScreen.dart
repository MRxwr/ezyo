import 'package:cached_network_image/cached_network_image.dart';
import 'package:ezyo/Config/Colors.dart';
import 'package:ezyo/Config/delivery-Statuses.dart';
import 'package:ezyo/Models/orders_model.dart';
import 'package:ezyo/Src/Home/home.dart';
import 'package:ezyo/Src/TrackOrder/order_details_screen.dart';
import 'package:ezyo/Widgets/customAppBar.dart';
import 'package:ezyo/Widgets/customButton.dart';
import 'package:ezyo/Widgets/customDivider.dart';
import 'package:ezyo/Widgets/customTrackOrderItemWidget.dart';
import 'package:ezyo/apis/ezyo_services.dart';
import 'package:ezyo/localization/localization_methods.dart';
import 'package:ezyo/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TrackOrderScreen extends StatefulWidget {
  const TrackOrderScreen({Key key}) : super(key: key);

  @override
  _TrackOrderScreenState createState() => _TrackOrderScreenState();
}

class _TrackOrderScreenState extends State<TrackOrderScreen> {

  String languageId;
  OrdersModel ordersModel;
  Future<OrdersModel> orders() async{

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String userId = sharedPreferences.getString("id");
    languageId = sharedPreferences.getString(LANG_CODE)??"en";
    EzyoServices ezyoServices = EzyoServices();
    OrdersModel ordersModel = await ezyoServices.orders(userId);
    return ordersModel;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    orders().then((value){
      setState(() {
        ordersModel = value;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil screenUtil = ScreenUtil();
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: customAppBar(appBarTitle: getTranslated(context, 'track_order'), context: context),
        body: Container(
          child: ordersModel == null?
          Container(
            child: CircularProgressIndicator(


            ),
            alignment: AlignmentDirectional.center,
          ):
          Container(
            child: ordersModel.data.isEmpty?
            Container(

              child: Center(
                child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(getTranslated(context, 'no_orders'),
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
            )
            :ListView.separated(
                shrinkWrap: true,
                itemCount: ordersModel.data.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OrderDetailsScreen(id: ordersModel.data[index].order.id,)));
                    },
                    child:
                    Container(
                      height: 90.h,
                      margin: EdgeInsets.symmetric(vertical: 20.h,horizontal: 20.w),
                      child: Row(

                        children: [
                          //item quantity and item Row
                          Expanded(
                            flex:1,
                            child: CachedNetworkImage(
                              height: 50.w,
                              width: 50.w,
                              imageUrl:TAG_IMAGE_URL+ordersModel.data[index].vendor.logo.toString(),
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
                          ),

                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //Name of the item
                                Expanded(
                                  flex:1,
                                  child: Text(languageId == "en"?ordersModel.data[index].vendor.enTitle.toString():ordersModel.data[index].vendor.arTitle.toString(),
                                      style: GoogleFonts.roboto(
                                          fontSize: 15, color: blackColor)),
                                ),

                                //Special Notes of the item
                                Expanded(
                                  flex: 1,
                                  child: Text(ordersModel.data[index].order.status.toString(),
                                      style: GoogleFonts.roboto(
                                          fontSize: 12,
                                          color: ordersModel.data[index].order.status == delivered
                                              ? deliveredColor
                                              : ordersModel.data[index].order.status == preparing
                                              ? preparingColor
                                              : ordersModel.data[index].order.status == outForDelivery
                                              ? outForDeliveryColor
                                              : ordersModel.data[index].order.status == cancelled
                                              ? cancelledDeliveryColor
                                              : paidColor)),
                                ),

                                //Special Notes of the item
                                Expanded(
                                  flex: 1,
                                  child: Text("${getTranslated(context, 'order_id')}${ordersModel.data[index].order.id.toString()}",
                                      style: GoogleFonts.roboto(
                                          fontSize: 13,
                                          color: blackColor.withOpacity(0.4))),
                                ),
                              ],
                            ),
                          ),
                          // Price and Cross Row
                          Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                Expanded(
                                  flex:1,
                                  child: Text(ordersModel.data[index].order.date.toString(),
                                      style: GoogleFonts.roboto(
                                          fontSize: 13, color: blackColor.withOpacity(0.4))),
                                ),

                                //Price of the item
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    '${ordersModel.data[index].order.price.toString()} ${getTranslated(context, 'kwd')}',
                                    style: GoogleFonts.roboto(fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                  );
                }
                ,separatorBuilder: (context,index){
                  return CustomDivider();
            },),
          ),
        ),
      ),
    );
  }
}
