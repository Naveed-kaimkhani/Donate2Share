//  Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Welcome',
//                   style: CustomTextStyle.font_14_black,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text('Ehsaan Foundations',
//                         style: CustomTextStyle.font_24_primaryColor),
//                     CircleAvatar(
//                       backgroundColor: Color(0xff326060),
//                       radius: 22.r,
//                     )
//                   ],
//                 ),
//                 SizedBox(height: 11.h),
//                 Divider(
//                   height: 1,
//                   color: Colors.grey[600],
//                 ),
//                 SizedBox(
//                   height: 12.h,
//                 ),
//                 Text(
//                   'Monthly Donation Analysis',
//                   style: CustomTextStyle.font_24,
//                 ),
//                 SizedBox(
//                   height: 8.h,
//                 ),
//                 Container(
//                   width: 325.w,
//                   height: 158.h,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                       border: Border.all(
//                         color: const Color(0xff326060),
//                         width: 1,
//                       )),
//                   child: ChartWidget(),
//                 ),
//                 SizedBox(height: 20.h),
//                 Divider(
//                   height: 1,
//                   color: Colors.grey[600],
//                 ),
//                 SizedBox(height: 6.h),
//                 Text(
//                   'Successful Donation',
//                   style: CustomTextStyle.font_24,
//                 ),
//                 // StreamBuilder<List<DonationModel>>(
//                 //   stream: FirebaseUserRepository.getDonationList(),
//                 //   builder: (context, snapshot) {
//                 //     if (snapshot.connectionState ==
//                 //         ConnectionState.waiting) {
//                 //       // return const ShimmerScreen();
//                 //       return SizedBox();
//                 //     } else if (snapshot.hasError) {
//                 //       return Text(snapshot.error.toString());
//                 //     } else if (!snapshot.hasData ||
//                 //         snapshot.data!.isEmpty) {
//                 //       return const NoDataFoundScreen(
//                 //         text: "No Donation",
//                 //       );
//                 //     } else {
//                 //       return SizedBox(
//                 //         height: MediaQuery.of(context).size.height,
//                 //         child: ListView.builder(
//                 //           itemCount: snapshot.data!.length,
//                 //           itemBuilder: (context, index) {
//                 //             return DonationWidget(
//                 //                 donationModel: snapshot.data![index]);
//                 //           },
//                 //         ),
//                 //       );
//                 //     }
//                 //   },
//                 // ),
//               ],
//             ),