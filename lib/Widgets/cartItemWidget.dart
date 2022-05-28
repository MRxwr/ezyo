import 'package:cached_network_image/cached_network_image.dart';
import 'package:ezyo/Config/Colors.dart';
import 'package:ezyo/Models/cart_model.dart';
import 'package:ezyo/localization/localization_methods.dart';
import 'package:ezyo/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CartItemWidget extends StatelessWidget {
  final String orderQuantity;
  final String imagePath;
  final String itemTitle;
  final String specialNotes;
  final String price;
  final Function onDelete;
  final CartModel cartModel;
  final String mLanguage;
  const CartItemWidget({
    Key key,
    this.orderQuantity,
    this.imagePath,
    this.itemTitle,
    this.specialNotes,
    this.price,
    this.onDelete,
    this.cartModel,
    this.mLanguage
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil screenUtil  = ScreenUtil();
    return Container(

      margin: EdgeInsets.only(left: 10.w, right: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //item quantity and item Row
          Row(
            children: [
              //Quantity of Item
              Container(
                padding: EdgeInsets.all(3.w),
                decoration: BoxDecoration(
                    border: Border.all(color: greyColor.withOpacity(0.4)),
                    borderRadius: BorderRadius.circular(3)),
                child: Text(
                  cartModel.quantity.toString(),
                  style: GoogleFonts.roboto(fontSize: screenUtil.setSp(12)),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              CachedNetworkImage(
                height: 40.w,
                width: 40.w,
                imageUrl:TAG_IMAGE_URL+cartModel.imageUrl,
                imageBuilder: (context, imageProvider) => Stack(
                  children: [
                    Container(
                      height: 40.w,
                      width: 40.w,
                      child: ClipRRect(

                          borderRadius: BorderRadius.circular(4.w),
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
                          height: 20.h,
                          width: 20.h,
                          child: new CircularProgressIndicator()),
                    ),


                errorWidget: (context, url, error) => ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.asset('assets/images/logo.png',
                      fit: BoxFit.fill,)),

              ),
              //Image of the item

              SizedBox(
                width: 10.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Name of the item
                  Text(mLanguage == "en"?cartModel.titleEn:cartModel.tileAr,
                      style:
                          GoogleFonts.roboto(fontSize: screenUtil.setSp(11), color: blackColor)),
                  SizedBox(
                    height: 5.h,
                  ),
                  //Special Notes of the item
                  Text(cartModel.orderNote,
                      style: GoogleFonts.roboto(
                          fontSize: screenUtil.setSp(11), color: blackColor.withOpacity(0.4))),
                ],
              ),
            ],
          ),
          // Price and Cross Row
          Row(
            children: [
              //Price of the item
              Text(
                '${double.parse(cartModel.finalPrice)*cartModel.quantity}' + " ${getTranslated(context, 'kwd')}",
                style: GoogleFonts.roboto(fontSize: screenUtil.setSp(12)),
              ),
              SizedBox(
                width: 10.w,
              ),
              //Delete the item
              GestureDetector(
                onTap: onDelete,
                child: Icon(
                  Icons.close,
                  size: 15.w,
                  color: blackColor.withOpacity(0.3),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
