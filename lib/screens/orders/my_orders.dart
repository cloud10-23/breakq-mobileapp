import 'package:breakq/configs/constants.dart';
import 'package:breakq/screens/cart/widgets/cart_helper.dart';
import 'package:breakq/screens/orders/widgets/order_item.dart';
import 'package:breakq/widgets/back_button.dart';
import 'package:flutter/material.dart';

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
            leading: BackButtonCircle(),
            title: Text(
              'My Orders',
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
