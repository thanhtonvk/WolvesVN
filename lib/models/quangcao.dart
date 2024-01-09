import 'package:json_annotation/json_annotation.dart';

part 'quangcao.g.dart';

@JsonSerializable()
class QuangCao {
  int? Id;
  String? Name;
  String? Image;
  String? End;
  int? Time;
  String? Link;

  QuangCao(this.Id, this.Name, this.Image, this.End, this.Time,this.Link);

  factory QuangCao.fromJson(Map<String, dynamic> json) =>
      _$QuangCaoFromJson(json);

  Map<String, dynamic> toJson() => _$QuangCaoToJson(this);
}
