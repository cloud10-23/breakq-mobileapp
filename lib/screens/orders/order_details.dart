import 'package:breakq/configs/constants.dart';
import 'package:breakq/configs/routes.dart';
import 'package:breakq/data/models/address.dart';
import 'package:breakq/data/models/cart_api_model.dart';
import 'package:breakq/data/models/my_order.dart';
import 'package:breakq/screens/orders/widgets/error.dart';
import 'package:breakq/widgets/back_button.dart';
import 'package:breakq/widgets/card_template.dart';
import 'package:breakq/widgets/price_details.dart';
import 'package:breakq/screens/checkout/widgets/ch_delivery/ch_delivery_address.dart';
import 'package:breakq/screens/checkout/widgets/ch_pickup/time_slot_picker.dart';
import 'package:breakq/screens/checkout/widgets/helper_widgets.dart';
import 'package:flutter/material.dart';
import 'package:breakq/utils/text_style.dart';
import 'package:flutter_icons/flutter_icons.dart';

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
                      'This is a sample answer to the FAQ question that is given above. We can have FAQs and answers like this',
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

    _listItems.add(SliverToBoxAdapter(child: FooterModule()));

    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details: #${widget.order.billNo}'),
        leading: BackButtonCircle(),
        backgroundColor: kWhite,
      ),
      body: CustomScrollView(
        slivers: _listItems,
      ),
      bottomNavigationBar: Container(
        color: kWhite,
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(kPaddingM),
                child: OutlinedButton.icon(
                  onPressed: () =>
                      Navigator.pushNamed(context, Routes.need_help),
                  icon: Icon(Feather.life_buoy),
                  label: Text('Need Help?'),
                  style: OutlinedButton.styleFrom(primary: kBlack),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(kPaddingM),
                child: ElevatedButton.icon(
                    icon: Icon(Feather.file),
                    onPressed: () {
                      Navigator.of(context).pushNamed(Routes.order_invoice,
                          arguments: widget.order);
                    },
                    style: ElevatedButton.styleFrom(primary: kBlue),
                    label: Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: kPaddingL),
                      child: Text('Invoice'),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
