class Price {
  Price({
    this.price,
    this.discount,
    this.extraOffer,
    this.totalAmnt,
    this.savings,
  });

  factory Price.calc(double orgPrice, double price, {double extraOffer = 10}) {
    return Price(
      price: orgPrice,
      discount: orgPrice - price,
      extraOffer: extraOffer,
      totalAmnt: price - extraOffer,
      savings: orgPrice - price + extraOffer,
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

  final double price;
  final double discount;
  final double extraOffer;
  final double totalAmnt;
  final double savings;
}
