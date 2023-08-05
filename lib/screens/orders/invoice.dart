import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/cart_api_model.dart';
import 'package:breakq/data/models/my_order.dart';
import 'package:breakq/screens/orders/widgets/error.dart';
import 'package:breakq/screens/orders/widgets/invoice.dart';
import 'package:breakq/screens/orders/widgets/invoice_widgets.dart';
import 'package:breakq/widgets/back_button.dart';
import 'package:breakq/widgets/theme_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:pdf/pdf.dart';

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
        leading: BackButtonCircle(), systemOverlayStyle: SystemUiOverlayStyle.dark,
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
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
              top: BorderSide(color: kBlue, width: 2),
              bottom: BorderSide(color: kBlue, width: 2)),
        ),
        child: Row(
          children: [
            Expanded(
              child: ThemeFilledButton(
                label: 'Go to Home Page',
                icon: FontAwesome.home,
                onPressed: () =>
                    Navigator.of(context).popUntil((route) => route.isFirst),
              ),
            ),
            Expanded(
              child: ThemeFilledButton(
                alternate: true,
                label: 'Download Invoice',
                icon: FontAwesome.download,
                onPressed: () {
                  generateInvoice(order, PdfPageFormat.a4);
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Download in progress...')));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
