import 'package:flutter/material.dart';
import 'package:we_chat_app/data/models/social_model.dart';
import 'package:we_chat_app/data/models/social_model_impl.dart';

import '../data/models/authentication_model.dart';
import '../data/models/authentication_model_impl.dart';
import '../data/vos/user_vo.dart';

class QRCodeScanBloc extends ChangeNotifier {
  /// States
  String qrCode = "";
  bool isDisposed = false;
  bool isLoading = false;

  UserVO? user;

  /// Model
  AuthenticationModel authModel = AuthenticationModelImpl();
  SocialModel model = SocialModelImpl();

  Future onScanQR(String userId) {
    _showLoading();
    return authModel.getUserProfileById(userId).then((user) {
      this.user = user;
      return model.addNewContactToScanner(user).then((value) {
        return model.addNewContactToScannedUser(user);
      });
    }).whenComplete(() => _hideLoading());
  }

  void _showLoading() {
    isLoading = true;
    _notifySafely();
  }

  void _hideLoading() {
    isLoading = false;
    _notifySafely();
  }


  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }

  void _notifySafely() {
    if(!isDisposed) {
      notifyListeners();
    }
  }
}