import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: 240.h,
              width: 276.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(top: 40.h, left: 29.w, right: 14.w),
                    child: Text(
                      'Donated Successfully',
                      style: TextStyle(
                          fontSize: 22.sp,
                          color: const Color(0xff326060),
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: 18.h, left: 45.w, right: 44.w),
                    child: Text(
                      'You have Donated successfully\n you can track your donation.\n Thank you.\n',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 12.sp, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.h, left: 45.w, right: 44.w),
                    child: Container(
                      height: 50.h,
                      width: 180.w,
                      decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 3.0,
                              spreadRadius: 0.5,
                              offset: Offset(0, 4),
                            ),
                          ],
                          color: const Color(0xff326060),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                          child: Text(
                        'Track Donation',
                        style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      )),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 128.w, right: 126.w),
                    child: Text(
                      'Ok',
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff326060)),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
