import 'package:breakq/blocs/checkout/ch_bloc.dart';
import 'package:breakq/configs/routes.dart';
import 'package:breakq/data/models/address.dart';
import 'package:breakq/data/models/checkout_session.dart';
import 'package:breakq/screens/checkout/widgets/radio_helper.dart';
import 'package:breakq/widgets/card_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/utils/text_style.dart';

class DeliveryAddressModule extends StatefulWidget {
  DeliveryAddressModule({this.session});
  final CheckoutSession session;
  @override
  _DeliveryAddressModuleState createState() => _DeliveryAddressModuleState();
}

class _DeliveryAddressModuleState extends State<DeliveryAddressModule> {
  @override
  Widget build(BuildContext context) {
    final List<Widget> _listItems = <Widget>[];

    final List<Address> _address = widget.session.address;

    _listItems.add(_addAddress());

    _listItems.addAll(List.generate(
      _address.length,
      (index) => _addressItem(index, widget.session),
    ));

    return CartHeading(title: 'Select Address', children: _listItems);
  }

  Widget _addressItem(int index, CheckoutSession session) {
    int _selectedIndex =
        session.selectedAddress ?? 0; //Get the selected address
    final Address _address = session.address[index];

    final Widget _child = Padding(
      padding: const EdgeInsets.symmetric(
          vertical: kPaddingM * 1.5, horizontal: kPaddingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Text(
                _address.fullName,
                style: Theme.of(context).textTheme.bodyText2.w600,
              ),
              Spacer(),
              if (_selectedIndex == index)
                InkWell(
                  onTap: () {
                    Navigator.of(context, rootNavigator: true)
                        .pushNamed(Routes.add_address);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: kWhite,
                      borderRadius: const BorderRadius.all(
                          Radius.circular(kRoundedButtonRadius)),
                    ),
                    padding: EdgeInsets.all(kPaddingS),
                    child: Text('EDIT',
                        style: Theme.of(context).textTheme.caption.w700),
                  ),
                ),
            ],
          ),
          SizedBox(height: kPaddingM),
          Text(_address.getFullAddress(),
              style: Theme.of(context).textTheme.caption.w500),
          SizedBox(height: kPaddingS),
          Text("Phone: " + _address.phone,
              style: Theme.of(context).textTheme.caption.w700),
        ],
      ),
    );

    if (_selectedIndex == index)
      return Padding(
        padding: const EdgeInsets.all(kPaddingS),
        child: Card(
          child: InkWell(
            child: CustomPaint(
              painter: RadioCustomPainter(index: 0),
              child: _child,
            ),
            onTap: () {
              BlocProvider.of<CheckoutBloc>(context)
                  .add(AddressSelectedChEvent(index: index));
            },
          ),
        ),
      );
    return Padding(
      padding: const EdgeInsets.all(kPaddingS),
      child: Card(
        child: InkWell(
          child: _child,
          onTap: () {
            BlocProvider.of<CheckoutBloc>(context)
                .add(AddressSelectedChEvent(index: index));
          },
        ),
      ),
    );
  }

  Widget _addAddress() {
    return Padding(
      padding: const EdgeInsets.only(
          bottom: kPaddingS, left: kPaddingS, right: kPaddingS),
      child: Card(
        child: InkWell(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: kPaddingM * 1.5, horizontal: kPaddingL),
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
            Navigator.of(context, rootNavigator: true)
                .pushNamed(Routes.add_address);
            // BlocProvider.of<CheckoutBloc>(context)
            //     .add(CheckoutTypeSelectedChEvent(type: _type));
          },
        ),
      ),
    );
  }
}

class DisplaySelectedAddress extends StatelessWidget {
  DisplaySelectedAddress({@required this.address});

  final Address address;
  @override
  Widget build(BuildContext context) {
    final Widget _child = Padding(
      padding: const EdgeInsets.symmetric(
          vertical: kPaddingM * 1.5, horizontal: kPaddingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            address.fullName,
            style: Theme.of(context).textTheme.bodyText2.w600,
          ),
          SizedBox(height: kPaddingM),
          Text(address.getFullAddress(),
              style: Theme.of(context).textTheme.caption.w500),
          SizedBox(height: kPaddingS),
          Text("Phone: " + address.phone,
              style: Theme.of(context).textTheme.caption.w700),
        ],
      ),
    );

    return CartHeading(title: "Delivery Address", children: [
      Padding(
        padding: const EdgeInsets.all(kPaddingS),
        child: Card(
          child: CustomPaint(
            painter: RadioCustomPainter(index: 0),
            child: _child,
          ),
        ),
      ),
    ]);
  }
}
