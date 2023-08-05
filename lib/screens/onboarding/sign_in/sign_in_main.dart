import 'package:breakq/configs/constants.dart';
import 'package:breakq/configs/routes.dart';
import 'package:breakq/screens/onboarding/sign_in/sign_in_base.dart';
import 'package:breakq/screens/onboarding/sign_in/widgets/sign_in_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:breakq/utils/text_style.dart';

import '../../../blocs/application/application_bloc.dart';

class IntroMain extends StatelessWidget {
  // IntroMain({@required this.onMobileLogin});
  // final VoidCallback onMobileLogin;
  @override
  Widget build(BuildContext context) {
    return BaseBlocWrapper(
      child: SignInBase(
        child: Container(
          decoration: BoxDecoration(
            color: kWhite,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(kCardRadius),
              topRight: Radius.circular(kCardRadius),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: kPaddingL, vertical: kPaddingL),
                child: Text(
                  "Welcome to BreakQ!",
                  style: Theme.of(context).textTheme.headline5.w600,
                ),
              ),
              // Spacer(),
              GestureDetector(
                  onTap: (){
                    // Navigator.of(context)
                    //     .popUntil(ModalRoute.withName(Routes.o_home));
                    // BlocProvider.of<ApplicationBloc>(context)
                    //     .add(OnboardingCompletedApplicationEvent());
                  },
                  child: Image(image: AssetImage(AssetImages.homeIllustration))),
              // Spacer(),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    kPaddingL, kPaddingM, kPaddingL, kPaddingS),
                child: Text(
                  "Shop faster and break the Queue with BreakQ!" +
                      " Let's start with your details",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .w500
                      .copyWith(color: Colors.black45),
                ),
              ),
              Spacer(),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kPaddingL),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40)),
                        // side: BorderSide(color: Colors.grey),
                        elevation: 0.0,
                        backgroundColor: kBlue900,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: kPaddingM * 2),
                      ),
                      onPressed: () =>
                          Navigator.of(context).pushNamed(Routes.o_mobileLogin),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Spacer(flex: 1),
                          Icon(
                            FontAwesome5Solid.mobile_alt,
                            size: 18.0,
                            color: kWhite,
                          ),
                          Spacer(flex: 2),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              "Continue with Mobile Number",
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .w600
                                  .white,
                            ),
                          ),
                          Spacer(flex: 4),
                        ],
                      ),
                      // splashColor: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kPaddingL,
                      vertical: kPaddingL,
                    ),
                    child: Row(
                      children: [
                        // Expanded(
                        //     child: SignInSocialButton(social: Social.google)),
                        // Expanded(
                        //     child: SignInSocialButton(social: Social.facebook)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
