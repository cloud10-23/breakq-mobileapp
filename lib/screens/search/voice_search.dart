import 'dart:async';
import 'dart:math';

import 'package:breakq/configs/app_globals.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/configs/routes.dart';
import 'package:breakq/main.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class VoiceSearch extends StatefulWidget {
  @override
  _VoiceSearchState createState() => _VoiceSearchState();
}

class _VoiceSearchState extends State<VoiceSearch> {
  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  String lastWords = '';
  String lastError = '';
  String lastStatus = '';
  String _currentLocaleId = '';
  int resultListened = 0;
  String _status = "";

  bool _isInitialised;
  final SpeechToText speech = SpeechToText();

  @override
  void initState() {
    super.initState();
    _isInitialised = getIt.get<AppGlobals>().hasSpeech;
    if (!_isInitialised) {
      initSpeechState();
    } else
      startListening();
  }

  @override
  void dispose() {
    super.dispose();
    stopListening();
  }

  Future<void> initSpeechState() async {
    var hasSpeech = await speech.initialize(
        onError: errorListener, onStatus: statusListener, debugLogging: true);
    if (hasSpeech) {
      var systemLocale = await speech.systemLocale();
      _currentLocaleId = systemLocale.localeId;
    }

    startListening();

    getIt.get<AppGlobals>().hasSpeech = true;

    if (!mounted) return;

    setState(() {
      _isInitialised = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: 100,
        child: Builder(builder: (context) {
          if (_isInitialised)
            return Row(
              children: <Widget>[
                Spacer(),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          blurRadius: .26,
                          spreadRadius: level * 1.5,
                          color: Colors.black.withOpacity(.05))
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.mic),
                    onPressed: () => startListening(),
                  ),
                ),
                Spacer(),
                Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      _status,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.cancel_outlined),
                  onPressed: () => cancelListening(context),
                ),
                Spacer(),
              ],
            );
          return Row(
            children: [
              Spacer(),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                child: Icon(
                  Icons.mic,
                ),
              ),
              Spacer(),
              Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    "Initialising...",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
              Spacer(),
              IconButton(
                icon: Icon(Icons.cancel_outlined),
                onPressed: () => cancelListening(context),
              ),
              Spacer(),
            ],
          );
        }),
      ),
    );
  }

  void startListening() {
    lastWords = '';
    lastError = '';
    speech.listen(
        onResult: (result) => resultListener(result, context),
        listenFor: Duration(seconds: 5),
        pauseFor: Duration(seconds: 5),
        partialResults: false,
        localeId: _currentLocaleId,
        onSoundLevelChange: soundLevelListener,
        cancelOnError: true,
        listenMode: ListenMode.confirmation);
    setState(() {
      _status = "Listening...";
    });
  }

  void stopListening() {
    speech.cancel();
  }

  void cancelListening(BuildContext context) {
    speech.cancel();
    Navigator.pop(context);
  }

  void resultListener(SpeechRecognitionResult result, BuildContext context) {
    ++resultListened;
    print('Result listener $resultListened');
    //Return the result text or give it to Search Bar
    lastWords = '${result.recognizedWords} - ${result.finalResult}';
    setState(() {
      _status = result.recognizedWords;
    });
    Navigator.pop(context);
    getIt.get<AppGlobals>().globalKeyCustomNavigator.currentState.pushNamed(
        CustomNavigatorRoutes.listing,
        arguments: result.recognizedWords);
  }

  void soundLevelListener(double level) {
    minSoundLevel = min(minSoundLevel, level);
    maxSoundLevel = max(maxSoundLevel, level);
    print("sound level $level: $minSoundLevel - $maxSoundLevel ");
    setState(() {
      this.level = level;
    });
  }

  void errorListener(SpeechRecognitionError error) {
    print("Received error status: $error, listening: ${speech.isListening}");
    lastError = '${error.errorMsg} - ${error.permanent}';
    setState(() {
      _status = 'An error occured';
    });
  }

  void statusListener(String status) {
    print(
        'Received listener status: $status, listening: ${speech.isListening}');
    setState(() {
      lastStatus = '$status';
    });
  }
}
