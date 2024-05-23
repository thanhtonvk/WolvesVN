// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rating _$RatingFromJson(Map<String, dynamic> json) => Rating(
      (json['Id'] as num?)?.toInt(),
      (json['IdSan'] as num?)?.toInt(),
      json['Name'] as String?,
      json['Content'] as String?,
      json['Date'] == null ? null : DateTime.parse(json['Date'] as String),
    );

Map<String, dynamic> _$RatingToJson(Rating instance) => <String, dynamic>{
      'Id': instance.Id,
      'IdSan': instance.IdSan,
      'Name': instance.Name,
      'Content': instance.Content,
      'Date': instance.Date?.toIso8601String(),
    };
