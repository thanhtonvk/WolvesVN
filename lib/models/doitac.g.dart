// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doitac.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoiTac _$DoiTacFromJson(Map<String, dynamic> json) => DoiTac(
      (json['Id'] as num).toInt(),
      json['TenDoiTac'] as String,
      json['TrangWeb'] as String,
      json['ThongTinKhac'] as String,
    );

Map<String, dynamic> _$DoiTacToJson(DoiTac instance) => <String, dynamic>{
      'Id': instance.Id,
      'TenDoiTac': instance.TenDoiTac,
      'TrangWeb': instance.TrangWeb,
      'ThongTinKhac': instance.ThongTinKhac,
    };
