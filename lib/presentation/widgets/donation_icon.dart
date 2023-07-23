
import 'package:donation_app/style/styling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DonationIcon extends StatelessWidget {
  final String image;
  final String route;

  const DonationIcon({
    required this.image,
    required this.route,
    
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: CircleAvatar(
        backgroundColor: Styling.primaryColor,
        radius: 30.r,
        child: Image.asset(
          image,
          // color: Styling.primaryColor,
        ),
      ),
      onTap: (){
        Navigator.pushNamed(context,route);
      },
    );
  }
}
