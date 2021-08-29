import 'package:json_annotation/json_annotation.dart';
part 'price_model.g.dart';

@JsonSerializable(createToJson: false)
class Price {
  Price({
    this.price,
    this.discount,
    this.extraOffer,
    this.delivery,
    this.totalAmnt,
    this.savings,
  });

  factory Price.addPrice(Price oldPrice, double price) {
    return Price(
      price: price,
      discount: oldPrice.discount,
      extraOffer: oldPrice.extraOffer,
      totalAmnt: oldPrice.totalAmnt,
      savings: oldPrice.savings,
    );
  }

  factory Price.calc(double orgPrice, double price, {double extraOffer = 10}) {
    return Price(
      price: orgPrice,
      discount: orgPrice - price,
      extraOffer: extraOffer,
      totalAmnt: price - extraOffer,
      savings: orgPrice - price + extraOffer,
    );
  }

  factory Price.addDelivery(Price oldPrice, double delivery) {
    return Price(
      price: oldPrice.price,
      discount: oldPrice.discount,
      extraOffer: oldPrice.extraOffer,
      delivery: delivery,
      totalAmnt: oldPrice.totalAmnt + delivery,
      savings: oldPrice.savings - delivery,
    );
  }

  // factory Price.fromJson(Map<String, dynamic> json) {
  //   return Price(
  //     json['bill_no'] as String ?? '0',
  //     json['bill_amnt'] as double ?? 0.0,
  //     DateTime.tryParse(json['bill_date'] as String ?? '') ?? DateTime.now(),
  //     Cart.fromJson(json['products'] as List<dynamic>),
  //   );
  // }

  factory Price.fromJson(Map<String, dynamic> json) => _$PriceFromJson(json);

  final double price;
  @JsonKey(name: "discount")
  final double discount;
  @JsonKey(name: "extra_Offer")
  final double extraOffer;
  @JsonKey(name: "delivery_Charges")
  final double delivery;
  @JsonKey(name: "final_Amount")
  final double totalAmnt;
  @JsonKey(name: "savings")
  final double savings;
}
