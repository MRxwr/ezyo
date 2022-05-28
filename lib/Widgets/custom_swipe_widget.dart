import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ezyo/Config/Colors.dart';
import 'package:ezyo/Models/home_model.dart';
import 'package:ezyo/Utils/helper.dart';
import 'package:ezyo/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomSwipeWidget extends StatelessWidget {
  final Function onPageChanged;
  final List<String>images;
  final int activeIndex;

  const CustomSwipeWidget(
      {Key key, this.onPageChanged, this.images, this.activeIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil screenUtil = ScreenUtil();
    return Container(
      height: 250.h,

      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) =>
              //             RestaurantSingleProductScreen()));
            },
            child: Container(
              height: screenUtil.screenHeight,
              width: MediaQuery.of(context).size.width,
              child: ClipRRect(

                child: CarouselSlider.builder(
                  options: CarouselOptions(
                      viewportFraction: 1,
                      enableInfiniteScroll: false,
                      autoPlay: true,
                      height: screenUtil.screenHeight,
                      autoPlayInterval: Duration(seconds: 2),
                      onPageChanged: onPageChanged),
                  itemCount: images.length,
                  itemBuilder: (context, index, realIndex) {
                    final image = TAG_IMAGE_URL+images[index];
                    return CachedNetworkImage(
                      width: double.infinity,
                      height: screenUtil.screenHeight,
                      imageUrl:image,
                      imageBuilder: (context, imageProvider) => Stack(
                        children: [
                          Container(
                            height: screenUtil.screenHeight,
                            width: double.infinity,
                            child: ClipRRect(

                                child:Container(
                                    width: double.infinity,
                                    height: screenUtil.screenHeight,
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
          ),


         Positioned.directional(
           bottom: 10.h,
             start: 0,
             end: 0,
             textDirection:  Directionality.of(context), child: Center(
               child: AnimatedSmoothIndicator(
           activeIndex: activeIndex,
           count: images.length,
           effect: ExpandingDotsEffect(
               dotWidth: 8.w,
               dotHeight: 8.w,
               dotColor: Colors.black12,
               activeDotColor: primaryColor,
           ),
         ),
             ))
        ],
      ),
    );
  }
}
