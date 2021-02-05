import 'package:breakq/blocs/checkout/ch_bloc.dart';
import 'package:breakq/data/models/checkout_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/utils/text_style.dart';

class CheckoutBaseStep extends StatefulWidget {
  const CheckoutBaseStep({
    Key key,
  }) : super(key: key);

  @override
  _CheckoutBaseStepState createState() => _CheckoutBaseStepState();
}

class _CheckoutBaseStepState extends State<CheckoutBaseStep> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutBloc, CheckoutState>(
      buildWhen: (previous, current) => current is SessionRefreshSuccessChState,
      builder: (BuildContext context, CheckoutState state) {
        if (state is SessionRefreshSuccessChState) {
          final CheckoutSession session = state.session;

          final List<Widget> _slivers = <Widget>[];

          _slivers.add(SliverToBoxAdapter(child: SizedBox(height: kPaddingL)));
          _slivers.add(SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kPaddingM),
                  child: _typeOfItems(index, session)),
              childCount: 3,
            ),
          ));

          return CustomScrollView(slivers: _slivers);
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _typeOfItems(int index, CheckoutSession session) {
    CheckoutType _type = CheckoutType.values[index];
    int _selectedIndex = session.currentStep.checkoutType.index;
    return Padding(
      padding: const EdgeInsets.all(kPaddingM),
      child: Card(
        color: (_selectedIndex == index) ? kPrimaryColor : kWhite,
        child: InkWell(
          child: Padding(
            padding: const EdgeInsets.all(kPaddingM * 2),
            child: Row(
              children: [
                Flexible(
                    child: Image(
                        image: AssetImage(AssetImages.checkoutImages(index)))),
                Spacer(),
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        CheckoutTypes.typeToString(_type),
                        style: Theme.of(context).textTheme.subtitle2.w500,
                      ),
                      SizedBox(height: kPaddingM),
                      Text(CheckoutTypes.typeDescription(_type),
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              .w300
                              .copyWith(color: Theme.of(context).hintColor)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          onTap: () {
            BlocProvider.of<CheckoutBloc>(context)
                .add(CheckoutTypeSelectedChEvent(type: _type));
          },
        ),
      ),
    );
  }
}
