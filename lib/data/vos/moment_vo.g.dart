// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moment_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MomentVO _$MomentVOFromJson(Map<String, dynamic> json) => MomentVO(
      id: json['id'] as int?,
      description: json['description'] as String?,
      profilePicture: json['profile_picture'] as String?,
      userName: json['user_name'] as String?,
      postImageLit: (json['post_image_list'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      postVideoList: (json['post_video_list'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      editPostImage: (json['edit_post_image'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$MomentVOToJson(MomentVO instance) => <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'profile_picture': instance.profilePicture,
      'user_name': instance.userName,
      'post_image_list': instance.postImageLit,
      'post_video_list': instance.postVideoList,
      'edit_post_image': instance.editPostImage,
    };
