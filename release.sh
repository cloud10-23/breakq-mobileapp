#!/bin/bash
# A script to automate the apk building process

flutter build apk --split-per-abi

VERSION=`cat version.txt`
VERSION=$(($VERSION+1))
echo $VERSION > version.txt

mv build/app/outputs/flutter-apk/app-armeabi-v7a-release.apk assets/apks/BreakQ_UI_FIX_v$VERSION.apk

adb install assets/apks/BreakQ_UI_FIX_v$VERSION.apk

adb push assets/apks/BreakQ_UI_FIX_v$VERSION.apk /storage/emulated/0/Download/Apks/
