import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/address.dart';
import 'package:breakq/data/repositories/address_repository.dart';
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
  final GlobalKey<FormState> formKey =
      GlobalKey(debugLabel: "Form for add address");
  final address = Address();

  @override
  void initState() {
    super.initState();
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
                      onSaved: (name) => address.rebuild(name: name),
                      error: "Please enter your name!",
                    ),
                    FilledEditText(
                      hint: "Phone Number",
                      inputTpe: TextInputType.phone,
                      onSaved: (phone) => address.rebuild(phone: phone),
                      error: "Please enter your mobile number!",
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 10,
                          child: FilledEditText(
                            hint: "Pin Code",
                            inputTpe: TextInputType.number,
                            onSaved: (pinCode) =>
                                address.rebuild(pinCode: pinCode),
                            error: "Please fill the pin code!",
                          ),
                        ),
                        Spacer(),
                        Expanded(
                          flex: 10,
                          child: FilledEditText(
                            hint: "House No/Building",
                            onSaved: (houseNo) =>
                                address.rebuild(houseNo: houseNo),
                            inputTpe: TextInputType.streetAddress,
                            error: "Please fill the house no!",
                          ),
                        ),
                      ],
                    ),
                    FilledEditText(
                      hint: "Street, Colony, Locality, Area",
                      onSaved: (street) => address.rebuild(street: street),
                      inputTpe: TextInputType.streetAddress,
                      error: "Please fill the address line!",
                    ),
                    FilledEditText(
                      hint: "Landmark (optional)",
                      onSaved: (landmark) =>
                          address.rebuild(landmark: landmark),
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: FilledEditText(
                            hint: "State",
                            onSaved: (state) => address.rebuild(state: state),
                            error: "Please fill the state!",
                          ),
                        ),
                        Spacer(),
                        Expanded(
                          flex: 5,
                          child: FilledEditText(
                            hint: "City",
                            onSaved: (city) =>
                                address.rebuild(cityDistTown: city),
                            error: "Please fill the city!",
                            isLastField: true,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    ThemeButton(
                      text: "Add Address",
                      onPressed: () async {
                        if (formKey.currentState.validate()) {
                          formKey.currentState.save();
                          await AddressRepository().addOrUpdate(address);
                          Navigator.of(context).pop();
                        }
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
