import 'package:firebase_analytics/firebase_analytics.dart';

/// Analytics Constants
/// Names
const homeScreenReached = "home_screen_reached";
const addNewPostScreenReached = "add_new_post_screen_reached";
const addNewPostAction = "add_new_post_action";
const editPostAction = "edit_post_action";

/// Params
const postId = "post_id";

class FirebaseAnalyticsTracker {
  static final FirebaseAnalyticsTracker _singleton =
      FirebaseAnalyticsTracker._internal();

  factory FirebaseAnalyticsTracker() {
    return _singleton;
  }

  FirebaseAnalyticsTracker._internal();

  /// Firebase Analytics Instance
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  Future logEvent(String name, Map<String, dynamic>? parameters) {
    return analytics.logEvent(name: name, parameters: parameters);
  }
}
