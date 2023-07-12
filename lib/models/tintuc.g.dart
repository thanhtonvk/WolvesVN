// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tintuc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TinTuc _$TinTucFromJson(Map<String, dynamic> json) => TinTuc(
      json['Content'] as String,
      json['Date'] as String,
      json['ID'] as int,
      json['Time'] as String,
      json['Type'] as bool,
    );

Map<String, dynamic> _$TinTucToJson(TinTuc instance) => <String, dynamic>{
      'Content': instance.Content,
      'Date': instance.Date,
      'ID': instance.ID,
      'Time': instance.Time,
      'Type': instance.Type,
    };
