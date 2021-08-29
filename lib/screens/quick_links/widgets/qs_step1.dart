import 'package:breakq/blocs/quick_shopping/qs_bloc.dart';
import 'package:breakq/data/models/my_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/qs_session_model.dart';
import 'package:breakq/generated/l10n.dart';
import 'package:breakq/screens/quick_links/widgets/service_header_delegate.dart';
import 'package:breakq/utils/text_style.dart';
import 'package:breakq/widgets/jumbotron.dart';
import 'package:breakq/widgets/list_item.dart';

class QSStep1 extends StatefulWidget {
  const QSStep1({
    Key key,
  }) : super(key: key);

  @override
  _QSStep1State createState() => _QSStep1State();
}

class _QSStep1State extends State<QSStep1> {
  @override
  void initState() {
    super.initState();
  }

  SliverPersistentHeader makeHeader(String headerText) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: ServiceHeaderDelegate(
        minHeight: kPaddingM * 3,
        maxHeight: kPaddingM * 4,
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(left: kPaddingM),
                child: Text(
                  headerText,
                  style: Theme.of(context).textTheme.headline6.w600,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QSBloc, QSState>(
      builder: (BuildContext context, QSState state) {
        final QSSessionModel session =
            (state as SessionRefreshSuccessQSState).session;

        if (session.orders.isEmpty) {
          return Container(
            alignment: AlignmentDirectional.center,
            child: Jumbotron(
              title: L10n.of(context).QSWarningNoBills,
              icon: Icons.report,
            ),
          );
        }

        final List<Widget> _slivers = <Widget>[];

        _slivers.add(SliverToBoxAdapter(child: SizedBox(height: kPaddingM)));
        _slivers.add(SliverToBoxAdapter(
            child: Container(
                child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
                onTap: () {
                  setState(() {
                    BlocProvider.of<QSBloc>(context)
                        .add(SelectAllBillsQSEvent());
                  });
                },
                child: Container(
                    margin: EdgeInsets.all(kPaddingM),
                    padding: EdgeInsets.all(kPaddingM),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: kBlackAccent, width: 2.0)),
                    child: Text("Select All",
                        style: Theme.of(context).textTheme.caption.w800))),
            Visibility(
              visible: (session.selectedBillIds?.isNotEmpty ?? false),
              child: InkWell(
                  onTap: () {
                    setState(() {
                      BlocProvider.of<QSBloc>(context)
                          .add(DeSelectAllBillsQSEvent());
                    });
                  },
                  child: Container(
                      margin: EdgeInsets.all(kPaddingM),
                      padding: EdgeInsets.all(kPaddingM),
                      child: Text("Cancel",
                          style: Theme.of(context).textTheme.caption.w800))),
            ),
          ],
        ))));
        _slivers.add(SliverToBoxAdapter(child: SizedBox(height: kPaddingM)));
        _slivers.add(SliverList(
          delegate: SliverChildListDelegate(
            <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kPaddingM),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                      List<Widget>.generate(session.orders.length, (int index) {
                    return _billItem(session.orders[index], session);
                  }),
                ),
              ),
            ],
          ),
        ));

        return CustomScrollView(slivers: _slivers);
      },
    );
  }

  Widget _billItem(Order order, QSSessionModel session) {
    return Container(
      color: kWhite,
      padding: const EdgeInsets.all(kPaddingS),
      child: ListItem(
        leading: Checkbox(
          value: session.selectedBillIds.contains(order.billNo.toString()),
          onChanged: (bool isChecked) {
            setState(() {
              if (isChecked) {
                BlocProvider.of<QSBloc>(context)
                    .add(BillSelectedQSEvent(order: order));
              } else {
                BlocProvider.of<QSBloc>(context)
                    .add(BillUnselectedQSEvent(order: order));
              }
            });
          },
        ),
        title: "Bill Date: " + order.billDate,
        titleTextStyle: Theme.of(context).textTheme.subtitle2.w500,
        subtitle: "No.: ${order.billNo}",
        subtitleTextStyle: Theme.of(context)
            .textTheme
            .bodyText2
            .w500
            .copyWith(color: Theme.of(context).hintColor),
        trailing: Padding(
          padding: const EdgeInsets.only(right: kPaddingS),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                order.billAmnt,
                style: Theme.of(context).textTheme.subtitle2.w500,
              ),
              SizedBox(height: kPaddingM),
              Text(
                "No of Products: ${order.products.length}",
                style: Theme.of(context)
                    .textTheme
                    .caption
                    .w500
                    .copyWith(color: Theme.of(context).hintColor),
              ),
            ],
          ),
        ),
        onPressed: () {
          setState(() {
            if (session.selectedBillIds.contains(order.billNo)) {
              BlocProvider.of<QSBloc>(context)
                  .add(BillUnselectedQSEvent(order: order));
            } else {
              BlocProvider.of<QSBloc>(context)
                  .add(BillSelectedQSEvent(order: order));
            }
          });
        },
      ),
    );
  }
}
