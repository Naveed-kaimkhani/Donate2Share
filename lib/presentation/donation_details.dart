import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:donation_app/domain/models/donation_model.dart';
import 'package:donation_app/presentation/widgets/circle_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DonationDetails extends StatefulWidget {
  final DonationModel donationModel;
  const DonationDetails({required this.donationModel, super.key});

  @override
  State<DonationDetails> createState() => _DonationDetailsState();
}

class _DonationDetailsState extends State<DonationDetails> {
 var selectedIndex = 0;
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider.builder(
                        options: CarouselOptions(
                            onPageChanged: (index, reason) => setState(() {
                                  selectedIndex = index;
                                }),
                            height: 400.h,
                            viewportFraction: 1,
                            enlargeCenterPage: true,
                            enableInfiniteScroll: false,
                            enlargeStrategy: CenterPageEnlargeStrategy.height,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 4)),
                        itemCount: widget.donationModel.pictures!.length,
                        itemBuilder: (BuildContext context, int itemIndex,
                                int pageViewIndex) =>
                            CachedNetworkImage(
                          imageUrl: widget.donationModel.pictures![itemIndex],
                          imageBuilder: (context, imageProvider) => Container(
                            width: 428.w,
                            height: 469.h,
                            margin: EdgeInsets.symmetric(horizontal: 1.0),
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
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}