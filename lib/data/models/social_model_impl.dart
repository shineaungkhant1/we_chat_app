import 'dart:io';

import 'package:we_chat_app/data/models/social_model.dart';

import '../../network/cloud_firestore_data_agent_impl.dart';
import '../../network/social_data_agent.dart';
import '../vos/moment_vo.dart';
import '../vos/user_vo.dart';
import 'authentication_model.dart';
import 'authentication_model_impl.dart';

class SocialModelImpl extends SocialModel {
  static final SocialModelImpl _singleton = SocialModelImpl._internal();

  factory SocialModelImpl() {
    return _singleton;
  }

  SocialModelImpl._internal();

  SocialDataAgent mDataAgent = CloudFireStoreDataAgentImpl();

  /// Other Models
  final AuthenticationModel _authenticationModel = AuthenticationModelImpl();

  @override
  Stream<List<MomentVO>> getMoment() {
    return mDataAgent.getMoment();
  }

  @override
  Future<void> deletePost(int postId) {
    return mDataAgent.deletePost(postId);
  }

  @override
  Future<void> addNewMoment(String description, List<File>? imageList,
      String profilePicture, List<File>? videoList) async {
    List<String> imageUrlList = [];
    List<String> videoUrlList = [];
    if (imageList != null && imageList.isNotEmpty) {
      await Future.forEach(imageList, (file) async {
        String url = await mDataAgent.uploadFileToFirebase(file);
        imageUrlList.add(url);
      });
    }
    if (videoList != null && videoList.isNotEmpty) {
      await Future.forEach(videoList, (file) async {
        String url = await mDataAgent.uploadFileToFirebase(file);
        videoUrlList.add(url);
      });
    }
    return craftMomentVO(
            description, imageUrlList, videoUrlList, profilePicture)
        .then((newPost) {
      return mDataAgent.addNewMoment(newPost);
    });
  }

  Future<MomentVO> craftMomentVO(String description, List<String> imageList,
      List<String> videoList, String profilePicture) {
    var currentMilliseconds = DateTime.now().millisecondsSinceEpoch;
    var newPost = MomentVO(
        id: currentMilliseconds,
        userName: _authenticationModel.getLoggedInUser().userName,
        postImageLit: imageList,
        postVideoList: videoList,
        description: description,
        profilePicture: profilePicture);
    return Future.value(newPost);
  }

  @override
  Stream<MomentVO> getMomentById(int momentId) {
    return mDataAgent.getMomentById(momentId);
  }

  @override
  Future<void> editPost(MomentVO moment, List<dynamic>? imageFile) {
    return mDataAgent.addNewMoment(moment);
  }

  @override
  Future<UserVO> getUserProfileById(String userId) {
    return mDataAgent.getUserProfileById(userId);
  }

  @override
  Future addNewContactToScanner(UserVO? userVo) {
    return mDataAgent.addNewContactToScanner(userVo ?? UserVO());
  }

  @override
  Future addNewContactToScannedUser(UserVO? scannedUser) {
    return mDataAgent.addNewContactToScannedUser(scannedUser ?? UserVO());
  }

  @override
  Stream<List<UserVO>> getContactsOfLoggedInUser() {
    return mDataAgent.getContactsOfLoggedInUser();
  }
}
