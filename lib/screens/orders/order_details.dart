import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/address.dart';
import 'package:breakq/data/models/price_model.dart';
import 'package:breakq/data/models/product_model.dart';
import 'package:breakq/widgets/card_template.dart';
import 'package:breakq/widgets/price_details.dart';
import 'package:breakq/screens/checkout/widgets/ch_delivery/ch_delivery_address.dart';
import 'package:breakq/screens/checkout/widgets/ch_pickup/time_slot_picker.dart';
import 'package:breakq/screens/checkout/widgets/helper_widgets.dart';
import 'package:flutter/material.dart';
import 'package:breakq/utils/text_style.dart';

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
      address: DeliveryAddress(
        name: "Jon Doe",
        addLine1: "No. 5, 5th Lane",
        addLine2: "Church Street",
        cityDistTown: "Riverdale",
        state: "California",
        pinCode: "610032",
        landmark: "DineOut Restraunt",
        phone: "1234567890",
      ),
    )));

    _listItems.add(SliverToBoxAdapter(
        child: DisplaySelectedTimeSlot(time: DateTime(2021, 1, 1, 13, 0))));

    _listItems.add(SliverToBoxAdapter(
      child: CartProductsModule(products: {
        Product(
          id: 100,
          image: AssetImages.maggi,
          oldPrice: 60,
          price: 40,
          quantity: '500 gm',
          title: 'Maggi',
        ): 2,
        Product(
          id: 101,
          image: AssetImages.dove,
          oldPrice: 100,
          price: 70,
          quantity: '500 ml',
          title: 'Dove',
        ): 4,
        Product(
          id: 102,
          image: AssetImages.wheat,
          oldPrice: 500,
          price: 490,
          quantity: '5 kg',
          title: 'Aashirvad Atta',
        ): 1,
      }),
    ));

    _listItems.add(SliverToBoxAdapter(
      child: PriceDetails(
          price: Price(
              price: 660,
              discount: 50,
              totalAmnt: 650,
              extraOffer: 10,
              savings: 10,
              delivery: 50)),
    ));

    _listItems.add(SliverToBoxAdapter(child: FooterModule()));

    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details: #1234567890'),
        backgroundColor: kWhite,
      ),
      body: CustomScrollView(
        slivers: _listItems,
      ),
      bottomNavigationBar: Container(
        color: kWhite,
        child: ButtonBar(
          alignment: MainAxisAlignment.spaceEvenly,
          children: [
            OutlineButton(
              onPressed: () {},
              child: Text('Need Help?'),
              textColor: kBlack,
            ),
            RaisedButton(onPressed: () {}, child: Text('Download Invoice PDF')),
          ],
        ),
      ),
    );
  }
}
