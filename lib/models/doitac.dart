import 'package:json_annotation/json_annotation.dart';
part 'doitac.g.dart';
@JsonSerializable()
class DoiTac{
  int Id;
  String TenDoiTac,TrangWeb,ThongTinKhac;

  DoiTac(this.Id, this.TenDoiTac, this.TrangWeb, this.ThongTinKhac);

  factory DoiTac.fromJson(Map<String, dynamic> json) => _$DoiTacFromJson(json);

  	Map<String, dynamic> toJson() => _$DoiTacToJson(this);
}