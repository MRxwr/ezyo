import 'package:ezyo/Config/Colors.dart';
import 'package:ezyo/Models/home_model.dart';
import 'package:ezyo/Models/search_model.dart';
import 'package:ezyo/Src/Restaurant/restaurantScreen.dart';
import 'package:ezyo/Widgets/customAppBar.dart';
import 'package:ezyo/Widgets/customButton.dart';
import 'package:ezyo/Widgets/customRestaurantHomeWidgets.dart';
import 'package:ezyo/apis/ezyo_services.dart';
import 'package:ezyo/localization/localization_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';
class SearchScreen extends StatefulWidget {
  String searchTxt;
   SearchScreen({Key key,this.searchTxt}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Map<String, dynamic>   response;
  HomeModel searchModel = null;
  String language = "";

  Future<dynamic> search()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    language = sharedPreferences.getString(LANG_CODE)??"en";
    EzyoServices ezyoServices = EzyoServices();
    response = await ezyoServices.search(widget.searchTxt);
    return response;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    search().then((value) {
      response = value;
      if(response != null){
         searchModel = HomeModel.fromJson(response);
      }
      setState(() {

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
           appBar: customAppBar(
          context: context, appBarTitle: getTranslated(context, 'search_result'), isLeading: true),
        body:Container(
          margin: EdgeInsets.all(20.w),
          child: response == null?
          Container(
            child: CircularProgressIndicator(


            ),
            alignment: AlignmentDirectional.center,
          ):searchModel == null?
          Container(

            child: Center(
              child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(getTranslated(context, 'no_search_result'),
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
          ):
              searchModel.data.vendors.isNotEmpty?
          ListView.builder(

              primary: false,
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: searchModel.data.vendors.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return  Container(
                    child:

                    GestureDetector(
                      onTap: () {

                        String isBusy = searchModel.data.vendors[index].isBusy;
                        if(isBusy == "0"){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      RestaurantScreen(vendorId: searchModel.data.vendors[index].id)));
                        }


                      },
                      child: RestaurantWidget(
                        vendors: searchModel.data.vendors[index],
                        lang: language,

                      ),
                    )


                )
                ;
              }):
              Container(

                child: Center(
                  child:
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(getTranslated(context, 'no_search_result'),
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



        ) ,


      ),
    );
  }
}
