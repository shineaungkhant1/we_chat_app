import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:we_chat_app/data/vos/message_vo.dart';
import 'package:we_chat_app/data/vos/user_vo.dart';
import 'package:we_chat_app/network/chat_data_agent.dart';
import 'package:we_chat_app/network/cloud_firestore_data_agent_impl.dart';
import 'package:we_chat_app/network/social_data_agent.dart';

/// Database Paths
const chatsPath = "contacts&messages";

/// File Upload References
const fileUploadRef = "uploads";

class RealtimeDatabaseDataAgentImpl extends ChatDataAgent {
  static final RealtimeDatabaseDataAgentImpl _singleton =
      RealtimeDatabaseDataAgentImpl._internal();

  factory RealtimeDatabaseDataAgentImpl() {
    return _singleton;
  }

  RealtimeDatabaseDataAgentImpl._internal();

  ///Database
  var databaseRef = FirebaseDatabase.instance.ref();

  /// FireStore Data Agent
  final SocialDataAgent _fireStoreDataAgent = CloudFireStoreDataAgentImpl();

  /// Storage
  var firebaseStorage = FirebaseStorage.instance;

  /// Auth
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Stream<List<MessageVO>> getMessages(
      String loggedInUserId, String sentUserId) {
    return databaseRef
        .child(chatsPath)
        .child(loggedInUserId)
        .child(sentUserId)
        .onValue
        .map((event) {
      final  value = event.snapshot.value;
      //print();
      //debugPrint();
      log("VALUE=======>$value");
      // if(value is Map<dynamic,dynamic>){
      //   return value.values
      //       .map<MessageVO>((element) => MessageVO.fromJson(Map<String,dynamic>.from(element)))
      //       .toList();
      // } else {
      //   return [];
      // }
      return event.snapshot.children.map<MessageVO>((dataSnapShot) {
        return MessageVO.fromJson(
            Map<String, dynamic>.from(dataSnapShot.value as dynamic));
      }).toList();
    });
  }

  @override
  Future<void> sendMessage(MessageVO message, UserVO? userVO) {
    return messageFromLoggedInUser(message, userVO).then((_) {
      return messageFromSentUser(message, userVO);
    });
  }

  Future<void> messageFromLoggedInUser(MessageVO message, UserVO? userVO) {
    return databaseRef
        .child(chatsPath)
        .child(_fireStoreDataAgent.getLoggedInUser().id ?? "")
        .child(userVO?.id ?? "")
        .child(message.timeStamp.toString())
        .set(message.toJson());
  }

  Future<void> messageFromSentUser(MessageVO message, UserVO? userVO) {
    return databaseRef
        .child(chatsPath)
        .child(userVO?.id ?? "")
        .child(_fireStoreDataAgent.getLoggedInUser().id ?? "")
        .child(message.timeStamp.toString())
        .set(message.toJson());
  }
}
