import 'package:breakq/configs/app_globals.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/price_model.dart';
import 'package:breakq/data/models/product_model.dart';
import 'package:breakq/main.dart';
import 'package:breakq/widgets/bold_title.dart';
import 'package:breakq/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class InvoiceHeader extends StatelessWidget {
  InvoiceHeader({@required this.branch, @required this.address});
  final String branch;
  final String address;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: kWhite,
      child: Row(
        children: [
          Image(
            image: AssetImage(AssetImages.bq_icon_text),
            width: 100,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacer(flex: 4),
                Padding(
                  padding: const EdgeInsets.all(kPaddingM),
                  child: BoldTitle(
                    title: branch,
                    padding: EdgeInsets.symmetric(horizontal: kPaddingM),
                    color: Colors.black,
                    fw: FontWeight.w600,
                  ),
                ),
                Spacer(flex: 1),
                Padding(
                  padding:
                      const EdgeInsets.only(left: kPaddingL, bottom: kPaddingM),
                  child: Text(
                    address,
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        .bold
                        .fs10
                        .copyWith(color: Theme.of(context).disabledColor),
                  ),
                ),
                Spacer(flex: 6),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class InvoiceThanksForShopping extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: kPaddingL),
      height: 100,
      color: kWhite,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Spacer(flex: 3),
                Text(
                  'Thanks For Shopping with us'.toUpperCase(),
                  style: Theme.of(context).textTheme.headline6.copyWith(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        fontSize: 18,
                      ),
                ),
                Spacer(flex: 1),
                Text(
                  'Your order has been successfully completed!',
                  style: Theme.of(context).textTheme.bodyText2.w600.grey.fs12,
                ),
                Spacer(flex: 5),
              ],
            ),
          ),
          Image(
            image: AssetImage(AssetImages.paid_image),
            width: 100,
          )
        ],
      ),
    );
  }
}

class InvoiceBillDetails extends StatelessWidget {
  InvoiceBillDetails({
    @required this.billNo,
    @required this.paymentMode,
    @required this.billDate,
    @required this.checkoutStatus,
    @required this.checkoutType,
    @required this.gstSummary,
    @required this.paymentStatus,
  });
  final String billNo;
  final String billDate;
  final String checkoutType;
  final String checkoutStatus;
  final String paymentMode;
  final String paymentStatus;
  final String gstSummary;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: kPaddingL),
      color: kWhite,
      child: Table(
        children: [
          _tableRow(context, 'Bill No.', billNo),
          _tableRow(context, 'Name',
              getIt.get<AppGlobals>().user.displayName ?? '(Unavailable)'),
          _tableRow(context, 'Mobile No.',
              getIt.get<AppGlobals>().user.phoneNumber ?? '(Unavailable'),
          _tableRow(context, 'Bill Date', billDate),
          _tableRow(context, 'Checkout Type', checkoutType),
          _tableRow(context, 'Checkout Status', checkoutStatus),
          _tableRow(context, 'Payment Mode', paymentMode),
          _tableRow(context, 'Payment Status', paymentStatus),
          _tableRow(context, 'GST Summary', gstSummary),
        ],
      ),
    );
  }

  TableRow _tableRow(BuildContext context, String key, String value) {
    //{String name, String mobileNo, String mode}){
    return TableRow(
      children: [
        TableCell(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: kPaddingS),
            child: Text('$key',
                style: Theme.of(context).textTheme.headline6.fs14.grey.w700),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: kPaddingS),
            child: Text(
              '$value',
              style: Theme.of(context).textTheme.bodyText2.w600.fs14.number,
            ),
          ),
        ),
      ],
    );
  }
}

class InvoiceBillItems extends StatelessWidget {
  InvoiceBillItems({this.products});
  final Map<Product, int> products;
  @override
  Widget build(BuildContext context) {
    List<TableRow> _items = [];
    products.forEach((product, qty) {
      _items.add(_itemRow(context, product: product, qty: qty));
    });
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: kPaddingL),
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: <TableRow>[
              _headingRow(context),
              _fillerRow(context),
            ] +
            _items +
            [
              _endRow(context),
            ],
      ),
    );
  }

  TableRow _headingRow(BuildContext context) {
    return TableRow(
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 2.0, color: Colors.black12))),
      children: [
        _headingRowCell(context, 'ITEM'),
        _headingRowCell(context, 'QTY'),
        _headingRowCell(context, 'PRICE'),
        _headingRowCell(context, 'TOTAL'),
      ],
    );
  }

  TableRow _fillerRow(BuildContext context) {
    return TableRow(
      children: [
        SizedBox(height: kPaddingL),
        SizedBox(height: kPaddingL),
        SizedBox(height: kPaddingL),
        SizedBox(height: kPaddingL),
      ],
    );
  }

  TableRow _endRow(BuildContext context) {
    return TableRow(
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 2.0, color: Colors.black12))),
      children: [
        SizedBox(height: kPaddingM),
        SizedBox(height: kPaddingM),
        SizedBox(height: kPaddingM),
        SizedBox(height: kPaddingM),
      ],
    );
  }

  Widget _headingRowCell(BuildContext context, String heading) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.only(bottom: kPaddingM),
        child: Column(
          crossAxisAlignment: (heading == 'ITEM')
              ? CrossAxisAlignment.start
              : (heading == 'QTY')
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.end,
          children: [
            Text(
              heading ?? "",
              style: Theme.of(context).textTheme.headline6.fs16.grey.w700,
            ),
          ],
        ),
      ),
    );
  }

  TableRow _itemRow(
    BuildContext context, {
    Product product,
    int qty,
  }) {
    //{String name, String mobileNo, String mode}){
    return TableRow(
      children: [
        TableCell(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: kPaddingS),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${product.title}',
                    style: Theme.of(context).textTheme.headline6.fs14.w700),
                Text(product.quantity ?? '',
                    maxLines: 1,
                    style: Theme.of(context).textTheme.caption.w600.grey),
              ],
            ),
          ),
        ),
        TableCell(
          child: Text(
            '$qty',
            style: Theme.of(context).textTheme.bodyText1.bold.number,
            textAlign: TextAlign.center,
          ),
        ),
        TableCell(
          child: Text(
            "₹ ${product.maxPrice.toStringAsFixed(2)}",
            style: Theme.of(context).textTheme.bodyText1.bold.number,
            textAlign: TextAlign.right,
          ),
        ),
        TableCell(
          child: Text(
            "₹ ${(product.maxPrice * qty).toStringAsFixed(2)}",
            style: Theme.of(context).textTheme.bodyText1.bold.number,
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}

class InvoicePriceDetails extends StatelessWidget {
  InvoicePriceDetails({@required this.price});

  final Price price;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: kPaddingM * 2, vertical: kPaddingM),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Item Price: ',
              style: Theme.of(context).textTheme.headline6.fs16.bold,
            ),
            Text(
              '₹ ' + ((price?.totalAmount ?? 0).toStringAsFixed(2) ?? "00.00"),
              style: Theme.of(context).textTheme.headline6.fs16.bold.number,
            ),
          ],
        ),
      ),
      SizedBox(height: kPaddingM),
      Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: kPaddingM, vertical: kPaddingS),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BoldTitle(
              title: 'Discount',
              padding: const EdgeInsets.symmetric(horizontal: kPaddingM),
              color: kGreen,
              fw: FontWeight.w600,
            ),
            BoldTitle(
              title: '- ₹ ' + (price?.discount ?? 0)?.toStringAsFixed(2) ??
                  "00.00",
              padding: EdgeInsets.symmetric(horizontal: kPaddingM),
              color: Colors.green[800],
              isNum: true,
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: kPaddingM, vertical: kPaddingS),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BoldTitle(
              title: 'Extra offer',
              padding: EdgeInsets.symmetric(horizontal: kPaddingM),
              color: kGreen,
              fw: FontWeight.w600,
            ),
            BoldTitle(
              title: '- ₹ ' + (price?.extraOffer ?? 0).toStringAsFixed(2),
              padding: EdgeInsets.symmetric(horizontal: kPaddingM),
              color: kGreen,
              isNum: true,
            ),
          ],
        ),
      ),
      if ((price?.delivery ?? 0) > 0)
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: kPaddingM, vertical: kPaddingS),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BoldTitle(
                title: 'Delivery Charges',
                padding: EdgeInsets.symmetric(horizontal: kPaddingM),
                color: Colors.black54,
                fw: FontWeight.w600,
              ),
              BoldTitle(
                title: '₹ ' + ((price?.delivery ?? 0).toStringAsFixed(2)),
                padding: EdgeInsets.symmetric(horizontal: kPaddingM),
                color: Colors.black54,
                fw: FontWeight.w500,
                isNum: true,
              ),
            ],
          ),
        ),
      SizedBox(height: kPaddingM),
      Container(
        margin: const EdgeInsets.all(kPaddingM * 2),
        padding: const EdgeInsets.all(kPaddingM),
        color: kBlue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BoldTitle(
              title: 'Total Amount Paid'.toUpperCase(),
              fw: FontWeight.w800,
              color: kWhite,
            ),
            CustomTitle(
              title: '₹ ' + (price?.finalAmount ?? 0).toStringAsFixed(2),
              fw: FontWeight.w600,
              isNum: true,
              color: kWhite,
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(kPaddingM),
        child: Text(
          'You have saved ₹ ' +
              ((price?.savings ?? 0)?.toStringAsFixed(2) ?? "00.00") +
              ' on this order',
          style: Theme.of(context).textTheme.subtitle1.bold.green,
        ),
      ),
    ]);
  }
}

class InvoiceQRCode extends StatelessWidget {
  InvoiceQRCode({this.billNo});
  final String billNo;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(
        'For internal use only',
        style: Theme.of(context).textTheme.caption.bold,
      ),
      Center(
        child: QrImage(
          data: billNo ?? 'ERROR',
          version: QrVersions.auto,
          backgroundColor: kWhite,
          size: 80,
          gapless: false,
        ),
      ),
    ]);
  }
}
