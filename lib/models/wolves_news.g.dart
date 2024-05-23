// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wolves_news.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WolvesNews _$WolvesNewsFromJson(Map<String, dynamic> json) => WolvesNews(
      json['Content'] as String,
      json['Date'] as String,
      (json['Id'] as num).toInt(),
      json['Image'] as String,
      json['Titile'] as String,
    );

Map<String, dynamic> _$WolvesNewsToJson(WolvesNews instance) =>
    <String, dynamic>{
      'Content': instance.Content,
      'Date': instance.Date,
      'Id': instance.Id,
      'Image': instance.Image,
      'Titile': instance.Titile,
    };
