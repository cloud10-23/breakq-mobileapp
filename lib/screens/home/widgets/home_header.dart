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
    return Container(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          WavyHeaderImage(
              shrinkOffsetPercentage: shrinkOffset / expandedHeight),
          Padding(
            padding: const EdgeInsets.only(
              bottom: kPaddingL,
              left: kPaddingL,
              top: kToolbarHeight,
              right: kPaddingL,
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Spacer(),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            L10n.of(context).homeTitleHi,
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                .white
                                .w500,
                          ),
                        ),
                        Flexible(
                          child: Text(
                            getIt.get<AppGlobals>().user?.displayName != null
                                ? getIt.get<AppGlobals>().user.displayName
                                : L10n.of(context).nameGuest,
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                .white
                                .w700,
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                      ],
                    ),
                    // Expanded(
                    //   child: Padding(
                    //     padding: const EdgeInsets.only(top: kPaddingS),
                    //     child: Text(
                    //       L10n.of(context).homeHeaderSubtitle,
                    //       style: Theme.of(context)
                    //           .textTheme
                    //           .bodyText1
                    //           .copyWith(color: kWhite),
                    //       maxLines: 1,
                    //     ),
                    //   ),
                    // ),
                    Spacer(flex: 5),
                  ],
                ),
                Spacer(),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: kPaddingS),
                        width: 80,
                        height: 80,
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
                ),
              ],
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                  bottom: kPaddingL, left: kPaddingL, right: kPaddingL),
              child: Card(
                color: getIt.get<AppGlobals>().isPlatformBrightnessDark
                    ? Theme.of(context).accentColor
                    : Theme.of(context).cardColor,
                margin: const EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(kBoxDecorationRadius)),
                elevation: 2,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(kBoxDecorationRadius / 2)),
                    onPressed: () {
                      // Switch to Search Tab
                      // if (onPressed != null) {
                      //   onPressed();
                      // }
                    },
                    child: IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.search,
                            color: Theme.of(context).hintColor,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
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
  double get minExtent => 158;

  /// Whether this delegate is meaningfully different from the old delegate.
  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
