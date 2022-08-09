import 'package:cached_network_image/cached_network_image.dart';
import 'package:ezyo/Config/Colors.dart';
import 'package:ezyo/Models/cart_model.dart';
import 'package:ezyo/Models/vendor_model.dart';
import 'package:ezyo/Src/Cart/view_order_screen.dart';
import 'package:ezyo/Src/Restaurant/sample-data.dart';
import 'package:ezyo/Src/RestaurantSingleProduct/restaurantSingleProductScreen.dart';
import 'package:ezyo/Widgets/customButton.dart';
import 'package:ezyo/Widgets/customTrackOrderItemWidget.dart';
import 'package:ezyo/apis/ezyo_services.dart';
import 'package:ezyo/localization/localization_methods.dart';
import 'package:ezyo/providers/cart_notifier.dart';
import 'package:ezyo/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math' as math;

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RestaurantScreen extends StatefulWidget {
  String vendorId;

   RestaurantScreen({Key key,this.vendorId}) : super(key: key);

  @override
  _RestaurantScreenState createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  String language ="";
  VendorModel vendorModel = null;
  String mTotalPrice ="";
  int number = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    vendor().then((value){
      setState(() {
        vendorModel = value;

      });

    });
  }
  Future<VendorModel> vendor()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    language = sharedPreferences.getString(LANG_CODE)??"en";
    EzyoServices ezyoServices = EzyoServices();
    VendorModel vendorModel = await ezyoServices.vendor(widget.vendorId);
    print('categories ---> ${vendorModel.data.categories[0].arTitle}');
    return vendorModel;
  }
  ScreenUtil screenUtil = ScreenUtil();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: Container(

          child: vendorModel == null?
          Container(
            child: CircularProgressIndicator(


            ),
            alignment: AlignmentDirectional.center,
          )
          :Stack(
            children: [
              CustomScrollView(
                slivers: [
                  SliverAppBar(
                    backgroundColor: primaryColor,
                    expandedHeight: 250.h,
                    //floating: true,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: Text(
                        language == "en"?vendorModel.data.vendor.enShop:vendorModel.data.vendor.arShop,
                        style: GoogleFonts.roboto(fontSize: screenUtil.setSp(20), color: Colors.white),
                      ),
                      background:     CachedNetworkImage(
                        width: double.infinity,
                        height: screenUtil.screenHeight,
                        imageUrl:TAG_IMAGE_URL+vendorModel.data.vendor.header,
                        imageBuilder: (context, imageProvider) => Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              child: Container(
                                  width: double.infinity,

                                  decoration: BoxDecoration(

                                    shape: BoxShape.rectangle,

                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: imageProvider),
                                  )
                              ),
                            )

                          ],
                        ),
                        placeholder: (context, url) =>
                            Center(
                              child: SizedBox(
                                  height: 50.h,
                                  width: 50.h,
                                  child: new CircularProgressIndicator()),
                            ),


                        errorWidget: (context, url, error) => ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset('assets/images/logo.png',
                              fit: BoxFit.fill,)),

                      ),
                    ),
                    pinned: true,
                    leading: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(5.w)),
                        margin: EdgeInsets.all(12.w),
                        child: Padding(
                          padding: EdgeInsetsDirectional.only(start: 8.w),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: whiteColor,
                            size: screenUtil.setSp(20),
                          ),
                        ),
                      ),
                    ),
                    actions: [
                      GestureDetector(
                        onTap: (){
                          Share.share(language == "en"? vendorModel.data.vendor.enShop +'\n'+ vendorModel.data.vendor.enDetails :

                          vendorModel.data.vendor.arShop +'\n'+ vendorModel.data.vendor.arDetails     );
                        },
                        child: Container(
                          width: 30.w,
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(5.w)),
                          margin: EdgeInsets.all(10.w),
                          child: Transform.rotate(
                              angle: 270 * math.pi / 180,
                              child: Icon(
                                Icons.logout,
                                color: whiteColor,
                                size: 20.w,
                              )),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      )
                    ],
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      margin: EdgeInsets.only(left: 25.w, right: 25.w),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CachedNetworkImage(
                                width: 100.w,
                                height: 100.h,
                                imageUrl:TAG_IMAGE_URL+vendorModel.data.vendor.logo,
                                imageBuilder: (context, imageProvider) => Stack(
                                  children: [
                                    Container(
                                      width: 100.w,
                                      height: 100.h,
                                      child: Container(
                                          width: 100.w,
                                          height: 100.h,

                                          decoration: BoxDecoration(

                                            shape: BoxShape.rectangle,

                                            image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: imageProvider),
                                          )
                                      ),
                                    )

                                  ],
                                ),
                                placeholder: (context, url) =>
                                    Center(
                                      child: SizedBox(
                                          height: 50.h,
                                          width: 50.h,
                                          child: new CircularProgressIndicator()),
                                    ),


                                errorWidget: (context, url, error) => ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset('assets/images/logo.png',
                                      fit: BoxFit.fill,)),

                              ),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    language == "en"?vendorModel.data.vendor.enShop:vendorModel.data.vendor.arShop,
                                    style: GoogleFonts.roboto(
                                        fontSize: screenUtil.setSp(20), fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Text(
                                    language == "en"?vendorModel.data.vendor.enDetails:vendorModel.data.vendor.enDetails,
                                    style: GoogleFonts.roboto(
                                        fontSize: screenUtil.setSp(15),
                                        fontWeight: FontWeight.normal,
                                        color: greyColor),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 25.h,
                          ),
                          Container(
                            child: vendorModel.data.categories[0].arTitle == null?
                            Container():ExpansionPanelList(

                              expansionCallback: (index, isExpanded) {
                                isExpanded = true;
                                setState(() {

                                });
                                final tile = vendorModel.data.categories[index];

                              },

                              expandedHeaderPadding: EdgeInsets.all(0),
                              elevation: 0,

                              dividerColor: whiteColor,
                              children: vendorModel.data.categories
                                  .map((tile) => ExpansionPanel(

                                      backgroundColor: Color(0xFFF5F5F5),
                                      canTapOnHeader: true,
                                      isExpanded: true,
                                      // value: language == "en"?tile.enTitle:tile.arTitle,
                                      headerBuilder: (context, isExpanded) =>

                                          Container(
                                            //  color: greyColor.withOpacity(0.3),

                                            child: ListTile(
                                              title: Text(language == "en"?tile.enTitle:tile.arTitle),
                                            ),
                                          ),
                                      body: Column(
                                          children: tile.items
                                              .map((tile) => GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  RestaurantSingleProductScreen(item: tile,language:language,vendorId: vendorModel.data.vendor.id.toString(),vendorNameAr: vendorModel.data.vendor.arShop,
                                                                      vendorNameEn: vendorModel.data.vendor.enShop,vendorImage: vendorModel.data.vendor.logo,times: vendorModel.data.vendor.times,startDate: vendorModel.data.vendor.startDate,)));
                                                    },
                                                    child:
                                                    Container(
                                                      height: 80.h,
                                                        color: whiteColor, child: Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 1,
                                                          child: Container(
                                                            margin: EdgeInsets.all(5.w),
                                                            child:  CachedNetworkImage(

                                                              imageUrl:tile.images.isEmpty?TAG_IMAGE_URL:TAG_IMAGE_URL+tile.images[0],
                                                              // TAG_IMAGE_URL+tile.images[0],
                                                              imageBuilder: (context, imageProvider) => Stack(
                                                                children: [
                                                                  ClipRRect(
                                                                    borderRadius: BorderRadius.circular(10.w),
                                                                    child: Container(


                                                                        decoration: BoxDecoration(

                                                                          shape: BoxShape.rectangle,

                                                                          image: DecorationImage(
                                                                              fit: BoxFit.fill,
                                                                              image: imageProvider),
                                                                        )
                                                                    ),
                                                                  )

                                                                ],
                                                              ),
                                                              placeholder: (context, url) =>
                                                                  Center(
                                                                    child: SizedBox(
                                                                        height: 50.h,
                                                                        width: 50.h,
                                                                        child: new CircularProgressIndicator()),
                                                                  ),


                                                              errorWidget: (context, url, error) => ClipRRect(
                                                                  borderRadius: BorderRadius.circular(10.w),
                                                                  child: Image.asset('assets/images/logo.png',
                                                                    fit: BoxFit.fill,)),

                                                            ),

                                                          ),
                                                        ),
                                                        Expanded(flex:3,child: Container(
                                                          margin: EdgeInsets.all(5.w),
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [

                                                              Expanded(
                                                            flex: 1,
                                                                child: Text(language == "en"?tile.enTitle:tile.arTitle,
                                                                style: TextStyle(color: Color(0xFF000000)
                                                                ,fontWeight: FontWeight.normal,
                                                                fontSize: screenUtil.setSp(15)),
                                                                ),

                                                              ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Text(language == "en"?tile.enDetails:tile.arDetails,
                                                              style: TextStyle(color: Color(0xFF5B5B5B)
                                                                  ,fontWeight: FontWeight.normal,
                                                                  fontSize: screenUtil.setSp(12)),
                                                            ),
                                                          ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(tile.price +"${getTranslated(context, 'kwd')}",
                                                                  style: TextStyle(color: Color(0xFFFF8262)
                                                                      ,fontWeight: FontWeight.normal,
                                                                      fontSize: screenUtil.setSp(10)),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ))
                                                      ],
                                                    )),
                                                  ))
                                              .toList())))
                                  .toList(),
                            ),
                          ),
                          SizedBox(
                            height: 60.h,
                          ),

                          SizedBox(
                            height: 20.h,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Positioned.directional( textDirection:  Directionality.of(context),
                  bottom: 20.h,
                start: 20.w,
                end: 20.w,
                child: CustomButton(
                isColored: true,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ViewOrderScreen()));
                },
                child: Container(
                  margin: EdgeInsets.only(left: 10.w, right: 10.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Consumer<CartNotifier>(
                        builder: (context, cart, child) {
                          return Text(getPrice(cart.cartModelList),
                            style: GoogleFonts.roboto(
                                fontSize: screenUtil.setSp(15), color: Colors.white),);
                        },
                      )
                      ,
                      Text(
                        getTranslated(context, 'view_order'),
                        style: GoogleFonts.roboto(
                            fontSize: screenUtil.setSp(12), color: whiteColor),
                      ),
                      Container(
                          padding: EdgeInsets.all(10.w),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: whiteColor,
                              )),
                          child:
                          Consumer<CartNotifier>(
                            builder: (context, cart, child) {
                              return Text(" ${cart.cartModelList.length}",
                                style: GoogleFonts.roboto(
                                    fontSize: screenUtil.setSp(15), color: Colors.white),);
                            },
                          )

                      ),
                    ],
                  ),
                ),
              ),)
            ],
          ),
        ),
      ),
    );
  }

  Future<String> getNumber() async{
    int number =  Provider.of<CartNotifier>(context,listen: false).cartModelList.length;
    return number.toString();

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

}
