import 'package:breakq/blocs/checkout/ch_bloc.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/address.dart';
import 'package:breakq/data/repositories/address_repository.dart';
import 'package:breakq/utils/form_validator.dart';
import 'package:breakq/widgets/edit_text_widgets.dart';
import 'package:breakq/widgets/theme_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:breakq/utils/text_style.dart';

class AddEditAddress extends StatefulWidget {
  AddEditAddress({this.address});
  final Address address;
  @override
  AddEditAddressState createState() => AddEditAddressState();
}

class AddEditAddressState extends State<AddEditAddress> {
  final GlobalKey<FormState> formKey =
      GlobalKey(debugLabel: "Form for add address");
  Address address;

  @override
  void initState() {
    super.initState();
    address = widget.address ?? Address();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kWhite,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              primary: true,
              pinned: true,
              expandedHeight: 150,
              flexibleSpace: FlexibleSpaceBar(
                title: Text('Add/ Edit Address',
                    style: Theme.of(context).textTheme.bodyText1.fs14.white),
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
                          initialValue: address?.fullName,
                          isFirstField: true,
                          onSaved: (name) => address.setName = name,
                          validators: [
                            FormValidator.isRequired("Please enter your name!")
                          ],
                          autoFillHints: [AutofillHints.name],
                        ),
                        FilledEditText(
                          hint: "Phone Number",
                          initialValue: address?.phone,
                          inputTpe: TextInputType.phone,
                          onSaved: (phone) => address.setPhone = phone,
                          validators: [
                            FormValidator.isRequired(
                                "Please enter your mobile number!"),
                            FormValidator.isMinLength(
                                length: 10,
                                errorMessage:
                                    "Please enter a valid mobile number!"),
                            FormValidator.isMaxLength(
                                length: 10,
                                errorMessage:
                                    "Please enter a valid mobile number!"),
                          ],
                          autoFillHints: [AutofillHints.telephoneNumber],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 10,
                              child: FilledEditText(
                                hint: "Pin Code",
                                initialValue: address?.pinCode,
                                inputTpe: TextInputType.number,
                                onSaved: (pinCode) =>
                                    address.setPinCode = pinCode,
                                validators: [
                                  FormValidator.isRequired(
                                      "Please fill the pin code!"),
                                  FormValidator.isMinLength(
                                      length: 6,
                                      errorMessage:
                                          "Please enter a valid pin code!"),
                                  FormValidator.isMaxLength(
                                      length: 6,
                                      errorMessage:
                                          "Please enter a valid pin code!"),
                                ],
                                autoFillHints: [AutofillHints.postalCode],
                              ),
                            ),
                            Spacer(),
                            Expanded(
                              flex: 10,
                              child: FilledEditText(
                                hint: "House No/Building",
                                initialValue: address?.houseNo,
                                onSaved: (houseNo) =>
                                    address.setHouseNo = houseNo,
                                inputTpe: TextInputType.streetAddress,
                                validators: [
                                  FormValidator.isRequired(
                                      "Please fill the house no!")
                                ],
                                autoFillHints: [
                                  AutofillHints.streetAddressLevel1
                                ],
                              ),
                            ),
                          ],
                        ),
                        FilledEditText(
                          hint: "Street, Colony, Locality, Area",
                          initialValue: address?.street,
                          onSaved: (street) => address.setStreet = street,
                          inputTpe: TextInputType.streetAddress,
                          validators: [
                            FormValidator.isRequired(
                                "Please fill the address line!")
                          ],
                          autoFillHints: [AutofillHints.streetAddressLevel2],
                        ),
                        FilledEditText(
                          hint: "Landmark (optional)",
                          initialValue: address?.landmark,
                          onSaved: (landmark) => address.setLandmark = landmark,
                          autoFillHints: [AutofillHints.streetAddressLevel3],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: FilledEditText(
                                hint: "State",
                                initialValue: address?.state,
                                onSaved: (state) => address.setState = state,
                                validators: [
                                  FormValidator.isRequired(
                                      "Please fill the state!")
                                ],
                                autoFillHints: [AutofillHints.addressState],
                              ),
                            ),
                            Spacer(),
                            Expanded(
                              flex: 5,
                              child: FilledEditText(
                                hint: "City",
                                initialValue: address?.city,
                                onSaved: (city) => address.setCityTown = city,
                                validators: [
                                  FormValidator.isRequired(
                                      "Please fill the city!")
                                ],
                                isLastField: true,
                                autoFillHints: [AutofillHints.addressCity],
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
                              BlocProvider.of<CheckoutBloc>(context)
                                  .add(LoadAddressChEvent());
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
