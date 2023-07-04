import 'package:json_annotation/json_annotation.dart';

part 'user_vo.g.dart';

@JsonSerializable()
class UserVO {
  @JsonKey(name: "id")
  String? id;

  @JsonKey(name: "user_profile")
  String? userProfile;

  @JsonKey(name: "user_name")
  String? userName;

  @JsonKey(name: "email")
  String? email;

  @JsonKey(name: "phone_number")
  String? phoneNumber;

  @JsonKey(name: "password")
  String? password;

  @JsonKey(name: "date_of_birth")
  String? dateOfBirth;

  @JsonKey(name: "gender")
  String? gender;

  @JsonKey(name: "qr_code")
  String? qrCode;



  UserVO({
    this.id,
    this.userProfile,
    this.userName,
    this.email,
    this.password,
    this.dateOfBirth,
    this.gender,
    this.phoneNumber,
    this.qrCode
  });

  factory UserVO.fromJson(Map<String, dynamic> json) => _$UserVOFromJson(json);

  Map<String, dynamic> toJson() => _$UserVOToJson(this);
}
