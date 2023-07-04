import 'package:flutter/foundation.dart';
import 'package:we_chat_app/data/models/social_model_impl.dart';
import 'package:we_chat_app/data/vos/user_vo.dart';

import '../data/models/social_model.dart';

class ContactBloc extends ChangeNotifier {
  /// States
  List<UserVO>? contactUsers;
  List<dynamic>? alphabetsStartByName;

  bool isDisposed = false;

  /// Model
  SocialModel model = SocialModelImpl();

  ContactBloc() {
    model.getContactsOfLoggedInUser().listen((users) {
      contactUsers = users;
      alphabetsStartByName = users.map((user) => user.userName?[0] ?? "").toSet().toList();
      _notifySafely();
    });
  }

  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }

  void _notifySafely() {
    if (!isDisposed) {
      notifyListeners();
    }
  }
}
