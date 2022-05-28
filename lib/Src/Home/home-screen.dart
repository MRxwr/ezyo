

import 'package:ezyo/Config/Colors.dart';
import 'package:ezyo/Models/home_model.dart';
import 'package:ezyo/Src/Home/search_screen.dart';
import 'package:ezyo/Src/Restaurant/restaurantScreen.dart';
import 'package:ezyo/Src/RestaurantSingleProduct/restaurantSingleProductScreen.dart';
import 'package:ezyo/Utils/helper.dart';
import 'package:ezyo/Widgets/customHeaderHomeWidget.dart';
import 'package:ezyo/Widgets/customRestaurantHomeWidgets.dart';
import 'package:ezyo/apis/ezyo_services.dart';
import 'package:ezyo/localization/localization_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int activeIndex = 0;
  final TextEditingController _searchController = new TextEditingController();
  int groupValue = 1;
  TabController _dayTabBarController;
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  HomeModel homeModel;
  String language;
  @override
  List<Tags> tags  = List();
  List<bool> selected = List();
  List<Vendors> vendors = null;
  String tagId = "";
  String fitler ="";

  Future<HomeModel> home() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
     language = sharedPreferences.getString(LANG_CODE)??"en";
    EzyoServices ezyoServices = EzyoServices();
    HomeModel languageModel = await ezyoServices.home(language,"","");
    Tags tag = Tags(id: "",arTitle: "الكل",enTitle: "All",logo: "");

    tags = languageModel.data.tags;
    vendors = languageModel.data.vendors;
    tags.insert(0, tag);
    for(int i =0;i<tags.length;i++){
      if(i == 0){
        selected.add(true);
      }else{
        selected.add(false);
      }
    }

    return languageModel;

  }
  Future<List<Vendors>>getVendors()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    language = sharedPreferences.getString(LANG_CODE)??"en";
    EzyoServices ezyoServices = EzyoServices();
    HomeModel languageModel = await ezyoServices.home(language,tagId,fitler);
    return languageModel.data.vendors;
  }
  void initState() {
    super.initState();

    controller.addListener(() {
      setState(() {
        closeTopContainer = controller.offset > 50;
      });
    });
    home().then((value) {
      setState(() {

        homeModel = value;
        init();
      });

    });
  }

  init() {
    _dayTabBarController = TabController(length: homeModel.data.tags.length, vsync: this);
  }

  final images = [
    "assets/images/sample.png",
    "assets/images/3.png",
    "assets/images/1.png",
    "assets/images/3.png"
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil screenUtil = ScreenUtil();
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.all(20),
          child: homeModel == null?
          Container(
            child: CircularProgressIndicator(


            ),
            alignment: AlignmentDirectional.center,
          )
          :Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 20.h,),
              Container(
                child: RichText(
                  text: TextSpan(
                      text: getTranslated(context, 'eat'),
                      style: GoogleFonts.roboto(
                          color: blackColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                          text: " !",
                          style: GoogleFonts.roboto(
                              color: primaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )
                      ]),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        margin: EdgeInsets.only(left: 10),
                        child: GestureDetector(
                          onTap: (){
                            String searchText = _searchController.text;
                            if(searchText.trim() != ""){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SearchScreen(searchTxt: _searchController.text,)));
                            }else{
                              Scaffold.of(context).showSnackBar(SnackBar(content: Text(
                                getTranslated(context, 'enter_search_text')
                              )));

                            }

                          },
                          child: Icon(
                            Icons.search,
                            color: primaryColor,
                            size: 30,
                          ),
                        )),
                    Container(
                      height: 30,
                      width: 220,
                      child: TextFormField(
                        textAlign: TextAlign.start,
                        textCapitalization: TextCapitalization.words,
                        keyboardType: TextInputType.text ,
                        onFieldSubmitted: (text){
                          String searchText = _searchController.text;
                          if(searchText.trim() != ""){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        SearchScreen(searchTxt: _searchController.text,)));
                          }else{
                            Scaffold.of(context).showSnackBar(SnackBar(content: Text(
                                getTranslated(context, 'enter_search_text')
                            )));

                          }

                        },


                        textInputAction: TextInputAction.search,
                        maxLines: 1,
                        minLines: 1,

                        controller: _searchController,
                        decoration: InputDecoration(

                            hintText: getTranslated(context, 'search'),
                            hintStyle: GoogleFonts.roboto(
                                color: greyColor.withOpacity(0.4)),
                            contentPadding:
                                EdgeInsets.only(top: 10, bottom: 10),
                            border: InputBorder.none),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20))),
                            isScrollControlled: true,
                            context: context,
                            builder: (context) => Container(
                                  height:
                                      Helper.setHeight(context, height: 0.8),
                                  width: Helper.setWidth(context),
                                  margin: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Container(
                                          height: 10,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              color:
                                                  greyColor.withOpacity(0.2)),
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.only(top: 30, left: 30),
                                        child: Text(
                                          getTranslated(context, 'sort_by'),
                                          style: GoogleFonts.roboto(
                                              color: primaryColor,
                                              fontSize: 15),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 40,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 20),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Radio(
                                                  toggleable: true,
                                                  value: 1,
                                                  groupValue: groupValue,
                                                  activeColor: primaryColor,
                                                  onChanged: (int val) {
                                                    setState(() {
                                                      groupValue = val;
                                                    });
                                                    fitler ="";
                                                    vendors = null;
                                                    getVendors().then((value) {
                                                      vendors = value;
                                                      setState(() {

                                                      });

                                                    });

                                                    Navigator.pop(context);
                                                  },
                                                ),
                                                Container(
                                                    child: Text(getTranslated(context, 'recommended'),
                                                        style: GoogleFonts.roboto(
                                                            color: blackColor,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal))),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Radio(
                                                  toggleable: true,
                                                  value: 2,
                                                  groupValue: groupValue,
                                                  activeColor: primaryColor,
                                                  onChanged: (int val) {
                                                    setState(() {
                                                      groupValue = val;
                                                    });
                                                    Navigator.pop(context);
                                                    fitler ="new";
                                                    vendors = null;
                                                    getVendors().then((value) {
                                                      vendors = value;
                                                      setState(() {

                                                      });

                                                    });
                                                  },
                                                ),
                                                Container(
                                                    child: Text(getTranslated(context, 'newest'),
                                                        style: GoogleFonts.roboto(
                                                            color: blackColor,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal))),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Radio(
                                                  toggleable: true,
                                                  value: 3,
                                                  groupValue: groupValue,
                                                  activeColor: primaryColor,
                                                  onChanged: (int val) {
                                                    setState(() {
                                                      groupValue = val;
                                                    });
                                                    Navigator.pop(context);
                                                    fitler ="alphabetical";
                                                    vendors = null;
                                                    getVendors().then((value) {
                                                      vendors = value;
                                                      setState(() {

                                                      });

                                                    });
                                                  },
                                                ),
                                                Container(
                                                    child: Text(getTranslated(context, 'a_z'),
                                                        style: GoogleFonts.roboto(
                                                            color: blackColor,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal))),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Radio(
                                                  toggleable: true,
                                                  value: 4,
                                                  groupValue: groupValue,
                                                  activeColor: primaryColor,
                                                  onChanged: (int val) {
                                                    setState(() {
                                                      groupValue = val;
                                                    });
                                                    Navigator.pop(context);
                                                    fitler ="fast";
                                                    vendors = null;
                                                    getVendors().then((value) {
                                                      vendors = value;
                                                      setState(() {

                                                      });

                                                    });
                                                  },
                                                ),
                                                Container(
                                                    child: Text(
                                                        getTranslated(context, 'fast'),
                                                        style: GoogleFonts.roboto(
                                                            color: blackColor,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal))),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ));
                      },
                      child: Container(
                          margin: EdgeInsets.only(right: 10),
                          height: 40,
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Image.asset("assets/icons/filters.png")),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 50.h,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index){
                      return GestureDetector(
                        onTap: (){
                          bool isSelected = selected[index];
                          if(!isSelected){
                            for(int i =0;i<selected.length;i++){
                              if(i == index){
                                selected[i]= true;
                              }else{
                                selected[i]= false;
                              }
                            }
                            vendors = null;
                            setState(() {

                            });
                            tagId = tags[index].id;
                            getVendors().then((value) {
                              vendors = value;
                              setState(() {

                              });

                            });


                          }


                        },
                        child: Container(
                          child:selected[index]?

                          Text(language == 'en'?tags[index].enTitle:tags[index].arTitle,style: TextStyle(
                            color: Color(0xFFFF8262),
                            fontSize: screenUtil.setSp(12),
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.underline,
                          ),)
                          :
                          Text(language == 'en'?tags[index].enTitle:tags[index].arTitle,style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: screenUtil.setSp(12),
                            fontWeight: FontWeight.normal,

                          ),)
                        ),
                      );
                    }, separatorBuilder: (context,index) {
                  return Container(width: 15.w,
               );
                }, itemCount: tags.length),
              ),
              SizedBox(
                height: 20,
              ),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 100),
                opacity: closeTopContainer ? 0 : 1,
                child:
                AnimatedContainer(
                  duration: const Duration(milliseconds: 100),
                  alignment: Alignment.topCenter,
                  height: closeTopContainer
                      ? 0
                      : Helper.setHeight(context, height: 0.25),
                  child:
                  CustomHeaderWidget(
                    language: language,


                    onPageChanged: (index, reason) {
                      setState(() {
                        activeIndex = index;
                      });
                    },
                    images: homeModel.data.banners,
                    activeIndex: activeIndex,
                  ),
                ),
              ),
              Expanded(
                child: vendors ==null ?
                Container(
                  child: CircularProgressIndicator(


                  ),
                  alignment: AlignmentDirectional.center,
                ):
                    vendors.isEmpty?
                        Container():
                Container(
                  child:

                  ListView.builder(
                      controller: controller,
                      primary: false,
                      physics: AlwaysScrollableScrollPhysics(),
                      itemCount: vendors.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return  Container(
                          child:

                            GestureDetector(
                            onTap: () {

                              String isBusy = vendors[index].isBusy;
                              if(isBusy == "0"){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RestaurantScreen(vendorId: vendors[index].id)));
                              }


                            },
                            child: RestaurantWidget(
                              vendors: vendors[index],
                              lang: language,

                            ),
                          )


                        )
                          ;
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
