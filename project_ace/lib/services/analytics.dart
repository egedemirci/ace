import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

logEvent(FirebaseAnalytics analytics) async {
  try {
    await analytics
        .logEvent(name: 'ace_app_log_event', parameters: <String, dynamic>{
      'string': 'Log Event',
      'int': 310,
      'long': 1234567890123,
      'double': 310.202202,
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
    await analytics.setCurrentScreen(
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
    await analytics.setUserId(id: userID);
  } catch (e) {
    await FirebaseCrashlytics.instance.recordError(
      e,
      StackTrace.current,
      reason: e.toString(),
    );
  }
}
