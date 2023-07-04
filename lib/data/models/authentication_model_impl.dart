import 'dart:io';

import '../../network/cloud_firestore_data_agent_impl.dart';
import '../../network/social_data_agent.dart';
import '../vos/user_vo.dart';
import 'authentication_model.dart';


class AuthenticationModelImpl extends AuthenticationModel {
  static final AuthenticationModelImpl _singleton =
      AuthenticationModelImpl._internal();

  factory AuthenticationModelImpl() {
    return _singleton;
  }

  AuthenticationModelImpl._internal();


  SocialDataAgent mDataAgent = CloudFireStoreDataAgentImpl();

  @override
  Future<void> login(String email, String password) {
    return mDataAgent.login(email, password);
  }

  @override
  Future<void> register(String email, String userName, String password,File? userProfile,String? dateOfBirth,String? gender,String? phoneNumber) {
    if(userProfile != null){
      return mDataAgent
          .uploadFileToFirebase(userProfile)
          .then((downloadUrl) => craftUserVO(email, password, userName, downloadUrl,dateOfBirth,gender,phoneNumber))
          .then((user) => mDataAgent.registerNewUser(user));
    } else {
      return craftUserVO(email, password, userName, "",dateOfBirth,gender,phoneNumber)
          .then((user) => mDataAgent.registerNewUser(user));
    }
  }

  Future<UserVO> craftUserVO(String email, String password, String userName,String userProfile,String? dateOfBirth,String? gender,String? phoneNumber) {
    var newUser = UserVO(
      id: "",
      userProfile: userProfile,
      userName: userName,
      email: email,
      password: password,
      dateOfBirth: dateOfBirth,
      gender: gender,
      phoneNumber: phoneNumber
    );
    return Future.value(newUser);
  }

  @override
  UserVO getLoggedInUser() {
    return mDataAgent.getLoggedInUser();
  }

  @override
  bool isLoggedIn() {
    return mDataAgent.isLoggedIn();
  }

  @override
  Future<void> logOut() {
    return mDataAgent.logOut();
  }

  @override
  Future<UserVO> getUserProfileById(String id) {
    return mDataAgent.getUserProfileById(id);
  }

  @override
  Future<List<String>> getOTP(String otp) {
    return mDataAgent.getOTP(otp);
  }
}
