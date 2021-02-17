import 'package:breakq/configs/constants.dart';
import 'package:breakq/screens/cart/widgets/cart_helper.dart';
import 'package:breakq/screens/checkout/widgets/radio_helper.dart';
import 'package:breakq/screens/orders/widgets/order_item.dart';
import 'package:breakq/widgets/bold_title.dart';
import 'package:breakq/widgets/card_template.dart';
import 'package:breakq/widgets/theme_button.dart';
import 'package:flutter/material.dart';
import 'package:breakq/utils/text_style.dart';

class MyOrders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            primary: true,
            backgroundColor: kWhite,
            pinned: true,
            expandedHeight: 100,
            flexibleSpace: FlexibleSpaceBar(
              title: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Spacer(
                    flex: 4,
                  ),
                  Text('My Orders',
                      style: Theme.of(context).textTheme.bodyText1.fs16),
                  Spacer(),
                ],
              ),
              background: Row(
                children: [
                  Spacer(),
                  Image(
                    image: AssetImage(AssetImages.orderIllustration),
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
            actions: <Widget>[],
          ),
          SliverToBoxAdapter(
            child: OrderItem(),
          ),
          SliverToBoxAdapter(
            child: OrderItem(),
          ),
          SliverToBoxAdapter(
            child: OrderItem(),
          ),
          SliverToBoxAdapter(
            child: EndPadding(),
          ),
        ],
      ),
    );
  }
}
