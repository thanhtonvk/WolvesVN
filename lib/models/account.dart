import 'package:json_annotation/json_annotation.dart';

part 'account.g.dart';

@JsonSerializable()
class Account {
  int? Id;
  String? PhoneNumber;
  String? Email;
  String? FirstName;
  String? LastName;
  String? DateOfBirth;
  String? Avatar;
  int? Wolves;
  int? Type;
  bool? IsActive;
  String? Password;

  Account(
      {this.Avatar,
      this.DateOfBirth,
      this.Email,
      this.FirstName,
       this.Id,
      this.IsActive,
      this.LastName,
      this.PhoneNumber,
      this.Type,
      this.Wolves,
      this.Password});

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);

  Map<String, dynamic> toJson() => _$AccountToJson(this);
// Account.fromJson(Map<String, dynamic> json)
//     : Avatar = json['Id'],
//       DateOfBirth = json['Id'],
//       Email = json['Id'],
//       FirstName = json['Id'],
//       Id = json['Id'],
//       IsActive = json['Id'],
//       LastName = json['Id'],
//       PhoneNumber = json['Id'],
//       Type = json['Type'],
//       Wolves = json['Wolves'];
// Map<String, dynamic> toJson() => {
//       'Avatar': Avatar,
//       'DateOfBirth': DateOfBirth,
//       'Email': Email,
//       'FirstName': FirstName,
//       'Id': Id,
//       'IsActive': IsActive,
//       'LastName': LastName,
//       'PhoneNumber': PhoneNumber,
//       'Type': Type,
//       'Wolves': Wolves
//     };
}
