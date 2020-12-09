import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/country.dart';
import 'package:flutter/material.dart';

class ShowSelectedCountry extends StatelessWidget {
  final VoidCallback onPressed;
  final Country country;

  const ShowSelectedCountry({Key key, this.onPressed, this.country})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(kPaddingS),
          child: Text(
            ' ${country.flag}  ${country.dialCode}',
            style: Theme.of(context).textTheme.headline6,
          ),
          // Was in a Row : Icon(Icons.arrow_drop_down, size: 24.0)
        ),
      ),
    );
  }
}
