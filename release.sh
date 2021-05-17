#!/bin/bash
# A script to automate the apk building process

flutter build apk --split-per-abi

VERSION=`cat version.txt`
VERSION=$(($VERSION+1))
APK=BreakQ_API_v$VERSION.apk

echo $VERSION > version.txt

mv build/app/outputs/flutter-apk/app-armeabi-v7a-release.apk assets/apks/$APK

adb install assets/apks/$APK

adb push assets/apks/$APK /storage/emulated/0/Download/Apks/
