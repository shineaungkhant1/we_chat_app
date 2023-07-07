import 'dart:io';
import '../vos/message_vo.dart';
import '../vos/moment_vo.dart';
import '../vos/user_vo.dart';

abstract class SocialModel {
  /// Moments
  Stream<List<MomentVO>> getMoment();
  Stream<MomentVO> getMomentById(int momentId);
  Future<void> addNewMoment(String description, List<File>? imageList, String profilePicture,List<File>? videoList);
  Future<void> editPost(MomentVO moment, List<dynamic>? imageFile);
  Future<void> deletePost(int postId);
  Future<UserVO> getUserProfileById(String userId );

  /// Contact
  Future addNewContactToScanner(UserVO? userVo);
  Future addNewContactToScannedUser(UserVO? scannedUser);
  Stream<List<UserVO>> getContactsOfLoggedInUser();

  /// Chat
  Future<void> sendMessage(UserVO userVO, String message, File? imageFile, File? videoFile);
  Stream<List<MessageVO>> getMessages(String loggedInUserId, String sentUserId);
}
