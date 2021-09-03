import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/cart_api_model.dart';
import 'package:breakq/data/models/my_order.dart';
import 'package:breakq/screens/orders/widgets/invoice_widgets.dart';
import 'package:breakq/widgets/back_button.dart';
import 'package:flutter/material.dart';

class Invoice extends StatelessWidget {
  Invoice({@required this.order});
  final Order order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Invoice"),
          leading: BackButtonCircle(),
        ),
        backgroundColor: kWhite,
        body: SingleChildScrollView(
          child: Column(
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
        ));
  }
}
