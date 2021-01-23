import 'package:breakq/blocs/quick_shopping/qs_bloc.dart';
import 'package:breakq/screens/quick_links/widgets/qs_step2.dart';
import 'package:breakq/screens/quick_links/widgets/qs_step1.dart';
import 'package:breakq/screens/quick_links/widgets/qs_success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/booking_session_model.dart';
import 'package:breakq/data/models/booking_wizard_page_model.dart';
import 'package:breakq/generated/l10n.dart';
import 'package:breakq/utils/ui.dart';
import 'package:breakq/widgets/full_screen_indicator.dart';
import 'package:breakq/widgets/loading_overlay.dart';
import 'package:breakq/widgets/portrait_mode_mixin.dart';
import 'package:breakq/widgets/sliver_app_title.dart';
import 'package:breakq/utils/text_style.dart';
import 'package:breakq/widgets/theme_button.dart';
import 'package:sprintf/sprintf.dart';

class QShoppingScreen extends StatefulWidget {
  static const id = 'QSShopping';
  const QShoppingScreen({
    Key key,
  }) : super(key: key);

  @override
  _QShoppingScreenState createState() => _QShoppingScreenState();
}

class _QShoppingScreenState extends State<QShoppingScreen>
    with PortraitStatefulModeMixin<QShoppingScreen> {
  final int totalSteps = 2;

  int _currentStep = 1;

  QSSessionModel session;

  List<StepsWizardPageModel> wizardPages = <StepsWizardPageModel>[];

  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<QSBloc>(context).add(LoadBillsQSEvent());
    wizardPages.add(StepsWizardPageModel.fromJson(<String, dynamic>{
      'step': 1,
      'body': QSStep1(),
    }));
    wizardPages.add(StepsWizardPageModel.fromJson(<String, dynamic>{
      'step': 2,
      'body': QSStep2(),
    }));
  }

  void _nextStep() {
    // Check any condition before moving to the next step
    if (_currentStep == 1) {
      if (session.selectedBillIds == null || session.selectedBillIds.isEmpty) {
        UI.showErrorDialog(context,
            message: L10n.of(context).QSWarningBills,
            onPressed: () => Navigator.pop(context));
        return;
      }

      BlocProvider.of<QSBloc>(context).add(LoadProductsQSEvent());
    } else if (_currentStep == 2) {
      if (session.selectedProductIds == null ||
          session.selectedProductIds.isEmpty) {
        UI.showErrorDialog(context,
            message: L10n.of(context).QSWarningProducts,
            onPressed: () => Navigator.pop(context));
      }

      BlocProvider.of<QSBloc>(context).add(AddToCartQSEvent());
    }

    if (_currentStep < totalSteps) {
      _scrollController.animateTo(
        0.0,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
      );
      setState(() {
        _currentStep++;
      });
    }
  }

  void _previousStep() {
    if (_currentStep > 1) {
      _scrollController.animateTo(
        0.0,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
      );
      setState(() {
        _currentStep--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocBuilder<QSBloc, QSState>(
      builder: (BuildContext context, QSState state) {
        if (state is! SessionRefreshSuccessQSState) {
          /// Show the full screen indicator until we return here.
          return FullScreenIndicator(
            color: Theme.of(context).cardColor,
            backgroundColor: Theme.of(context).cardColor,
          );
        }

        session = (state as SessionRefreshSuccessQSState).session;

        if (session.isSubmitted) {
          return QSSuccessDialog();
        }

        return Scaffold(
          body: LoadingOverlay(
            isLoading: session.isLoading,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: CustomScrollView(
                    controller: _scrollController,
                    slivers: <Widget>[
                      SliverAppBar(
                        automaticallyImplyLeading: false, //no back button
                        pinned: true,
                        leading: Visibility(
                          visible: _currentStep > 1,
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back),
                            tooltip: L10n.of(context).commonTooltipInfo,
                            onPressed: _previousStep,
                          ),
                        ),
                        actions: <Widget>[
                          IconButton(
                            icon: const Icon(Icons.close),
                            tooltip: L10n.of(context).commonTooltipInfo,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                        expandedHeight: 150.0,
                        title: SliverAppTitle(
                          child: Text(
                            sprintf('%d/%d: %s', <dynamic>[
                              _currentStep,
                              totalSteps,
                              L10n.of(context).bookingTitleWizardPage(
                                  'page' + _currentStep.toString())
                            ]),
                            style: Theme.of(context).textTheme.caption.black,
                          ),
                        ),
                        centerTitle: true,
                        flexibleSpace: FlexibleSpaceBar(
                          background: Container(
                            padding: const EdgeInsets.only(
                                top: kPaddingS,
                                left: kPaddingL,
                                bottom: kPaddingL,
                                right: kPaddingM),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  L10n.of(context).bookingLabelSteps(
                                      _currentStep, totalSteps),
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      .black,
                                  maxLines: 1,
                                ),
                                SizedBox(height: kPaddingL),
                                Text(
                                  L10n.of(context).bookingTitleWizardPage(
                                      'page' + _currentStep.toString()),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5
                                      .black
                                      .w400,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SliverFillRemaining(
                        hasScrollBody: true,
                        child: IndexedStack(
                          index: _currentStep - 1,
                          children: List<Widget>.generate(wizardPages.length,
                              (int index) => wizardPages[index].body),
                        ),
                      ),
                    ],
                  ),
                ),
                _bottomBar(),
              ],
            ),
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
        child: Row(
          children: <Widget>[
            Spacer(),
            ThemeButton(
              text: _currentStep == totalSteps
                  ? L10n.of(context).QSBtnFinish
                  : L10n.of(context).QSBtnNext,
              onPressed: _nextStep,
              disableTouchWhenLoading: true,
              showLoading: session.isLoading,
            ),
          ],
        ),
      ),
    );
  }
}
