import 'package:flutter/material.dart';
import 'package:breakq/configs/app_globals.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/generated/l10n.dart';
import 'package:breakq/main.dart';
import 'package:breakq/utils/text_style.dart';

/// Delegate for configuring a [SliverPersistentHeader].
///
/// A sliver whose size varies when the sliver is scrolled to the edge
/// of the viewport opposite the sliver's [GrowthDirection].
class HomeHeaderPlain extends SliverPersistentHeaderDelegate {
  HomeHeaderPlain({
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
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Padding(
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
  double get minExtent => expandedHeight;

  /// Whether this delegate is meaningfully different from the old delegate.
  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
