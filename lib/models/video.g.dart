// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Video _$VideoFromJson(Map<String, dynamic> json) => Video(
      json['Id'] as int,
      json['Content'] as String,
      json['LinkVideo'] as String?,
      json['LinkYoutube'] as String?,
    );

Map<String, dynamic> _$VideoToJson(Video instance) => <String, dynamic>{
      'Id': instance.Id,
      'Content': instance.Content,
      'LinkVideo': instance.LinkVideo,
      'LinkYoutube': instance.LinkYoutube,
    };
