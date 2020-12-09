import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:breakq/blocs/auth/auth_bloc.dart';
import 'package:breakq/configs/app_globals.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/configs/routes.dart';
import 'package:breakq/generated/l10n.dart';
import 'package:breakq/main.dart';
import 'package:breakq/utils/form_utils.dart';
import 'package:breakq/utils/form_validator.dart';
import 'package:breakq/utils/ui.dart';
import 'package:breakq/widgets/form_label.dart';
import 'package:breakq/widgets/list_title.dart';
import 'package:breakq/widgets/modal_bottom_sheet_item.dart';
import 'package:breakq/widgets/theme_button.dart';
import 'package:breakq/widgets/theme_text_input.dart';

enum PhotoSource { gallery, camera }

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key key}) : super(key: key);

  @override
  _EditProfileScreenState createState() {
    return _EditProfileScreenState();
  }
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final GlobalKey<ThemeTextInputState> keyNameInput =
      GlobalKey<ThemeTextInputState>();
  final TextEditingController _textNameController = TextEditingController();
  final TextEditingController _textPhoneController = TextEditingController();
  final FocusNode _focusName = FocusNode();
  final FocusNode _focusPhone = FocusNode();

  File _image;
  AuthBloc _authBloc;

  @override
  void initState() {
    _authBloc = BlocProvider.of<AuthBloc>(context);

    _textNameController.text =
        getIt.get<AppGlobals>().user?.displayName ?? 'Guest';
    _textPhoneController.text = getIt.get<AppGlobals>().user?.phoneNumber ?? '';

    super.initState();
  }

  Future<void> _update() async {
    FormUtils.hideKeyboard(context);

    if (keyNameInput.currentState.validate()) {
      _authBloc.add(ProfileUpdatedAuthEvent(
        fullName: _textNameController.text,
        phone: _textPhoneController.text,
        image: _image,
      ));
    }
  }

  Future<void> _getImage() async {
    // final ImagePicker picker = ImagePicker();
    // final PickedFile image = await picker.getImage(source: ImageSource.gallery);
    // if (image != null) {
    //   setState(() {
    //     _image = File(image.path);
    //   });
    // }
  }

  void _photoSourceSelection(BuildContext context) {
    final List<ModalBottomSheetItem<PhotoSource>> _options =
        <ModalBottomSheetItem<PhotoSource>>[];

    _options.add(ModalBottomSheetItem<PhotoSource>(
      text: L10n.of(context).commonPhotoSources(PhotoSource.gallery),
      value: PhotoSource.gallery,
    ));

    // if (getIt.get<AppGlobals>().cameras.isNotEmpty) {
    //   _options.add(ModalBottomSheetItem<PhotoSource>(
    //     text: L10n.of(context).commonPhotoSources(PhotoSource.camera),
    //     value: PhotoSource.camera,
    //   ));
    // }

    showModalBottomSheet<PhotoSource>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return ModalBottomSheet(
          options: _options,
          onChange: (dynamic item) async {
            final PhotoSource selectedSource = item as PhotoSource;
            if (selectedSource == PhotoSource.gallery) {
              _getImage();
            } else {
              await Navigator.pushNamed<String>(context, Routes.takePicture)
                  .then((String imagePath) {
                if (imagePath != null) {
                  setState(() {
                    _image = File(imagePath);
                  });
                }
              });
            }
          },
        );
      },
    );
  }

  Widget _profilePicture() {
    ImageProvider _defaultImage;
    if (getIt.get<AppGlobals>().user?.photoURL == null)
      _defaultImage = AssetImage(AssetsImages.profileDefault);
    else
      _defaultImage = NetworkImage(getIt.get<AppGlobals>().user.photoURL);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            _photoSourceSelection(context);
          },
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Container(
                width: 128,
                height: 128,
                child: _image == null
                    ? Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: _defaultImage,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(64),
                        child: Image.file(
                          _image,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
              const Icon(
                Icons.camera_alt,
                color: Colors.white,
                size: 24,
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(L10n.of(context).editProfileTitle),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(
                    left: kPaddingM, right: kPaddingM, top: kPaddingM),
                children: <Widget>[
                  _profilePicture(),
                  ListTitle(
                      title: L10n.of(context).editProfileListTitleContact),
                  FormLabel(text: L10n.of(context).editProfileLabelFullname),
                  ThemeTextInput(
                    key: keyNameInput,
                    focusNode: _focusName,
                    textInputAction: TextInputAction.next,
                    onSubmitted: (String text) {
                      FormUtils.fieldFocusChange(
                        context,
                        _focusName,
                        _focusPhone,
                      );
                    },
                    controller: _textNameController,
                    validator: FormValidator.isRequired(
                        L10n.of(context).formValidatorRequired),
                  ),
                  FormLabel(text: L10n.of(context).editProfileLabelPhone),
                  ThemeTextInput(
                    focusNode: _focusPhone,
                    readOnly: true,
                    textInputAction: TextInputAction.next,
                    controller: _textPhoneController,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: kPaddingM, vertical: kPaddingS),
              child: BlocBuilder<AuthBloc, AuthState>(
                builder: (BuildContext context, AuthState apiState) {
                  return BlocListener<AuthBloc, AuthState>(
                    listener: (BuildContext context, AuthState apiListener) {
                      if (apiListener is ProfileUpdateFailureAuthState) {
                        UI.showErrorDialog(context,
                            message: apiListener.message);
                      }
                      if (apiListener is ProfileUpdateSuccessAuthState) {
                        UI.showMessage(
                          context,
                          title: L10n.of(context).editProfileTitle,
                          message: L10n.of(context).editProfileSuccess,
                          buttonText: L10n.of(context).commonBtnClose,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        );
                      }
                    },
                    child: ThemeButton(
                      onPressed: _update,
                      text: L10n.of(context).editProfileBtnUpdate,
                      showLoading: apiState is ProcessInProgressAuthState,
                      disableTouchWhenLoading: true,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
