import 'package:flutter/material.dart';
import 'package:breakq/configs/app_globals.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/configs/routes.dart';
import 'package:breakq/main.dart';
import 'package:breakq/utils/text_style.dart';

class ProfileInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String _photoURL = getIt.get<AppGlobals>().user.photoURL;
    ImageProvider _image;
    if (_photoURL == null)
      _image = AssetImage(AssetsImages.profileDefault);
    else
      _image = NetworkImage(_photoURL);

    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.editProfile);
      },
      child: Row(
        children: <Widget>[
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: _image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kPaddingM),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    getIt.get<AppGlobals>().user.displayName ?? "Guest",
                    maxLines: 1,
                    style: Theme.of(context).textTheme.headline5.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                  // const Padding(padding: EdgeInsets.only(top: 4)),
                  // Text(
                  //   getIt.get<AppGlobals>().user.email,
                  //   maxLines: 1,
                  //   style: Theme.of(context).textTheme.caption.fs14,
                  //   overflow: TextOverflow.ellipsis,
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
