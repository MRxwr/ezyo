import 'package:ezyo/Config/Colors.dart';
import 'package:ezyo/Models/cart_model.dart';
import 'package:ezyo/Models/vendor_model.dart';
import 'package:ezyo/Src/Cart/view_order_screen.dart';
import 'package:ezyo/Utils/helper.dart';
import 'package:ezyo/Widgets/action_icon.dart';
import 'package:ezyo/Widgets/customButton.dart';
import 'package:ezyo/Widgets/customHeaderHomeWidget.dart';
import 'package:ezyo/Widgets/custom_swipe_widget.dart';
import 'package:ezyo/localization/localization_methods.dart';
import 'package:ezyo/providers/cart_notifier.dart';
import 'package:ezyo/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class RestaurantSingleProductScreen extends StatefulWidget {
  Items item;
  String language;
  String vendorId;
  String vendorNameAr;
  String vendorNameEn;
  String vendorImage;
  List<String> times;
  String startDate;
   RestaurantSingleProductScreen({Key key,@required this.item,@required this.language,@required this.vendorId,@required this.vendorNameAr,@required this.vendorNameEn,@required this.vendorImage,@required this.times,@required this.startDate}) : super(key: key);

  @override
  _RestaurantSingleProductScreenState createState() =>
      _RestaurantSingleProductScreenState();
}

class _RestaurantSingleProductScreenState
    extends State<RestaurantSingleProductScreen> {
  ScreenUtil screenUtil = ScreenUtil();
  int activeIndex = 0;
  int  quantity = 1;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final TextEditingController _nameController = new TextEditingController();
  String itemPrice = '0.0';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    itemPrice = '${double.parse(widget.item.price)-(double.parse(widget.item.price)*(double.parse(widget.item.discount)/100))}';

  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: true,
        body: Container(
          height: Helper.setHeight(context),
          child: Stack(
            children: [
              Image.asset(
                "assets/images/bg.png",
                height: Helper.setHeight(context),
                width: Helper.setWidth(context),
                fit: BoxFit.cover,
              ),
              CustomScrollView(
                slivers: [
                  SliverAppBar(
                    backgroundColor: primaryColor,
                    expandedHeight: 250,
                    flexibleSpace: FlexibleSpaceBar(
                      background:
                      CustomSwipeWidget(
                        onPageChanged: (index, reason) {
                          setState(() {
                            activeIndex = index;
                          });
                        },
                        images: widget.item.images,
                        activeIndex: activeIndex,
                      )

                      // Image.asset(
                      //   "assets/images/2.png",
                      //   fit: BoxFit.cover,
                      // ),
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
                        child: Icon(
                          Icons.close,
                          color: whiteColor,
                          size: 20.w,
                        ),
                      ),
                    ),
                    actions: [

                      GestureDetector(
                        onTap: (){
                          // cart();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ViewOrderScreen()));

                        },
                        child:
                        Consumer<CartNotifier>(
                          builder: (context,cart,child){
                            return NamedIcon(

                              iconData: Icons.notifications,


                              notificationCount:  cart.cartModelList.length,);
                          },


                        ),


                      ),
                      SizedBox(width: 5.w,),




                    ],
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.65,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                height: 30.h,
                              ),
                              Text(
                                widget.language == "en"?widget.item.enTitle:widget.item.arTitle,
                                style: GoogleFonts.roboto(
                                    fontSize: screenUtil.setSp(20),
                                    color: blackColor,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                widget.language == "en"?widget.item.enDetails:widget.item.arDetails,
                                style: GoogleFonts.roboto(
                                    fontSize: screenUtil.setSp(15), color: greyColor),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Text(
                                '${double.parse(itemPrice) *quantity } ${getTranslated(context, 'kwd')}',
                                style: GoogleFonts.roboto(
                                    fontSize: screenUtil.setSp(20),
                                    color: primaryColor,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(height: 30.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      quantity++;
                                      setState(() {

                                      });
                                    },
                                    child: CircleAvatar(
                                      radius: 15.w,
                                      backgroundColor: primaryColor,
                                      child: Icon(
                                        Icons.add,
                                        color: whiteColor,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15.w,
                                  ),
                                  Text(
                                    quantity.toString(),
                                    style: GoogleFonts.roboto(
                                        fontSize: screenUtil.setSp(20),
                                        color: blackColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    width: 15.w,
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      if(quantity>1){
                                        quantity--;
                                      }

                                      setState(() {

                                      });
                                    },
                                    child: CircleAvatar(
                                      radius: 15.w,
                                      backgroundColor: primaryColor,
                                      child: Icon(
                                        Icons.remove,
                                        color: whiteColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 30.h,
                              ),
                              Text(
                                getTranslated(context, 'special_order'),
                                style: GoogleFonts.roboto(
                                    fontSize: screenUtil.setSp(20),
                                    color: blackColor,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 25.h),
                              Container(
                                padding: EdgeInsets.only(left: 10.w, right: 10.w),
                                margin: EdgeInsets.only(left: 20.w, right: 20.w),
                                height:
                                    MediaQuery.of(context).size.height * 0.18,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: whiteColor,
                                  border: Border.all(
                                      color: greyColor.withOpacity(0.4)),
                                ),
                                child: TextField(
                                  keyboardType: TextInputType.multiline,
                                  controller: this._nameController,
                                  minLines: 2,
                                  maxLines: 7,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: getTranslated(context, 'special_order_optional')),
                                  cursorColor: primaryColor,
                                ),
                              ),
                            ],
                          ),

                          Padding(
                            padding:  EdgeInsets.only(left:8.w,right: 8.w),
                            child:
                            CustomButton(
                              isColored: true,
                              onPressed: () {

                                addtoCart(context);
                              },
                              child: Center(
                                  child: Text(
                                getTranslated(context, 'add_to_cart'),
                                style: GoogleFonts.roboto(
                                    fontSize: screenUtil.setSp(12), color: whiteColor),
                              )),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addtoCart(BuildContext context) {
    List<CartModel >  cartModelList = Provider.of<CartNotifier>(context,listen: false).cartModelList;
    if(cartModelList.isNotEmpty){
      String vendor = cartModelList[0].vendorId;
      if(vendor  == widget.vendorId){
        addCart();
      }else{
        ShowPostAlertDialog(context,getTranslated(context, 'empty_cart'));
      }

    }else{
      addCart();
    }





  }
void addCart(){
  String specialOrder = _nameController.text;

  CartModel cartModel = CartModel(tileAr:widget.item.arTitle,titleEn:widget.item.enTitle,descriptionAr:widget.item.arDetails,descriptionEn:widget.item.enDetails,
      imageUrl:widget.item.images[0],id:widget.item.id,vendorId:widget.vendorId,orderNote:specialOrder,
      quantity:quantity,price:widget.item.price.toString(),discount:widget.item.discount,finalPrice: itemPrice,vendorTitleAr: widget.vendorNameAr,
      vendorTitleEn: widget.vendorNameEn,vendorImage: widget.vendorImage,times: widget.times,startDate: widget.startDate);

   Provider.of<CartNotifier>(context,listen: false).addCart(cartModel);
  print(Provider.of<CartNotifier>(context,listen: false).cartModelList.length);
  _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(getTranslated(context, 'item_added'))));
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
           getTranslated(context, 'yes'),
            style: TextStyle(color: Color(0xFFFFFFFF), fontSize: screenUtil.setSp(18)),
          ),
          onPressed: ()async {
            await alert.dismiss();
            Provider.of<CartNotifier>(context,listen: false).clearCart();
           addCart();

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
            Navigator.pop(context);

          },
          color:kMainColor,
          radius: BorderRadius.circular(6.w),
        )
      ],
    );
    alert.show();

  }

}
