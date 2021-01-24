import 'package:breakq/data/models/bill_model.dart';
import 'package:breakq/data/models/product_model.dart';

class QSSessionModel {
  QSSessionModel({
    this.bills,
    this.products,
    this.selectedBillIds,
    this.selectedProductIds,
    this.isSubmitted = false,
    this.isLoading = false,
    this.apiError = '',
  });

  QSSessionModel rebuild({
    List<Bill> bills,
    List<Product> products,
    List<String> selectedBillIds,
    Map<int, int> selectedProductIds,
    bool isSubmitted,
    bool isLoading,
    String apiError,
  }) {
    return QSSessionModel(
      bills: bills ?? this.bills,
      products: products ?? this.products,
      selectedBillIds: selectedBillIds ?? this.selectedBillIds,
      selectedProductIds: selectedProductIds ?? this.selectedProductIds,
      isSubmitted: isSubmitted ?? this.isSubmitted,
      isLoading: isLoading ?? this.isLoading,
      apiError: apiError ?? '',
    );
  }

  final List<Bill> bills;
  final List<Product> products;
  final List<String> selectedBillIds;
  final Map<int, int> selectedProductIds;
  final bool isSubmitted, isLoading;
  final String apiError;

  @override
  String toString() {
    return '''BookingSessionModel:
    selectedBills: $selectedBillIds
    totalProducts: ${selectedProductIds?.length ?? 0}''';
  }
}
