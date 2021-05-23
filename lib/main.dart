import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ilkproje/directions_repository.dart';
import 'package:ilkproje/model/directions_model.dart';
import 'package:ilkproje/screens/giris_yap/giris_ekrani.dart';
import 'package:ilkproje/screens/splash_screen.dart';
import 'package:ilkproje/stream.dart';
import 'package:ilkproje/utils/shared_preferences.dart';

import 'model/marker_model.dart';
import 'service/marker_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

LatLng latlngPosition;
LatLng center;

Position currentPosition;
GoogleMapController newGoogleMapController;
var geoLocator = Geolocator();

Future<LatLng> getCurrentLocation() async {
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  currentPosition = position;
  latlngPosition = LatLng(position.latitude, position.longitude);
  center = latlngPosition;
  return latlngPosition;
}

locatePosition() async {
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  currentPosition = position;
  latlngPosition = LatLng(position.latitude, position.longitude);
  CameraPosition cameraPosition =
      CameraPosition(target: latlngPosition, zoom: 17);
  newGoogleMapController
      .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
}

move() async {
  CameraPosition cameraPosition =
      CameraPosition(target: seciliOtopark, zoom: 17);
  newGoogleMapController
      .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
}

moveDestination() async {
  CameraPosition cameraPosition = CameraPosition(target: center, zoom: 17);
  newGoogleMapController
      .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
}

moveDestinationWithTilt() async {
  CameraPosition cameraPosition =
      CameraPosition(target: center, zoom: 17, tilt: 60);
  newGoogleMapController
      .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
}

MarkerService markerService = new MarkerService();
Future<List<MarkerModel>> markerList;

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Raleway'),
      home: SplashScreen(),
    );
  }
}

Completer<GoogleMapController> mapController = Completer();
String otoparkAdi;
String kapasite;
String doluluk;
String uzaklik = "aaaaa";
LatLng seciliOtopark;
String publicId;
void _onMapCreated(GoogleMapController controller) {
  mapController.complete(controller);
  newGoogleMapController = controller;
  locatePosition();
}

class MapScreen extends StatefulWidget {
  MapScreen();

  @override
  _MapScreenState createState() => _MapScreenState();
}

Marker _origin;
Marker _destination;
Directions _info;
List<MarkerModel> dd;

class _MapScreenState extends State<MapScreen> {
  BitmapDescriptor markerIcon;
  bool isTapped = false;

  static const _initialCameraPosition = CameraPosition(
    target: LatLng(40.98950183825638, 28.716782792372992),
    zoom: 11.5,
  );
  @override
  void initState() {
    markerList = markerService.getMarkers();
    BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(16, 16)),
            'assets/images/markerIcon.png')
        .then((onValue) {
      markerIcon = onValue;
    });

    super.initState();
  }

  double bottomPad = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: isTapped == false ? 0 : 160),
          child: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Colors.black45, spreadRadius: 0.5, blurRadius: 14)
            ]),
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: () async {
                await moveDestination();
              },
              child: Icon(
                Icons.my_location,
                color: Color(0xff01b7c3),
              ),
            ),
          ),
        ),
        body: StreamBuilder(
          stream: markersStream(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              return FutureBuilder<Object>(
                  future: snapshot.data,
                  builder: (context, snapshot) {
                    dd = snapshot.data;
                    return Stack(
                      children: [
                        Positioned.fill(
                          child: FutureBuilder(
                              future: getCurrentLocation(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: CircularProgressIndicator(
                                        color: Colors.blue),
                                  );
                                }
                                return GoogleMap(
                                  mapType: MapType.normal,
                                  padding: EdgeInsets.only(),
                                  myLocationEnabled: true,
                                  zoomGesturesEnabled: true,
                                  zoomControlsEnabled: true,
                                  onMapCreated: (controller) {
                                    mapController.complete(controller);
                                    newGoogleMapController = controller;
                                    locatePosition();
                                    setState(() {
                                      bottomPad = 300;
                                    });
                                  },
                                  polylines: {
                                    if (_info != null)
                                      Polyline(
                                          polylineId: PolylineId('polylineid'),
                                          color: Colors.red,
                                          width: 5,
                                          points: _info.polylinePoints
                                              .map((e) => LatLng(
                                                  e.latitude, e.longitude))
                                              .toList())
                                  },
                                  initialCameraPosition: CameraPosition(
                                      target: latlngPosition == null
                                          ? LatLng(42, 36)
                                          : center,
                                      zoom: 17),
                                  markers: Set.from(setMarkers(dd)),
                                  onTap: (a) {
                                    setState(() {
                                      isTapped = false;
                                      _info = null;
                                    });
                                  },
                                );
                              }),
                        ),
                        _info != null
                            ? Positioned(
                                top: 60,
                                left: 60,
                                right: 60,
                                child: Container(
                                  height: 45,
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black45,
                                            blurRadius: 10)
                                      ],
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Row(
                                      children: [
                                        Spacer(),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.drive_eta,
                                              color: Color(0xff01b7c3),
                                              size: 20,
                                            ),
                                            Text(
                                              _info.totalDistance,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 21),
                                            ),
                                          ],
                                        ),
                                        Spacer(),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.timer_sharp,
                                              color: Color(0xff01b7c3),
                                              size: 20,
                                            ),
                                            Text(
                                              _info.totalDuration,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 21),
                                            ),
                                          ],
                                        ),
                                        Spacer(),
                                      ],
                                    ),
                                  ),
                                ))
                            : Container(),
                        isTapped
                            ? Positioned(
                                child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.18,
                                      margin: EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                          bottom: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              25),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: <BoxShadow>[
                                            BoxShadow(
                                                color: Colors.black54,
                                                blurRadius: 10),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Container(
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0, right: 8),
                                              child: Expanded(
                                                flex: 2,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    CircleAvatar(
                                                        radius: 50,
                                                        backgroundImage: AssetImage(
                                                            "assets/images/otopark.jpg"))
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Container(
                                                padding:
                                                    EdgeInsets.only(left: 8),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Spacer(flex: 4),
                                                    InkWell(
                                                      onTap: () async {
                                                        await move();
                                                      },
                                                      child: Text(
                                                          dd
                                                              .singleWhere(
                                                                  (element) =>
                                                                      element
                                                                          .publicId ==
                                                                      publicId)
                                                              .name
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontSize: 17.2,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          )),
                                                    ),
                                                    Spacer(flex: 1),
                                                    Text(
                                                        "Doluluk:" +
                                                            dd
                                                                .singleWhere(
                                                                    (element) =>
                                                                        element
                                                                            .publicId ==
                                                                        publicId)
                                                                .emptyParking
                                                                .toString() +
                                                            "/" +
                                                            dd
                                                                .singleWhere(
                                                                    (element) =>
                                                                        element
                                                                            .publicId ==
                                                                        publicId)
                                                                .capacity
                                                                .toString(),
                                                        style: TextStyle(
                                                          fontSize: 17.2,
                                                        )),
                                                    Text(
                                                        "Kat Sayısı:" +
                                                            dd
                                                                .singleWhere(
                                                                    (element) =>
                                                                        element
                                                                            .publicId ==
                                                                        publicId)
                                                                .sumFloor
                                                                .toString(),
                                                        style: TextStyle(
                                                            fontSize: 17.2,
                                                            color: Color(
                                                                0xff01b7c3))),
                                                    Spacer(flex: 8),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                                flex: 2,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 24.0, left: 12),
                                                      child: IconButton(
                                                          onPressed:
                                                              getDirections,
                                                          icon: Icon(
                                                            Icons.directions,
                                                            color: Color(
                                                                0xff01b7c3),
                                                            size: 52,
                                                          )),
                                                    )
                                                  ],
                                                ))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ))
                            : Container(),
                      ],
                    );
                  });
            }
          },
        ));
  }

  void getDirections() async {
    final directions = await DirectionsRepository().getDirections(
        origin: latlngPosition, destination: _destination.position);
    setState(() {
      print("info doldu");
      _info = directions;
    });
    moveDestinationWithTilt();
  }

  List<Marker> markers = [];

  List<Marker> setMarkers(List<MarkerModel> data) {
    data.forEach((d) => markers.add(new Marker(
        markerId: MarkerId(d.name),
        position: LatLng(d.xCoordinates, d.yCoordinates),
        icon: markerIcon,
        infoWindow: InfoWindow(),
        onTap: () {
          setState(() {
            _info = null;
            center = LatLng(d.xCoordinates, d.yCoordinates);
            otoparkAdi = d.name;
            kapasite = d.capacity.toString();
            doluluk = d.emptyParking.toString();
            seciliOtopark = LatLng(d.xCoordinates, d.yCoordinates);
            publicId = d.publicId;
            _destination = new Marker(
                markerId: MarkerId('destination'),
                position: LatLng(d.xCoordinates, d.yCoordinates));

            isTapped = true;
            setInfo(d);
            move();
          });
          print(d.name);
        })));

    return markers;
  }

  setInfo(MarkerModel d) {
    setState(() {
      print(dd[0].toString());
      otoparkAdi = d.name;
      kapasite = d.capacity.toString();
      doluluk = d.emptyParking.toString();
    });
  }

  markersStream() async* {
    while (true) {
      await Future.delayed(Duration(seconds: 3));
      print("------------------------");
      print("girdi");
      print("-----------------------");
      yield markerService.getMarkers();
      /*Future<List<MarkerModel>> markerList = markerService.getMarkers();
    yield markerList;*/
    }
  }
}
