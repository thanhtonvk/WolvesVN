// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vip.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Vip _$VipFromJson(Map<String, dynamic> json) => Vip(
      json['Id'] as int,
      json['IdAccount'] as int,
      json['Start'] as String,
      json['End'] as String,
      json['Type'] as int,
    );

Map<String, dynamic> _$VipToJson(Vip instance) => <String, dynamic>{
      'Id': instance.Id,
      'IdAccount': instance.IdAccount,
      'Start': instance.Start,
      'End': instance.End,
      'Type': instance.Type,
    };
