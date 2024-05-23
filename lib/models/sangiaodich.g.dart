// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sangiaodich.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SanGiaoDich _$SanGiaoDichFromJson(Map<String, dynamic> json) => SanGiaoDich(
      (json['Id'] as num).toInt(),
      json['Content'] as String,
      json['Titile'] as String,
    );

Map<String, dynamic> _$SanGiaoDichToJson(SanGiaoDich instance) =>
    <String, dynamic>{
      'Id': instance.Id,
      'Content': instance.Content,
      'Titile': instance.Titile,
    };
