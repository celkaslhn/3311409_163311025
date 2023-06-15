// To parse this JSON data, do
//
//     final cars = carsFromJson(jsonString);

import 'dart:convert';

List<Cars> carsFromJson(String str) =>
    List<Cars>.from(json.decode(str).map((x) => Cars.fromJson(x)));

String carsToJson(List<Cars> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Cars {
  String name;
  String licensePlate;
  String carColor;
  String job;
  

  Cars({
    required this.name,
    required this.licensePlate,
    required this.carColor,
    required this.job,
    
  });

  factory Cars.fromJson(Map<String, dynamic> json) => Cars(
        name: json["name"],
        licensePlate: json["license_plate"],
        carColor: json["car-color"],
        //   registerCarQty: json["register-car-qty"],
        job: json["job"],
       
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "license_plate": licensePlate,
        "car-color": carColor,
        //  "register-car-qty": registerCarQty,
        "job": job,
  
      };
}


class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
