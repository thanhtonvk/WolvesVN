// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'san.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

San _$SanFromJson(Map<String, dynamic> json) => San(
      (json['Id'] as num?)?.toInt(),
      json['Name'] as String?,
      json['Image'] as String?,
      json['Detail'] as String?,
      (json['ExpertPoint'] as num?)?.toDouble(),
      (json['InvesterPoint'] as num?)?.toDouble(),
      json['Website'] as String?,
      (json['Year'] as num?)?.toInt(),
      json['Address'] as String?,
      json['TradePlatform'] as String?,
      json['Pushmax'] as String?,
      json['TradeProduct'] as String?,
      json['License'] as String?,
      json['Method'] as String?,
    );

Map<String, dynamic> _$SanToJson(San instance) => <String, dynamic>{
      'Id': instance.Id,
      'Name': instance.Name,
      'Image': instance.Image,
      'Detail': instance.Detail,
      'ExpertPoint': instance.ExpertPoint,
      'InvesterPoint': instance.InvesterPoint,
      'Website': instance.Website,
      'Year': instance.Year,
      'Address': instance.Address,
      'TradePlatform': instance.TradePlatform,
      'Pushmax': instance.Pushmax,
      'TradeProduct': instance.TradeProduct,
      'License': instance.License,
      'Method': instance.Method,
    };
