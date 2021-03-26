import 'package:flutter/material.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/button_group_model.dart';
import 'package:breakq/utils/text_style.dart';

class ThemeButtonGroup extends StatefulWidget {
  const ThemeButtonGroup({
    Key key,
    this.buttonValues,
    this.elevation,
    this.onChange,
    this.buttonPadding,
    this.preselectedValue,
    this.isUnselectable = false,
  }) : super(key: key);

  /// Values of button group.
  final List<ButtonGroupModel> buttonValues;

  /// Button elevation.
  final double elevation;

  /// On value change.
  final Function(ButtonGroupModel) onChange;

  /// Button padding.
  final EdgeInsetsGeometry buttonPadding;

  /// Preselected button value.
  final ButtonGroupModel preselectedValue;

  final bool isUnselectable;

  @override
  _ThemeButtonGroupState createState() => _ThemeButtonGroupState();
}

class _ThemeButtonGroupState extends State<ThemeButtonGroup> {
  ButtonGroupModel _currentSelectedButton;

  @override
  void initState() {
    super.initState();

    if (widget.preselectedValue != null) {
      final int index = widget.buttonValues.indexOf(widget.preselectedValue);
      if (index != -1) {
        _currentSelectedButton = widget.buttonValues[index];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 5.0,
      runSpacing: 10.0,
      children: _buildButtonsRow()
          .map((Widget c) => Container(
                child: c,
                padding: widget.buttonPadding ??
                    const EdgeInsets.only(right: kPaddingS),
              ))
          .toList(),
    );
  }

  List<Widget> _buildButtonsRow() {
    return widget.buttonValues.map((ButtonGroupModel button) {
      final int index = widget.buttonValues.indexOf(button);
      return Card(
        margin: EdgeInsets.zero,
        elevation: widget.elevation ?? 0,
        color: _currentSelectedButton == widget.buttonValues[index]
            ? kBlue
            : Theme.of(context).highlightColor,
        shape: RoundedRectangleBorder(
          borderRadius:
              const BorderRadius.all(Radius.circular(kRoundedButtonRadius)),
        ),
        child: MaterialButton(
            padding: const EdgeInsets.symmetric(horizontal: kPaddingM * 2),
            onPressed: () {
              if (widget.onChange != null) {
                widget.onChange(button);
              }
              setState(() {
                if (widget.isUnselectable &&
                    _currentSelectedButton == widget.buttonValues[index]) {
                  _currentSelectedButton = null;
                } else {
                  _currentSelectedButton = widget.buttonValues[index];
                }
              });
            },
            child: Text(
              widget.buttonValues[index].label,
              // textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                    color: _currentSelectedButton == widget.buttonValues[index]
                        ? kWhite
                        : Theme.of(context).textTheme.button.color,
                    fontWeight:
                        _currentSelectedButton == widget.buttonValues[index]
                            ? FontWeight.w500
                            : FontWeight.w600,
                  ),
            )),
      );
    }).toList();
  }
}

class CategoriesButtonGroup extends StatefulWidget {
  const CategoriesButtonGroup({
    Key key,
    this.onChange,
    this.preselectedValue,
  }) : super(key: key);

  /// On value change.
  final Function(int) onChange;

  /// Preselected button value.
  final ButtonGroupModel preselectedValue;

  @override
  _CategoriesButtonGroupState createState() => _CategoriesButtonGroupState();
}

class _CategoriesButtonGroupState extends State<CategoriesButtonGroup> {
  int _currentSelectedButton;

  @override
  void initState() {
    super.initState();

    // if (widget.preselectedValue != null) {
    //   final int index = widget.buttonValues.indexOf(widget.preselectedValue);
    //   if (index != -1) {
    //     _currentSelectedButton = widget.buttonValues[index];
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10.0,
      runSpacing: 10.0,
      children: List.generate(
        9,
        (index) => _buildCategoryButton(index),
      ),
    );
  }

  Widget _buildCategoryButton(int index) {
    return Container(
      height: 100,
      width: 100,
      child: Card(
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.zero,
        color: _currentSelectedButton == index ? kBlue : kWhite,
        shape: RoundedRectangleBorder(
          borderRadius:
              const BorderRadius.all(Radius.circular(kRoundedButtonRadius)),
        ),
        child: InkWell(
            onTap: () {
              if (widget.onChange != null) {
                widget.onChange(index);
              }
              setState(() {
                if (_currentSelectedButton == index) {
                  _currentSelectedButton = null;
                } else {
                  _currentSelectedButton = index;
                }
              });
            },
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
                  style: const TextStyle().copyWith(
                    fontSize: 12,
                    color: _currentSelectedButton == index
                        ? kWhite
                        : Theme.of(context).textTheme.button.color,
                    fontWeight: _currentSelectedButton == index
                        ? FontWeight.bold
                        : FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
              ],
            )),
      ),
    );
  }
}
