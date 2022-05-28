import 'package:cached_network_image/cached_network_image.dart';
import 'package:ezyo/Config/Colors.dart';
import 'package:ezyo/Config/delivery-Statuses.dart';
import 'package:ezyo/Src/TrackOrder/order_details_screen.dart';
import 'package:ezyo/localization/localization_methods.dart';
import 'package:ezyo/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'customDivider.dart';

class TrackOrderItem extends StatelessWidget {
  final String imagePath;
  final String itemTitle;
  final String delieveryStatus;
  final String orderId;
  final String price;
  final String dateTime;

  const TrackOrderItem(
      {Key key,
      this.imagePath,
      this.itemTitle,
      this.delieveryStatus,
      this.orderId,
      this.price,
      this.dateTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil screenUtil = ScreenUtil();
    return Container(

      child: Column(
        children: [

          Container(
            height: 100.h,
            margin: EdgeInsets.symmetric(vertical: 10.h,horizontal: 20.w),
            child: Row(

              children: [
                //item quantity and item Row
                Expanded(
                  flex:1,
                  child: CachedNetworkImage(
                  height: 50.w,
                    width: 50.w,
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
                ),

                Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //Name of the item
                              Expanded(
                                flex:1,
                                child: Text(itemTitle,
                                    style: GoogleFonts.roboto(
                                        fontSize: 20, color: blackColor)),
                              ),

                              //Special Notes of the item
                              Expanded(
                                flex: 1,
                                child: Text(delieveryStatus,
                                    style: GoogleFonts.roboto(
                                        fontSize: 12,
                                        color: delieveryStatus == delivered
                                            ? deliveredColor
                                            : delieveryStatus == preparing
                                                ? preparingColor
                                                : delieveryStatus == outForDelivery
                                                    ? outForDeliveryColor
                                                    : delieveryStatus == cancelled
                                                        ? cancelledDeliveryColor
                                                        : paidColor)),
                              ),

                              //Special Notes of the item
                              Expanded(
                                flex: 1,
                                child: Text("${getTranslated(context, 'order_id')} $orderId",
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
                        child: Text(dateTime,
                            style: GoogleFonts.roboto(
                                fontSize: 13, color: blackColor.withOpacity(0.4))),
                      ),

                      //Price of the item
                      Expanded(
                        flex: 1,
                        child: Text(
                          "$price",
                          style: GoogleFonts.roboto(fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          CustomDivider()
        ],
      ),
    );
  }
}
