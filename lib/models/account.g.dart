// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) => Account(
      Avatar: json['Avatar'] as String?,
      DateOfBirth: json['DateOfBirth'] as String?,
      Email: json['Email'] as String?,
      FirstName: json['FirstName'] as String?,
      Id: (json['Id'] as num?)?.toInt(),
      IsActive: json['IsActive'] as bool?,
      LastName: json['LastName'] as String?,
      PhoneNumber: json['PhoneNumber'] as String?,
      Type: (json['Type'] as num?)?.toInt(),
      Wolves: (json['Wolves'] as num?)?.toInt(),
      Password: json['Password'] as String?,
    );

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      'Id': instance.Id,
      'PhoneNumber': instance.PhoneNumber,
      'Email': instance.Email,
      'FirstName': instance.FirstName,
      'LastName': instance.LastName,
      'DateOfBirth': instance.DateOfBirth,
      'Avatar': instance.Avatar,
      'Wolves': instance.Wolves,
      'Type': instance.Type,
      'IsActive': instance.IsActive,
      'Password': instance.Password,
    };
