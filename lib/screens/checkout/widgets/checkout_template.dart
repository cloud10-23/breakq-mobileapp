import 'package:breakq/blocs/checkout/ch_bloc.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/generated/l10n.dart';
import 'package:breakq/utils/ui.dart';
import 'package:flutter/material.dart';
import 'package:breakq/utils/text_style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';

class CheckoutTemplate extends StatelessWidget {
  CheckoutTemplate({
    @required this.slivers,
    this.bottomBar,
    this.title = 'Checkout',
    this.subTitle,
    this.showBackButton = true,
    this.controller,
    this.checkoutType = CheckoutType.walkIn,
  });

  final String title;
  final String subTitle;
  final List<Widget> slivers;
  final Widget bottomBar;
  final bool showBackButton;
  final ScrollController controller;
  final CheckoutType checkoutType;

  @override
  Widget build(BuildContext context) {
    String bgImage;
    switch (checkoutType) {
      case CheckoutType.walkIn:
        bgImage = AssetImages.checkoutWalkinIllustration;
        break;
      case CheckoutType.pickUp:
        bgImage = AssetImages.checkoutSelfPickupIllustration;
        break;
      case CheckoutType.delivery:
        bgImage = AssetImages.checkoutDeliveryIllustration;
        break;
    }
    return Scaffold(
      body: CustomScrollView(
        controller: controller, //?? ScrollController(),
        slivers: <Widget>[
              SliverAppBar(
                pinned: true,
                backgroundColor: kWhite,
                brightness: Brightness.light,
                iconTheme: IconThemeData(color: kBlack),
                expandedHeight: 150,
                flexibleSpace: FlexibleSpaceBar(
                  background: Row(
                    children: [
                      Spacer(),
                      Image(image: AssetImage(bgImage)),
                    ],
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Spacer(flex: 10),
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.subtitle2.w800.black,
                        maxLines: 1,
                      ),
                      Spacer(),
                      Text(
                        subTitle ?? '',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.caption.w700.fs10,
                        maxLines: 1,
                      ),
                      Spacer(),
                    ],
                  ),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.close),
                    tooltip: L10n.of(context).commonTooltipInfo,
                    onPressed: () {
                      UI.confirmationDialogBox(context,
                          title: "Warning !",
                          cancelButtonText: "No",
                          okButtonText: "Yes",
                          message: "Are you sure you want to cancel checkout?",
                          onConfirmation: () {
                        Navigator.of(context, rootNavigator: true).pop();
                      });
                    },
                  ),
                ],
                leading: Visibility(
                  visible: showBackButton,
                  child: IconButton(
                    icon: const Icon(Feather.arrow_left_circle),
                    tooltip: L10n.of(context).commonTooltipInfo,
                    onPressed: () {
                      BlocProvider.of<CheckoutBloc>(context)
                          .add(BackPressedChEvent());
                    },
                  ),
                ),
              ),
            ] +
            slivers,
      ),
      bottomNavigationBar: bottomBar,
    );
  }
}
