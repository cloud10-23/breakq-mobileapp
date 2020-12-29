import 'package:breakq/configs/constants.dart';
import 'package:flutter/material.dart';

class TopDealsCard extends StatelessWidget {
  TopDealsCard({this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return Card(
      // shape: RoundedRectangleBorder(),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Image(
                image: AssetImage(categories[index]['image']),
                fit: BoxFit.fill),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            categories[index]['name'],
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyText2
                .copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5.0,
          ),
        ],
      ),
    );
  }
}
