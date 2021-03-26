import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/generated/l10n.dart';
import 'package:breakq/widgets/list_item.dart';
import 'package:breakq/utils/text_style.dart';

@immutable
class ModalBottomSheetItem<T> extends Equatable {
  const ModalBottomSheetItem({this.text, this.value});

  final String text;
  final T value;

  @override
  List<Object> get props => <T>[value];
}

class ModalBottomSheet extends StatefulWidget {
  const ModalBottomSheet({
    Key key,
    this.selected,
    this.options,
    this.onChange,
    this.onClose,
    this.title,
  }) : super(key: key);

  final ModalBottomSheetItem<dynamic> selected;
  final List<ModalBottomSheetItem<dynamic>> options;
  final ValueChanged onChange;
  final VoidCallback onClose;
  final String title;

  @override
  _ModalBottomSheetState createState() {
    return _ModalBottomSheetState();
  }
}

class _ModalBottomSheetState extends State<ModalBottomSheet> {
  ModalBottomSheetItem<dynamic> _selected;

  @override
  void initState() {
    _selected = widget.selected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(
                left: kPaddingM, right: kPaddingM, bottom: 56 + kPaddingM),
            decoration: BoxDecoration(
              color: kWhite,
              borderRadius:
                  const BorderRadius.all(Radius.circular(kBoxDecorationRadius)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: kPaddingM, right: kPaddingL),
              child: SingleChildScrollView(
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      if (widget.title != null)
                        Padding(
                          padding: const EdgeInsets.all(kPaddingL),
                          child: Text(
                            widget.title,
                            textAlign: TextAlign.left,
                            style: Theme.of(context).textTheme.headline6.bold,
                          ),
                        ),
                      Column(
                        children: widget.options
                            .map((ModalBottomSheetItem<dynamic> item) {
                          return ListItem(
                            title: item.text,
                            titleTextStyle: _selected != null &&
                                    item.text == _selected.text
                                ? Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .w700
                                    .primaryColor
                                : Theme.of(context).textTheme.subtitle2.w600,
                            trailing:
                                _selected != null && item.text == _selected.text
                                    ? Icon(
                                        Icons.radio_button_checked,
                                        color: Theme.of(context).accentColor,
                                      )
                                    : Icon(
                                        Icons.radio_button_unchecked,
                                        color: Theme.of(context).hintColor,
                                      ),
                            onPressed: () {
                              setState(() {
                                _selected = item;
                                Navigator.pop(context);
                                widget.onChange(_selected.value);
                              });
                            },
                            showBorder: item != widget.options.last,
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: kPaddingM, right: kPaddingM, bottom: kPaddingM),
            child: FlatButton(
              color: kWhite,
              highlightColor: kBlue,
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(kBoxDecorationRadius))),
              onPressed: () {
                if (widget.onClose != null) {
                  widget.onClose();
                }
                setState(() {
                  Navigator.pop(context);
                });
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    L10n.of(context).commonBtnClose.toUpperCase(),
                    style: Theme.of(context).textTheme.button.w500,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
