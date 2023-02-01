import 'package:infinite_scroll_bloc/domain/entities/airline.entity.dart';

class PassengerEntity {
  String? sId;
  String? name;
  int? trips;
  List<AirlineEntity>? airline;
  int? iV;

  PassengerEntity({this.sId, this.name, this.trips, this.airline, this.iV});

  PassengerEntity.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    trips = json['trips'];
    if (json['airline'] != null) {
      airline = <AirlineEntity>[];
      json['airline'].forEach((v) {
        airline!.add(AirlineEntity.fromJson(v));
      });
    }
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['trips'] = trips;
    if (airline != null) {
      data['airline'] = airline!.map((v) => v.toJson()).toList();
    }
    data['__v'] = iV;
    return data;
  }
}
