// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gold.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Gold _$GoldFromJson(Map<String, dynamic> json) => Gold(
      (json['BuyInto'] as num?)?.toDouble(),
      json['Content'] as String?,
      json['Date'] as String?,
      json['Id'] as int?,
      (json['SoldOut'] as num?)?.toDouble(),
      json['Symbol'] as String?,
    );

Map<String, dynamic> _$GoldToJson(Gold instance) => <String, dynamic>{
      'BuyInto': instance.BuyInto,
      'Content': instance.Content,
      'Date': instance.Date,
      'Id': instance.Id,
      'SoldOut': instance.SoldOut,
      'Symbol': instance.Symbol,
    };
