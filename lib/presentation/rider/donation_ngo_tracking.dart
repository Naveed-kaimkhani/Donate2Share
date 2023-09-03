import 'dart:async';
import 'dart:ui' as ui;
import 'package:custom_info_window/custom_info_window.dart';
import 'package:donation_app/data/firebase_user_repository.dart';
import 'package:donation_app/providers/rider_provider.dart';
import 'package:donation_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:provider/provider.dart';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../domain/models/donation_ngo_model.dart';
import '../../domain/models/seller_model.dart';
import '../../providers/seller_provider.dart';
import '../../style/styling.dart';
import '../donar screens/tracing_screen_bottom_navigation.dart';
import '../widgets/loading_map.dart';
import '../widgets/user_marker_info_window.dart';

class Donatin_Ngo_Tracing extends StatefulWidget {
  final DonationNgoModel requestModel;
  const Donatin_Ngo_Tracing({super.key, required this.requestModel});

  @override
  State<Donatin_Ngo_Tracing> createState() => _Donatin_Ngo_TracingState();
}

class _Donatin_Ngo_TracingState extends State<Donatin_Ngo_Tracing> {
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
    try {
      currentLocation =
          await _firebaseUserRepository.getUserCurrentLocation(context);
      setState(() {});
      getPolyPoints();

      positionStreamSubscription = Geolocator.getPositionStream().listen(
        (Position position) async {
          GoogleMapController controller = await _controller.future;
          // print(currentLocation);
          setState(() {
            currentLocation = position;

            distance = getDistancebtwRiderNSeller();

            // controller.animateCamera(
            //     CameraUpdate.newCameraPosition(
            //       CameraPosition(
            //         target: LatLng(
            //             currentLocation!.latitude, currentLocation!.longitude),
            //         zoom: 18,
            //       ),
            //     ),
            //     );
          });
        },
        onError: (e) {
          print(e);
          // utils.flushBarErrorMessage(e.toString(), context);
        },
      );
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
      // LatLng(25.531790, 69.011800),

      LatLng(widget.requestModel.donarLat!, widget.requestModel.donarLong!),
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

  Future<Position> convertLatLngToPosition(LatLng latLng) async {
    return Position(
      latitude: latLng.latitude,
      longitude: latLng.longitude,
      timestamp: DateTime.now(),
      accuracy: 0.0,
      altitude: 0.0,
      heading: 0.0,
      speed: 0.0,
      speedAccuracy: 0.0,
      isMocked: false,
      floor: null,
    );
  }

  addMarker() async {
    riderIcon = await getByteFromAssets("assets/locationIcon.png", 70);
    donarIcon = await getByteFromAssets("assets/donation_icon.png", 70);
    ngoIcon = await getByteFromAssets("assets/ngo_icon.png", 70);
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
    addMarker();
    distance = getDistancebtwRiderNSeller();
    // getPolyPoints();
  }

  @override
  Widget build(BuildContext context) {
    String dis = distance.toString();
    double halfLength =
        dis.length / 3; // Calculate the half length of the string
    double firstLine = (widget.requestModel.donarAddress!.length / 2);
    return SafeArea(
      child: currentLocation == null
          ? const LoadingMap()
          : Scaffold(
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
                              const InfoWindow(title: "Current Position")),
                      Marker(
                          markerId: const MarkerId("1"),
                          position: LatLng(25.531790, 69.011800),
                          icon: BitmapDescriptor.fromBytes(donarIcon!),
                          infoWindow:
                              const InfoWindow(title: "Donation Position")),
                      Marker(
                          markerId: const MarkerId("2"),
                          position: ngoLocation!,
                          icon: BitmapDescriptor.fromBytes(ngoIcon!),
                          onTap: () {
                            _windowinfoController.addInfoWindow!(
                              UserMarkerInfoWindow(
                                request: widget.requestModel,
                              ),
                              LatLng(widget.requestModel.ngoLat!,
                                  widget.requestModel.ngoLong!),
                            );
                          },
                          infoWindow: const InfoWindow(title: "Ngo Position")),
                    },
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                      _windowinfoController.googleMapController = controller;
                    },
                    onTap: (position) {
                      _windowinfoController.hideInfoWindow!();
                    },
                    polylines: _polyline,
                  ),
                  const BackButton(),
                  CustomInfoWindow(
                    controller: _windowinfoController,
                    height: 150,
                    width: 300,
                    offset: 10,
                  ),
                ],
              ),
            ),
    );
  }
}
