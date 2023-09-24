import 'package:donation_app/presentation/widgets/all_donars_screen_header.dart';
import 'package:donation_app/presentation/widgets/custom_divider.dart';
import 'package:donation_app/presentation/widgets/setting_screen_widget.dart';
import 'package:donation_app/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../style/custom_text_style.dart';
import '../../style/styling.dart';
import '../../utils/dialogues/logout.dart';

class NGOSetting extends StatelessWidget {
  const NGOSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            // HomeHeader(barTitle: "Settings", height: 115.h),
            // SizedBox(
            //   height: 9.h,
            // ),
            const AllDonarsScreenHeader(
              header: "Settings",
              subHeader: "",
            ),
            SizedBox(
              height: 20.h,
            ),
            SettingScreenWidget(
              text: "profile",
              icon: Icons.admin_panel_settings,
              routeName: "UpdateNGOProfile",
            ),
            //  ServicesNSettingHeade(text: 'Setting Available'),
            const CustomDivider(),
            SettingScreenWidget(
              text: "Change Password",
              icon: Icons.password_outlined,
              routeName: "NgoChangePassword",
            ),
            const CustomDivider(),
            SettingScreenWidget(
              text: "Privacy Policy",
              // imageURL: Images.wheel,
              icon: Icons.privacy_tip_outlined,
              routeName: RoutesName.privacyPolicyScreen,
            ),
            const CustomDivider(),
            SettingScreenWidget(
              text: "Contact Us",
              icon: Icons.phone,
              routeName: RoutesName.aboutUs,
            ),
            const CustomDivider(),
            SettingScreenWidget(
              text: "About Us",
              // imageURL: Images.mechanic_pic,
              icon: Icons.admin_panel_settings,
              routeName: RoutesName.contactUs,
            ),
            const CustomDivider(),
            SizedBox(
              height: 20.h,
            ),
            GestureDetector(
              child: Row(
                children: [
                  SizedBox(
                    width: 20.w,
                  ),
                  Icon(
                    Icons.logout_outlined,
                    color: Styling.primaryColor,
                    size: 25.h,
                  ),
                  Text(
                    "LogOut",
                    style: CustomTextStyle.font_15_primaryColor,
                  )
                ],
              ),
              onTap: () {
                showLogoutPopup(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
