import 'package:json_annotation/json_annotation.dart';
part 'sangiaodich.g.dart';
@JsonSerializable()
class SanGiaoDich{
  int Id;
  String Content;
  String Titile;

  SanGiaoDich(this.Id, this.Content, this.Titile);

  factory SanGiaoDich.fromJson(Map<String, dynamic> json) =>
      _$SanGiaoDichFromJson(json);

  Map<String, dynamic> toJson() => _$SanGiaoDichToJson(this);
}