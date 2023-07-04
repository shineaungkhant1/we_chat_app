import 'package:flutter/material.dart';
import 'package:we_chat_app/data/models/authentication_model_impl.dart';
import 'package:we_chat_app/data/vos/user_vo.dart';

import '../data/models/authentication_model.dart';

class ProfileBloc extends ChangeNotifier{

  /// State
  String userProfile="";
  String userName="";
  String phoneNumber="";
  String qrCode ="";
  UserVO? user;
  bool isDisposed = false;
  String selectedYear = "";
  String dateOfBirth="";
  String gender="";


  /// Model
  final AuthenticationModel _model = AuthenticationModelImpl();




  ProfileBloc() {
    var user = _model.getLoggedInUser();
    _prepopulateForProfilePage(user.id ?? "");
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

  void _prepopulateForProfilePage(String id) {
    _model.getUserProfileById(id).then((userVo) {
      userName = userVo.userName ?? "";
      userProfile = userVo.userProfile ?? "";
      dateOfBirth=userVo.dateOfBirth??"";
      phoneNumber=userVo.phoneNumber??"";
      gender=userVo.gender??"";
      qrCode = userVo.qrCode ?? "";
      user = userVo;
      _notifySafely();
    });
  }

  Future onTapLogout() {
    return _model.logOut();
  }





}