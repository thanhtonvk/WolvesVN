import 'package:json_annotation/json_annotation.dart';
part 'tintuc.g.dart';
@JsonSerializable()
class TinTuc{
  String Content;
  String Date;
  int ID;
  String Time;
  bool Type;

  TinTuc(this.Content, this.Date, this.ID, this.Time, this.Type);

  factory TinTuc.fromJson(Map<String, dynamic> json) => _$TinTucFromJson(json);

  Map<String, dynamic> toJson() => _$TinTucToJson(this);
}