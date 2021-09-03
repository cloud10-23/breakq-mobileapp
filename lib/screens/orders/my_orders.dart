import 'package:breakq/blocs/orders/orders_bloc.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/my_order.dart';
import 'package:breakq/screens/cart/widgets/cart_helper.dart';
import 'package:breakq/screens/orders/widgets/order_item.dart';
import 'package:breakq/widgets/back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              backgroundColor: kWhite,
              leading: BackButtonCircle(),
              title: Text(
                'My Orders',
              ),
              actions: <Widget>[],
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final List<Order> _orders = (state as OrdersLoadedState).orders;

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
