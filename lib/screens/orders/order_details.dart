import 'package:breakq/configs/constants.dart';
import 'package:breakq/configs/routes.dart';
import 'package:breakq/data/models/address.dart';
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
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
    final List<Widget> _listItems = <Widget>[];

    _listItems.add(SliverToBoxAdapter(
        child: CheckoutTypeModule(
      index: 2,
      isReadOnly: true,
    )));

    _listItems
        .add(SliverToBoxAdapter(child: ShowQRModule(billNo: '1234567890')));

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

    _listItems.add(SliverToBoxAdapter(
        child: DisplaySelectedAddress(
      address: Address(
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

    _listItems.add(SliverToBoxAdapter(
        child: DisplaySelectedTimeSlot(time: DateTime(2021, 1, 1, 13, 0))));

    _listItems.add(SliverToBoxAdapter(
      child: CartProductsModule(products: generateSampleProducts()),
    ));

    _listItems.add(SliverToBoxAdapter(
      child: PriceDetails(
        price: generateSamplePrice(),
      ),
    ));

    _listItems.add(SliverToBoxAdapter(child: FooterModule()));

    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details: #1234567890'),
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
                      Navigator.of(context).pushNamed(Routes.order_invoice);
                    },
                    style: ElevatedButton.styleFrom(primary: kBlue),
                    label: Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: kPaddingL),
                      child: Text('Show Invoice'),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
