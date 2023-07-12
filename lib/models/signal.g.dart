// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Signal _$SignalFromJson(Map<String, dynamic> json) => Signal(
      json['Content'] as String?,
      json['Date'] as String?,
      json['Id'] as int?,
      json['Image'] as String?,
      (json['SL'] as num).toDouble(),
      (json['TP'] as num).toDouble(),
    );

Map<String, dynamic> _$SignalToJson(Signal instance) => <String, dynamic>{
      'Content': instance.Content,
      'Date': instance.Date,
      'Id': instance.Id,
      'Image': instance.Image,
      'SL': instance.SL,
      'TP': instance.TP,
    };
