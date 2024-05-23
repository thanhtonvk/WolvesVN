// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vip.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Vip _$VipFromJson(Map<String, dynamic> json) => Vip(
      (json['Id'] as num).toInt(),
      (json['IdAccount'] as num).toInt(),
      json['Start'] as String,
      json['End'] as String,
      (json['Type'] as num).toInt(),
    );

Map<String, dynamic> _$VipToJson(Vip instance) => <String, dynamic>{
      'Id': instance.Id,
      'IdAccount': instance.IdAccount,
      'Start': instance.Start,
      'End': instance.End,
      'Type': instance.Type,
    };
