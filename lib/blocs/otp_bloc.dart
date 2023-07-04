import 'package:flutter/material.dart';

import '../data/models/authentication_model.dart';
import '../data/models/authentication_model_impl.dart';
import '../resources/strings.dart';

class OTPBloc extends ChangeNotifier {
  bool isLoading = false;
  String otp = "";
  List<TextEditingController> textEditControllerList =[];
  bool isDisposed = false;


  final AuthenticationModel _model = AuthenticationModelImpl();

  OTPBloc(){
    textEditControllerList = textEditingControllerList;
}

  Future<void> getDefaultOTP() async {
    _showLoading();
    List<String> defaultOTP = await _model.getOTP(otp);

    bool otpMatches = true;
    for (int i = 0;
    i < textEditControllerList.length && i < defaultOTP.length;
    i++) {
      textEditControllerList[i].text = defaultOTP[i];
      if (defaultOTP[i] != textEditControllerList[i].text) {
        otpMatches = false;
      }
    }

    if (otpMatches) {
      print("OTP is correct");

    } else {
      print("OTP is incorrect");

    }

    _hideLoading();
  }


  Future<void> onTapOTP() {
    _showLoading();
    return getDefaultOTP().whenComplete(() => _hideLoading());
  }

  void setOTP(String enteredOTP) {
    otp = enteredOTP;
    _notifySafely();
  }

  void _showLoading() {
    isLoading = true;
    _notifySafely();
  }

  void _hideLoading() {
    isLoading = false;
    _notifySafely();
  }

  void _notifySafely() {
    if (!isDisposed) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }
}
