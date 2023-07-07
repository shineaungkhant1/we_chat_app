import 'dart:io';

import 'package:we_chat_app/data/models/social_model.dart';
import 'package:we_chat_app/data/vos/message_vo.dart';
import 'package:we_chat_app/network/chat_data_agent.dart';
import 'package:we_chat_app/network/real_time_data_agent_impl.dart';

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

  /// Data Agents
  SocialDataAgent mDataAgent = CloudFireStoreDataAgentImpl();
  ChatDataAgent mChatDataAgent = RealtimeDatabaseDataAgentImpl();

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

  @override
  Stream<List<MessageVO>> getMessages(
      String loggedInUserId, String sentUserId) {
    return mChatDataAgent.getMessages(loggedInUserId, sentUserId);
  }

  @override
  Future<void> sendMessage(
      UserVO userVo, String message, File? imageFile, File? videoFile) {
    if (imageFile != null) {
      return mDataAgent
          .uploadFileToFirebase(imageFile)
          .then((downloadUrl) => craftNewMessageVo(message, downloadUrl, ""))
          .then((newMessage) => mChatDataAgent.sendMessage(newMessage, userVo));
    } else if (videoFile != null) {
      return mDataAgent
          .uploadFileToFirebase(videoFile)
          .then((downloadUrl) => craftNewMessageVo(message, "", downloadUrl))
          .then((newMessage) => mChatDataAgent.sendMessage(newMessage, userVo));
    } else {
      return craftNewMessageVo(message, "", "")
          .then((newMessage) => mChatDataAgent.sendMessage(newMessage, userVo));
    }
  }

  Future<MessageVO> craftNewMessageVo(
      String message, String imageUrl, String videoUrl) {
    var currentMilliseconds = DateTime.now().millisecondsSinceEpoch;
    var loggedInUserId = _authenticationModel.getLoggedInUser().id ?? "";
    return _authenticationModel.getUserProfileById(loggedInUserId).then((user) {
      var newMessage = MessageVO(
        userId: user.id ?? "",
        userName: user.userName ?? "",
        userProfile: user.userProfile ?? "",
        message: message,
        imageFile: imageUrl,
        videoFile: videoUrl,
        timeStamp: currentMilliseconds.toString(),
      );
      return Future.value(newMessage);
    });
  }
}
