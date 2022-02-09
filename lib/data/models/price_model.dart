import 'package:json_annotation/json_annotation.dart';
part 'price_model.g.dart';

@JsonSerializable(createToJson: false)
class Price {
  Price({
    this.totalAmount,
    this.discount,
    this.extraOffer,
    this.delivery,
    this.finalAmount,
    this.savings,
  });

  factory Price.addPrice(Price oldPrice, double price) {
    return Price(
      totalAmount: price,
      discount: oldPrice.discount,
      extraOffer: oldPrice.extraOffer,
      finalAmount: oldPrice.finalAmount,
      savings: oldPrice.savings,
    );
  }

  factory Price.addProduct(Price oldPrice, double productPrice) {
    return Price(
      totalAmount: (oldPrice.finalAmount ?? 0) + productPrice,
      discount: oldPrice.discount,
      extraOffer: oldPrice.extraOffer,
      finalAmount: (oldPrice.finalAmount ?? 0) + productPrice,
      savings: oldPrice.savings,
    );
  }

  factory Price.calc(double orgPrice, double price, {double extraOffer = 0}) {
    return Price(
      totalAmount: orgPrice,
      discount: orgPrice - price,
      extraOffer: extraOffer,
      finalAmount: price - extraOffer,
      savings: orgPrice - price + extraOffer,
    );
  }

  factory Price.addDelivery(Price oldPrice, double delivery) {
    return Price(
      totalAmount: oldPrice.totalAmount,
      discount: oldPrice.discount,
      extraOffer: oldPrice.extraOffer,
      delivery: delivery,
      finalAmount: oldPrice.finalAmount + delivery,
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

  @JsonKey(name: "totalAmount")
  final double totalAmount;
  @JsonKey(name: "discount")
  final double discount;
  @JsonKey(name: "extra_Offer")
  final double extraOffer;
  @JsonKey(name: "delivery_Charges")
  final double delivery;
  @JsonKey(name: "final_Amount")
  final double finalAmount;
  @JsonKey(name: "savings")
  final double savings;
}
