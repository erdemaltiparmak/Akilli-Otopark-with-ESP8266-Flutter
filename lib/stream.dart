import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ilkproje/service/marker_service.dart';

import 'model/marker_model.dart';

class StreamDemo extends StatefulWidget {
  StreamDemo({Key key}) : super(key: key);

  @override
  _StreamDemoState createState() => _StreamDemoState();
}

var markerService = MarkerService();
Future<List<MarkerModel>> markerList;

class _StreamDemoState extends State<StreamDemo> {
  @override
  void initState() {
    markerList = markerService.getMarkers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: markersStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: Text(snapshot.data.toString()),
            );
          }
          return FutureBuilder(
              future: snapshot.data,
              builder: (context, snapshot) {
                return Scaffold(
                  body: Container(
                    child: Center(child: Text(snapshot.toString())),
                  ),
                );
              });
        });
  }
}

Stream<Future<List<MarkerModel>>> markersStream() async* {
  while (true) {
    await Future.delayed(Duration(milliseconds: 500));
    Future<List<MarkerModel>> markerList = markerService.getMarkers();
    yield markerList;
  }
}
