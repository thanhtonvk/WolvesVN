import 'package:json_annotation/json_annotation.dart';

part 'signal.g.dart';

@JsonSerializable()
class Signal {
  String? Content;
  String? Date;
  int? Id;
  String? Image;
  double SL;
  double TP;

  Signal(this.Content, this.Date, this.Id, this.Image, this.SL, this.TP);

  factory Signal.fromJson(Map<String, dynamic> json) => _$SignalFromJson(json);

  Map<String, dynamic> toJson() => _$SignalToJson(this);
}
