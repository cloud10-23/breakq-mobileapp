import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/cart_api_model.dart';
import 'package:breakq/data/models/my_order.dart';
import 'package:breakq/screens/orders/widgets/error.dart';
import 'package:breakq/screens/orders/widgets/invoice_widgets.dart';
import 'package:breakq/widgets/back_button.dart';
import 'package:breakq/widgets/theme_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Invoice extends StatelessWidget {
  Invoice({@required this.order});
  final Order order;

  @override
  Widget build(BuildContext context) {
    if (order == null || order.billNo == null) {
      return OrderError();
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // backgroundColor: kWhite,
        title: Text("Invoice"),
        brightness: Brightness.light,
        leading: BackButtonCircle(),
      ),
      backgroundColor: kWhite,
      body: ListView(
        children: [
          InvoiceHeader(
            branch: 'Branch ${order.storeId}',
            address: '<Address>',
          ),
          InvoiceThanksForShopping(),
          Container(color: kWhite, child: Divider(thickness: 2)),
          InvoiceBillDetails(
            billNo: order.billNo.toString(),
            paymentMode: order.paymentMode,
            billDate: order.billDate,
            checkoutType: CheckoutTypes.fromAPItypeToString(order.checkoutType),
            checkoutStatus: order.status,
            paymentStatus: order.paymentStatus,
            gstSummary: "@ 6%",
          ),
          Container(color: kWhite, child: Divider(thickness: 2)),
          SizedBox(height: kPaddingM * 2),
          InvoiceBillItems(
            products: CartProduct.asMap(order.products),
          ),
          SizedBox(height: kPaddingM * 2),
          InvoicePriceDetails(price: order.price),
          SizedBox(height: kPaddingL),
          InvoiceQRCode(billNo: '${order.billNo}'),
        ],
      ),
      bottomNavigationBar: ThemeFilledButton(
        label: 'Go to Home Page',
        icon: FontAwesome.home,
        onPressed: () =>
            Navigator.of(context).popUntil((route) => route.isFirst),
      ),
    );
  }
}
