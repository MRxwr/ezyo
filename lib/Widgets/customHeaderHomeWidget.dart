import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ezyo/Config/Colors.dart';
import 'package:ezyo/Models/home_model.dart';
import 'package:ezyo/Src/Home/weview_screen.dart';
import 'package:ezyo/Src/Restaurant/restaurantScreen.dart';
import 'package:ezyo/Utils/helper.dart';
import 'package:ezyo/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomHeaderWidget extends StatelessWidget {
  final Function onPageChanged;
  final List<Banners>images;
  final int activeIndex;
  final String language;


  const CustomHeaderWidget(

      {Key key, this.onPageChanged, this.images, this.activeIndex,this.language
     })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil screenUtil = ScreenUtil();
    return Container(
      height: Helper.setHeight(context, height: 0.25),
      child: FittedBox(
        fit: BoxFit.fill,
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CarouselSlider.builder(
                  options: CarouselOptions(
                      viewportFraction: 1,
                      enableInfiniteScroll: false,
                      autoPlay: true,
                      height: 200,
                      autoPlayInterval: Duration(seconds: 2),
                      onPageChanged: onPageChanged),
                  itemCount: images.length,
                  itemBuilder: (context, index, realIndex) {
                    final image = TAG_IMAGE_URL+images[index].image;
                    return GestureDetector(
                      onTap: (){
                        String url = images[index].url;
                        print(url);

                        if(url.toString().trim().isNotEmpty|| url.toString().trim()!= null ){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WebViewScreen(title: language == "en"?images[index].enTitle:images[index].arTitle,url:url ,)));
                        }else{
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      RestaurantScreen(vendorId: images[index].id)));
                        }
                      },
                      child: CachedNetworkImage(
                        width: double.infinity,
                        imageUrl:image,
                        imageBuilder: (context, imageProvider) => Stack(
                          children: [
                        Container(
                          width: double.infinity,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
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
                    );
                    // return Container(
                    //   width: double.infinity,
                    //   child: ClipRRect(
                    //     borderRadius: BorderRadius.circular(10),
                    //     child: Image.asset(
                    //       image,
                    //       fit: BoxFit.fill,
                    //       width: double.infinity,
                    //     ),
                    //   ),
                    // );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
                child: AnimatedSmoothIndicator(
              activeIndex: activeIndex,
              count: images.length,
              effect: ExpandingDotsEffect(
                dotWidth: 8,
                dotHeight: 8,
                dotColor: Colors.black12,
                activeDotColor: primaryColor,
              ),
            )),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
