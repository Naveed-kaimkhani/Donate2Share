import 'dart:async';
import 'dart:typed_data';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:donation_app/domain/models/donation_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:ui' as ui;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../../domain/models/user_model.dart';
import '../../providers/admin_provider.dart';
import '../../providers/donars_list_provider.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import '../../style/styling.dart';
import '../widgets/tracing_screen_bottom_navigation.dart';

class TrackDonation extends StatefulWidget {
  final DonationModel donation;

  const TrackDonation({super.key, required this.donation});

  @override
  State<TrackDonation> createState() => _TrackDonationState();
}

class _TrackDonationState extends State<TrackDonation> {
//  Position? currentLocation=LatLng(widget.donation.donarLat!, widget.donation.donarLong);
  UserModel? admin;
  List<LatLng> polyLineCoordinates = [];
  final String apiKey = 'AIzaSyBhJ2QJhSVwOR7lNCQQGDqE2vraGinYlB0';
  Uint8List? adminIcon;

  final CustomInfoWindowController _windowinfoController =
      CustomInfoWindowController();
  final Completer<GoogleMapController> _controller = Completer();

  double? distance;

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        apiKey,
        PointLatLng(widget.donation.donarLat!, widget.donation.donarLong!),
        PointLatLng(admin!.lat!, admin!.long!));
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) =>
          polyLineCoordinates.add(LatLng(point.latitude, point.longitude)));
      setState(() {});
    }
  }

  double getDistancebtwRiderNSeller() {
    return Geolocator.distanceBetween(widget.donation.donarLat!,
        widget.donation.donarLong!, admin!.lat!, admin!.long!);
  }

  Future<Uint8List> getByteFromAssets(String path, int widht) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: widht);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  addMarker() async {
    adminIcon = await getByteFromAssets("assets/admin.png", 100);
  }

  @override
  void initState() {
    super.initState();
    admin = Provider.of<AdminProvider>(context, listen: false).admin;
addMarker();
    distance = getDistancebtwRiderNSeller();
  }

  @override
  Widget build(BuildContext context) {
    String dis = distance.toString();

    double firstLine = (admin!.address!.length / 2);
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: TracingScreenBottomNavigation(
          distance: distance,
          halfLength: dis.length / 3,
          // widget: widget,
          address: admin!.address!,
          phone: admin!.phone!,
          firstLine: firstLine,
        ),
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
                  target: LatLng(
                      widget.donation.donarLat!, widget.donation.donarLong!),
                  zoom: 18),
              compassEnabled: true,
              markers: {
                Marker(
                    markerId: const MarkerId(
                      "0",
                    ),
                    position: LatLng(
                        widget.donation.donarLat!, widget.donation.donarLong!),
                    // icon: BitmapDescriptor.fromBytes(sellerTracingIcon!),
                    infoWindow: const InfoWindow(title: "Food Location")),
                Marker(
                    markerId: const MarkerId("1"),
                    position: LatLng(admin!.lat!, admin!.long!),
                    // icon: BitmapDescriptor.fromBytes(adminIcon!),
                    infoWindow: const InfoWindow(title: "Admin")),
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
