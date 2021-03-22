import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/utils/text_style.dart';

enum ImageAnimationStatus { hidden, becomingVisible, visible }

/// Full screen success dialog presented on the end of a wizard process.
///
/// Used at the end of a booking or reviewing process.
class CheckoutSuccessPlane extends StatefulWidget {
  const CheckoutSuccessPlane({
    Key key,
    this.iconVisibilityDuration = const Duration(milliseconds: 500),
    this.iconSizeDuration = const Duration(milliseconds: 200),
    this.delay = const Duration(milliseconds: 100),
    this.title,
    this.subtitle,
  }) : super(key: key);

  /// Duration of the main icon fade in process.
  final Duration iconVisibilityDuration;

  /// Duration of the main icon resizing process.
  final Duration iconSizeDuration;

  /// Start delay duration.
  final Duration delay;

  /// Dialog title.
  final String title;

  /// Dialog subtitle.
  final String subtitle;

  @override
  _BookingSuccessDialogState createState() => _BookingSuccessDialogState();
}

class _BookingSuccessDialogState extends State<CheckoutSuccessPlane>
    with TickerProviderStateMixin {
  ImageAnimationStatus _successIconStatus = ImageAnimationStatus.hidden;

  AnimationController iconVisibilityAnimationController,
      iconSizeAnimationController;

  Random random;

  @override
  void initState() {
    super.initState();

    random = Random();

    iconVisibilityAnimationController = AnimationController(
      vsync: this,
      duration: widget.iconVisibilityDuration,
    );
    iconVisibilityAnimationController.addListener(() => setState(() {}));
    iconVisibilityAnimationController
        .addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        iconSizeAnimationController.forward(from: 0.0);
      }
    });

    iconSizeAnimationController = AnimationController(
      vsync: this,
      duration: widget.iconSizeDuration,
    );
    iconSizeAnimationController.addListener(() => setState(() {}));
    iconSizeAnimationController.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        _successIconStatus = ImageAnimationStatus.visible;

        iconSizeAnimationController.reverse();
      }
    });

    asyncInitState();
  }

  @override
  void dispose() {
    iconVisibilityAnimationController.dispose();
    iconSizeAnimationController.dispose();
    super.dispose();
  }

  Future<void> asyncInitState() async {
    await Future<void>.delayed(widget.delay);

    if (mounted) {
      setState(() {
        _successIconStatus = ImageAnimationStatus.becomingVisible;
        iconVisibilityAnimationController.forward(from: 0.0);
      });
    }
  }

  Widget _drawSuccessImage() {
    double extraSize, iconOpacity;

    switch (_successIconStatus) {
      case ImageAnimationStatus.hidden:
        extraSize = 0.0;
        iconOpacity = 0.0;
        break;
      case ImageAnimationStatus.becomingVisible:
      case ImageAnimationStatus.visible:
        iconOpacity = iconVisibilityAnimationController.value;
        extraSize = iconSizeAnimationController.value * 20;
        break;
    }

    return Opacity(
      opacity: iconOpacity,
      child: Image(
        image: AssetImage(_successIconStatus == ImageAnimationStatus.visible
            ? AssetImages.success
            : AssetImages.success_plane),
        height: 200 + extraSize,
        width: 200 + extraSize,
        // color: kPrimaryColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: Theme.of(context).brightness == Brightness.dark
          ? SystemUiOverlayStyle.light
          : SystemUiOverlayStyle.dark,
      child: Container(
        color: Theme.of(context).cardColor,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(kPaddingM),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Spacer(flex: 4),
                      _drawSuccessImage(),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(top: kPaddingM),
                        child: Text(
                          widget.title ?? '',
                          style: Theme.of(context).textTheme.headline5.w700,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Visibility(
                        visible:
                            _successIconStatus == ImageAnimationStatus.visible,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: kPaddingM,
                              left: kPaddingM,
                              right: kPaddingM),
                          child: Text(
                            widget.subtitle ?? '',
                            style:
                                Theme.of(context).textTheme.headline6.w600.grey,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Spacer(flex: 6),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
