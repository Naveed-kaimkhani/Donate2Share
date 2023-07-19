
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../../style/styling.dart';

// class NGONavigation extends StatefulWidget {
//   const NGONavigation({Key? key}) : super(key: key);
//   @override
//   State<NGONavigation> createState() => _NGONavigationState();
// }

// class _NGONavigationState extends State<NGONavigation> {
//   List pages = [
//     // const UserHomePage(),
//     // Services(),
//     // // Profile(),
//     // ChatHomePage(),
//     // Setting(),
//   ];
//   int currentindex = 0;
//   void onTap(int index) {
//     setState(() {
//       currentindex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: Container(
//         color: Styling.primaryColor,
//         padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 15.h),
//         // padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 20.h),

//         child: GNav(
//           backgroundColor: Styling.primaryColor,
//           color: Colors.white,
//           activeColor: Styling.primaryColor,
//           tabBackgroundColor: Colors.white,
//           padding: const EdgeInsets.all(6),
//           gap: 8,
//           onTabChange: onTap,
//           tabs: const [
//             GButton(
//               icon: Icons.home,
//               text: "Home",
//             ),
//             GButton(
//               icon: Icons.grid_view_rounded,
//               text: "Services",
//             ),
//             GButton(
//               icon: Icons.chat,
//               text: "Chats",
//             ),
//             GButton(
//               icon: Icons.settings_outlined,
//               text: "Setting",
//             ),
//           ],
//         ),
//       ),
//       body: pages[currentindex],
//     );
//   }
// }
