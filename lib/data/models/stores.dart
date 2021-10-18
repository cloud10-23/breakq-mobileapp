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
  });

  factory Store.rebuild(Store store) {
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
    );
  }

  factory Store.fromJson(Map<String, dynamic> json) => _$StoreFromJson(json);

  Map<String, dynamic> toJson() => _$StoreToJson(this);
}
