import 'package:ezyo/Config/Colors.dart';
import 'package:ezyo/Models/add_address_model.dart' as AddAddress;
import 'package:ezyo/Src/Checkout/checkout-screen.dart';
import 'package:ezyo/Utils/helper.dart';
import 'package:ezyo/Widgets/customAppBar.dart';
import 'package:ezyo/Widgets/customButton.dart';
import 'package:ezyo/Widgets/titleandBoxDropDown.dart';
import 'package:ezyo/Widgets/titleandBoxTextField.dart';
import 'package:ezyo/Widgets/titleandTextfield.dart';
import 'package:ezyo/apis/ezyo_services.dart';
import 'package:ezyo/localization/localization_methods.dart';
import 'package:ezyo/providers/model_hud.dart';
import 'package:ezyo/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geocoder/geocoder.dart';
import 'package:intl/intl.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AddressScreen extends StatefulWidget {
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
   AddressScreen({Key key}) : super(key: key);

  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  LocationData _currentPosition;
  String _address,_dateTime;
  GoogleMapController mapController;
  Marker marker;
  Location location = Location();

  GoogleMapController _controller;
  LatLng _initialcameraposition = LatLng(29.378586, 47.990341);
  List<Marker> _markers = <Marker>[];


  List countries = ["Kuwait", "United States", "Pakistan", "China"];
  String currentSelectedCountry = "Kuwait";
  List areas = [
    "Al Ahmadi",
    "Hawalli",
    "Şabāḩ as Sālim",
    "Mubārak al Kabīr",
    "Al Farwaniyah"
  ];
  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _phoneController = new TextEditingController();
  final TextEditingController _CountryCountroller = new TextEditingController();
  final TextEditingController _AreaController = new TextEditingController();

  final TextEditingController _BlockController = new TextEditingController();
  final TextEditingController _StreetController = new TextEditingController();
  final TextEditingController _HouseNoController = new TextEditingController();
  final TextEditingController _AvenueController = new TextEditingController();
  final TextEditingController _FloorController = new TextEditingController();
  final TextEditingController _FlatController = new TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String currentSelectedArea = "Al Ahmadi";

  ScreenUtil screenUtil = ScreenUtil();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _CountryCountroller.text = "Kuwait";
  }
  void _onMapCreated(GoogleMapController _cntlr)
  {
    _controller = _cntlr;



    // location.onLocationChanged.listen((l) {
    //   _controller.animateCamera(
    //     CameraUpdate.newCameraPosition(
    //       CameraPosition(target: LatLng(l.latitude, l.longitude),zoom: 15),
    //     ),
    //   );
    // });
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil screenUtil = ScreenUtil();
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: ModalProgressHUD(
        inAsyncCall: Provider.of<ModelHud>(context).isLoading,
        child: Scaffold(
          key: _scaffoldKey,
          appBar: customAppBar(
              context: context, appBarTitle: getTranslated(context, 'address_string'), isLeading: true),
          body: Form(
            key: widget._globalKey,
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    Container(
                        margin: EdgeInsets.all(30),
                        child: Column(
                          children: [


                            //Here we need to incorporate map for the user
                            Container(
                              height: 80.h,
                              child: GoogleMap(
                                initialCameraPosition: CameraPosition(target: _initialcameraposition,
                                    zoom: 15),
                                mapType: MapType.normal,


                                onMapCreated: _onMapCreated,
                                myLocationEnabled: true,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            //Here we will implement Geo Locator to get the current Location of the user
                            Row(
                              children: [
                                Icon(Icons.my_location),
                                SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  onTap: (){
                                    getLoc();
                                  },
                                  child: Text(
                                    getTranslated(context, 'locate_me'),
                                    style: GoogleFonts.roboto(
                                        color: primaryColor,
                                        decoration: TextDecoration.underline),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            //Here are the remaining fields to get the data from the user
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                           getTranslated(context, 'name'),
                            style: TextStyle(color: blackColor, fontSize: screenUtil.setSp(15)),
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          TextFormField(
                            validator: validateName,
                            textAlign: TextAlign.start,
                            textCapitalization: TextCapitalization.words,
                            keyboardType: TextInputType.name ,

                            textInputAction: TextInputAction.next,
                            maxLines: 1,
                            minLines: 1,
                            controller: this._nameController,
                            style:TextStyle(
                                color: blackColor,
                                fontSize: screenUtil.setSp(15),
                                fontWeight: FontWeight.normal
                            ) ,
                            decoration: new InputDecoration(
                              contentPadding: EdgeInsets.all(6.w),
                              hintText: getTranslated(context, 'name_string'),
                              hintStyle: TextStyle(
                                  color: Color(0xFF747474),
                                  fontSize: screenUtil.setSp(15),
                                  fontWeight: FontWeight.normal
                              ),

                              labelStyle: new TextStyle(color: const Color(0xFF424242)),
                              enabledBorder:      OutlineInputBorder(

                                  borderSide: BorderSide(
                                      color: Color(0x88707070)
                                      ,width: 1
                                  )
                              ),
                              focusedBorder: OutlineInputBorder(

                                  borderSide: BorderSide(
                                      color: Color(0x88707070)
                                      ,width: 1
                                  )
                              ),
                              border: OutlineInputBorder(

                                  borderSide: BorderSide(
                                      color: Color(0xFFFF0000)
                                      ,width: 1
                                  )
                              ),
                            ),
                          )
                        ],
                      ),

                            SizedBox(
                              height: 10.h,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  getTranslated(context, 'country'),
                                  style: TextStyle(color: blackColor, fontSize: screenUtil.setSp(15)),
                                ),
                                SizedBox(
                                  height: 4.h,
                                ),
                                TextFormField(
                                  enabled: false,

                                  textAlign: TextAlign.start,
                                  textCapitalization: TextCapitalization.words,
                                  keyboardType: TextInputType.name ,
                                  style:TextStyle(
                                      color: blackColor,
                                      fontSize: screenUtil.setSp(15),
                                      fontWeight: FontWeight.normal
                                  ) ,

                                  textInputAction: TextInputAction.next,
                                  maxLines: 1,
                                  minLines: 1,
                                  controller: this._CountryCountroller,
                                  decoration: new InputDecoration(
                                    contentPadding: EdgeInsets.all(6.w),
                                    hintText: getTranslated(context, 'country'),
                                    hintStyle: TextStyle(
                                        color: Color(0xFF747474),
                                        fontSize: screenUtil.setSp(15),
                                        fontWeight: FontWeight.normal
                                    ),

                                    labelStyle: new TextStyle(color: const Color(0xFF424242)),
                                    enabledBorder:      OutlineInputBorder(

                                        borderSide: BorderSide(
                                            color: Color(0x88707070)
                                            ,width: 1
                                        )
                                    ),
                                    focusedBorder: OutlineInputBorder(

                                        borderSide: BorderSide(
                                            color: Color(0x88707070)
                                            ,width: 1
                                        )
                                    ),
                                    border: OutlineInputBorder(

                                        borderSide: BorderSide(
                                            color: Color(0xFFFF0000)
                                            ,width: 1
                                        )
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                 getTranslated(context, 'area'),
                                  style: TextStyle(color: blackColor, fontSize: screenUtil.setSp(15)),
                                ),
                                SizedBox(
                                  height: 4.h,
                                ),
                                TextFormField(
                                  validator: validateName,
                                  textAlign: TextAlign.start,
                                  textCapitalization: TextCapitalization.words,
                                  keyboardType: TextInputType.name ,
                                  style:TextStyle(
                                      color: blackColor,
                                      fontSize: screenUtil.setSp(15),
                                      fontWeight: FontWeight.normal
                                  ) ,

                                  textInputAction: TextInputAction.next,
                                  maxLines: 1,
                                  minLines: 1,
                                  controller: this._AreaController,
                                  decoration: new InputDecoration(
                                    contentPadding: EdgeInsets.all(6.w),
                                    hintText: getTranslated(context, 'area_string'),
                                    hintStyle: TextStyle(
                                        color: Color(0xFF747474),
                                        fontSize: screenUtil.setSp(15),
                                        fontWeight: FontWeight.normal
                                    ),

                                    labelStyle: new TextStyle(color: const Color(0xFF424242)),
                                    enabledBorder:      OutlineInputBorder(

                                        borderSide: BorderSide(
                                            color: Color(0x88707070)
                                            ,width: 1
                                        )
                                    ),
                                    focusedBorder: OutlineInputBorder(

                                        borderSide: BorderSide(
                                            color: Color(0x88707070)
                                            ,width: 1
                                        )
                                    ),
                                    border: OutlineInputBorder(

                                        borderSide: BorderSide(
                                            color: Color(0xFFFF0000)
                                            ,width: 1
                                        )
                                    ),
                                  ),
                                )
                              ],
                            ),

                            SizedBox(
                              height: 10.h,
                            ),
                            // Block and Street
                            Container(
                              child: Row(
                                children: [
                                  Expanded(
                                    child:  Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          getTranslated(context, 'block'),
                                          style: TextStyle(color: blackColor, fontSize: screenUtil.setSp(15)),
                                        ),
                                        SizedBox(
                                          height: 4.h,
                                        ),
                                        TextFormField(
                                          validator: validateName,
                                          textAlign: TextAlign.start,
                                          textCapitalization: TextCapitalization.words,
                                          keyboardType: TextInputType.name ,
                                          style:TextStyle(
                                              color: blackColor,
                                              fontSize: screenUtil.setSp(15),
                                              fontWeight: FontWeight.normal
                                          ) ,

                                          textInputAction: TextInputAction.next,
                                          maxLines: 1,
                                          minLines: 1,
                                          controller: this._BlockController,
                                          decoration: new InputDecoration(
                                            contentPadding: EdgeInsets.all(6.w),
                                            hintText: getTranslated(context, 'block_string'),
                                            hintStyle: TextStyle(
                                                color: Color(0xFF747474),
                                                fontSize: screenUtil.setSp(15),
                                                fontWeight: FontWeight.normal
                                            ),

                                            labelStyle: new TextStyle(color: const Color(0xFF424242)),
                                            enabledBorder:      OutlineInputBorder(

                                                borderSide: BorderSide(
                                                    color: Color(0x88707070)
                                                    ,width: 1
                                                )
                                            ),
                                            focusedBorder: OutlineInputBorder(

                                                borderSide: BorderSide(
                                                    color: Color(0x88707070)
                                                    ,width: 1
                                                )
                                            ),
                                            border: OutlineInputBorder(

                                                borderSide: BorderSide(
                                                    color: Color(0xFFFF0000)
                                                    ,width: 1
                                                )
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Expanded(
                                    child:
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          getTranslated(context, 'street'),
                                          style: TextStyle(color: blackColor, fontSize: screenUtil.setSp(15)),
                                        ),
                                        SizedBox(
                                          height: 4.h,
                                        ),
                                        TextFormField(
                                          validator: validateName,
                                          textAlign: TextAlign.start,
                                          textCapitalization: TextCapitalization.words,
                                          keyboardType: TextInputType.name ,
                                          style:TextStyle(
                                              color: blackColor,
                                              fontSize: screenUtil.setSp(15),
                                              fontWeight: FontWeight.normal
                                          ) ,

                                          textInputAction: TextInputAction.next,
                                          maxLines: 1,
                                          minLines: 1,
                                          controller: this._StreetController,
                                          decoration: new InputDecoration(
                                            contentPadding: EdgeInsets.all(6.w),
                                            hintText: getTranslated(context, 'street_string'),
                                            hintStyle: TextStyle(
                                                color: Color(0xFF747474),
                                                fontSize: screenUtil.setSp(15),
                                                fontWeight: FontWeight.normal
                                            ),

                                            labelStyle: new TextStyle(color: const Color(0xFF424242)),
                                            enabledBorder:      OutlineInputBorder(

                                                borderSide: BorderSide(
                                                    color: Color(0x88707070)
                                                    ,width: 1
                                                )
                                            ),
                                            focusedBorder: OutlineInputBorder(

                                                borderSide: BorderSide(
                                                    color: Color(0x88707070)
                                                    ,width: 1
                                                )
                                            ),
                                            border: OutlineInputBorder(

                                                borderSide: BorderSide(
                                                    color: Color(0xFFFF0000)
                                                    ,width: 1
                                                )
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                  SizedBox(
                    height: 10.h,
                  ),
                            // House No and Avenue
                            Container(
                              child: Row(
                                children: [
                                  Expanded(
                                    child:
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          getTranslated(context, 'house_no'),
                                          style: TextStyle(color: blackColor, fontSize: screenUtil.setSp(15)),
                                        ),
                                        SizedBox(
                                          height: 4.h,
                                        ),
                                        TextFormField(
                                          validator: validateName,
                                          textAlign: TextAlign.start,
                                          textCapitalization: TextCapitalization.words,
                                          keyboardType: TextInputType.name ,
                                          style:TextStyle(
                                              color: blackColor,
                                              fontSize: screenUtil.setSp(15),
                                              fontWeight: FontWeight.normal
                                          ) ,

                                          textInputAction: TextInputAction.next,
                                          maxLines: 1,
                                          minLines: 1,
                                          controller: this._HouseNoController,
                                          decoration: new InputDecoration(
                                            contentPadding: EdgeInsets.all(6.w),
                                            hintText: getTranslated(context, 'house_string'),
                                            hintStyle: TextStyle(
                                                color: Color(0xFF747474),
                                                fontSize: screenUtil.setSp(15),
                                                fontWeight: FontWeight.normal
                                            ),

                                            labelStyle: new TextStyle(color: const Color(0xFF424242)),
                                            enabledBorder:      OutlineInputBorder(

                                                borderSide: BorderSide(
                                                    color: Color(0x88707070)
                                                    ,width: 1
                                                )
                                            ),
                                            focusedBorder: OutlineInputBorder(

                                                borderSide: BorderSide(
                                                    color: Color(0x88707070)
                                                    ,width: 1
                                                )
                                            ),
                                            border: OutlineInputBorder(

                                                borderSide: BorderSide(
                                                    color: Color(0xFFFF0000)
                                                    ,width: 1
                                                )
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          getTranslated(context, 'avenue'),
                                          style: TextStyle(color: blackColor, fontSize: screenUtil.setSp(15)),
                                        ),
                                        SizedBox(
                                          height: 4.h,
                                        ),
                                        TextFormField(

                                          textAlign: TextAlign.start,
                                          textCapitalization: TextCapitalization.words,
                                          keyboardType: TextInputType.name ,
                                          style:TextStyle(
                                              color: blackColor,
                                              fontSize: screenUtil.setSp(15),
                                              fontWeight: FontWeight.normal
                                          ) ,

                                          textInputAction: TextInputAction.next,
                                          maxLines: 1,
                                          minLines: 1,
                                          controller: this._AvenueController,
                                          decoration: new InputDecoration(
                                            contentPadding: EdgeInsets.all(6.w),
                                            hintText: getTranslated(context, 'avenue'),
                                            hintStyle: TextStyle(
                                                color: Color(0xFF747474),
                                                fontSize: screenUtil.setSp(15),
                                                fontWeight: FontWeight.normal
                                            ),

                                            labelStyle: new TextStyle(color: const Color(0xFF424242)),
                                            enabledBorder:      OutlineInputBorder(

                                                borderSide: BorderSide(
                                                    color: Color(0x88707070)
                                                    ,width: 1
                                                )
                                            ),
                                            focusedBorder: OutlineInputBorder(

                                                borderSide: BorderSide(
                                                    color: Color(0x88707070)
                                                    ,width: 1
                                                )
                                            ),
                                            border: OutlineInputBorder(

                                                borderSide: BorderSide(
                                                    color: Color(0xFFFF0000)
                                                    ,width: 1
                                                )
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Expanded(
                                    child:   Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          getTranslated(context, 'floor'),
                                          style: TextStyle(color: blackColor, fontSize: screenUtil.setSp(15)),
                                        ),
                                        SizedBox(
                                          height: 4.h,
                                        ),
                                        TextFormField(

                                          textAlign: TextAlign.start,
                                          textCapitalization: TextCapitalization.words,
                                          keyboardType: TextInputType.name ,
                                          style:TextStyle(
                                              color: blackColor,
                                              fontSize: screenUtil.setSp(15),
                                              fontWeight: FontWeight.normal
                                          ) ,

                                          textInputAction: TextInputAction.next,
                                          maxLines: 1,
                                          minLines: 1,
                                          controller: this._FloorController,
                                          decoration: new InputDecoration(
                                            contentPadding: EdgeInsets.all(6.w),
                                            hintText: getTranslated(context, 'floor'),
                                            hintStyle: TextStyle(
                                                color: Color(0xFF747474),
                                                fontSize: screenUtil.setSp(15),
                                                fontWeight: FontWeight.normal
                                            ),

                                            labelStyle: new TextStyle(color: const Color(0xFF424242)),
                                            enabledBorder:      OutlineInputBorder(

                                                borderSide: BorderSide(
                                                    color: Color(0x88707070)
                                                    ,width: 1
                                                )
                                            ),
                                            focusedBorder: OutlineInputBorder(

                                                borderSide: BorderSide(
                                                    color: Color(0x88707070)
                                                    ,width: 1
                                                )
                                            ),
                                            border: OutlineInputBorder(

                                                borderSide: BorderSide(
                                                    color: Color(0xFFFF0000)
                                                    ,width: 1
                                                )
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          getTranslated(context, 'flat'),
                                          style: TextStyle(color: blackColor, fontSize: screenUtil.setSp(15)),
                                        ),
                                        SizedBox(
                                          height: 4.h,
                                        ),
                                        TextFormField(

                                          textAlign: TextAlign.start,
                                          textCapitalization: TextCapitalization.words,
                                          keyboardType: TextInputType.name ,
                                          style:TextStyle(
                                              color: blackColor,
                                              fontSize: screenUtil.setSp(15),
                                              fontWeight: FontWeight.normal
                                          ) ,

                                          textInputAction: TextInputAction.next,
                                          maxLines: 1,
                                          minLines: 1,
                                          controller: this._FlatController,
                                          decoration: new InputDecoration(
                                            contentPadding: EdgeInsets.all(6.w),
                                            hintText: getTranslated(context, 'flat'),
                                            hintStyle: TextStyle(
                                                color: Color(0xFF747474),
                                                fontSize: screenUtil.setSp(15),
                                                fontWeight: FontWeight.normal
                                            ),

                                            labelStyle: new TextStyle(color: const Color(0xFF424242)),
                                            enabledBorder:      OutlineInputBorder(

                                                borderSide: BorderSide(
                                                    color: Color(0x88707070)
                                                    ,width: 1
                                                )
                                            ),
                                            focusedBorder: OutlineInputBorder(

                                                borderSide: BorderSide(
                                                    color: Color(0x88707070)
                                                    ,width: 1
                                                )
                                            ),
                                            border: OutlineInputBorder(

                                                borderSide: BorderSide(
                                                    color: Color(0xFFFF0000)
                                                    ,width: 1
                                                )
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                  SizedBox(
                    height: 10.h,
                  ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  getTranslated(context, 'mobile_no'),
                                  style: TextStyle(color: blackColor, fontSize: screenUtil.setSp(15)),
                                ),
                                SizedBox(
                                  height: 4.h,
                                ),
                                TextFormField(
                                  validator: validatePhone,
                                  textAlign: TextAlign.start,
                                  textCapitalization: TextCapitalization.words,
                                  keyboardType: TextInputType.phone ,
                                  style:TextStyle(
                                      color: blackColor,
                                      fontSize: screenUtil.setSp(15),
                                      fontWeight: FontWeight.normal
                                  ) ,

                                  textInputAction: TextInputAction.done,
                                  maxLines: 1,
                                  minLines: 1,
                                  controller: this._phoneController,
                                  decoration: new InputDecoration(
                                    contentPadding: EdgeInsets.all(6.w),
                                    hintText: getTranslated(context, 'Mobile Number'),
                                    hintStyle: TextStyle(
                                        color: Color(0xFF747474),
                                        fontSize: screenUtil.setSp(15),
                                        fontWeight: FontWeight.normal
                                    ),

                                    labelStyle: new TextStyle(color: const Color(0xFF424242)),
                                    enabledBorder:      OutlineInputBorder(

                                        borderSide: BorderSide(
                                            color: Color(0x88707070)
                                            ,width: 1
                                        )
                                    ),
                                    focusedBorder: OutlineInputBorder(

                                        borderSide: BorderSide(
                                            color: Color(0x88707070)
                                            ,width: 1
                                        )
                                    ),
                                    border: OutlineInputBorder(

                                        borderSide: BorderSide(
                                            color: Color(0xFFFF0000)
                                            ,width: 1
                                        )
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        )),
                    Container(
                      margin: EdgeInsets.all(10.w),
                      child: CustomButton(
                        isColored: true,
                        onPressed: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => CheckoutScreen()));
                          validate(context);
                        },
                        child: Center(
                            child: Text(
                         getTranslated(context, 'add_address'),
                          style:
                              GoogleFonts.roboto(fontSize: screenUtil.setSp(12), color: Colors.white),
                        )),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  getLoc() async{
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _currentPosition = await location.getLocation();
    _initialcameraposition = LatLng(_currentPosition.latitude,_currentPosition.longitude);
    location.onLocationChanged.listen((LocationData currentLocation) {
      print("${currentLocation.longitude} : ${currentLocation.longitude}");
      setState(() {
        _currentPosition = currentLocation;
        var newPosition = CameraPosition(
            target: LatLng(_currentPosition.latitude, _currentPosition.longitude),
            zoom: 16);
        _initialcameraposition = LatLng(_currentPosition.latitude,_currentPosition.longitude);
        CameraUpdate update =CameraUpdate.newCameraPosition(newPosition);
        CameraUpdate zoom = CameraUpdate.zoomTo(16);

        _controller.moveCamera(update);

        DateTime now = DateTime.now();
        _dateTime = DateFormat('EEE d MMM kk:mm:ss ').format(now);
        _getAddress(_currentPosition.latitude, _currentPosition.longitude)
            .then((value) {
          setState(() {

            _CountryCountroller.text = value[0].countryName;
            _AreaController.text = value[0].adminArea;
            _StreetController.text = value[0].addressLine;
            _nameController.text = value[0].featureName;
            _AvenueController.text = value[0].subAdminArea;


            print(_address);
          });
        });
      });
    });
  }


  Future<List<Address>> _getAddress(double lat, double lang) async {
    final coordinates = new Coordinates(lat, lang);
    List<Address> add =
    await Geocoder.local.findAddressesFromCoordinates(coordinates);

    return add;
  }

  String validateName(String value) {

    if (value.trim().length ==0) {
      return "";
    }

    return null;
  }
  String validatePhone(String value) {
    String patttern = r'(^[0-9]{8}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "";
    }
    else if (!regExp.hasMatch(value)) {
      return "";
    }
    return null;





  }

  void validate(BuildContext context) async {

    if(widget._globalKey.currentState.validate()) {
      widget._globalKey.currentState.save();
      String name = _nameController.text;
      String country = _CountryCountroller.text;
      String area = _AreaController.text;
      String block = _BlockController.text;
      String street  = _StreetController.text;
      String houseNo =_HouseNoController.text;
      String avenue = _AvenueController.text;
      String floor = _FloorController.text;
      String flat  = _FlatController.text;
      String phone = _phoneController.text;
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      String userId = sharedPreferences.getString("id");
      final modelHud = Provider.of<ModelHud>(context, listen: false);
      modelHud.changeIsLoading(true);

      EzyoServices ezyoServices = EzyoServices();
      AddAddress.AddAddressModel addressModel = await  ezyoServices.addAddress(userId, name, country, area, block, street, houseNo, floor, flat, phone,avenue);
      modelHud.changeIsLoading(false);
      bool isOk =  addressModel.ok;
      if(isOk){
        ShowPostAlertDialog(context,addressModel.status);
      }

    }
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
            getTranslated(context, 'ok_string'),
            style: TextStyle(color: Color(0xFFFFFFFF), fontSize: screenUtil.setSp(18)),
          ),
          onPressed: ()async {
            await alert.dismiss();

            Navigator.of(context).pop({'selection':true});
          },
          color:kMainColor,
          radius: BorderRadius.circular(6.w),
        )
      ],
    );
    alert.show();

  }

}
