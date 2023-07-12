import 'package:json_annotation/json_annotation.dart';

part 'gold.g.dart';

@JsonSerializable()
class Gold {
  double? BuyInto;
  String? Content;
  String? Date;
  int? Id;
  double? SoldOut;
  String? Symbol;

  Gold(this.BuyInto, this.Content, this.Date, this.Id, this.SoldOut,
      this.Symbol);

  factory Gold.fromJson(Map<String, dynamic> json) => _$GoldFromJson(json);

  	Map<String, dynamic> toJson() => _$GoldToJson(this);
}
