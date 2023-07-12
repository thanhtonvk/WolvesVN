import 'package:json_annotation/json_annotation.dart';
part 'wolves_news.g.dart';
@JsonSerializable()
class WolvesNews{
  String Content;
  String Date;
  int Id;
  String Image;
  String Titile;

  WolvesNews(this.Content, this.Date, this.Id, this.Image, this.Titile);

  factory WolvesNews.fromJson(Map<String, dynamic> json) =>
      _$WolvesNewsFromJson(json);

  Map<String, dynamic> toJson() => _$WolvesNewsToJson(this);
}