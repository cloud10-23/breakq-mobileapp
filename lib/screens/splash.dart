import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:breakq/blocs/application/application_bloc.dart';
import 'package:breakq/widgets/full_screen_indicator.dart';

/// Splash screen shown while the app is loading.
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ApplicationBloc>(context).add(SetupApplicationEvent());
  }

  @override
  Widget build(BuildContext context) {
    return const FullScreenIndicator();
  }
}
