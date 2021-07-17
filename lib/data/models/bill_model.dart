import 'package:breakq/data/models/cart_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bill_model.g.dart';

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class Bill {
  Bill(
    this.billNo,
    this.billAmnt,
    this.billDate,
    this.products,
  );

  factory Bill.fromJson(Map<String, dynamic> json) => _$BillFromJson(json);

  final String billNo;
  final double billAmnt;
  final DateTime billDate;
  @JsonKey(fromJson: _fromProducts)
  final Cart products;

  static Cart _fromProducts(List<dynamic> products) => Cart.fromJson(products);
}
