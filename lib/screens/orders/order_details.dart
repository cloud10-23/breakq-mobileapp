import 'package:breakq/configs/constants.dart';
import 'package:breakq/configs/routes.dart';
import 'package:breakq/data/models/address.dart';
import 'package:breakq/data/models/cart_api_model.dart';
import 'package:breakq/data/models/my_order.dart';
import 'package:breakq/screens/orders/widgets/error.dart';
import 'package:breakq/screens/orders/widgets/invoice.dart';
import 'package:breakq/widgets/back_button.dart';
import 'package:breakq/widgets/card_template.dart';
import 'package:breakq/widgets/price_details.dart';
import 'package:breakq/screens/checkout/widgets/ch_delivery/ch_delivery_address.dart';
import 'package:breakq/screens/checkout/widgets/ch_pickup/time_slot_picker.dart';
import 'package:breakq/screens/checkout/widgets/helper_widgets.dart';
import 'package:breakq/widgets/theme_button.dart';
import 'package:flutter/material.dart';
import 'package:breakq/utils/text_style.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:pdf/pdf.dart';

class OrderDetails extends StatefulWidget {
  OrderDetails({@required this.order});
  final Order order;
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
    final List<Widget> _listItems = <Widget>[];

    if (widget.order == null || widget.order.billNo == null) {
      return OrderError();
    }

    CheckoutType checkoutType =
        CheckoutTypes.fromAPItypeToEnum(widget.order.checkoutType);

    _listItems.add(SliverToBoxAdapter(
        child: CheckoutTypeModule(
      index: checkoutType.index,
      isReadOnly: true,
    )));

    _listItems.add(SliverToBoxAdapter(
        child: ShowQRModule(billNo: '${widget.order.billNo}')));

    _listItems.add(SliverToBoxAdapter(
        child: CartHeading(
            title: 'FAQs',
            isCaps: false,
            children: List.generate(
              3,
              (index) => ExpansionTile(
                title: Text(
                  'What if question - ${index + 1} ?',
                  style: Theme.of(context).textTheme.caption.fs14.w500,
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: kPaddingL, right: kPaddingM, bottom: kPaddingL),
                    child: Text(
                      'This is a sample answer to the FAQ question that is'
                      ' given above. We can have FAQs and answers like this',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  )
                ],
              ),
            ))));

    if (checkoutType == CheckoutType.delivery) {
      _listItems.add(SliverToBoxAdapter(
          child: DisplaySelectedAddress(
        address: widget.order?.address ??
            Address(
              fullName: "Jon Doe",
              houseNo: "No. 5, 5th Lane",
              street: "Church Street",
              city: "Riverdale",
              state: "California",
              pinCode: "610032",
              landmark: "DineOut Restraunt",
              phone: "1234567890",
            ),
      )));
    }

    if (checkoutType != CheckoutType.walkIn) {
      _listItems.add(SliverToBoxAdapter(
          child: DisplaySelectedTimeSlot(
        time: widget.order?.timeSlot?.time ?? "",
        date: widget.order?.timeSlot?.date ?? "",
      )));
    }

    _listItems.add(SliverToBoxAdapter(
        child: CartProductsModule(
      products: CartProduct.asMap(widget.order.products),
    )));

    _listItems.add(SliverToBoxAdapter(
      child: PriceDetails(
        price: widget.order.price,
      ),
    ));

    _listItems.add(SliverToBoxAdapter(child: SizedBox(height: kPaddingL)));

    _listItems.add(SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: kPaddingM, vertical: kPaddingS),
        child: ElevatedButton.icon(
          icon: Icon(Ionicons.md_download),
          label: Text('Download Invoice'.toUpperCase()),
          style: ElevatedButton.styleFrom(primary: kPrimaryColor),
          onPressed: () {
            generateInvoice(widget.order, PdfPageFormat.a4);
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Download in progress...')));
          },
        ),
      ),
    ));

    _listItems.add(SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kPaddingM),
        child: ElevatedButton.icon(
          icon: Icon(Ionicons.ios_close_circle),
          label: Text('Cancel Order'.toUpperCase()),
          style: ElevatedButton.styleFrom(primary: Colors.redAccent),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    ));

    _listItems.add(SliverToBoxAdapter(child: FooterModule()));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order Details: #${widget.order.billNo}',
          style: TextStyle(
            color: kWhite,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
          ),
        ),
        leading: BackButtonCircle(),
      ),
      body: CustomScrollView(
        slivers: _listItems,
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
                label: 'Need Help?',
                icon: Feather.life_buoy,
                onPressed: () => Navigator.pushNamed(context, Routes.need_help),
              ),
            ),
            Expanded(
              child: ThemeFilledButton(
                alternate: true,
                label: 'Invoice',
                icon: Feather.file,
                onPressed: () => Navigator.of(context)
                    .pushNamed(Routes.order_invoice, arguments: widget.order),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
