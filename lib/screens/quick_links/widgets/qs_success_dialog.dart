import 'package:flutter/material.dart';
import 'package:breakq/generated/l10n.dart';
import 'package:breakq/widgets/success_dialog.dart';

class QSSuccessDialog extends StatefulWidget {
  @override
  _QSSuccessDialogState createState() => _QSSuccessDialogState();
}

class _QSSuccessDialogState extends State<QSSuccessDialog> {
  final Duration durationBeforeClose = Duration(seconds: 3);

  @override
  void initState() {
    super.initState();
    Future.delayed(durationBeforeClose).then((_) {
      if (mounted) Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SuccessDialog(
      title: L10n.of(context).QSSuccessTitle.toUpperCase(),
      subtitle: L10n.of(context).QSSuccessSubtitle,
      btnLabel: L10n.of(context).QSBtnClose,
      startIcon: Icons.shopping_cart,
      endIcon: Icons.add_shopping_cart,
    );
  }
}
