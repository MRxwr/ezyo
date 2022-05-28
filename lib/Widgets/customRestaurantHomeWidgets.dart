import 'package:cached_network_image/cached_network_image.dart';
import 'package:ezyo/Config/Colors.dart';
import 'package:ezyo/Models/home_model.dart';
import 'package:ezyo/localization/localization_methods.dart';
import 'package:ezyo/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomGeneralRestaurantWidget extends StatelessWidget {
 Vendors vendors;
 ScreenUtil screenUtil = ScreenUtil();
 String lang;
   CustomGeneralRestaurantWidget(
      {Key key, this.vendors, this.lang})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 200,
          width: MediaQuery.of(context).size.width,
          child: CachedNetworkImage(
            width: double.infinity,
            height: 200.h,
            imageUrl:TAG_IMAGE_URL+vendors.header,
            imageBuilder: (context, imageProvider) => Stack(
              children: [
                Container(
                  width: double.infinity,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.w),
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
        SizedBox(
          height: 10.h,
        ),
        Text(
          lang == "en"?vendors.enShop:vendors.arShop,
          style: GoogleFonts.roboto(fontSize: screenUtil.setSp(20), fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5.h,
        ),
        Text(
          lang == "en"?vendors.enDetails:vendors.arDetails,
          style: GoogleFonts.roboto(
              fontSize: screenUtil.setSp(15), fontWeight: FontWeight.normal, color: greyColor),
        ),
        SizedBox(
          height: 20.h,
        ),
      ],
    );
  }
}

class CustomBusyRestaurantWidget extends StatelessWidget {
  Vendors vendors;
  ScreenUtil screenUtil = ScreenUtil();
  String lang;
   CustomBusyRestaurantWidget(
      {Key key, this.vendors, this.lang})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 200.h,
              width: MediaQuery.of(context).size.width,
              // decoration: BoxDecoration(
              //     //  borderRadius: BorderRadius.circular(10),
              //     ),
              child: CachedNetworkImage(
                width: double.infinity,
                height: 200.h,
                imageUrl:TAG_IMAGE_URL+vendors.header,
                imageBuilder: (context, imageProvider) => Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.w),
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
            Align(
              alignment: Alignment.center,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.w),
                  color: blackColor.withOpacity(0.7),
                ),
                height: 200.h,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child:
              Container(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Text(
                    getTranslated(context, 'busy'),
                    style: GoogleFonts.roboto(color: whiteColor),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        Text(
          lang == "en"?vendors.enShop:vendors.arShop,
          style: GoogleFonts.roboto(fontSize: screenUtil.setSp(20), fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5.h,
        ),
        Text(
          lang == "en"?vendors.enDetails:vendors.arDetails,
          style: GoogleFonts.roboto(
              fontSize: screenUtil.setSp(15), fontWeight: FontWeight.normal, color: greyColor),
        ),
        SizedBox(
          height: 20.h,
        ),
      ],
    );
  }
}

class CustomNewRestaurantWidget extends StatelessWidget {

  Vendors vendors;
  ScreenUtil screenUtil = ScreenUtil();
  String lang;
   CustomNewRestaurantWidget(
      {Key key,this.vendors,this.lang})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.w)),
          child: Stack(
            children: [
              Container(
                height: screenUtil.screenHeight,
                width: MediaQuery.of(context).size.width,
                // decoration: BoxDecoration(
                //     //   borderRadius: BorderRadius.circular(10),
                //     ),
                child: CachedNetworkImage(
                  width: double.infinity,
                  height: screenUtil.screenHeight,
                  imageUrl:TAG_IMAGE_URL+vendors.header,
                  imageBuilder: (context, imageProvider) => Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.w),
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

              Align(
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        padding: EdgeInsets.all(5.w),
                        margin: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(5.w),
                        ),
                        child: Text(
                          "New",
                          style: GoogleFonts.roboto(
                              fontSize: screenUtil.setSp(13), color: whiteColor),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child:
                      Container(
                        alignment: Alignment.bottomRight,
                        width: 100.w,
                        margin: EdgeInsets.only(right: 10.w, top: 100.h),
                        padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(20.w),
                        ),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Center(
                            child:
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Image.asset(
                                  "assets/icons/time.png",
                                  height: 15,
                                  width: 15,
                                  fit: BoxFit.fill,
                                ),
                                Text(
                                  vendors.delivery,
                                  style: GoogleFonts.roboto(fontSize: screenUtil.setSp(12)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Text(
          lang == "en"?vendors.enShop:vendors.arShop,
          style: GoogleFonts.roboto(fontSize: screenUtil.setSp(20), fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5.h,
        ),
        Text(
          lang == "en"?vendors.enDetails:vendors.arDetails,
          style: GoogleFonts.roboto(
              fontSize: screenUtil.setSp(15), fontWeight: FontWeight.normal, color: greyColor),
        ),
        SizedBox(
          height: 20.h,
        ),
      ],
    );
  }
}

class RestaurantWidget extends StatelessWidget{
  Vendors vendors;
  ScreenUtil screenUtil = ScreenUtil();
  String lang;
  RestaurantWidget(
      {Key key,this.vendors,this.lang})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
 
    return Container(
      height: 250.h,
      width: screenUtil.screenWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Container(
            child: Stack(
              children: [
                CachedNetworkImage(
                  width: double.infinity,
                  height: screenUtil.screenHeight,
                  imageUrl:TAG_IMAGE_URL+vendors.header,
                  imageBuilder: (context, imageProvider) => Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.w),
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
                            height: 50.h,
                            width: 50.h,
                            child: new CircularProgressIndicator()),
                      ),


                  errorWidget: (context, url, error) => ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset('assets/images/logo.png',
                        fit: BoxFit.fill,)),

                ),

                Container(
                  child:  vendors.isBusy != "0"?
                  Container(

                    alignment: AlignmentDirectional.center,


                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.w),
                      color: blackColor.withOpacity(0.7),
                    ),
                    height: screenUtil.screenHeight,
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                     getTranslated(context, 'busy'),
                      style: GoogleFonts.roboto(color: whiteColor,fontSize: screenUtil.setSp(12)) ,

                    )
                  ):Container(

                  ),
                ),
                Positioned.directional(  textDirection:  Directionality.of(context),
                    child: vendors.isNew != "0"?
                    Container(
                  padding: EdgeInsets.all(5.w),

                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(5.w),
                  ),
                  child: Text(
                    getTranslated(context, 'new'),
                    style: GoogleFonts.roboto(
                        fontSize: screenUtil.setSp(13), color: whiteColor),
                  ),
                ):Container()
                    ,top: 10.h,start: 10.w,),
                Positioned.directional(textDirection: Directionality.of(context), child:
                Container(
                  padding: EdgeInsets.symmetric(vertical: 6.h,horizontal: 15.w),
                 
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(20.w),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Image.asset(
                        "assets/icons/time.png",
                        height: 15,
                        width: 15,
                        fit: BoxFit.fill,
                      ),
                      SizedBox(width: 10.h,),
                      Text(
                        vendors.delivery,
                        style: GoogleFonts.roboto(fontSize: screenUtil.setSp(12)),
                      ),
                    ],
                  ),
                ),
                bottom: 6.h,
                end: 6.w,)


              ],
            ),
          ),flex: 4,),
          Expanded(child: Container(
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                SizedBox(
                  height: 5.h,
                ),
                Text(

                  lang == "en"?vendors.enShop:vendors.arShop,
                  style: GoogleFonts.roboto(fontSize: screenUtil.setSp(15), fontWeight: FontWeight.bold),
                  textAlign:TextAlign.start,
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  lang == "en"?vendors.enDetails:vendors.arDetails,
                  style: GoogleFonts.roboto(
                      fontSize: screenUtil.setSp(10), fontWeight: FontWeight.normal, color: greyColor),
                  textAlign:TextAlign.start,

                ),
              ],
            ),
          ),flex: 1,)
          
        ],
      ),
      
    );
  }
}
