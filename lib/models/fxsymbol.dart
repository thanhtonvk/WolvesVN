import 'package:json_annotation/json_annotation.dart';

part 'fxsymbol.g.dart';

@JsonSerializable()
class FxSymbol {
  String? T;
  String? v;
  String? vw;
  String? o;
  String? c;
  String? h;
  String? l;
  String? t;
  String? n;

  FxSymbol(
      this.T, this.v, this.vw, this.o, this.c, this.h, this.l, this.t, this.n);

  factory FxSymbol.fromJson(Map<String, dynamic> json) =>
      _$FxSymbolFromJson(json);

  Map<String, dynamic> toJson() => _$FxSymbolToJson(this);

  @override
  String toString() {
    // TODO: implement toString
    return T.toString();
  }
}
