import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:donation_app/domain/models/donation_model.dart';
import 'package:donation_app/presentation/widgets/call_widget.dart';
import 'package:donation_app/presentation/widgets/circle_progress.dart';
import 'package:donation_app/style/custom_text_style.dart';
import 'package:donation_app/style/styling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DonationDetails extends StatefulWidget {
  final DonationModel donationModel;
  const DonationDetails({required this.donationModel, super.key});

  @override
  State<DonationDetails> createState() => _DonationDetailsState();
}

class _DonationDetailsState extends State<DonationDetails> {
  var selectedIndex = 0;
  EdgeInsetsGeometry k = EdgeInsets.only(left: 18.w);
  SizedBox l = SizedBox(
    height: 12.h,
  );
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: CallWidget(
            iconSize: 10.h,
            radius: 2.0,
            num: widget.donationModel.donarPhone!,
            context: context),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // BackButton(
              //   color: Colors.white,
              // ),
              CarouselSlider.builder(
                options: carousel(),
                itemCount: widget.donationModel.pictures!.length,
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) =>
                        CachedNetworkImage(
                  imageUrl: widget.donationModel.pictures![itemIndex],
                  imageBuilder: (context, imageProvider) => Container(
                    width: 428.w,
                    height: 459.h,
                    margin: const EdgeInsets.symmetric(horizontal: 1.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30.r),
                          bottomRight: Radius.circular(30.r)),

                      // shape: BoxShape.circle,
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover),
                    ),
                  ),
                  placeholder: (context, url) => const Center(
                    widthFactor: 2.0,
                    heightFactor: 2.0,
                    // child: CircularProgressIndicator()
                    child: CircleProgress(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Center(
                child: AnimatedSmoothIndicator(
                  activeIndex: selectedIndex,
                  count: widget.donationModel.pictures!.length,
                  effect: SwapEffect(
                    dotWidth: 10.w,
                    dotHeight: 10.h,
                    activeDotColor: Styling.primaryColor,
                    dotColor: const Color.fromARGB(255, 177, 167, 167),
                  ),
                  duration: const Duration(milliseconds: 700),
                ),
              ),
              SizedBox(
                height: 22.h,
              ),
              Padding(
                padding: k,
                child: Text(
                  "Donated By",
                  style: CustomTextStyle.font_10_black,
                ),
              ),
              // SizedBox(
              //   height: 2.h,
              // ),
              Padding(
                padding: EdgeInsets.only(left: 18.w, right: 16.w),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.donationModel.donarName.toString(),
                      style: CustomTextStyle.font_24_black,
                    ),
                    SizedBox(
                      width: 185.w,
                    ),
                    Text(
                      widget.donationModel.quantity.toString(),
                      style: CustomTextStyle.font_33_primaryColor,
                    ),
                    Text(
                      // " ${widget.donationModel.type!=="food"}",
                      widget.donationModel.type == "food" ? " kg" : " clothes",
                      style: CustomTextStyle.font_10_black,
                    ),
                    //  ${widget.donationModel.type}
                  ],
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Padding(
                padding: k,
                child: Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      color: Styling.primaryColor,
                    ),
                    Text(
                      " ${widget.donationModel.donarAddress!}",
                      style: CustomTextStyle.font_12_black,
                    ),
                  ],
                ),
              ),
              l,
              l,
              Padding(
                padding: k,
                child: Text(
                  "Description: ",
                  style: CustomTextStyle.font_12_black,
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: k,
                child: Text(
                  widget.donationModel.donationDescription!,
                  style: CustomTextStyle.font_14_black,
                ),
              ),
              l,
              Padding(
                padding: k,
                child: Text(
                  "Location: ",
                  style: CustomTextStyle.font_12_black,
                ),
              ),

              SizedBox(
                height: 4.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 14.w, right: 14.w),
                child: SizedBox(
                  height: 120.h,
                  width: 380.w,
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                        target: LatLng(widget.donationModel.donarLat!,
                            widget.donationModel.donarLong!),
                        zoom: 18),
                    compassEnabled: true,
                    markers: {
                      Marker(
                          markerId: const MarkerId(
                            "0",
                          ),
                          position: LatLng(widget.donationModel.donarLat!,
                              widget.donationModel.donarLong!),
                          // icon: BitmapDescriptor.fromBytes(sellerTracingIcon!),
                          infoWindow: const InfoWindow(title: "Food Location")),
                    },
                    // onMapCreated: (GoogleMapController controller) {
                    // },
                    // onTap: (position) {
                    // },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  CarouselOptions carousel() {
    return CarouselOptions(
        onPageChanged: (index, reason) => setState(() {
              selectedIndex = index;
            }),
        height: 300.h,
        viewportFraction: 1,
        enlargeCenterPage: true,
        enableInfiniteScroll: false,
        enlargeStrategy: CenterPageEnlargeStrategy.height,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 4));
  }
}
