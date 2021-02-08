import 'package:breakq/blocs/cart/cart_bloc.dart';
import 'package:breakq/blocs/checkout/ch_bloc.dart';
import 'package:breakq/configs/routes.dart';
import 'package:breakq/data/models/checkout_session.dart';
import 'package:breakq/data/models/wizard_page_model.dart';
import 'package:breakq/screens/checkout/ch_base_step.dart';
import 'package:breakq/screens/checkout/ch_choice_step.dart';
import 'package:breakq/screens/checkout/widgets/ch_delivery/ch_delivery_success.dart';
import 'package:breakq/screens/checkout/widgets/ch_pickup/ch_pickup_success.dart';
import 'package:breakq/screens/checkout/widgets/ch_walkin/ch_walkin_success.dart';
import 'package:breakq/widgets/bold_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/generated/l10n.dart';
import 'package:breakq/widgets/full_screen_indicator.dart';
import 'package:breakq/widgets/portrait_mode_mixin.dart';
import 'package:breakq/utils/text_style.dart';
import 'package:breakq/widgets/theme_button.dart';

class CheckoutScreen extends StatefulWidget {
  static const id = 'Checkout';
  const CheckoutScreen({
    Key key,
  }) : super(key: key);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen>
    with
        PortraitStatefulModeMixin<CheckoutScreen>,
        SingleTickerProviderStateMixin {
  // ChCurrentStep _currentStep;

  CheckoutSession session;

  List<CheckoutStepsWizardPageModel> wizardPages =
      <CheckoutStepsWizardPageModel>[];

  String _title = 'Checkout';

  TabController _tabController;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    BlocProvider.of<CheckoutBloc>(context).add(LoadCartChEvent());
    wizardPages.add(CheckoutStepsWizardPageModel.fromJson(<String, dynamic>{
      'step': 0,
      'body': CheckoutBaseStep(),
    }));
    wizardPages.add(CheckoutStepsWizardPageModel.fromJson(<String, dynamic>{
      'type': CheckoutType.walkIn,
      'step': 1,
      'body': CheckoutChoiceSelector(),
    }));
  }

  void _nextStep() {
    BlocProvider.of<CheckoutBloc>(context).add(NextPressedChEvent());
  }

  void _previousStep() {
    BlocProvider.of<CheckoutBloc>(context).add(BackPressedChEvent());
    // if (_currentStep.step >= 1) {
    //   setState(() {
    //     _subtitle = 'Choose a checkout type';
    //     _currentStep.step--;
    //   });
    // }
  }

  Future<bool> _onBackPressed(BuildContext context) async {
    if (session.currentStep.step <= 0) {
      Navigator.pop(context);
      return true;
    }
    _previousStep();
    return false;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocBuilder<CheckoutBloc, CheckoutState>(
      builder: (BuildContext context, CheckoutState state) {
        if (state is! SessionRefreshSuccessChState) {
          /// Show the full screen indicator until we return here.
          return FullScreenIndicator(
            color: Theme.of(context).cardColor,
            backgroundColor: Theme.of(context).cardColor,
          );
        }

        session = (state as SessionRefreshSuccessChState).session;

        if (session.isCompleted) {
          switch (session.currentStep.checkoutType) {
            case CheckoutType.walkIn:
              return WalkinCheckoutSuccess();
              break;
            case CheckoutType.pickUp:
              return PickupCheckoutSuccessDialog();
              break;
            case CheckoutType.delivery:
              return DeliveryCheckoutSuccessDialog();
              break;
          }
        }

        if (session.currentStep.step <= 0)
          _tabController.animateTo(0);
        else
          _tabController.animateTo(1);

        return WillPopScope(
          onWillPop: () => _onBackPressed(context),
          child: Scaffold(
            body: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: kPaddingL, left: kPaddingS),
                  color: kPrimaryColor,
                  height: 150.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Spacer(),
                      Row(
                        children: [
                          IconButton(
                            padding: EdgeInsets.zero,
                            icon: const Icon(Icons.arrow_back),
                            tooltip: L10n.of(context).commonTooltipInfo,
                            onPressed: (session.currentStep.step > 0)
                                ? _previousStep
                                : null,
                            disabledColor: kPrimaryColor,
                          ),
                          Expanded(
                            child: Text(
                              _title,
                              textAlign: TextAlign.center,
                              style:
                                  Theme.of(context).textTheme.subtitle2.black,
                              maxLines: 1,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close),
                            tooltip: L10n.of(context).commonTooltipInfo,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                      Spacer(flex: 2),
                      Padding(
                        padding: const EdgeInsets.only(left: kPaddingL),
                        child: Text(
                          (session?.title?.isEmpty ?? true)
                              ? "Choose a checkout type"
                              : session?.title ?? "",
                          style:
                              Theme.of(context).textTheme.headline6.black.w400,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Spacer(flex: 2),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: List<Widget>.generate(wizardPages.length,
                        (int index) => wizardPages[index].body),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: _bottomBar(),
          ),
        );
      },
    );
  }

  Widget _bottomBar() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border(
          top: BorderSide(
            width: 2,
            color: Theme.of(context).dividerColor,
          ),
        ),
      ),
      padding: const EdgeInsets.all(kPaddingM * 2),
      child: SafeArea(
        top: false,
        child: BlocBuilder<CartBloc, CartState>(builder: (context, state) {
          if (state is! CartLoaded) {
            return Container();
          }
          return Row(
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomTitle(
                        title: 'Pay:',
                        fw: FontWeight.w800,
                      ),
                      CustomTitle(
                        title: (state is CartLoaded)
                            ? '₹ ' +
                                (state.cart?.cartValue?.toStringAsFixed(2) ??
                                    "00.00")
                            : '₹ 00.00',
                        padding: EdgeInsets.symmetric(horizontal: kPaddingS),
                        fw: FontWeight.w700,
                      ),
                    ],
                  ),
                  BoldTitle(
                    title: 'View price details',
                    padding: EdgeInsets.symmetric(horizontal: kPaddingS),
                    color: kHyperLinkColor,
                    isNum: true,
                  ),
                  //     Row
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         BoldTitle(
                  //           title: 'Discount: ',
                  //           padding: EdgeInsets.symmetric(horizontal: kPaddingS),
                  //           color: Colors.green[800],
                  //           isNum: true,
                  //         ),
                  //         BoldTitle(
                  //           title: (state is CartLoaded)
                  //               ? '- ₹ ' +
                  //                   (((state.cart?.orgCartValue ?? 0) -
                  //                               (state.cart?.cartValue ?? 0))
                  //                           ?.toStringAsFixed(2) ??
                  //                       "00.00")
                  //               : '- ₹ 00.00',
                  //           padding: EdgeInsets.symmetric(horizontal: kPaddingS),
                  //           color: Colors.green[800],
                  //           isNum: true,
                  //         ),
                  //       ],
                  //     ),
                  //     Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         BoldTitle(
                  //           title: 'Tax (GST): ',
                  //           padding: EdgeInsets.symmetric(horizontal: kPaddingS),
                  //           color: Colors.black,
                  //           fw: FontWeight.w500,
                  //           isNum: true,
                  //         ),
                  //         BoldTitle(
                  //           title: '₹ 50.00',
                  //           padding: EdgeInsets.symmetric(horizontal: kPaddingS),
                  //           color: Colors.black87,
                  //           fw: FontWeight.w500,
                  //           isNum: true,
                  //         ),
                  //       ],
                  //     ),
                ],
              ),
              Spacer(),
              ThemeButton(
                text: ((session?.currentStep?.step ?? 0) >=
                        totalSteps[session?.currentStep?.checkoutType ?? 0])
                    ? "Pay"
                    : "Next",
                onPressed: _nextStep,
                disableTouchWhenLoading: true,
                showLoading: session.isLoading,
              ),
            ],
          );
        }),
      ),
    );
  }
}
