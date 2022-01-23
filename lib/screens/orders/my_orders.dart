import 'package:breakq/blocs/orders/orders_bloc.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/my_order.dart';
import 'package:breakq/screens/cart/widgets/cart_helper.dart';
import 'package:breakq/screens/orders/widgets/order_item.dart';
import 'package:breakq/widgets/back_button.dart';
import 'package:breakq/widgets/jumbotron.dart';
import 'package:breakq/widgets/shimmer_box.dart';
import 'package:flutter/material.dart';
import 'package:breakq/utils/text_style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';

class MyOrders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersBloc, OrdersState>(
      builder: (BuildContext context, OrdersState state) {
        if (state is! OrdersLoadedState) {
          return Scaffold(
              primary: true,
              appBar: AppBar(
                primary: true,
                leading: BackButtonCircle(),
                title: Text('My Orders',
                    style: Theme.of(context).textTheme.headline6.fs16.white),
                actions: <Widget>[],
              ),
              body: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: kPaddingL, horizontal: kPaddingS),
                  child: ShimmerBox(height: 350),
                ),
              ));
        }

        final List<Order> _orders = (state as OrdersLoadedState).orders;

        return Scaffold(
          primary: true,
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                primary: true,
                pinned: true,
                leading: BackButtonCircle(),
                title: Text('My Orders',
                    style: Theme.of(context).textTheme.headline6.fs16.white),
                actions: <Widget>[],
              ),
              (_orders == null || _orders.isEmpty)
                  ? SliverFillRemaining(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Jumbotron(
                            padding: const EdgeInsets.all(kPaddingL),
                            icon: FontAwesome.archive,
                            title: "No orders to show",
                          ),
                        ],
                      ),
                    )
                  : SliverToBoxAdapter(
                      child: Column(
                        children: List.generate(
                          _orders.length,
                          (index) => OrderItem(
                            order: _orders[index],
                          ),
                        ),
                      ),
                    ),
              SliverToBoxAdapter(
                child: EndPadding(),
              ),
            ],
          ),
        );
      },
    );
  }
}
