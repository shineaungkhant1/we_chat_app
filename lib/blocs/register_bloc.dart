import 'dart:io';

import 'package:flutter/foundation.dart';

import '../data/models/authentication_model.dart';
import '../data/models/authentication_model_impl.dart';

class RegisterBloc extends ChangeNotifier {
  /// State
  bool isLoading = false;
  String email = "";
  String password = "";
  String userName = "";
  bool isDisposed = false;
  String selectedDate = 'Day';
  String selectedMonth = 'Month';
  String selectedYear = 'Year';
  String selectedGender = '';
  String phoneNumber="";

  /// Image
  File? userProfile;

  /// Model
  final AuthenticationModel _model = AuthenticationModelImpl();

  Future onTapRegister() {
    _showLoading();
    String dateOfBirth = '$selectedDate, $selectedMonth, $selectedYear';
    return _model
        .register(email, userName, password,userProfile,dateOfBirth,selectedGender,phoneNumber)
        .whenComplete(() => _hideLoading());
  }

  void onEmailChanged(String email) {
    this.email = email;
  }

  void onPhoneNumberChanged(String phoneNumber){
    this.phoneNumber = phoneNumber;
  }

  void onPasswordChanged(String password) {
    this.password = password;
  }

  void onUserNameChanged(String userName) {
    this.userName = userName;
  }

  void onImageChosen(File imageFile) {
    userProfile = imageFile;
    _notifySafely();
  }

  void onTapDeleteImage() {
    userProfile = null;
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
