import 'dart:async';
import 'dart:ui' as ui;
import 'package:custom_info_window/custom_info_window.dart';
import 'package:donation_app/data/firebase_user_repository.dart';
import 'package:donation_app/presentation/widgets/circle_progress.dart';
import 'package:donation_app/presentation/widgets/wave_circle.dart';
import 'package:donation_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../domain/models/donation_ngo_model.dart';
import '../../domain/models/seller_model.dart';
import '../donar screens/tracing_screen_bottom_navigation.dart';
import '../widgets/loading_map.dart';
import '../widgets/user_marker_info_window.dart';
import 'no_data_found.dart';

class FoodTracking extends StatefulWidget {
  final DonationNgoModel requestModel;
  const FoodTracking({super.key, required this.requestModel});

  @override
  State<FoodTracking> createState() => _FoodTrackingState();
}

class _FoodTrackingState extends State<FoodTracking> {
  // List<SellerModel>? _listOfSellers;
  final CustomInfoWindowController _windowinfoController =
      CustomInfoWindowController();
  final FirebaseUserRepository _firebaseUserRepository =
      FirebaseUserRepository();
  SellerModel? rider;
  final String apiKey = 'AIzaSyArAQyQpUk0j3303XE7HSqxBbCdcLUJ9cE';
  LatLng? donarLocation = const LatLng(0.0, 0.0);
  LatLng? ngoLocation;
  Position? riderLocation;
  Uint8List? riderIcon;
  Uint8List? donarIcon;
  Uint8List? ngoIcon;
  final Completer<GoogleMapController> _controller = Completer();

  Position? currentLocation;
  StreamSubscription<Position>? positionStreamSubscription;
  double? distance;
  final Set<Polyline> _polyline = {};
  List<LatLng>? latlng;

  double getDistancebtwRiderNSeller() {
    return Geolocator.distanceBetween(
        currentLocation!.latitude,
        currentLocation!.longitude,
        widget.requestModel.ngoLat!,
        widget.requestModel.ngoLong!);
  }

  void getUserCurrentLocation() async {
    print(widget.requestModel.donarLat);
    print(widget.requestModel.donarLong);
    try {
      currentLocation = await utils.convertLatLngToPosition(LatLng(
        widget.requestModel.donarLat!,
        widget.requestModel.donarLong!,
      ));
      ngoLocation =
          LatLng(widget.requestModel.ngoLat!, widget.requestModel.ngoLong!);
      setState(() {});
      getPolyPoints();

      distance = getDistancebtwRiderNSeller();
      // positionStreamSubscription = Geolocator.getPositionStream().listen(
      //   (Position position) async {
      //     GoogleMapController controller = await _controller.future;
      //     // print(currentLocation);
      //     setState(() {
      //       currentLocation = position;

      //       distance = getDistancebtwRiderNSeller();

      //       // controller.animateCamera(
      //       //     CameraUpdate.newCameraPosition(
      //       //       CameraPosition(
      //       //         target: LatLng(
      //       //             currentLocation!.latitude, currentLocation!.longitude),
      //       //         zoom: 18,
      //       //       ),
      //       //     ),
      //       //     );
      //     });
      //   },
      //   onError: (e) {
      //     print(e);
      //     // utils.flushBarErrorMessage(e.toString(), context);
      //   },
      // );
    } catch (error) {
      print(error);
      // utils.flushBarErrorMessage(error.toString(), context);
      return null; // or throw the error
    }
  }

  void getPolyPoints() async {
    //asif taj wala
    List<LatLng> latlng = [
      LatLng(currentLocation!.latitude, currentLocation!.longitude),
      LatLng(25.531790, 69.011800),
      // LatLng(widget.requestModel.donarLat!, widget.requestModel.donarLong!),
      LatLng(widget.requestModel.ngoLat!, widget.requestModel.ngoLong!),
    ];
    for (int i = 0; i < latlng.length; i++) {
      setState(() {
        _polyline.add(Polyline(
          polylineId: PolylineId(i.toString()),
          visible: true,
          width: 8,
          points: latlng,
          color: Colors.blue,
        ));
      });
    }
    addMarker();
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
    riderIcon = await getByteFromAssets("assets/man.png", 70);
    donarIcon = await getByteFromAssets("assets/donation_icon.png", 70);
    ngoIcon = await getByteFromAssets("assets/ngo_icon.png", 70);

    // setState(() {

    // });
  }

  @override
  void dispose() {
    positionStreamSubscription?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    utils.checkConnectivity(context);
    getUserCurrentLocation();
    // addMarker();
    // getPolyPoints();
  }

//donarIcon==null?CircleProgress():
  @override
  Widget build(BuildContext context) {
    String dis = distance.toString();
    double halfLength =
        dis.length / 3; // Calculate the half length of the string
    double firstLine = (widget.requestModel.donarAddress!.length / 2);
    return SafeArea(
      child: StreamBuilder<SellerModel?>(
        stream: FirebaseUserRepository.getRiderStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const WaveCircleProgress();
            // return SizedBox();
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else if (!snapshot.hasData) {
            return const NoDataFoundScreen(
              text: "No Donation",
            );
          } else {
            return SafeArea(
              child: Scaffold(
                bottomNavigationBar: TracingScreenBottomNavigation(
                  distance: distance,
                  halfLength: halfLength,
                  adminAddress: widget.requestModel.donarAddress!,
                  phone: widget.requestModel.donarPhone!,
                  firstLine: firstLine,
                ),
                body: Stack(
                  children: [
                    GoogleMap(
                      initialCameraPosition: CameraPosition(
                          target: LatLng(currentLocation!.latitude,
                              currentLocation!.longitude),
                          zoom: 18),
                      compassEnabled: true,
                      markers: {
                        Marker(
                            markerId: const MarkerId(
                              "0",
                            ),
                            position: LatLng(currentLocation!.latitude,
                                currentLocation!.longitude),
                            // icon: BitmapDescriptor.fromBytes(riderIcon!),
                            infoWindow:
                                const InfoWindow(title: "Food Position")),
                        Marker(
                            markerId: const MarkerId("1"),
                            position: LatLng(
                                snapshot.data!.lat!, snapshot.data!.long!),

                            /// rider location
                            // icon: BitmapDescriptor.fromBytes(donarIcon!),

                            icon: BitmapDescriptor.defaultMarker,
                            infoWindow:
                                const InfoWindow(title: "Rider Position")),
                        Marker(
                            markerId: const MarkerId("2"),
                            position: ngoLocation!,
                            // icon: BitmapDescriptor.fromBytes(ngoIcon!),
                            icon: BitmapDescriptor.defaultMarker,
                            // onTap: () {
                            //   _windowinfoController.addInfoWindow!(
                            //     UserMarkerInfoWindow(
                            //       request: widget.requestModel,
                            //     ),
                            //     LatLng(widget.requestModel.ngoLat!,
                            //         widget.requestModel.ngoLong!),
                            //   );
                            // },
                            infoWindow:
                                const InfoWindow(title: "Ngo Position")),
                      },
                      onMapCreated: (GoogleMapController controller) {
                        if (!_controller.isCompleted) {
                          _controller.complete(controller);
                          _windowinfoController.googleMapController =
                              controller;
                        }
                      },
                      // onTap: (position) {
                      //   _windowinfoController.hideInfoWindow!();
                      // },
                      polylines: _polyline,
                    ),
                    const BackButton(),
                    // CustomInfoWindow(
                    //   controller: _windowinfoController,
                    //   height: 150,
                    //   width: 300,
                    //   offset: 10,
                    // ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
