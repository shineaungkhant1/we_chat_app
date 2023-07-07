import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:we_chat_app/network/social_data_agent.dart';

import '../data/vos/moment_vo.dart';
import '../data/vos/user_vo.dart';

/// News Feed Collection
const momentsCollection = "moments";
const usersCollection = "users";
const fileUploadRef = "uploads";

/// QR Collection
const contactsCollection = "contacts";

class CloudFireStoreDataAgentImpl extends SocialDataAgent {
  /// FireStore
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  /// Storage
  var firebaseStorage = FirebaseStorage.instance;

  /// Auth
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Future<void> addNewMoment(MomentVO newPost) {
    return _fireStore
        .collection(momentsCollection)
        .doc(newPost.id.toString())
        .set(newPost.toJson());
  }

  @override
  Future<void> deletePost(int postId) {
    return _fireStore
        .collection(momentsCollection)
        .doc(postId.toString())
        .delete();
  }

  @override
  Stream<List<MomentVO>> getMoment() {
    return _fireStore
        .collection(momentsCollection)
        .snapshots()
        .map((querySnapShot) {
      return querySnapShot.docs.map<MomentVO>((document) {
        return MomentVO.fromJson(document.data());
      }).toList();
    });
  }

  @override
  Stream<MomentVO> getMomentById(int newsFeedId) {
    return _fireStore
        .collection(momentsCollection)
        .doc(newsFeedId.toString())
        .get()
        .asStream()
        .where((documentSnapShot) => documentSnapShot.data() != null)
        .map((documentSnapShot) => MomentVO.fromJson(documentSnapShot.data()!));
  }

  @override
  Future<String> uploadFileToFirebase(dynamic file) {
    if (file is String) {
      return firebaseStorage
          .ref(fileUploadRef)
          .child("${DateTime.now().millisecondsSinceEpoch}")
          .putFile(File(file))
          .then((taskSnapshot) => taskSnapshot.ref.getDownloadURL());
    } else if (file is File) {
      return firebaseStorage
          .ref(fileUploadRef)
          .child("${DateTime.now().millisecondsSinceEpoch}")
          .putFile(file)
          .then((taskSnapshot) => taskSnapshot.ref.getDownloadURL());
    } else {
      throw Exception("Invalid file type");
    }
  }

  @override
  Future registerNewUser(UserVO newUser) {
    return auth
        .createUserWithEmailAndPassword(
            email: newUser.email ?? "", password: newUser.password ?? "")
        .then((credential) =>
            credential.user?..updateDisplayName(newUser.userName))
        .then((user) {
      newUser.id = user?.uid ?? "";
      newUser.qrCode = user?.uid ?? "";
      _addNewUser(newUser);
    });
  }

  Future<void> _addNewUser(UserVO newUser) {
    return _fireStore
        .collection(usersCollection)
        .doc(newUser.id.toString())
        .set(newUser.toJson());
  }

  @override
  Future login(String email, String password) {
    return auth.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  bool isLoggedIn() {
    return auth.currentUser != null;
  }

  @override
  UserVO getLoggedInUser() {
    return UserVO(
        id: auth.currentUser?.uid,
        email: auth.currentUser?.email,
        userName: auth.currentUser?.displayName,
        phoneNumber: auth.currentUser?.phoneNumber,
        gender: auth.currentUser?.photoURL);
  }

  @override
  Future logOut() {
    return auth.signOut();
  }

  @override
  Future<UserVO> getUserProfileById(String userId) {
    return _fireStore
        .collection("users")
        .doc(userId.toString())
        .get()
        .then((documentSnapShot) => UserVO.fromJson(documentSnapShot.data()!));
  }

  @override
  Future<List<String>> getOTP(String otp) async {
    final DocumentSnapshot snapshot = await _fireStore
        .collection("otp")
        .doc("H39XPe2Gk7Ulr74H5FuRHxhATHm2")
        .get();

    final data = snapshot.data();
    if (data != null && data is Map<String, dynamic>) {
      final otpList = data['otp'] as List<dynamic>;
      final otpStrings = otpList.map((otp) => otp.toString()).toList();
      return otpStrings;
    } else {
      return [];
    }
  }

  @override
  Future<void> addNewContactToScanner(UserVO userVo) {
    return _fireStore
        .collection(usersCollection)
        .doc(getLoggedInUser().id ?? "")
        .collection(contactsCollection)
        .doc(userVo.id.toString())
        .set(userVo.toJson());
  }

  @override
  Future<void> addNewContactToScannedUser(UserVO userVo) async {
    var scannerId = getLoggedInUser().id ?? "";
    UserVO scannerUser = UserVO();
    await getUserProfileById(scannerId).then((user) {
      scannerUser = user;
    }).catchError((error) {
      debugPrint(error.toString());
    });

    return _fireStore
        .collection(usersCollection)
        .doc(userVo.id ?? "")
        .collection(contactsCollection)
        .doc(scannerId)
        .set(scannerUser.toJson());
  }

  @override
  Stream<List<UserVO>> getContactsOfLoggedInUser() {
    String loggedInUserId = getLoggedInUser().id ?? "";
    return _fireStore
        .collection(usersCollection)
        .doc(loggedInUserId)
        .collection(contactsCollection)
        .snapshots()
        .map((querySnapShot) {
      return querySnapShot.docs.map<UserVO>((document) {
        return UserVO.fromJson(document.data());
      }).toList();
    });
  }
}
