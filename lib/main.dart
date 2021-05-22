import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ilkproje/directions_repository.dart';
import 'package:ilkproje/model/directions_model.dart';
import 'package:ilkproje/stream.dart';

import 'model/marker_model.dart';
import 'service/marker_service.dart';

void main() {
  runApp(MyApp());
}

LatLng latlngPosition;
Position currentPosition;
GoogleMapController newGoogleMapController;
var geoLocator = Geolocator();

Future<LatLng> getCurrentLocation() async {
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  currentPosition = position;
  latlngPosition = LatLng(position.latitude, position.longitude);
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

MarkerService markerService = new MarkerService();
Future<List<MarkerModel>> markerList;

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Raleway'),
      home: MapScreen(),
    );
  }
}

Completer<GoogleMapController> mapController = Completer();
String otoparkAdi;
String kapasite;
String doluluk;
String uzaklik = "aaaaa";
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

class _MapScreenState extends State<MapScreen> {
  BitmapDescriptor markerIcon;

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
        body: FutureBuilder(
      future: markerList,
      builder: (context, AsyncSnapshot<List<MarkerModel>> snapshot) {
        List<MarkerModel> data;
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else {
          data = snapshot.data;
          return Stack(
            children: [
              Positioned.fill(
                child: FutureBuilder(
                    future: getCurrentLocation(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(color: Colors.blue),
                        );
                      }
                      return GoogleMap(
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
                                    .map((e) => LatLng(e.latitude, e.longitude))
                                    .toList())
                        },
                        initialCameraPosition: CameraPosition(
                            target: latlngPosition == null
                                ? LatLng(42, 36)
                                : latlngPosition,
                            zoom: 17),
                        markers: Set.from(setMarkers(data)),
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
                  ? Align(
                      alignment: Alignment.topCenter,
                      child: Positioned(
                          top: 50,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(15)),
                            child: Container(
                              child: Text(
                                _info.totalDistance + _info.totalDuration,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 21),
                              ),
                            ),
                          )),
                    )
                  : Container(),
              isTapped
                  ? Positioned(
                      child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.18,
                            margin: EdgeInsets.only(
                                left: 20,
                                right: 20,
                                bottom:
                                    MediaQuery.of(context).size.height / 25),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: Colors.black54, blurRadius: 10),
                                ],
                                borderRadius: BorderRadius.circular(20)),
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
                                      padding: EdgeInsets.only(left: 8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Spacer(flex: 4),
                                          Text(otoparkAdi,
                                              style: TextStyle(
                                                fontSize: 17.2,
                                                fontWeight: FontWeight.bold,
                                              )),
                                          Spacer(flex: 1),
                                          Text(
                                              "Doluluk:" +
                                                  doluluk +
                                                  "/" +
                                                  kapasite,
                                              style: TextStyle(
                                                fontSize: 17.2,
                                              )),
                                          Text("otoparkUzaklik",
                                              style: TextStyle(
                                                  fontSize: 17.2,
                                                  color: Color(0xff01b7c3))),
                                          Spacer(flex: 8),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(top: 24.0),
                                            child: IconButton(
                                                onPressed: getDirections,
                                                icon: Icon(
                                                  Icons.directions,
                                                  color: Color(0xff01b7c3),
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
                  : Container()
            ],
          );
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
  }

  bool isTapped = false;
  List<Marker> markers = [];

  List<Marker> setMarkers(List<MarkerModel> data) {
    data.forEach((d) => markers.add(new Marker(
        markerId: MarkerId(d.name),
        position: LatLng(d.xCoordinates, d.yCoordinates),
        icon: markerIcon,
        infoWindow: InfoWindow(),
        onTap: () {
          setState(() {
            otoparkAdi = d.name;
            kapasite = d.capacity.toString();
            doluluk = d.emptyParking.toString();
            _destination = new Marker(
                markerId: MarkerId('destination'),
                position: LatLng(d.xCoordinates, d.yCoordinates));

            isTapped = true;
          });
          print(d.name);
        })));
    return markers;
  }
}

// class NewWidget extends StatefulWidget {
//   const NewWidget({
//     Key key,
//   }) : super(key: key);

//   @override
//   _NewWidgetState createState() => _NewWidgetState();
// }

// class _NewWidgetState extends State<NewWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return ;
//   }
// }