import 'dart:async';
import 'dart:convert';
import 'package:ilkproje/model/marker_model.dart';
import 'package:http/http.dart' as http;

class MarkerService {
  Future<List<MarkerModel>> getMarkers() async {
    final data = await http.Client()
        .get(Uri.parse("https://akilli-otopark-app.herokuapp.com/api/otopark"));

    if (data.statusCode != 200) throw Exception();

    List<MarkerModel> markerList = (json.decode(data.body) as List)
        .map((item) => new MarkerModel.fromJson(item))
        .toList();

    return markerList;
  }
}
