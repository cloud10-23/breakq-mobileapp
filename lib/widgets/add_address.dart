import 'package:breakq/configs/constants.dart';
import 'package:breakq/widgets/edit_text_widgets.dart';
import 'package:breakq/widgets/theme_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:breakq/utils/text_style.dart';

class AddEditAddress extends StatefulWidget {
  static var tag = "/T2SignUp";

  @override
  AddEditAddressState createState() => AddEditAddressState();
}

class AddEditAddressState extends State<AddEditAddress> {
  bool passwordVisible = false;
  bool isRemember = false;
  final GlobalKey<FormState> formKey =
      GlobalKey(debugLabel: "Form for add address");

  @override
  void initState() {
    super.initState();
    passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          primary: true,
          pinned: true,
          expandedHeight: 150,
          flexibleSpace: FlexibleSpaceBar(
            title: Text('Add/ Edit Address',
                style: Theme.of(context).textTheme.bodyText1.fs14),
            background: Row(
              children: [
                Spacer(),
                Expanded(
                  child: SvgPicture.asset(
                    AssetImages.addressIllustration,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: AutofillGroup(
              child: Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    FilledEditText(
                      hint: "Full Name",
                      isFirstField: true,
                      onSaved: (newValue) {},
                      error: "Please enter your name!",
                    ),
                    FilledEditText(
                      hint: "Phone Number",
                      inputTpe: TextInputType.phone,
                      onSaved: (newValue) {},
                      error: "Please enter your mobile number!",
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 10,
                          child: FilledEditText(
                            hint: "Pin Code",
                            inputTpe: TextInputType.number,
                            onSaved: (newValue) {},
                            error: "Please fill the pin code!",
                          ),
                        ),
                        Spacer(),
                        Expanded(
                          flex: 10,
                          child: FilledEditText(
                            hint: "House No/Building",
                            onSaved: (newValue) {},
                            inputTpe: TextInputType.streetAddress,
                            error: "Please fill the house no!",
                          ),
                        ),
                      ],
                    ),
                    FilledEditText(
                      hint: "Street, Colony, Locality, Area",
                      onSaved: (newValue) {},
                      inputTpe: TextInputType.streetAddress,
                      error: "Please fill the address line!",
                    ),
                    FilledEditText(
                      hint: "Landmark (optional)",
                      onSaved: (newValue) {},
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: FilledEditText(
                            hint: "State",
                            onSaved: (newValue) {},
                            error: "Please fill the state!",
                          ),
                        ),
                        Spacer(),
                        Expanded(
                          flex: 5,
                          child: FilledEditText(
                            hint: "City",
                            onSaved: (newValue) {},
                            error: "Please fill the city!",
                            isLastField: true,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    ThemeButton(
                      text: "Add Address",
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
