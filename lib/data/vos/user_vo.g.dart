// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserVO _$UserVOFromJson(Map<String, dynamic> json) => UserVO(
      id: json['id'] as String?,
      userProfile: json['user_profile'] as String?,
      userName: json['user_name'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      dateOfBirth: json['date_of_birth'] as String?,
      gender: json['gender'] as String?,
      phoneNumber: json['phone_number'] as String?,
      qrCode: json['qr_code'] as String?,
    );

Map<String, dynamic> _$UserVOToJson(UserVO instance) => <String, dynamic>{
      'id': instance.id,
      'user_profile': instance.userProfile,
      'user_name': instance.userName,
      'email': instance.email,
      'phone_number': instance.phoneNumber,
      'password': instance.password,
      'date_of_birth': instance.dateOfBirth,
      'gender': instance.gender,
      'qr_code': instance.qrCode,
    };
