import 'package:breakq/configs/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:breakq/blocs/application/application_bloc.dart';
import 'package:breakq/widgets/full_screen_indicator.dart';

/// Splash screen shown while the app is loading.
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key, this.isPrimary = true}) : super(key: key);
  final bool isPrimary;

  @override
  _SplashScreenState createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.isPrimary)
      BlocProvider.of<ApplicationBloc>(context).add(SetupApplicationEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: LayoutBuilder(
        builder: (context, constraints) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Spacer(flex: 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AssetImages.bq_icon_text,
                  width: constraints.maxWidth * 0.5,
                  fit: BoxFit.fitWidth,
                ),
              ],
            ),
            Spacer(flex: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  // color: kWhite,
                  strokeWidth: 4,
                  // backgroundColor: kBlue,
                ),
              ],
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
