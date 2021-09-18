import 'package:breakq/configs/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:breakq/utils/text_style.dart';

// ignore: must_be_immutable
class AddressEditText extends StatefulWidget {
  var isPassword;
  var isSecure;
  var fontSize;
  var textColor;
  var fontFamily;
  var text;
  var maxLine;
  TextEditingController mController;

  VoidCallback onPressed;

  AddressEditText(
      {var this.fontSize = 20.0,
      var this.textColor = kBlack,
      var this.isPassword = false,
      var this.isSecure = false,
      var this.text = "",
      var this.mController,
      var this.maxLine = 1});

  @override
  State<StatefulWidget> createState() {
    return AddressEditTextState();
  }
}

class AddressEditTextState extends State<AddressEditText> {
  @override
  Widget build(BuildContext context) {
    if (!widget.isSecure) {
      return TextField(
        controller: widget.mController,
        obscureText: widget.isPassword,
        cursorColor: kPrimaryColor,
        maxLines: widget.maxLine,
        style: TextStyle(
            fontSize: widget.fontSize,
            color: kBlack,
            fontFamily: widget.fontFamily),
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: kBlue),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: kBlue),
          ),
        ),
      );
    } else {
      return TextField(
          controller: widget.mController,
          obscureText: widget.isPassword,
          cursorColor: kBlue,
          style: TextStyle(
              fontSize: widget.fontSize,
              color: kBlack,
              fontFamily: widget.fontFamily),
          decoration: InputDecoration(
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  widget.isPassword = !widget.isPassword;
                });
              },
              child: Icon(
                  widget.isPassword ? Icons.visibility : Icons.visibility_off,
                  color: kBlack),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: kBlack),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: kBlue),
            ),
          ));
    }
  }
}

Widget ring(BuildContext context, String description) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(150.0),
          border: Border.all(width: 16.0, color: kBlue),
        ),
      ),
      SizedBox(height: 16),
      Text(description,
          style: Theme.of(context).textTheme.headline6.fs18,
          maxLines: 2,
          textAlign: TextAlign.center),
    ],
  );
}

Widget shareIcon(String iconPath, Color tintColor) {
  return Padding(
    padding: EdgeInsets.only(left: 20, right: 20),
    child: Image.asset(iconPath, width: 28, height: 28, fit: BoxFit.fill),
  );
}

// TextFormField editTextStyle(var hintText, {isPassword = true}) {
//   return TextFormField(
//     obscureText: isPassword,
//     decoration: InputDecoration(
//       contentPadding: EdgeInsets.fromLTRB(16, 10, 16, 10),
//       hintText: hintText,
//       hintStyle: TextStyle(color: t5TextColorThird),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(4),
//         borderSide: const BorderSide(color: t5ViewColor, width: 0.0),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(4),
//         borderSide: const BorderSide(color: t5ViewColor, width: 0.0),
//       ),
//     ),
//   );
// }

class FilledEditText extends StatefulWidget {
  final Function onchanged;
  final bool isPassword;
  final double fontSize;
  final Color textColor;
  final String hint;
  final int maxLine;
  final String error;
  final TextInputType inputTpe;
  final FormFieldSetter onSaved;
  final bool isFirstField;
  final bool isLastField;
  final EdgeInsetsGeometry padding;
  final TextCapitalization capitalization;
  final Iterable<String> autoFillHints;

  FilledEditText({
    this.fontSize = 20.0,
    this.textColor = kBlack,
    this.isPassword = false,
    this.onchanged,
    @required this.hint,
    this.error,
    this.maxLine = 1,
    this.onSaved,
    this.inputTpe,
    this.isFirstField = false,
    this.isLastField = false,
    this.padding = const EdgeInsets.symmetric(vertical: kPaddingM),
    this.capitalization,
    this.autoFillHints = const [],
  });

  @override
  State<StatefulWidget> createState() {
    return FilledEditTextState();
  }
}

class FilledEditTextState extends State<FilledEditText> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.padding,
      color: kWhite,
      child: TextFormField(
        autofillHints: widget.autoFillHints,
        autofocus: widget.isFirstField,
        onChanged: widget.onchanged,
        obscureText: widget.isPassword,
        keyboardType: widget.inputTpe,
        textCapitalization: widget.capitalization ?? TextCapitalization.words,
        textInputAction:
            (widget.isLastField) ? TextInputAction.done : TextInputAction.next,
        validator: (value) {
          if (value.isEmpty && widget.error != null) {
            return widget.error;
          }
          return null;
        },
        // onFieldSubmitted: widget.onSaved,
        onSaved: widget.onSaved,
        style: Theme.of(context).textTheme.bodyText1.fs14.number,
        decoration: InputDecoration(
          // contentPadding: EdgeInsets.fromLTRB(14, 4, 14, 4),
          hintText: widget.hint,
          hintStyle: TextStyle(fontSize: 14),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(color: kBlackAccent, width: 2.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(color: kBlue, width: 2.0),
          ),
        ),
      ),
    );
  }
}
