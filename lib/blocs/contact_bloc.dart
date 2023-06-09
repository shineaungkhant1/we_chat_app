

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:we_chat_app/data/models/social_model_impl.dart';
import 'package:we_chat_app/data/vos/user_vo.dart';

import '../data/models/authentication_model.dart';
import '../data/models/authentication_model_impl.dart';
import '../data/models/social_model.dart';
import '../data/vos/message_vo.dart';

class ContactBloc extends ChangeNotifier {
  /// States
  List<UserVO>? contactUsers;
  List<dynamic>? alphabetsStartByName;
  bool isDisposed = false;
  String loggedInUserId = "";
  String sentUserId = "";
  File? selectedImageFile;
  File? selectedVideoFile;
  String fileFormat = "";
  String message = "";
  String userProfile="";
  List<MessageVO>? messages;
  bool isMessageError = false;
  bool isLoading = false;

  /// Model
  final SocialModel _model = SocialModelImpl();
  final AuthenticationModel _authenticationModel = AuthenticationModelImpl();

  void onFileChosen(File file) {
    var fileFormat = file.path.split("/").last.split(".").last;
    this.fileFormat = fileFormat;
    if (fileFormat == "jpg" ||
        fileFormat == "jpeg" ||
        fileFormat == "png" ||
        fileFormat == "gif") {
      selectedImageFile = file;
    } else {
      selectedVideoFile = file;
    }
    _notifySafely();
  }

  Future onSendMessage(UserVO userVO) {
    if (message.isEmpty &&
        selectedImageFile == null &&
        selectedVideoFile == null) {
      isMessageError = true;
      _notifySafely();
      return Future.error("Can't be empty");
    } else {
      isLoading = true;
      _notifySafely();
      isMessageError = false;
      return _sendNewMessage(userVO).then((value) {
        message = "";
        isLoading = false;
        _notifySafely();
      });
    }
  }

  Future<void> _sendNewMessage(UserVO userVO) {
    return _model.sendMessage(
        userVO, message, selectedImageFile, selectedVideoFile);
  }

  void onMessageChanged(String message) {
    this.message = message;
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

  ContactBloc(UserVO userVO) {
    _model.getContactsOfLoggedInUser().listen((users) {
      contactUsers = users;
      alphabetsStartByName = users.map((user) => user.userName?[0] ?? "").toSet().toList();
      _notifySafely();
    });
    loggedInUserId = _authenticationModel.getLoggedInUser().id ?? "";
    sentUserId = userVO?.id ?? "";

    _model.getMessages(loggedInUserId, sentUserId).listen((messages) {
      // this.messages = messages;
      this.messages = List.of((messages).reversed.toList());
      print("LISTMESSAGE=====>${this.messages?.first}");
      _notifySafely();
    });
  }


}
