import 'dart:io';

import 'package:breakq/configs/app_globals.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/configs/routes.dart';
import 'package:breakq/generated/l10n.dart';
import 'package:breakq/main.dart';
import 'package:breakq/screens/edit_profile/edit_profile.dart';
import 'package:breakq/widgets/modal_bottom_sheet_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImageEditor extends StatefulWidget {
  @override
  _ProfileImageEditorState createState() => _ProfileImageEditorState();
}

class _ProfileImageEditorState extends State<ProfileImageEditor> {
  File _image;

  Future<void> _getImage() async {
    final ImagePicker picker = ImagePicker();
    final PickedFile image = await picker.getImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  void _photoSourceSelection(BuildContext context) {
    final List<ModalBottomSheetItem<PhotoSource>> _options =
        <ModalBottomSheetItem<PhotoSource>>[];

    _options.add(ModalBottomSheetItem<PhotoSource>(
      text: L10n.of(context).commonPhotoSources(PhotoSource.gallery),
      value: PhotoSource.gallery,
    ));

    // if (getIt.get<AppGlobals>().cameras.isNotEmpty) {
    _options.add(ModalBottomSheetItem<PhotoSource>(
      text: L10n.of(context).commonPhotoSources(PhotoSource.camera),
      value: PhotoSource.camera,
    ));
    // }

    showModalBottomSheet<PhotoSource>(
      backgroundColor: kWhite,
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

  @override
  Widget build(BuildContext context) {
    ImageProvider _defaultImage;
    if (getIt.get<AppGlobals>().user?.photoURL == null)
      _defaultImage = AssetImage(AssetImages.profileDefault);
    else
      _defaultImage =
          CachedNetworkImageProvider(getIt.get<AppGlobals>().user.photoURL);
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
                width: 98,
                height: 98,
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
}
