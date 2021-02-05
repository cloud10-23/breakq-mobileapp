import 'package:breakq/blocs/checkout/ch_bloc.dart';
import 'package:breakq/data/models/address.dart';
import 'package:breakq/data/models/checkout_session.dart';
import 'package:breakq/screens/checkout/widgets/helper_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/utils/text_style.dart';

class ChDeliverySelectAddress extends StatefulWidget {
  @override
  _ChDeliverySelectAddressState createState() =>
      _ChDeliverySelectAddressState();
}

class _ChDeliverySelectAddressState extends State<ChDeliverySelectAddress> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutBloc, CheckoutState>(
      builder: (BuildContext context, CheckoutState state) {
        final CheckoutSession session =
            (state as SessionRefreshSuccessChState).session;

        final List<Widget> _listItems = <Widget>[];

        _listItems.add(SliverToBoxAdapter(child: SizedBox(height: kPaddingL)));
        _listItems.add(makeHeader(context, "Select a delivery address"));

        final List<DeliveryAddress> _address = session.address;

        _listItems.add(SliverList(
            delegate: SliverChildBuilderDelegate(
          (context, index) => _addressItem(index, session),
          childCount: _address.length,
        )));

        _listItems.add(_addAddress());

        return CustomScrollView(
          slivers: _listItems,
        );
      },
    );
  }

  Widget _addressItem(int index, CheckoutSession session) {
    int _selectedIndex =
        session.selectedAddress ?? 0; //Get the selected address
    final DeliveryAddress _address = session.address[index];
    return Padding(
      padding: const EdgeInsets.all(kPaddingM),
      child: Card(
        color: (_selectedIndex == index) ? kPrimaryColor : kWhite,
        child: InkWell(
          child: Padding(
            padding: const EdgeInsets.all(kPaddingM * 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  _address.name,
                  style: Theme.of(context).textTheme.subtitle1.w500,
                ),
                // Row(
                //   children: [
                //     Text(
                //       _address.name,
                //       style: Theme.of(context).textTheme.subtitle1.w500,
                //     ),
                //     SizedBox(width: kPaddingL),
                //     Text(
                //       _address.phone,
                //       style: Theme.of(context).textTheme.subtitle2.w300,
                //     ),
                //   ],
                // ),
                SizedBox(height: kPaddingL),
                Text(_address.getFullAddress(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        .w300
                        .copyWith(color: Theme.of(context).hintColor)),
                SizedBox(height: kPaddingS),
                Text("Phone: " + _address.phone,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        .w500
                        .copyWith(color: Theme.of(context).hintColor)),
              ],
            ),
          ),
          onTap: () {
            BlocProvider.of<CheckoutBloc>(context)
                .add(AddressSelectedChEvent(index: index));
          },
        ),
      ),
    );
  }

  Widget _addAddress() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(kPaddingM),
        child: Card(
          child: InkWell(
            child: Padding(
              padding: const EdgeInsets.all(kPaddingM * 2),
              child: Row(
                children: [
                  Icon(Icons.add),
                  SizedBox(width: kPaddingL),
                  Text(
                    "Add Address",
                    style: Theme.of(context).textTheme.subtitle2.w500,
                  ),
                ],
              ),
            ),
            onTap: () {
              // BlocProvider.of<CheckoutBloc>(context)
              //     .add(CheckoutTypeSelectedChEvent(type: _type));
            },
          ),
        ),
      ),
    );
  }
}
