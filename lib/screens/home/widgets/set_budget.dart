import 'package:breakq/blocs/budget/budget_bloc.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/widgets/card_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:breakq/utils/text_style.dart';

class SetBudgetBottomSheet extends StatefulWidget {
  @override
  _SetBudgetBottomSheetState createState() => _SetBudgetBottomSheetState();
}

class _SetBudgetBottomSheetState extends State<SetBudgetBottomSheet> {
  GlobalKey<FormState> _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return CartHeading(
      title: "Set Budget",
      isCaps: true,
      children: [
        Form(
          key: _formKey,
          child: TextFormField(
            validator: (value) {
              if (value?.contains(RegExp(r'^[0-9]+$')) ?? false) return null;
              return "Please enter a number";
            },
            autofocus: true,
            cursorColor: kBlue,
            style: Theme.of(context).textTheme.headline3.black,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(
                FontAwesome.rupee,
                size: 32,
                color: kBlue,
              ),
              focusColor: kBlue,
              suffix: IconButton(
                icon: Icon(
                  Feather.check_circle,
                  color: kBlue,
                  size: 25,
                ),
                onPressed: _onSubmit,
              ),
            ),
            onEditingComplete: _onSubmit,
            onFieldSubmitted: (_) => _onSubmit,
            onSaved: (value) {
              BlocProvider.of<BudgetBloc>(context)
                  .add(BudgetSetEvent(budget: double.tryParse(value)));
              Navigator.of(context).pop();
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(kPaddingL),
          child: Text(
            "Choose an amount for your budget. We'll let you know when" +
                " you exceed your budget",
            style: Theme.of(context).textTheme.caption,
          ),
        )
      ],
    );
  }

  void _onSubmit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
    }
  }
}
