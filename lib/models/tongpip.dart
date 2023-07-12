import 'package:json_annotation/json_annotation.dart';
part 'tongpip.g.dart';
@JsonSerializable()
class TongPip{
  String Date;
  int Id;
  String Money;
  num PipCu;
  num PipMoi;
  num SL;
  num TP;

  TongPip(this.Date, this.Id, this.Money, this.PipCu, this.PipMoi, this.SL,
      this.TP);

  factory TongPip.fromJson(Map<String, dynamic> json) => _$TongPipFromJson(json);

  	Map<String, dynamic> toJson() => _$TongPipToJson(this);
}