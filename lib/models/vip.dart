import 'package:json_annotation/json_annotation.dart';
part 'vip.g.dart';
@JsonSerializable()
class Vip{
  int Id;
  int IdAccount;
  String Start;
  String End;
  int Type;

  Vip(this.Id, this.IdAccount, this.Start, this.End, this.Type);

  factory Vip.fromJson(Map<String, dynamic> json) => _$VipFromJson(json);

  Map<String, dynamic> toJson() => _$VipToJson(this);
}