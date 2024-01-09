import 'package:json_annotation/json_annotation.dart';

part 'san.g.dart';

@JsonSerializable()
class San{
  int? Id;
  String? Name;
  String? Image;
  String? Detail;
  double? ExpertPoint;
  double? InvesterPoint;
  String? Website;
  int? Year;
  String? Address;
  String? TradePlatform;
  String? Pushmax;
  String? TradeProduct;
  String? License;
  String? Method;

  San(
      this.Id,
      this.Name,
      this.Image,
      this.Detail,
      this.ExpertPoint,
      this.InvesterPoint,
      this.Website,
      this.Year,
      this.Address,
      this.TradePlatform,
      this.Pushmax,
      this.TradeProduct,
      this.License,
      this.Method);

  factory San.fromJson(Map<String, dynamic> json) => _$SanFromJson(json);

  	Map<String, dynamic> toJson() => _$SanToJson(this);
}