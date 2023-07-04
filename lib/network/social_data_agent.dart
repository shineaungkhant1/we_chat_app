import 'dart:io';

import 'package:we_chat_app/data/vos/moment_vo.dart';

import '../data/vos/user_vo.dart';


abstract class SocialDataAgent {
  /// News Feed
  Stream<List<MomentVO>> getMoment();
  Future<void> addNewMoment(MomentVO newPost);
  Future<void> deletePost(int postId);
  Stream<MomentVO> getMomentById(int newsFeedId);
  Future<String> uploadFileToFirebase(File image);


  /// Authentication
  Future registerNewUser(UserVO newUser);
  Future login(String email, String password);
  bool isLoggedIn();
  UserVO getLoggedInUser();
  Future logOut();
  Future<UserVO> getUserProfileById(String userId );
  Future<List<String>> getOTP(String otp);
  Stream<List<UserVO>> getContactsOfLoggedInUser();

  ///QR Scan
  Future<void> addNewContactToScanner(UserVO userVo);
  Future<void> addNewContactToScannedUser(UserVO userVo);
}
