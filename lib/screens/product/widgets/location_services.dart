import 'package:flutter/material.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/configs/routes.dart';
import 'package:breakq/data/models/product_model.dart';
import 'package:breakq/data/models/service_model.dart';
import 'package:breakq/generated/l10n.dart';
import 'package:breakq/widgets/link_text.dart';
import 'package:breakq/widgets/list_item.dart';
import 'package:breakq/widgets/uppercase_title.dart';
import 'package:breakq/utils/text_style.dart';
import 'package:sprintf/sprintf.dart';

class LocationServices extends StatelessWidget {
  const LocationServices({
    Key key,
    this.location,
    this.limit = 3,
  }) : super(key: key);

  final ProductModel location;
  final int limit;

  @override
  Widget build(BuildContext context) {
    // if (location == null || location.services == null) {
    //   return Container();
    // }
    // if (location.services.isEmpty) return Container();

    // List<ServiceModel> _services = location.services;

    // if (limit < _services.length) {
    //   _services = _services.sublist(0, limit);
    // }

    return Container(
      padding: const EdgeInsets.only(
          left: kPaddingM, right: kPaddingM, bottom: kPaddingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          UppercaseTitle(title: L10n.of(context).locationTitleTopServices),
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.only(top: kPaddingS),
            // children: _services.map((ServiceModel service) {
            //   return ListItem(
            // leading: Radio<int>(
            //   value: service.id,
            //   groupValue: 0,
            //   onChanged: (int selected) {},
            // ),
            //       title: service.name,
            //       titleTextStyle: Theme.of(context).textTheme.subtitle1.fs18.w500,
            //       subtitle: service.description,
            //       subtitleTextStyle: Theme.of(context)
            //           .textTheme
            //           .bodyText1
            //           .w300
            //           .copyWith(color: Theme.of(context).hintColor),
            //       trailing: Column(
            //         crossAxisAlignment: CrossAxisAlignment.end,
            //         children: <Widget>[
            //           Text(
            //             L10n.of(context).commonCurrencyFormat(
            //                 sprintf('%.2f', <double>[service.price])),
            //             style: Theme.of(context).textTheme.subtitle1.fs18.w500,
            //           ),
            //           Text(
            //             L10n.of(context)
            //                 .commonDurationFormat(service.duration.toString()),
            //             style: Theme.of(context)
            //                 .textTheme
            //                 .bodyText1
            //                 .w300
            //                 .copyWith(color: Theme.of(context).hintColor),
            //           ),
            //         ],
            //       ),
            //       onPressed: () {
            //         Navigator.pushNamed(context, Routes.booking,
            //             arguments: <String, dynamic>{
            //               'locationId': location.id,
            //               'preselectedService': service
            //             });
            //       },
            //     );
            //   }).toList(),
            // ),
            // if (limit < location.services.length)
            //   Padding(
            //     padding: const EdgeInsets.only(top: kPaddingL),
            //     child: LinkText(
            //       text: L10n.of(context).locationLinkAllServices,
            //       onTap: () {
            //         Navigator.pushNamed(context, Routes.booking,
            //             arguments: <String, dynamic>{'locationId': location.id});
            //       },
            //     ),
          ),
        ],
      ),
    );
  }
}
