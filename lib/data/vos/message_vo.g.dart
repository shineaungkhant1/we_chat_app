// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageVO _$MessageVOFromJson(Map<String, dynamic> json) => MessageVO(
      userId: json['userId'] as String?,
      userName: json['userName'] as String?,
      userProfile: json['userProfile'] as String?,
      message: json['message'] as String?,
      imageFile: json['imageFile'] as String?,
      videoFile: json['videoFile'] as String?,
      timeStamp: json['timeStamp'] as String?,
    );

Map<String, dynamic> _$MessageVOToJson(MessageVO instance) => <String, dynamic>{
      'userId': instance.userId,
      'userName': instance.userName,
      'userProfile': instance.userProfile,
      'message': instance.message,
      'imageFile': instance.imageFile,
      'videoFile': instance.videoFile,
      'timeStamp': instance.timeStamp,
    };
