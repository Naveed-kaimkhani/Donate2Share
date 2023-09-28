import 'dart:async';
import 'dart:ui' as ui;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:donation_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../domain/models/donation_ngo_model.dart';
import '../../style/styling.dart';
import '../widgets/loading_map.dart';
import '../widgets/tracing_screen_bottom_navigation.dart';

class FoodTrackingByDonar extends StatefulWidget {
  final DonationNgoModel requestModel;
  const FoodTrackingByDonar({super.key, required this.requestModel});

  @override
  State<FoodTrackingByDonar> createState() => _FoodTrackingByDonarState();
}

class _FoodTrackingByDonarState extends State<FoodTrackingByDonar> {
  // List<SellerModel>? _listOfSellers;
  final CustomInfoWindowController _windowinfoController =
      CustomInfoWindowController();
  final String apiKey = 'AIzaSyBhJ2QJhSVwOR7lNCQQGDqE2vraGinYlB0';
  LatLng? sourceLocation = const LatLng(0.0, 0.0);
  LatLng? riderLocation;
  // SellerModel? seller;
  Uint8List? sellerTracingIcon;
  String? donarPhone;
  // Uint8List? sellerLocation;
  final Completer<GoogleMapController> _controller = Completer();

  List<LatLng> polyLineCoordinates = [];
  Position? currentLocation;
  // StreamSubscription<Position>? positionStreamSubscription;
  double? distance;

  double getDistancebtwRiderNSeller(
    double riderLat,
    double riderLong,
  ) {
    return Geolocator.distanceBetween(riderLat, riderLong,
        widget.requestModel.donarLat!, widget.requestModel.donarLong!);
  }

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      apiKey,
      PointLatLng(
          widget.requestModel.donarLat!, widget.requestModel.donarLong!),
      PointLatLng(riderLocation!.latitude, riderLocation!.longitude),

      // PointLatLng(25.5238, 69.0141),
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) =>
          polyLineCoordinates.add(LatLng(point.latitude, point.longitude)));
      setState(() {});
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
    sellerTracingIcon = await getByteFromAssets("assets/man.png", 100);
    // sellerLocation = await getByteFromAssets("assets/SellerLocation.png", 70);
  }

// Initialize Firestore
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

// Start listening to rider location updates
  void listenToRiderLocation() async {
    await firestore
        .collection('riders')
        .doc("ktpVdGvLpbWs3PT4XOCMqi9CjCr2")
        .snapshots()
        .listen((snapshot) {
      if (snapshot.exists) {
        // Handle rider's location update
        double latitude = snapshot['lat'];
        double longitude = snapshot['long'];

        donarPhone = snapshot['phone'];
        setState(() {
          riderLocation = LatLng(latitude, longitude);

          distance = getDistancebtwRiderNSeller(
              riderLocation!.latitude, riderLocation!.longitude);
        });
        // Update the rider's location on the map or do other processing as needed
      }
      getPolyPoints();
    });
    if (riderLocation != null) {
      getPolyPoints();
    }
  }

  @override
  void dispose() {
    // positionStreamSubscription?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    utils.checkConnectivity(context);
    sourceLocation =
        LatLng(widget.requestModel.donarLat!, widget.requestModel.donarLong!);
    // seller = Provider.of<SellerProvider>(context, listen: false).seller;
    // _listOfSellers =
    //     Provider.of<AllSellerDataProvider>(context, listen: false).sellers;
    addMarker();
    listenToRiderLocation();
    // initializeValues();

    // getUserCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    String dis = distance.toString();
    double halfLength =
        dis.length / 3; // Calculate the half length of the string
    double firstLine = (widget.requestModel.donarAddress!.length / 2);
    return SafeArea(
      child: riderLocation == null &&
              sellerTracingIcon == null &&
              distance == null
          ? const LoadingMap()
          : Scaffold(
              bottomNavigationBar: TracingScreenBottomNavigation(
                distance: distance,
                halfLength: halfLength,
                address: widget.requestModel.donarAddress!,
                // senderAddress: widget.requestModel.senderAddress,
                phone: donarPhone!,
                firstLine: firstLine,
              ),
              body: Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: CameraPosition(
                        target: LatLng(sourceLocation!.latitude,
                            sourceLocation!.longitude),
                        zoom: 18),
                    compassEnabled: true,
                    markers: {
                      Marker(
                          markerId: const MarkerId(
                            "0",
                          ),
                          position: LatLng(sourceLocation!.latitude,
                              sourceLocation!.longitude),
                          icon: BitmapDescriptor.defaultMarker,
                          infoWindow: const InfoWindow(title: "Your Position")),
                      Marker(
                        markerId: const MarkerId("1"),
                        position: riderLocation!,
                        icon: sellerTracingIcon == null
                            ? BitmapDescriptor.defaultMarker
                            : BitmapDescriptor.fromBytes(sellerTracingIcon!),
                        onTap: () {
                          // _windowinfoController.addInfoWindow!(
                          //   UserMarkerInfoWindow(
                          //     request: widget.requestModel,
                          //   ),
                          //   LatLng(widget.requestModel.senderLat!,
                          //       widget.requestModel.senderLong!),
                          // );
                        },
                      ),
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
