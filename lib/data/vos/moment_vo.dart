import 'package:json_annotation/json_annotation.dart';

part 'moment_vo.g.dart';

@JsonSerializable()
class MomentVO {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "description")
  String? description;

  @JsonKey(name: "profile_picture")
  String? profilePicture;

  @JsonKey(name: "user_name")
  String? userName;

  @JsonKey(name: "post_image_list")
  List<String>? postImageLit;

  @JsonKey(name: "post_video_list")
  List<String>? postVideoList;

  @JsonKey(name: "edit_post_image")
  List<String>? editPostImage;




  MomentVO({
    this.id,
    this.description,
    this.profilePicture,
    this.userName,
    this.postImageLit,
     this.postVideoList,
    this.editPostImage
  });

  factory MomentVO.fromJson(Map<String, dynamic> json) =>
      _$MomentVOFromJson(json);

  Map<String, dynamic> toJson() => _$MomentVOToJson(this);
}
