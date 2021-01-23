import 'package:breakq/blocs/quick_shopping/qs_bloc.dart';
import 'package:breakq/configs/app_globals.dart';
import 'package:breakq/data/models/product_model.dart';
import 'package:breakq/generated/l10n.dart';
import 'package:breakq/main.dart';
import 'package:breakq/widgets/jumbotron.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/booking_session_model.dart';
import 'package:breakq/utils/text_style.dart';
import 'package:sprintf/sprintf.dart';

class QSStep2 extends StatefulWidget {
  @override
  _QSStep2State createState() => _QSStep2State();
}

class _QSStep2State extends State<QSStep2> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QSBloc, QSState>(
      builder: (BuildContext context, QSState state) {
        final QSSessionModel session =
            (state as SessionRefreshSuccessQSState).session;

        final List<Widget> _listItems = <Widget>[
          SizedBox(height: kPaddingL),
        ];

        if (session.products?.isEmpty ?? true) {
          return Container(
            alignment: AlignmentDirectional.center,
            child: Jumbotron(
              title: L10n.of(context).QSWarningProducts,
              icon: Icons.report,
            ),
          );
        }

        final List<Product> _products = session.products;

        _listItems
            .addAll(_products.map((product) => _productItem(product, session)));

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kPaddingM),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _listItems,
            ),
          ),
        );
      },
    );
  }

  Widget _productItem(Product product, QSSessionModel session) {
    return Card(
      margin: EdgeInsets.zero,
      child: InkWell(
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius:
                const BorderRadius.all(Radius.circular(kBoxDecorationRadius)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 75,
                    height: 75,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(product.image),
                        // image: NetworkImage(product.image),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(kBoxDecorationRadius),
                        bottomLeft: Radius.circular(kBoxDecorationRadius),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kPaddingM),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          sprintf('%s', <String>[product.title]),
                          maxLines: 1,
                          style:
                              Theme.of(context).textTheme.subtitle1.fs18.w500,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: kPaddingS,
                              bottom: kPaddingS,
                              left: kPaddingS,
                              right: kPaddingS),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                sprintf('%s', <String>[product.quantity]),
                                maxLines: 1,
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                        color: Theme.of(context).hintColor),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: kPaddingS,
                                    right: kPaddingS,
                                    bottom: kPaddingS,
                                    top: 2),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      "₹ " + product.price.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          .bold,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      "₹ " + product.oldPrice.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption
                                          .w300
                                          .copyWith(
                                              decoration:
                                                  TextDecoration.lineThrough),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Checkbox(
                value: session.selectedProductIds.contains(product.id),
                onChanged: (bool isChecked) {
                  setState(() {
                    if (isChecked) {
                      BlocProvider.of<QSBloc>(context)
                          .add(ProductSelectedQSEvent(product: product));
                    } else {
                      BlocProvider.of<QSBloc>(context)
                          .add(ProductUnselectedQSEvent(product: product));
                    }
                  });
                },
              ),
            ],
          ),
        ),
        onTap: () {
          getIt.get<AppGlobals>().onProductPressed(product, context);
        },
      ),
    );
  }
}
