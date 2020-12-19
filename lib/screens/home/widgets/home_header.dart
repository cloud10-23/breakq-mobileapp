import 'package:flutter/material.dart';
import 'package:breakq/configs/app_globals.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/generated/l10n.dart';
import 'package:breakq/main.dart';
import 'package:breakq/screens/home/widgets/wavy_header_image.dart';
import 'package:breakq/utils/text_style.dart';

/// Delegate for configuring a [SliverPersistentHeader].
///
/// A sliver whose size varies when the sliver is scrolled to the edge
/// of the viewport opposite the sliver's [GrowthDirection].
class HomeHeader extends SliverPersistentHeaderDelegate {
  HomeHeader({
    this.expandedHeight,
    this.label,
    this.onPressed,
  });

  /// The max height of the header.
  final double expandedHeight;
  final VoidCallback onPressed;
  final String label;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SafeArea(
      child: Stack(
        overflow: Overflow.clip,
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              bottom: kPaddingS,
              left: kPaddingM,
              top: kPaddingM,
              right: kPaddingM,
            ),
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      L10n.of(context).homeTitleHi,
                      style: Theme.of(context).textTheme.headline6.w500,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: kPaddingS,
                        left: kPaddingM,
                      ),
                      child: Text(
                        getIt.get<AppGlobals>().user?.displayName != null
                            ? getIt.get<AppGlobals>().user.displayName
                            : L10n.of(context).nameGuest,
                        // L10n.of(context).homeHeaderSubtitle,
                        style: Theme.of(context).textTheme.headline4.w600,
                        // .copyWith(color: kWhite),
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: kPaddingS),
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(AssetsImages.profileDefault),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ],
            ),
          ),
          Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            padding: const EdgeInsets.all(kPaddingM),
            height: 90,
            child: Card(
              color: getIt.get<AppGlobals>().isPlatformBrightnessDark
                  ? Theme.of(context).accentColor
                  : Theme.of(context).cardColor,
              margin: const EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(kBoxDecorationRadius)),
              elevation: 2,
              child: FlatButton(
                // color: kPrimaryAccentColor,
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(kBoxDecorationRadius / 2)),
                onPressed: () {
                  // Switch to Search Tab
                  // if (onPressed != null) {
                  //   onPressed();
                  // }
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.search,
                      color: Theme.of(context).hintColor,
                    ),
                    Spacer(),
                    Expanded(
                      flex: 9,
                      child: Text(
                        L10n.of(context).homePlaceholderSearch,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            .copyWith(color: Theme.of(context).hintColor),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// The size of the header when it is not shrinking at the top of the
  /// viewport.
  ///
  /// This must return a value equal to or greater than [minExtent].
  @override
  double get maxExtent => expandedHeight;

  /// The smallest size to allow the header to reach, when it shrinks at the
  /// start of the viewport.
  ///
  /// This must return a value equal to or less than [maxExtent].
  @override
  double get minExtent => 90;

  /// Whether this delegate is meaningfully different from the old delegate.
  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
