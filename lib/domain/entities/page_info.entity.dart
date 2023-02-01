import 'package:infinite_scroll_bloc/domain/entities/passanger.entity.dart';

class PageInfoEntity {
  int? totalPassengers;
  int? totalPages;
  List<PassengerEntity>? passengers;

  PageInfoEntity({this.totalPassengers, this.totalPages, this.passengers});

  PageInfoEntity.fromJson(Map<String, dynamic> json) {
    totalPassengers = json['totalPassengers'];
    totalPages = json['totalPages'];
    if (json['data'] != null) {
      passengers = <PassengerEntity>[];
      json['data'].forEach((v) {
        passengers?.add(PassengerEntity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalPassengers'] = totalPassengers;
    data['totalPages'] = totalPages;
    data['data'] = passengers?.map((v) => v.toJson()).toList();
    return data;
  }
}
