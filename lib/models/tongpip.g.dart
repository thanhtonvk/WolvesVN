// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tongpip.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TongPip _$TongPipFromJson(Map<String, dynamic> json) => TongPip(
      json['Date'] as String,
      (json['Id'] as num).toInt(),
      json['Money'] as String,
      json['PipCu'] as num,
      json['PipMoi'] as num,
      json['SL'] as num,
      json['TP'] as num,
    );

Map<String, dynamic> _$TongPipToJson(TongPip instance) => <String, dynamic>{
      'Date': instance.Date,
      'Id': instance.Id,
      'Money': instance.Money,
      'PipCu': instance.PipCu,
      'PipMoi': instance.PipMoi,
      'SL': instance.SL,
      'TP': instance.TP,
    };
