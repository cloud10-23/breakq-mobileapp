import 'package:breakq/data/repositories/store_repository.dart';
import 'package:breakq/utils/console.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:breakq/blocs/auth/auth_bloc.dart';
import 'package:breakq/configs/app_theme.dart';
import 'package:breakq/configs/app_globals.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/main.dart';
import 'package:breakq/utils/app_preferences.dart';
import 'package:location/location.dart';

part 'application_event.dart';
part 'application_state.dart';

class ApplicationBloc extends Bloc<ApplicationEvent, ApplicationState> {
  ApplicationBloc({
    this.authBloc,
  }) : super(InitialApplicationState());

  final AuthBloc authBloc;

  @override
  Stream<ApplicationState> mapEventToState(ApplicationEvent event) async* {
    if (event is SetupApplicationEvent) {
      yield* _mapSetupApplicationEventToState();
    } else if (event is LocationServicesInitedApplicationEvent) {
      yield* _mapInitLocationServicesApplicationEventToState();
    } else if (event is SettingsLoadedApplicationEvent) {
      yield* _mapLoadSettingsApplicationEventToState();
    } else if (event is OnboardingCompletedApplicationEvent) {
      yield* _mapCompletedOnboardingApplicationEventToState();
    } else if (event is LifecycleChangedApplicationEvent) {
      yield* _mapLifecycleChangedApplicationEventToState(event);
    }
  }

  Stream<ApplicationState> _mapSetupApplicationEventToState() async* {
    yield SetupInProgressApplicationState();

    /// Load server/global settings.
    // add(SettingsLoadedApplicationEvent());

    /// Deafult dark option is 'dynamic'.
    DarkOption darkOption = DarkOption.alwaysOff;

    // Validate the selected dark option.
    // if (selectedDarkOption.isNotEmpty) {
    // darkOption = DarkOption.values.firstWhere(
    //     (DarkOption e) => e.toString() == selectedDarkOption,
    //     orElse: () => DarkOption.alwaysOff);
    // }
    // Save the dark option value for future use.
    getIt.get<AppGlobals>().darkThemeOption = darkOption;

    /// Get the current app version.
    // final String oldVersion =
    //     await getIt.get<AppPreferences>().getString(PreferenceKey.appVersion);

    /// Is the user onboarded already?
    getIt.get<AppGlobals>().isUserOnboarded = await getIt
        .get<AppPreferences>()
        .containsKey(PreferenceKey.isOnboarded);

    // // New install/version?
    // if (oldVersion != kAppVersion) {
    //   // Save the new version info.
    //   await getIt
    //       .get<AppPreferences>()
    //       .setString(PreferenceKey.appVersion, kAppVersion);
    //   // Clear logged in user info, and force to re-login.
    //   // await getIt.get<AppPreferences>().remove(PreferenceKey.user);
    // } else {
    // }

    // If user is onboarded, continue to location services initialization.
    if (getIt.get<AppGlobals>()?.isUserOnboarded ?? false) {
      /// Init location services.
      authBloc.add(ProfileLoadedAuthEvent());
      add(LocationServicesInitedApplicationEvent());
      yield SetupSuccessApplicationState();
    } else {
      /// User is not onboarded. Lets welcome them.
      yield OnboardingInProgressApplicationState();
    }
  }

  Stream<ApplicationState> _mapLoadSettingsApplicationEventToState() async* {
    // getIt.get<AppGlobals>().categories =
    //     await const LocationRepository().getCategories();
  }

  Stream<ApplicationState>
      _mapInitLocationServicesApplicationEventToState() async* {
    // LocationAccuracy.powerSave may cause infinite loops on Android
    // while calling getLocation().

    /// Checks if the location service is enabled.
    try {
      bool serviceEnabled = await getIt.get<Location>().serviceEnabled();
      if (serviceEnabled == null || !serviceEnabled) {
        /// Request the activation of the location service.
        final bool serviceRequestedResult =
            await getIt.get<Location>().requestService();
        serviceEnabled = serviceRequestedResult;
      }

      /// Checks if the app has permission to access location.
      PermissionStatus permissionGranted =
          await getIt.get<Location>().hasPermission();
      if (permissionGranted != PermissionStatus.granted) {
        final PermissionStatus permissionRequestedResult =
            await getIt.get<Location>().requestPermission();
        permissionGranted = permissionRequestedResult;
      }
      if (permissionGranted == PermissionStatus.granted) {
        // getIt.get<Location>().changeSettings(accuracy: LocationAccuracy.low);
        // getLocation() may loop forever on emulators if location is set to 'None'.
        getIt.get<AppGlobals>().currentPosition =
            await getIt.get<Location>().getLocation();
      } else {
        getIt.get<AppGlobals>().currentPosition =
            LocationData.fromMap(<String, double>{
          'latitude': kDefaultLat,
          'longitude': kDefaultLon,
          'accuracy': 0.0,
          'altitude': 0.0,
          'speed': 0.0,
          'speed_accuracy': 0.0,
          'heading': 0.0,
          'time': 0.0,
        });
      }
    } catch (e) {
      Console.log('Location ERROR', e.toString(), error: e);
    }

    // Setup is completed. On the main screen.
    yield SetupSuccessApplicationState();
  }

  Stream<ApplicationState>
      _mapCompletedOnboardingApplicationEventToState() async* {
    // Save the info about completed onboarding process to shared preferences.
    await getIt.get<AppPreferences>().setBool(PreferenceKey.isOnboarded, true);

    /// Init the locations services via [ApplicationBloc] event.
    add(LocationServicesInitedApplicationEvent());
  }

  Stream<ApplicationState> _mapLifecycleChangedApplicationEventToState(
      LifecycleChangedApplicationEvent event) async* {
    yield LifecycleChangeInProgressApplicationState(event.state);
  }
}
