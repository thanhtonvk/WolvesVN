import 'package:json_annotation/json_annotation.dart';

part 'video.g.dart';

@JsonSerializable()
class Video {
  int Id;
  String Content;
  String? LinkVideo;
  String? LinkYoutube;


  Video(this.Id, this.Content, this.LinkVideo, this.LinkYoutube);

  factory Video.fromJson(Map<String, dynamic> json) => _$VideoFromJson(json);

  Map<String, dynamic> toJson() => _$VideoToJson(this);
}
