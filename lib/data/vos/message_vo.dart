import 'package:json_annotation/json_annotation.dart';

part 'message_vo.g.dart';

@JsonSerializable()
class MessageVO {
  String? userId;
  String? userName;
  String? userProfile;
  String? message;
  String? imageFile;
  String? videoFile;
  String? timeStamp;

  MessageVO(
      {this.userId,
      this.userName,
      this.userProfile,
      this.message,
      this.imageFile,
      this.videoFile,
      this.timeStamp});


  @override
  String toString() {
    return 'MessageVO{message: $message}';
  }

  factory MessageVO.fromJson(Map<String, dynamic> json) =>
      _$MessageVOFromJson(json);

  Map<String, dynamic> toJson() => _$MessageVOToJson(this);
}
