import 'package:flutter/material.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/toolbar_option_model.dart';
import 'package:breakq/widgets/modal_bottom_sheet_item.dart';
import 'package:breakq/utils/text_style.dart';

/// Filter button used on search screen for filtering data.
///
/// Pressing the button opens a [ModalBottomSheet] dialog box for presenting the
/// options to select from.
class FilterButton extends StatefulWidget {
  const FilterButton({
    Key key,
    @required this.label,
    this.modalTitle,
    this.modalItems,
    this.selectedItem,
    this.onSelection,
  }) : super(key: key);

  /// Button label.
  final String label;

  /// [ModalBottomSheet] dialog box title.
  final String modalTitle;

  /// [ModalBottomSheet] dialog box items.
  final List<ToolbarOptionModel> modalItems;

  /// [ModalBottomSheet] dialog box preselected items.
  final ModalBottomSheetItem<ToolbarOptionModel> selectedItem;

  /// [ModalBottomSheet] dialog box item selection callback function.
  final ToolbarOptionModelCallback onSelection;

  @override
  _FilterButtonState createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton>
    with SingleTickerProviderStateMixin {
  /// Uniqe key for button animations.
  final UniqueKey keyIcon = UniqueKey();

  /// Button animation controller.
  AnimationController animationController;

  /// Is button opened (modal box is shown)?
  bool _isOpened = false;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: kButtonAnimationDuration,
    );
  }

  @override
  void dispose() {
    animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        animationController.forward();
        setState(() {
          _isOpened = true;
        });
        _showModal(context);
      },
      child: Card(
        color: _isOpened ? kBlue : Theme.of(context).cardColor,
        margin: const EdgeInsets.only(right: kPaddingS / 2),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kRoundedButtonRadius)),
        elevation: 0,
        child: Container(
          padding: const EdgeInsets.only(
              top: kPaddingS / 2,
              left: kPaddingM * 2,
              bottom: kPaddingS / 2,
              right: kPaddingS * 2),
          child: Row(
            children: <Widget>[
              Text(
                widget.label,
                style: Theme.of(context).textTheme.subtitle2.w600.copyWith(
                    color: _isOpened
                        ? kWhite
                        : Theme.of(context).textTheme.subtitle2.color),
              ),
              RotationTransition(
                turns: Tween<double>(begin: 0, end: 0.5).animate(
                  CurvedAnimation(
                    parent: animationController,
                    curve: Curves.easeIn,
                  ),
                ),
                child: Icon(
                  Icons.keyboard_arrow_up,
                  key: keyIcon,
                  color: _isOpened
                      ? kWhite
                      : Theme.of(context).textTheme.subtitle2.color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showModal(BuildContext context) {
    final List<ModalBottomSheetItem<ToolbarOptionModel>> _options =
        <ModalBottomSheetItem<ToolbarOptionModel>>[];

    for (final ToolbarOptionModel model in widget.modalItems) {
      _options.add(ModalBottomSheetItem<ToolbarOptionModel>(
        text: model.label,
        value: model,
      ));
    }

    showModalBottomSheet<void>(
      backgroundColor: kTransparent,
      context: context,
      builder: (BuildContext context) {
        return ModalBottomSheet(
          title: widget.modalTitle,
          selected: widget.selectedItem,
          options: _options,
          onClose: _close,
          onChange: (dynamic item) {
            _close();
            item = item as ToolbarOptionModel;
            if (item != widget.selectedItem) {
              if (widget.onSelection != null) {
                widget.onSelection(item as ToolbarOptionModel);
              }
            }
          },
        );
      },
    ).then((void value) => _close());
  }

  void _close() {
    animationController.reverse();
    setState(() => _isOpened = false);
  }
}
