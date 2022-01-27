import 'dart:math';

import 'package:json_annotation/json_annotation.dart';

part 'stores.g.dart';

@JsonSerializable()
class Store {
  final int storeId;
  final String mobileNo;
  final String branchName;
  final String branchStore;
  final String state;
  final String city;
  final String pinCode;
  final String country;
  final String latitude;
  final String longitude;
  final double distance;

  Store({
    this.storeId,
    this.mobileNo,
    this.branchName,
    this.branchStore,
    this.state,
    this.city,
    this.pinCode,
    this.country,
    this.latitude,
    this.longitude,
    this.distance,
  });

  factory Store.rebuild(Store store, lat, long) {
    return Store(
      storeId: store.storeId,
      mobileNo: store.mobileNo,
      branchName: store.branchName,
      branchStore: store.branchStore,
      state: store.state,
      city: store.city,
      pinCode: store.pinCode,
      country: store.country,
      latitude: store.latitude,
      longitude: store.longitude,
      distance: calculateDistance(double.tryParse(store.latitude),
          double.tryParse(store.longitude), lat, long),
    );
  }

  static double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  factory Store.fromJson(Map<String, dynamic> json) => _$StoreFromJson(json);

  Map<String, dynamic> toJson() => _$StoreToJson(this);
}
