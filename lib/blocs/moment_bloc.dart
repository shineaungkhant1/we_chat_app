import 'package:flutter/foundation.dart';

import '../analytics/firebase_analytics_tracker.dart';
import '../data/models/authentication_model.dart';
import '../data/models/authentication_model_impl.dart';
import '../data/models/social_model.dart';
import '../data/models/social_model_impl.dart';
import '../data/vos/moment_vo.dart';

class MomentBloc extends ChangeNotifier {
  List<MomentVO>? moment;

  final SocialModel _mSocialModel = SocialModelImpl();
  final AuthenticationModel _mAuthenticationModel = AuthenticationModelImpl();

  bool isDisposed = false;

  MomentBloc() {
    _mSocialModel.getMoment().listen((momentList) {
      moment = momentList;
      if (!isDisposed) {
        notifyListeners();
      }
    });
    _sendAnalyticsData();
  }

  /// Analytics
  void _sendAnalyticsData() async{
    await FirebaseAnalyticsTracker().logEvent(homeScreenReached, null);
  }

  void onTapDeletePost(int postId) async {
    await _mSocialModel.deletePost(postId);
  }

  Future onTapLogout() {
    return _mAuthenticationModel.logOut();
  }

  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }
}
