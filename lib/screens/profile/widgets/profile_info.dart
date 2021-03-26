import 'package:flutter/material.dart';
import 'package:breakq/configs/app_globals.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/configs/routes.dart';
import 'package:breakq/main.dart';
import 'package:breakq/utils/text_style.dart';

class ProfileInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String _photoURL = getIt.get<AppGlobals>().user?.photoURL ?? null;
    ImageProvider _image;
    if (_photoURL == null)
      _image = AssetImage(AssetImages.profileDefault);
    else
      _image = NetworkImage(_photoURL);

    final List<Widget> profileColumn = [
      Row(
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
              padding: const EdgeInsets.only(left: kPaddingL),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    getIt.get<AppGlobals>().user?.displayName ?? "Guest",
                    maxLines: 2,
                    style: Theme.of(context).textTheme.headline5.bold.white,
                    overflow: TextOverflow.fade,
                  ),
                  const Padding(padding: EdgeInsets.only(top: kPaddingM)),
                  Text(
                    getIt.get<AppGlobals>().user?.phoneNumber ?? '',
                    maxLines: 1,
                    style:
                        Theme.of(context).textTheme.bodyText1.w400.white.number,
                    overflow: TextOverflow.fade,
                  ),
                ],
              ),
            ),
          ),
          Icon(
            Icons.arrow_right,
            size: 30,
            color: kWhite,
          )
        ],
      ),
    ];

    return InkWell(
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, Routes.editProfile);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: (getIt.get<AppGlobals>().user?.email == null)
            ? profileColumn
            : profileColumn +
                [
                  SizedBox(height: kPaddingL),
                  Text(
                    getIt.get<AppGlobals>().user?.email ?? "",
                    maxLines: 1,
                    style: Theme.of(context).textTheme.caption.w600.white,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
      ),
    );
  }
}
