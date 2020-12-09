import 'package:flutter/material.dart';
import 'package:breakq/configs/constants.dart';

/// Ribbon style widget.
class Ribbon extends StatefulWidget {
  @override
  RibbonState createState() => RibbonState();
}

class RibbonState extends State<Ribbon> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(right: kPaddingL, top: kPaddingS - 6),
          child: ClipPath(
            clipper: ArcClipper(),
            child: Container(
              width: 40.0,
              height: 64.0,
              padding: const EdgeInsets.only(bottom: 10),
              color: Colors.lightGreen,
              child: const Center(
                child: Icon(
                  Icons.check,
                  color: kWhite,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 4.0,
          right: kPaddingL - 6,
          child: ClipPath(
            clipper: TriangleClipper(),
            child: Container(
              width: 6.0,
              height: 6.0,
              color: Colors.green[700],
            ),
          ),
        )
      ],
    );
  }
}

class ArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(0.0, 0.0);

    path.lineTo(0.0, size.height);
    path.lineTo(size.width / 2, size.height - 12);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(0.0, 0.0);
    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
