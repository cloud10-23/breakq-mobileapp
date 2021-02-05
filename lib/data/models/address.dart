class DeliveryAddress {
  final String name;
  final String addLine1;
  final String addLine2;
  final String cityDistTown;
  final String state;
  final String landmark;
  final String phone;
  final String pinCode;

  DeliveryAddress({
    this.name,
    this.addLine1,
    this.addLine2,
    this.cityDistTown,
    this.state,
    this.landmark,
    this.phone,
    this.pinCode,
  });

  DeliveryAddress rebuild({
    String name,
    String addLine1,
    String addLine2,
    String cityDistTown,
    String state,
    String landmark,
    String phone,
    String pinCode,
  }) {
    return DeliveryAddress(
      name: name ?? this.name,
      addLine1: addLine1 ?? this.addLine1,
      addLine2: addLine2 ?? this.addLine2,
      cityDistTown: cityDistTown ?? this.cityDistTown,
      state: state ?? this.state,
      landmark: landmark ?? this.landmark,
      phone: phone ?? this.phone,
      pinCode: pinCode ?? this.pinCode,
    );
  }

  String getFullAddress() {
    return this.addLine1 +
        ", " +
        this.addLine2 +
        ", " +
        this.cityDistTown +
        ", " +
        this.pinCode +
        ", " +
        this.state;
  }

  @override
  String toString() {
    return "Delivery Address Model";
  }
}
