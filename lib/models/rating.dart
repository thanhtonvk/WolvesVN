import 'package:json_annotation/json_annotation.dart';
part 'rating.g.dart';
@JsonSerializable()
class Rating{
  int? Id;
  int? IdSan;
  String? Name;
  String? Content;
  DateTime? Date;

  Rating(this.Id, this.IdSan, this.Name, this.Content, this.Date);

  factory Rating.fromJson(Map<String, dynamic> json) => _$RatingFromJson(json);

  	Map<String, dynamic> toJson() => _$RatingToJson(this);
}