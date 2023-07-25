import 'dart:async';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:donation_app/domain/models/donation_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../style/styling.dart';
class TrackDonation extends StatefulWidget {
  final DonationModel donation;
  const TrackDonation({super.key, required this.donation});

  @override
  State<TrackDonation> createState() => _TrackDonationState();
}

class _TrackDonationState extends State<TrackDonation> {
//  Position? currentLocation=LatLng(widget.donation.donarLat!, widget.donation.donarLong);
 
  List<LatLng> polyLineCoordinates = [];
 
  final CustomInfoWindowController _windowinfoController =
      CustomInfoWindowController();
  final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:  Scaffold(
              // bottomNavigationBar: TracingScreenBottomNavigation(
              //   distance: distance,
              //   halfLength: halfLength,
              //   widget: widget,
              //   firstLine: firstLine,
              // ),
//               floatingActionButton: IconButton(
//                 onPressed: () {
// // Navigating to a new screen
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => SellerSideChatScreen(
//                         user: widget.requestModel,
//                       ),
//                     ),
//                   );
//                 },
//                 icon: Icon(Icons.chat),
//                 color: Styling.primaryColor,
//                 iconSize: 40.h,
//               ),
              body: Stack(
                children: [
                  
                  GoogleMap(
                    initialCameraPosition: CameraPosition(
                        target: LatLng(widget.donation.donarLat!,
                            widget.donation.donarLong!),
                        zoom: 18),
                    compassEnabled: true,
                    markers: {
                      Marker(
                          markerId: const MarkerId(
                            "0",
                          ),
                          position: LatLng(widget.donation.donarLat!,
                              widget.donation.donarLong!),
                          // icon: BitmapDescriptor.fromBytes(sellerTracingIcon!),
                          infoWindow:
                              const InfoWindow(title: "Food Location")),
                      // Marker(
                      //     markerId: const MarkerId("1"),
                      //     position: LatLng(sourceLocation!.latitude,
                      //         sourceLocation!.longitude),
                      //     icon: BitmapDescriptor.fromBytes(sellerLocation!),
                      //     infoWindow: const InfoWindow(title: "Your Position")),
                      // Marker(
                      //   markerId: const MarkerId("2"),
                      //   position: destinationLocation!,
                      //   icon: BitmapDescriptor.defaultMarker,
                      //   onTap: () {
                      //     _windowinfoController.addInfoWindow!(
                      //       UserMarkerInfoWindow(
                      //         request: widget.requestModel,
                      //       ),
                      //       LatLng(widget.requestModel.senderLat!,
                      //           widget.requestModel.senderLong!),
                      //     );
                      //   },
                      // ),
                    },
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                      _windowinfoController.googleMapController = controller;
                    },
                    onTap: (position) {
                      _windowinfoController.hideInfoWindow!();
                    },
                    polylines: {
                      Polyline(
                        polylineId: const PolylineId('route'),
                        points: polyLineCoordinates,
                        color: Styling.primaryColor,
                        width: 6,
                      )
                    },
                  ),
                  const BackButton(),
                  CustomInfoWindow(
                    controller: _windowinfoController,
                    height: 150.h,
                    width: 300.w,
                    offset: 10,
                  ),
                ],
              ),
            ),
    );
  }
}