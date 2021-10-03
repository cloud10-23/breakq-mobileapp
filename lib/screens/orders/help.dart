import 'package:breakq/widgets/back_button.dart';
import 'package:flutter/material.dart';
import 'package:breakq/configs/constants.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:breakq/utils/text_style.dart';
import 'package:url_launcher/url_launcher.dart';

class NeedHelp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Need Help?",
            style: TextStyle(
              color: kWhite,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal,
            ),
          ),
          leading: BackButtonCircle(),
        ),
        backgroundColor: kWhite,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 100,
                color: kWhite,
                child: Row(
                  children: [
                    Image(
                      image: AssetImage(AssetImages.bq_icon_text),
                      width: 100,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(kPaddingM),
                        child: Text(
                            'In case of any queries, please reach out to us',
                            style: Theme.of(context).textTheme.subtitle1.w600),
                      ),
                    ),
                  ],
                ),
              ),
              Container(color: kWhite, child: Divider(thickness: 2)),
              SizedBox(height: kPaddingL),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: kPaddingL),
                color: kWhite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        _launchPhone(
                          '+91 1234567890',
                        );
                      },
                      child: Row(
                        children: [
                          Icon(AntDesign.customerservice),
                          Spacer(flex: 2),
                          Text('Customer Helpline:'),
                          Spacer(flex: 3),
                          Text(
                            '+91 1234567890',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                .w600
                                .number,
                          ),
                          Spacer(),
                        ],
                      ),
                      style: OutlinedButton.styleFrom(
                          primary: kBlack,
                          padding: EdgeInsets.all(kPaddingM * 2)),
                    ),
                    SizedBox(height: kPaddingL),
                    OutlinedButton(
                      onPressed: () {
                        _launchPhone(
                          '+91 9876543210',
                        );
                      },
                      child: Row(
                        children: [
                          Icon(Feather.phone),
                          Spacer(flex: 2),
                          Text('Alternate Helpline:'),
                          Spacer(flex: 3),
                          Text(
                            '+91 9876543210',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                .w600
                                .number,
                          ),
                          Spacer(),
                        ],
                      ),
                      style: OutlinedButton.styleFrom(
                          primary: kBlack,
                          padding: EdgeInsets.all(kPaddingM * 2)),
                    ),
                    SizedBox(height: kPaddingL),
                    OutlinedButton(
                      onPressed: () {
                        _launchMail(
                          'helpline-breakq@gmail.com',
                        );
                      },
                      child: Row(
                        children: [
                          Icon(Feather.mail),
                          Spacer(flex: 2),
                          Text('Mail To:'),
                          Spacer(flex: 3),
                          Text(
                            'helpline-breakq@gmail.com',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                .w600
                                .number,
                          ),
                          Spacer(),
                        ],
                      ),
                      style: OutlinedButton.styleFrom(
                          primary: kBlack,
                          padding: EdgeInsets.all(kPaddingM * 2)),
                    ),
                  ],
                ),
              ),
              // Container(color: kWhite, child: Divider(thickness: 2)),
              SizedBox(height: kPaddingM * 2),
            ],
          ),
        ));
  }

  void _launchPhone(String no) async {
    String _url = 'tel:$no';
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
  }

  void _launchMail(String mail) async {
    final Uri _emailLaunchUri = Uri(
        scheme: 'mailto', path: mail, queryParameters: {'subject': 'BreakQ:'});
    final String _url = _emailLaunchUri.toString();
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
  }
}
