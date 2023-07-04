import 'dart:io';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:we_chat_app/data/vos/moment_vo.dart';

import '../analytics/firebase_analytics_tracker.dart';
import '../data/models/authentication_model.dart';
import '../data/models/authentication_model_impl.dart';
import '../data/models/social_model.dart';
import '../data/models/social_model_impl.dart';
import '../data/vos/user_vo.dart';

class AddNewMomentBloc extends ChangeNotifier {
  /// State
  String newMomentDescription = "";
  bool isAddNewMomentError = false;
  bool isDisposed = false;
  bool isLoading = false;
  UserVO? _loggedInUser;
  List<File> selectedImages=[];
  List<File> selectedVideos=[];

  Color themeColor = Colors.black;

  /// Image
  List<dynamic>? chosenFile;

  /// For Edit Mode
  bool isInEditMode = false;
  String userName = "";
  String profilePicture = "";
  MomentVO? mNewMoments;

  /// Model
  final SocialModel _model = SocialModelImpl();
  final AuthenticationModel _authenticationModel = AuthenticationModelImpl();



  AddNewMomentBloc({int? newMomentsId}) {
    _loggedInUser = _authenticationModel.getLoggedInUser();
    if (newMomentsId != null) {
      isInEditMode = true;
      _prepopulateDataForEditMode(newMomentsId);
    } else {
      _prepopulateDataForAddNewPost();
    }

    /// Firebase
    _sendAnalyticsData(addNewPostScreenReached, null);

  }

  void onChooseImage(File onChooseImage){
    selectedImages.add(onChooseImage);
  }

  void onChooseVideo(File onChooseVideo){
    selectedVideos.add(onChooseVideo);
  }

  void _prepopulateDataForAddNewPost() {
    userName = _loggedInUser?.userName ?? "";

    String id =_loggedInUser?.id??"";
    _authenticationModel.getUserProfileById(id).then((value){
      profilePicture = value.userProfile??"";
      print("Profile Picture==========================>$profilePicture" );
      _notifySafely();
    });
    _notifySafely();
  }

  void _prepopulateDataForEditMode(int newsFeedId) {
    _model.getMomentById(newsFeedId).listen((newsFeed) {
      userName = newsFeed.userName ?? "";
      profilePicture = newsFeed.profilePicture ?? "";
      newMomentDescription = newsFeed.description ?? "";
      mNewMoments = newsFeed;
      _notifySafely();
    });
  }

  void onImageChosen(List<dynamic> imageFile) {
    chosenFile = imageFile;
    _notifySafely();
  }

  void onTapDeleteImage() {
    chosenFile = null;
    _notifySafely();
  }

  void onNewPostTextChanged(String newPostDescription) {
    newMomentDescription = newPostDescription;
  }

  Future onTapAddNewMoment() {
    print("Desc=======> $newMomentDescription");
    if (newMomentDescription.isEmpty) {
      isAddNewMomentError = true;
      _notifySafely();
      return Future.error("Error");
    } else {
      isLoading = true;
      _notifySafely();
      isAddNewMomentError = false;
      if (isInEditMode) {
        return _editNewsFeedPost().then((value) {
          isLoading = false;
          _notifySafely();
          _sendAnalyticsData(
              editPostAction, {postId: mNewMoments?.id.toString() ?? ""});
        });
      } else {
        return _createNewNewsFeedPost().then((value) {
          isLoading = false;
          _notifySafely();
          _sendAnalyticsData(addNewPostAction, null);
        });
      }
    }
  }

  /// Analytics
  void _sendAnalyticsData(String name, Map<String, String>? parameters) async {
    await FirebaseAnalyticsTracker().logEvent(name, parameters);
  }

  void _notifySafely() {
    if (!isDisposed) {
      notifyListeners();
    }
  }

  Future<dynamic> _editNewsFeedPost() {
    mNewMoments?.description = newMomentDescription;
    if (mNewMoments != null) {
      return _model.editPost(mNewMoments!, chosenFile);
    } else {
      return Future.error("Error");
    }
  }

  Future<void> _createNewNewsFeedPost() {
    return _model.addNewMoment(newMomentDescription, selectedImages,profilePicture,selectedVideos);
  }

  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }
}
