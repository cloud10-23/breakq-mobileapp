import 'package:breakq/blocs/quick_shopping/qs_bloc.dart';
import 'package:breakq/configs/api_urls.dart';
import 'package:breakq/data/models/product_model.dart';
import 'package:breakq/generated/l10n.dart';
import 'package:breakq/screens/listing/widgets/product_cart_buttons.dart';
import 'package:breakq/screens/product/widgets/product_buttons.dart';
import 'package:breakq/widgets/jumbotron.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/qs_session_model.dart';
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
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                  onTap: () {
                    setState(() {
                      BlocProvider.of<QSBloc>(context)
                          .add(SelectAllProductsQSEvent());
                    });
                  },
                  child: Container(
                      margin: EdgeInsets.all(kPaddingM),
                      padding: EdgeInsets.all(kPaddingM),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: kBlackAccent, width: 2)),
                      child: Text("Add All",
                          style: Theme.of(context).textTheme.caption.w800))),
              Visibility(
                visible: (session.selectedProductIds?.isNotEmpty ?? false),
                child: InkWell(
                    onTap: () {
                      setState(() {
                        BlocProvider.of<QSBloc>(context)
                            .add(DeleteAllProductsQSEvent());
                      });
                    },
                    child: Container(
                        margin: EdgeInsets.all(kPaddingM),
                        padding: EdgeInsets.all(kPaddingM),
                        child: Text("Reset",
                            style: Theme.of(context).textTheme.caption.w800))),
              ),
            ],
          ),
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
            padding: const EdgeInsets.only(left: kPaddingM),
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
      margin: EdgeInsets.symmetric(vertical: kPaddingS),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius:
              const BorderRadius.all(Radius.circular(kBoxDecorationRadius)),
        ),
        child: ExpansionTile(
          trailing: (session.selectedProductIds.keys.contains(product.id))
              ? ListAddRemButtons(
                  onAdd: () {
                    BlocProvider.of<QSBloc>(context)
                        .add(ProductAddedQSEvent(product: product));
                  },
                  onRem: () {
                    BlocProvider.of<QSBloc>(context)
                        .add(ProductMinusQSEvent(product: product));
                  },
                  qty: session.selectedProductIds[product.id] ?? 0,
                )
              : ListAddItemButton(
                  onProductAdd: () => BlocProvider.of<QSBloc>(context)
                      .add(ProductAddedQSEvent(product: product)),
                  // getIt.get<AppGlobals>().onProductAdd(product, context),
                ),
          childrenPadding: EdgeInsets.only(bottom: kPaddingM),
          tilePadding: EdgeInsets.all(0),
          children: [
            Row(
              children: [
                ResetCartButtonText(
                    title: 'Reset',
                    onProductDel: () => BlocProvider.of<QSBloc>(context)
                        .add(DeleteProductQSEvent(product: product))),
                BulkAddButtons(
                    product: product,
                    onPressed: (qty) {
                      BlocProvider.of<QSBloc>(context).add(
                          ProductAddedQSEvent(product: product, quantity: qty));
                    }),
              ],
            ),
          ],
          title: Row(
            children: <Widget>[
              Image.network(
                apiBaseFull + product.image,
                width: 75,
                height: 75,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Image.asset(
                  AssetImages.productPlaceholder,
                  width: 75,
                  height: 75,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kPaddingM),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        sprintf('%s', <String>[product.title]),
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style:
                            Theme.of(context).textTheme.caption.black.fs12.w600,
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
                              sprintf('%s', <String>[product.description]),
                              maxLines: 1,
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .fs10
                                  .copyWith(color: Theme.of(context).hintColor),
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
                                    "₹ " + product.salePrice.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        .number
                                        .bold,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    (product.maxPrice != product.salePrice)
                                        ? "₹ " +
                                            product.maxPrice.toStringAsFixed(2)
                                        : '',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        .number
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
