import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

logEvent(FirebaseAnalytics analytics) async {
  try {
    analytics.logEvent(name: 'ace_app_log_event', parameters: <String, dynamic>{
      'string': 'Log Event',
      'int': 310,
      'long': 1234567890123,
      'double': 310.202002,
      'bool': true,
    });
  } catch (e) {
    await FirebaseCrashlytics.instance.recordError(
      e,
      StackTrace.current,
      reason: e.toString(),
    );
  }
}

setCurrentScreen(
    FirebaseAnalytics analytics, String screenName, String screenClass) async {
  try {
    analytics.setCurrentScreen(
      screenName: screenName,
      screenClassOverride: screenClass,
    );
  } catch (e) {
    await FirebaseCrashlytics.instance.recordError(
      e,
      StackTrace.current,
      reason: e.toString(),
    );
  }
}

setUserId(FirebaseAnalytics analytics, String userID) async {
  try {
    analytics.setUserId(id: userID);
  } catch (e) {
    await FirebaseCrashlytics.instance.recordError(
      e,
      StackTrace.current,
      reason: e.toString(),
    );
  }
}
