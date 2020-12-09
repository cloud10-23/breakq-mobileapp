import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

/// Console related functions like logging.
class Console {
  /// Log to console.
  static void log(String tag, dynamic msg, {Object error}) {
    // Application was compiled in debug mode?
    if (kDebugMode) {
      developer.log('$msg', time: DateTime.now(), name: tag, error: error);
    } else {
      // TODO(juzo): Debugging in production mode
    }
  }
}
