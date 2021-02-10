import 'package:breakq/blocs/checkout/ch_bloc.dart';
import 'package:breakq/data/models/checkout_session.dart';
import 'package:breakq/screens/checkout/widgets/radio_helper.dart';
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

          _slivers.add(SliverToBoxAdapter(
              child: Container(
            height: 50.0,
            color: kPrimaryColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kPaddingL),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(),
                  Text(
                    "Choose a checkout type",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .fs14
                        .w600
                        .copyWith(color: Colors.black54),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Spacer(),
                ],
              ),
            ),
          )));
          _slivers.add(SliverToBoxAdapter(child: SizedBox(height: kPaddingL)));
          _slivers.add(SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kPaddingM),
                  child: CheckoutTypeRadio(index: index, session: session)),
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
}
