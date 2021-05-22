class MarkerModel {
  String publicId;
  String name;
  int capacity;
  int sumFloor;
  int emptyParking;
  double xCoordinates;
  double yCoordinates;
  List<Parkings> parkings;

  MarkerModel(
      {this.publicId,
      this.name,
      this.capacity,
      this.sumFloor,
      this.emptyParking,
      this.xCoordinates,
      this.yCoordinates,
      this.parkings});

  MarkerModel.fromJson(Map<String, dynamic> json) {
    publicId = json['publicId'];
    name = json['name'];
    capacity = json['capacity'];
    sumFloor = json['sumFloor'];
    emptyParking = json['emptyParking'];
    xCoordinates = json['xCoordinates'];
    yCoordinates = json['yCoordinates'];
    if (json['parkings'] != null) {
      parkings = new List<Parkings>();
      json['parkings'].forEach((v) {
        parkings.add(new Parkings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['publicId'] = this.publicId;
    data['name'] = this.name;
    data['capacity'] = this.capacity;
    data['sumFloor'] = this.sumFloor;
    data['emptyParking'] = this.emptyParking;
    data['xCoordinates'] = this.xCoordinates;
    data['yCoordinates'] = this.yCoordinates;
    if (this.parkings != null) {
      data['parkings'] = this.parkings.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Parkings {
  String publicId;
  String whosePlace;
  int floor;
  int number;
  String status;

  Parkings(
      this.publicId, this.whosePlace, this.floor, this.number, this.status);

  Parkings.fromJson(Map<String, dynamic> json) {
    publicId = json['publicId'];
    whosePlace = json['whosePlace'];
    floor = json['floor'];
    number = json['number'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['publicId'] = this.publicId;
    data['whosePlace'] = this.whosePlace;
    data['floor'] = this.floor;
    data['number'] = this.number;
    data['status'] = this.status;
    return data;
  }
}
